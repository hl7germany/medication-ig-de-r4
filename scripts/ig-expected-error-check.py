import os
import xml.etree.ElementTree as ET
import re
import json

# Path to qa.xml (relative to script)
xml_path = os.path.join(os.path.dirname(__file__), "../output/qa.xml")
resources_dir = os.path.join(os.path.dirname(__file__), "../fsh-generated/resources")

# FHIR namespace
FHIR_NS = {'fhir': 'http://hl7.org/fhir'}
RESOURCE_TYPES = ("MedicationRequest", "MedicationDispense", "MedicationStatement")

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
# Track constraint keys observed per file from QA errors
constraint_keys_by_file = {}
# Track in which resource types a constraint key was triggered
constraint_resource_types = {}


def extract_constraint_key(issue):
    """Extract failing invariant key from issue details text, if present."""
    details = issue.find("fhir:details", FHIR_NS)
    if details is None:
        return None
    details_text = details.find("fhir:text", FHIR_NS)
    if details_text is None:
        return None
    value = details_text.attrib.get("value", "")
    match = re.search(r"Constraint failed: ([A-Za-z0-9]+):", value)
    if match:
        return match.group(1)
    return None


def extract_expected_constraint_key(filename):
    """
    Extract expected key from a -C- constraint filename.
    Supported naming patterns include both:
    - ...-C-<Key>.json
    - ...-C-<Key>-MD.json / -MS.json
    - ...-C-<Key>-Request-01-of-05.json (and Dispense/Statement variants)
    """
    match = re.match(
        r".*-C-([A-Za-z0-9]+)(?:-(?:Request|Dispense|Statement|MR|MD|MS))?(?:-\d+-of-\d+)?\.json$",
        filename,
    )
    if match:
        return match.group(1)
    return None


def get_resource_type_from_filename(filename):
    """Derive medication resource type from resource filename."""
    base = os.path.basename(filename)
    for resource_type in RESOURCE_TYPES:
        if base.startswith(resource_type + "-"):
            return resource_type
    return None


def load_error_constraint_keys(resources_path):
    """Load all error-level constraint keys from local medication StructureDefinitions."""
    sd_names = {"TimingDgMP", "TimingDE", "DosageDE", "DosageDgMP"}
    keys = set()

    if not os.path.isdir(resources_path):
        return keys

    for filename in os.listdir(resources_path):
        if not (filename.startswith("StructureDefinition-") and filename.endswith(".json")):
            continue
        path = os.path.join(resources_path, filename)
        try:
            with open(path, "r", encoding="utf-8") as f:
                sd = json.load(f)
        except Exception:
            continue
        if sd.get("name") not in sd_names:
            continue
        for element in sd.get("differential", {}).get("element", []):
            for constraint in (element.get("constraint") or []):
                if constraint.get("severity", "").lower() == "error":
                    key = constraint.get("key")
                    if key:
                        keys.add(key)
    return keys

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
            # Track which constraint key(s) actually fired for this file
            if filename:
                base_file = os.path.basename(filename)
                key = extract_constraint_key(issue)
                if key:
                    if base_file not in constraint_keys_by_file:
                        constraint_keys_by_file[base_file] = set()
                    constraint_keys_by_file[base_file].add(key)
                    resource_type = get_resource_type_from_filename(base_file)
                    if resource_type:
                        if key not in constraint_resource_types:
                            constraint_resource_types[key] = set()
                        constraint_resource_types[key].add(resource_type)
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

# Check whether -C- files actually trigger the expected constraint key
constraint_files_checked = 0
constraint_files_expected_found = 0
constraint_missing_expected = []
if os.path.isdir(resources_dir):
    for filename in os.listdir(resources_dir):
        if not filename.endswith(".json"):
            continue
        expected_key = extract_expected_constraint_key(filename)
        if not expected_key:
            continue
        constraint_files_checked += 1
        observed = constraint_keys_by_file.get(filename, set())
        if expected_key in observed:
            constraint_files_expected_found += 1
        else:
            constraint_missing_expected.append((filename, expected_key, sorted(observed)))

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

print("\n==Constraint Key Check")
print(f"{constraint_files_expected_found}/{constraint_files_checked} files include expected constraint key")

if constraint_missing_expected:
    print(f"\n{len(constraint_missing_expected)} files missing expected key:")
    for filename, expected_key, observed in sorted(constraint_missing_expected):
        observed_text = ", ".join(observed) if observed else "<none>"
        print(f"- {filename}: expected {expected_key}, observed {observed_text}")

print("\n==Error Constraint Coverage (by resource type)==")
error_constraint_keys = load_error_constraint_keys(resources_dir)
fully_covered = 0
missing_coverage = []

for key in sorted(error_constraint_keys):
    covered_types = constraint_resource_types.get(key, set())
    missing_types = [rt for rt in RESOURCE_TYPES if rt not in covered_types]
    if missing_types:
        missing_coverage.append((key, missing_types, sorted(covered_types)))
    else:
        fully_covered += 1

print(f"{fully_covered}/{len(error_constraint_keys)} error constraints triggered in all 3 resource types")

if missing_coverage:
    print(f"\n{len(missing_coverage)} error constraints with missing resource-type coverage:")
    for key, missing_types, covered_types in missing_coverage:
        covered_text = ", ".join(covered_types) if covered_types else "<none>"
        print(f"- {key}: missing {', '.join(missing_types)} (covered: {covered_text})")
