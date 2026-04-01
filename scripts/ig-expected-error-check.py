import os
import xml.etree.ElementTree as ET

# Path to qa.xml (relative to script)
xml_path = os.path.join(os.path.dirname(__file__), "../output/qa.xml")
resources_dir = os.path.join(os.path.dirname(__file__), "../fsh-generated/resources")

# FHIR namespace
FHIR_NS = {'fhir': 'http://hl7.org/fhir'}

# Parse XML
tree = ET.parse(xml_path)
root = tree.getroot()

total_errors = 0
expected_errors = 0
unexpected_errors = 0
unexpected_files = set()
false_positive_files = set()

# Track which -INV- resources have errors (store just the filename, not the full path)
inv_resources_with_errors = set()

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

    # Check all issues for errors
    for issue in op_outcome.findall("fhir:issue", FHIR_NS):
        sev = issue.find("fhir:severity", FHIR_NS)
        if sev is not None and sev.attrib.get("value", "").lower() == "error":
            total_errors += 1
            # Determine expected/unexpected
            # Expected errors: -INV-, -INV-C, -Invalid-, -Unsupported-, or contain "inv-", "invalid", "unsupported"
            if filename and ("-INV-" in filename or "-INV-C" in filename or "-Invalid-" in filename or "-Unsupported-" in filename or 
                           "invalid" in filename.lower() or "inv-" in filename.lower() or "unsupported" in filename.lower()):
                expected_errors += 1
                # Track that this -INV- resource has an error (extract just the base filename)
                if filename and ("-INV-" in filename or "-INV-C" in filename):
                    base_name = os.path.basename(filename).replace(".json", "")
                    inv_resources_with_errors.add(base_name)
            else:
                unexpected_errors += 1
                # Only add non-empty filenames
                if filename:
                    unexpected_files.add(filename)
                else:
                    unexpected_files.add("<no filename>")

# Check for false positives: -INV- resources that should have errors but don't
if os.path.isdir(resources_dir):
    for filename in os.listdir(resources_dir):
        # Only check Medication resources with -INV- or -INV-C in their names
        if ("-INV-" in filename or "-INV-C" in filename) and filename.endswith(".json"):
            base_name = filename.replace(".json", "")
            # If this resource doesn't have an error in qa.xml, it's a false positive
            if base_name not in inv_resources_with_errors:
                false_positive_files.add(base_name)

print("==Error Check==")
print(f"{total_errors} Errors")
print(f"{expected_errors} Expected Error Issues")
print(f"{unexpected_errors} Unexpected Errors in")
for fname in unexpected_files:
    print(f"- {fname}")

if false_positive_files:
    print(f"\n{len(false_positive_files)} False Positives:")
    for fname in sorted(false_positive_files):
        print(f"- {fname}")
