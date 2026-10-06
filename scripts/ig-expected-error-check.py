import os
import sys
import xml.etree.ElementTree as ET
import re
import json

# Path to qa.xml (relative to script)
xml_path = os.path.join(os.path.dirname(__file__), "../output/qa.xml")
resources_dir = os.path.join(os.path.dirname(__file__), "../fsh-generated/resources")
qa_html_path = os.path.join(os.path.dirname(__file__), "../output/qa.html")
# Zusätzliche Constraints, die ein -C-Beispiel neben dem erwarteten auslösen darf (siehe unten)
baseline_path = os.path.join(os.path.dirname(__file__), "expected-additional-constraints.json")
WRITE_BASELINE = "--write-baseline" in sys.argv

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
# Track constraint keys observed per file from QA issues
error_constraint_keys_by_file = {}
warning_constraint_keys_by_file = {}
# Track in which resource types a constraint key was triggered
error_constraint_resource_types = {}
warning_constraint_resource_types = {}


def extract_constraint_key(issue):
    """Extract failing invariant key from issue details text, if present."""
    details = issue.find("fhir:details", FHIR_NS)
    if details is None:
        return None
    details_text = details.find("fhir:text", FHIR_NS)
    if details_text is None:
        return None
    value = details_text.attrib.get("value", "")
    # Constraint keys may include "-", ".", and "_" (e.g. "dos-1").
    match = re.search(r"Constraint failed: ([A-Za-z0-9][A-Za-z0-9._-]*):", value)
    if match:
        return match.group(1)
    return None


def extract_expected_constraint_keys(filename, marker="-C-"):
    """
    Extract the candidate keys from a constraint filename, most specific first.
    Supported naming patterns include both:
    - ...<marker><Key>.json
    - ...<marker><Key>-MD.json / -MS.json
    - ...<marker><Key>-Request-01-of-05.json (and Dispense/Statement variants)
    A key may itself end in a resource marker (e.g. ExtRequiresDosage-MD), therefore
    both the unstripped and the stripped variant are returned as candidates.
    """
    if not filename.endswith(".json") or marker not in filename:
        return []

    # Extract everything after the marker and strip known trailing resource markers.
    raw = filename[:-5].split(marker, 1)[1]
    key = re.sub(r"-(?:Request|Dispense|Statement|MR|MD|MS)-\d+-of-\d+$", "", raw)
    key = re.sub(r"-(?:Request|Dispense|Statement|MR|MD|MS)$", "", key)
    key = re.sub(r"-\d+-of-\d+$", "", key)
    return [k for k in dict.fromkeys([raw, key]) if k]


def get_resource_type_from_filename(filename):
    """Derive medication resource type from resource filename."""
    base = os.path.basename(filename)
    for resource_type in RESOURCE_TYPES:
        if base.startswith(resource_type + "-"):
            return resource_type
    return None


def load_constraint_keys(resources_path, severity):
    """Load constraint keys with the given severity from local medication StructureDefinitions."""
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
                if constraint.get("severity", "").lower() == severity:
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

    # Check all issues for errors and warnings
    for issue in op_outcome.findall("fhir:issue", FHIR_NS):
        sev = issue.find("fhir:severity", FHIR_NS)
        severity = sev.attrib.get("value", "").lower() if sev is not None else ""
        if severity == "warning" and filename:
            base_file = os.path.basename(filename)
            key = extract_constraint_key(issue)
            if key:
                if base_file not in warning_constraint_keys_by_file:
                    warning_constraint_keys_by_file[base_file] = set()
                warning_constraint_keys_by_file[base_file].add(key)
                resource_type = get_resource_type_from_filename(base_file)
                if resource_type:
                    if key not in warning_constraint_resource_types:
                        warning_constraint_resource_types[key] = set()
                    warning_constraint_resource_types[key].add(resource_type)

        if severity == "error":
            total_errors += 1
            # Track which constraint key(s) actually fired for this file
            if filename:
                base_file = os.path.basename(filename)
                key = extract_constraint_key(issue)
                if key:
                    if base_file not in error_constraint_keys_by_file:
                        error_constraint_keys_by_file[base_file] = set()
                    error_constraint_keys_by_file[base_file].add(key)
                    resource_type = get_resource_type_from_filename(base_file)
                    if resource_type:
                        if key not in error_constraint_resource_types:
                            error_constraint_resource_types[key] = set()
                        error_constraint_resource_types[key].add(resource_type)
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
        expected_keys = extract_expected_constraint_keys(filename, "-C-")
        if not expected_keys:
            continue
        constraint_files_checked += 1
        observed = error_constraint_keys_by_file.get(filename, set())
        if any(key in observed for key in expected_keys):
            constraint_files_expected_found += 1
        else:
            constraint_missing_expected.append((filename, " or ".join(expected_keys), sorted(observed)))

