import os
import re
import xml.etree.ElementTree as ET

# Path to qa.xml (relative to script)
xml_path = os.path.join(os.path.dirname(__file__), "../output/qa.xml")

# FHIR namespace
FHIR_NS = {'fhir': 'http://hl7.org/fhir'}

# Parse XML
tree = ET.parse(xml_path)
root = tree.getroot()

total_errors = 0
expected_errors = 0
unexpected_errors = 0
unexpected_files = set()
constraint_mismatches = []

def get_issue_details(issue):
    # Try the most likely FHIR XML locations for error details
    elem = issue.find("fhir:details/fhir:text", FHIR_NS)
    if elem is not None and "value" in elem.attrib:
        return elem.attrib["value"]
    # Fallbacks, just in case
    elem = issue.find("fhir:details", FHIR_NS)
    if elem is not None and "value" in elem.attrib:
        return elem.attrib["value"]
    return ""

def get_constraint_prefix(details):
    # Returns e.g. "Constraint failed: DosageStructuredRequiresBoth"
    if details.startswith("Constraint failed:"):
        parts = details.split(":", 2)  # Split into at most 3 parts
        if len(parts) >= 2:
            return f"{parts[0]}:{parts[1]}"
    return details.split(":", 1)[0]  # fallback: first segment


def extract_key_from_filename(filename):
    # Matches -C-<key> in the filename (non-greedy, up to next - or .)
    match = re.search(r"-C-([A-Za-z0-9_]+)", filename)
    return match.group(1) if match else None

for entry in root.findall("fhir:entry", FHIR_NS):
    resource = entry.find("fhir:resource", FHIR_NS)
    if resource is None:
        continue
    op_outcome = resource.find("fhir:OperationOutcome", FHIR_NS)
    if op_outcome is None:
        continue

    # Find the filename (if any)
    filename = None
    for ext in op_outcome.findall("fhir:extension", FHIR_NS):
        if ext.attrib.get("url") == "http://hl7.org/fhir/StructureDefinition/operationoutcome-file":
            val = ext.find("fhir:valueString", FHIR_NS)
            if val is not None and "value" in val.attrib:
                filename = val.attrib["value"]

    constraint_key = extract_key_from_filename(filename) if filename else None

    for issue in op_outcome.findall("fhir:issue", FHIR_NS):
        sev = issue.find("fhir:severity", FHIR_NS)
        if sev is not None and sev.attrib.get("value", "").lower() == "error":
            total_errors += 1
            # Get details string (try fhir:details/fhir:text/fhir:valueString, fallback to fhir:details/fhir:valueString)
            details = get_issue_details(issue)
            
            # Determine expected/unexpected
            if filename and ("invalid" in filename.lower() or "unsupported" in filename.lower()):
                expected_errors += 1
            else:
                unexpected_errors += 1
                if filename:
                    unexpected_files.add(os.path.basename(filename))
                else:
                    unexpected_files.add("<no filename>")

            # If -C-<key> in filename, check details
            if constraint_key:
                prefix = f"Constraint failed: {constraint_key}:"
                if not details.startswith(prefix):
                    constraint_mismatches.append({
                        "filename": filename,
                        "key": constraint_key,
                        "details": details
                    })

print("==Error Check==")
print(f"{total_errors} Errors")
print(f"{expected_errors} Expected Errors")
print(f"{unexpected_errors} Unexpected Errors in")
for fname in unexpected_files:
    print(f"- {fname}")

if constraint_mismatches:
    print("\n==Constraint Mismatches==")
    for mismatch in constraint_mismatches:
        print(f"{os.path.basename(mismatch['filename'])} | key: {mismatch['key']} | details: {get_constraint_prefix(mismatch['details'])}")
else:
    print("\nAll constraint error details match their key.")
