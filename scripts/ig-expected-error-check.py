import os
import re
import xml.etree.ElementTree as ET
from collections import defaultdict

# Path to qa.xml (relative to script)
xml_path = os.path.join(os.path.dirname(__file__), "../output/qa.xml")

# FHIR namespace
FHIR_NS = {'fhir': 'http://hl7.org/fhir'}

# Parse XML
tree = ET.parse(xml_path)
root = tree.getroot()

def get_issue_details(issue):
    # Try the most likely FHIR XML locations for error details
    elem = issue.find("fhir:details/fhir:text", FHIR_NS)
    if elem is not None and "value" in elem.attrib:
        return elem.attrib["value"]
    elem = issue.find("fhir:details", FHIR_NS)
    if elem is not None and "value" in elem.attrib:
        return elem.attrib["value"]
    return ""

def get_constraint_prefix(details):
    if details.startswith("Constraint failed:"):
        parts = details.split(":", 2)
        if len(parts) >= 2:
            return f"{parts[0]}:{parts[1]}"
    return details.split(":", 1)[0]

def color(text, code): return f"\033[{code}m{text}\033[0m"
def green(text): return color(text, "32")
def red(text): return color(text, "31")
def yellow(text): return color(text, "33")
def bold(text): return color(text, "1")
def checkmark(): return "✅"
def crossmark(): return "❌"
def warn(): return "⚠️"

# Build a map: (filename, key) -> list of all error prefixes for that file
all_errors_by_file = defaultdict(list)

for entry in root.findall("fhir:entry", FHIR_NS):
    resource = entry.find("fhir:resource", FHIR_NS)
    if resource is None:
        continue
    op_outcome = resource.find("fhir:OperationOutcome", FHIR_NS)
    if op_outcome is None:
        continue
    # Find filename
    filename = None
    for ext in op_outcome.findall("fhir:extension", FHIR_NS):
        if ext.attrib.get("url") == "http://hl7.org/fhir/StructureDefinition/operationoutcome-file":
            val = ext.find("fhir:valueString", FHIR_NS)
            if val is not None and "value" in val.attrib:
                filename = val.attrib["value"]
    if not filename:
        continue
    short_filename = os.path.basename(filename)
    # Extract constraint key from filename
    match = re.search(r"-C-([A-Za-z0-9_]+)", short_filename)
    constraint_key = match.group(1) if match else None
    if not constraint_key:
        continue  # Only process files with a constraint key
    # Collect all error prefixes for this file
    for issue in op_outcome.findall("fhir:issue", FHIR_NS):
        sev = issue.find("fhir:severity", FHIR_NS)
        if sev is not None and sev.attrib.get("value", "").lower() == "error":
            details = get_issue_details(issue)
            prefix = get_constraint_prefix(details)
            all_errors_by_file[(short_filename, constraint_key)].append(prefix)

if all_errors_by_file:
    print("\n==Constraint Mismatches==\n")
    for (fname, key), prefixes in all_errors_by_file.items():
        expected_prefix = f"Constraint failed: {key}"
        triggered_expected = any(p.startswith(expected_prefix) for p in prefixes)
        unexpected = [p for p in prefixes if not p.startswith(expected_prefix)]
        
        if not triggered_expected or unexpected:
            print(f"{fname} | key: {key}")
        if not triggered_expected:
            print(f"{crossmark()} {red('Expected Constraint did not trigger!')}")
            
        # List unexpected constraints (those not matching the key)
        if unexpected:
            print(f"{warn()} {yellow('Unexpected triggered Constraints:')}")
            for p in unexpected:
                print(f"   - {p}")
        if not triggered_expected or unexpected:
            print()
else:
    print("\nAll constraint error details match their key.")