# Check whether -W- files actually trigger the expected warning constraint key
warning_files_checked = 0
warning_files_expected_found = 0
warning_missing_expected = []
if os.path.isdir(resources_dir):
    for filename in os.listdir(resources_dir):
        if not filename.endswith(".json"):
            continue
        expected_keys = extract_expected_constraint_keys(filename, "-W-")
        if not expected_keys:
            continue
        warning_files_checked += 1
        observed = warning_constraint_keys_by_file.get(filename, set())
        if any(key in observed for key in expected_keys):
            warning_files_expected_found += 1
        else:
            warning_missing_expected.append((filename, " or ".join(expected_keys), sorted(observed)))

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

print("\n==Warning Constraint Check")
print(f"{warning_files_expected_found}/{warning_files_checked} files include expected warning constraint key")

if warning_missing_expected:
    print(f"\n{len(warning_missing_expected)} files missing expected warning key:")
    for filename, expected_key, observed in sorted(warning_missing_expected):
        observed_text = ", ".join(observed) if observed else "<none>"
        print(f"- {filename}: expected {expected_key}, observed {observed_text}")

print("\n==Error Constraint Coverage (by resource type)==")
error_constraint_keys = load_constraint_keys(resources_dir, "error")
fully_covered = 0
missing_coverage = []

for key in sorted(error_constraint_keys):
    covered_types = error_constraint_resource_types.get(key, set())
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

print("\n==Warning Constraint Coverage (by resource type)==")
warning_constraint_keys = load_constraint_keys(resources_dir, "warning")
warning_fully_covered = 0
warning_missing_coverage = []

for key in sorted(warning_constraint_keys):
    covered_types = warning_constraint_resource_types.get(key, set())
    missing_types = [rt for rt in RESOURCE_TYPES if rt not in covered_types]
    if missing_types:
        warning_missing_coverage.append((key, missing_types, sorted(covered_types)))
    else:
        warning_fully_covered += 1

print(f"{warning_fully_covered}/{len(warning_constraint_keys)} warning constraints triggered in all 3 resource types")

if warning_missing_coverage:
    print(f"\n{len(warning_missing_coverage)} warning constraints with missing resource-type coverage:")
    for key, missing_types, covered_types in warning_missing_coverage:
        covered_text = ", ".join(covered_types) if covered_types else "<none>"
        print(f"- {key}: missing {', '.join(missing_types)} (covered: {covered_text})")


# --- Isolierte Negativbeispiele ---------------------------------------------------------
# Ein -C-Beispiel soll nur seinen eigenen Constraint verletzen. Löst es weitere aus, kann es
# eine zu lockere Regel verdecken: So lösten die dos-1-Beispiele auf den dgMP-Profilen immer
# auch den strengeren dgMP-Fehler aus, und dass dos-1 selbst zu locker war, fiel nicht auf.
# Bekannte, fachlich unvermeidbare Nebeneffekte stehen je erwartetem Key in
# scripts/expected-additional-constraints.json. Neue Nebeneffekte schlagen fehl, bis sie dort
# bewusst eingetragen sind (python3 scripts/ig-expected-error-check.py --write-baseline).
print("\n==Isolation Check (zusätzliche Fehler in -C-Beispielen)==")
baseline = {}
if os.path.isfile(baseline_path):
    with open(baseline_path, "r", encoding="utf-8") as f:
        baseline = {k: set(v) for k, v in json.load(f).items() if not k.startswith("_")}
