import os
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
            if filename and ("invalid" in filename.lower() or "unsupported" in filename.lower()):
                expected_errors += 1
            else:
                unexpected_errors += 1
                # Only add non-empty filenames
                if filename:
                    unexpected_files.add(filename)
                else:
                    unexpected_files.add("<no filename>")

print("==Error Check==")
print(f"{total_errors} Errors")
print(f"{expected_errors} Expected Errors")
print(f"{unexpected_errors} Unexpected Errors in")
for fname in unexpected_files:
    print(f"- {fname}")