observed_extra = {}
isolation_violations = []
for filename, observed in sorted(error_constraint_keys_by_file.items()):
    candidates = extract_expected_constraint_keys(filename, "-C-")
    if not candidates:
        continue
    expected = next((c for c in candidates if c in observed), candidates[-1])
    extra = observed - set(candidates)
    if not extra:
        continue
    observed_extra.setdefault(expected, set()).update(extra)
    not_allowed = extra - baseline.get(expected, set())
    if not_allowed:
        isolation_violations.append((filename, expected, sorted(not_allowed)))
if WRITE_BASELINE:
    data = {"_comment": "Je erwartetem Constraint-Key: weitere Constraints, die dessen -C-Beispiele zusätzlich auslösen dürfen. Erzeugt mit --write-baseline; Änderungen im Review prüfen."}
    data.update({k: sorted(v) for k, v in sorted(observed_extra.items())})
    with open(baseline_path, "w", encoding="utf-8") as f:
        json.dump(data, f, indent=2, ensure_ascii=False)
        f.write("\n")
    print(f"Baseline geschrieben: {len(observed_extra)} Keys mit zusätzlichen Constraints")
    isolation_violations = []
print(f"{len(isolation_violations)} Beispiele mit nicht eingetragenen zusätzlichen Constraints")
for filename, expected, extra in isolation_violations:
    print(f"- {filename}: erwartet {expected}, zusätzlich {', '.join(extra)}")

# --- Fehlerbeispiele für DE-Regeln auf DE-Profilen -----------------------------------------
# Ein Fehler, den DosageDE/TimingDE definieren, muss auf einem DE-Profil getestet werden.
# Auf einem dgMP-Profil greift zusätzlich die strengere dgMP-Regel und verdeckt die DE-Regel.
print("\n==DE-Fehler auf DE-Profilen==")
de_error_keys = set()
for name in os.listdir(resources_dir):
    if name.startswith("StructureDefinition-") and name.endswith(".json"):
        with open(os.path.join(resources_dir, name), "r", encoding="utf-8") as f:
            sd = json.load(f)
        if sd.get("name") in ("DosageDE", "TimingDE"):
            for element in sd.get("differential", {}).get("element", []):
                for constraint in element.get("constraint") or []:
                    if constraint.get("severity") == "error":
                        de_error_keys.add(constraint.get("key"))
profile_violations = []
for filename in sorted(os.listdir(resources_dir)):
    candidates = extract_expected_constraint_keys(filename, "-C-")
    if not candidates or not any(c in de_error_keys for c in candidates):
        continue
    with open(os.path.join(resources_dir, filename), "r", encoding="utf-8") as f:
        profiles = json.load(f).get("meta", {}).get("profile", [])
    if not any(p.endswith("DE") for p in profiles):
        profile_violations.append((filename, profiles))
print(f"{len(profile_violations)} Fehlerbeispiele für DE-Regeln ohne DE-Profil")
for filename, profiles in profile_violations:
    print(f"- {filename}: {', '.join(profiles) or '<kein Profil>'}")

# --- Links ---------------------------------------------------------------------------------
print("\n==Broken Links==")
broken_links = 0
if os.path.isfile(qa_html_path):
    with open(qa_html_path, "r", encoding="utf-8") as f:
        match = re.search(r"broken links = (\d+)", f.read())
    broken_links = int(match.group(1)) if match else 0
print(f"{broken_links} Broken Links (Details in output/qa.html)")

# --- Ergebnis ------------------------------------------------------------------------------
failed = {
    "unerwartete Fehler": unexpected_errors,
    "False Positives": len(false_positive_files),
    "Beispiele ohne erwarteten Fehler-Key": len(constraint_missing_expected),
    "Beispiele ohne erwarteten Warn-Key": len(warning_missing_expected),
    "Fehler-Constraints ohne Abdeckung aller Ressourcentypen": len(missing_coverage),
    "Warn-Constraints ohne Abdeckung aller Ressourcentypen": len(warning_missing_coverage),
    "nicht isolierte Negativbeispiele": len(isolation_violations),
    "DE-Fehlerbeispiele ohne DE-Profil": len(profile_violations),
    "Broken Links": broken_links,
}
problems = {k: v for k, v in failed.items() if v}
if problems:
    print("\nFEHLGESCHLAGEN: " + "; ".join(f"{v} {k}" for k, v in problems.items()))
    sys.exit(1)
print("\nAlle Prüfungen bestanden.")
