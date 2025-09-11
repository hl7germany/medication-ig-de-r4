import os
import sys
import json
from typing import List, Dict, Any

MATRIX_COLUMNS = [
    "duration", "durationUnit", "frequency", "period", "periodUnit",
    "Day<br>of<br>Week", "Time<br>Of<br>Day", "when", "bounds[x]"
]
COLUMN_KEYS = [
    "duration", "durationUnit", "frequency", "period", "periodUnit",
    "Day of Week", "Time Of Day", "when", "bounds[x]"
]

def extract_timing_matrix_fields(timing):
    def get(val, default=""):
        return val if val is not None else default
    fields = {}
    fields["duration"] = str(get(timing.get("repeat", {}).get("duration", "")))
    fields["durationUnit"] = get(timing.get("repeat", {}).get("durationUnit", ""))
    fields["frequency"] = str(get(timing.get("repeat", {}).get("frequency", "")))
    fields["period"] = str(get(timing.get("repeat", {}).get("period", "")))
    fields["periodUnit"] = get(timing.get("repeat", {}).get("periodUnit", ""))
    fields["Day of Week"] = ", ".join(timing.get("repeat", {}).get("dayOfWeek", []))
    fields["Time Of Day"] = ", ".join(timing.get("repeat", {}).get("timeOfDay", []))
    fields["when"] = ", ".join(timing.get("repeat", {}).get("when", []))
    bounds = timing.get("repeat", {}).get("boundsDuration") \
        or timing.get("repeat", {}).get("boundsPeriod") \
        or timing.get("repeat", {}).get("boundsRange")
    if bounds:
        if "duration" in bounds:
            fields["bounds[x]"] = f"Duration = {bounds['duration']} {bounds.get('unit', '')}"
        elif "start" in bounds:
            fields["bounds[x]"] = f"Period.start = {bounds['start']}"
        else:
            fields["bounds[x]"] = str(bounds)
    else:
        fields["bounds[x]"] = ""
    return fields

def extract_dose_quantity(dosage):
    dq = dosage.get("doseAndRate", [{}])[0].get("doseQuantity")
    if dq:
        value = dq.get("value", "")
        unit = dq.get("unit", "")
        return f"{value} {unit}".strip()
    return ""

def extract_dosages(resource):
    """Extract dosage objects from supported FHIR resource types."""
    if not isinstance(resource, dict):
        return []
    resource_type = resource.get("resourceType")
    if resource_type == "MedicationRequest":
        return resource.get("dosageInstruction", [])
    elif resource_type == "MedicationStatement":
        return resource.get("dosage", []) or resource.get("dosageInstruction", [])
    elif resource_type == "MedicationDispense":
        return resource.get("dosageInstruction", [])
    return []

def find_structure_definitions(input_folder: str, names: List[str]) -> Dict[str, Dict[str, Any]]:
    """Return a dict name->StructureDefinition JSON for given profile names (first match per name)."""
    wanted = set(names)
    found: Dict[str, Dict[str, Any]] = {}
    for filename in os.listdir(input_folder):
        if not filename.startswith("StructureDefinition-") or not filename.endswith(".json"):
            continue
        path = os.path.join(input_folder, filename)
        try:
            with open(path, "r", encoding="utf-8") as f:
                sd = json.load(f)
        except Exception:
            continue
        name = sd.get("name")
        if name in wanted and name not in found:
            found[name] = sd
        if wanted == set(found.keys()):  # all collected
            break
    return found

def extract_constraints_from_element(sd: Dict[str, Any], element_id: str, source: str) -> List[Dict[str, str]]:
    """Extract constraints (key + severity) for a given element id within a StructureDefinition differential."""
    results: List[Dict[str, str]] = []
    for element in sd.get("differential", {}).get("element", []):
        if element.get("id") == element_id:
            for c in element.get("constraint", []) or []:
                key = c.get("key")
                if key:
                    results.append({
                        "key": key,
                        "severity": c.get("severity", "error"),
                        "source": source,
                        "profile": sd.get("name", "")
                    })
            break
    return results

def generate_matrix_for_constraint(input_folder, output_path, constraint_key, severity):
    """Generate matrix for a specific constraint key. Returns True if examples found.

    Examples: filenames containing -C-<key> (error) or -W-<key> (warning).
    """
    markers = [f"-C-{constraint_key}", f"-W-{constraint_key}"]
    all_files: List[str] = []
    for f in os.listdir(input_folder):
        if not (f.startswith('MedicationRequest-') or f.startswith('MedicationDispense-') or f.startswith('MedicationStatement-')):
            continue
        fp = os.path.join(input_folder, f)
        if not os.path.isfile(fp):
            continue
        if any(m in f for m in markers):
            all_files.append(f)
    matrix_rows = []
    for filename in all_files:
        file_path = os.path.join(input_folder, filename)
        try:
            with open(file_path, "r", encoding="utf-8") as f:
                resource = json.load(f)
            dosages = extract_dosages(resource)
            if not dosages:
                continue  # skip if no dosages
            display_name = os.path.splitext(filename)[0]
            file_link = f"[{display_name}](./{filename.replace('.json', '.html')})"
            
            # Create a row with consolidated information for all dosages
            # Extract all dose quantities and timing fields from all dosages
            all_dose_quantities = []
            all_timing_fields = {}
            
            for dosage in dosages:
                # Collect dose quantity
                dose_quantity = extract_dose_quantity(dosage)
                if dose_quantity:
                    all_dose_quantities.append(dose_quantity)
                
                # Collect timing information
                if "timing" in dosage:
                    timing_fields = extract_timing_matrix_fields(dosage["timing"])
                else:
                    timing_fields = {k: '' for k in COLUMN_KEYS}
                
                for key, value in timing_fields.items():
                    if value:  # Only include non-empty values
                        if key not in all_timing_fields:
                            all_timing_fields[key] = []
                        if value not in all_timing_fields[key]:
                            all_timing_fields[key].append(value)
            
            # Combine multiple values with <br> for display
            combined_dose_quantity = "<br>".join(all_dose_quantities) if all_dose_quantities else ""
            
            # Build the row with consolidated timing information (without dosage text)
            row = [file_link, combined_dose_quantity]
            for key in COLUMN_KEYS:
                if key in all_timing_fields and all_timing_fields[key]:
                    # Join multiple values with <br>
                    combined_value = "<br>".join(str(v) for v in all_timing_fields[key])
                    row.append(combined_value)
                else:
                    row.append("")
            
            matrix_rows.append(row)
        except Exception as e:
            print(f"Error processing {filename}: {e}", file=sys.stderr)
    if not matrix_rows:
        return False
    header = "| File | doseQuantity | " + " | ".join(MATRIX_COLUMNS) + " |"
    sep = "| :---: | :---: | " + " | ".join([":---:"] * len(MATRIX_COLUMNS)) + " |"
    md_table = header + "\n" + sep + "\n"
    for row in matrix_rows:
        md_table += "| " + " | ".join(row) + " |\n"
    with open(output_path, "w", encoding="utf-8") as f:
        f.write(md_table)
    # Suppress per-table output; summary printed later.
    return True

def main():
    if len(sys.argv) != 3:
        print("Usage: python script.py <input_folder> <output_folder>")
        sys.exit(1)

    input_folder = sys.argv[1]
    output_folder = sys.argv[2]
    os.makedirs(output_folder, exist_ok=True)

    # Step 0: Remove previously generated constraint tables to avoid stale leftovers
    try:
        for fname in os.listdir(output_folder):
            if fname.startswith("dosage-constraint-") and fname.endswith(".md"):
                try:
                    os.remove(os.path.join(output_folder, fname))
                except Exception as e:
                    print(f"WARNING: Could not remove old file {fname}: {e}", file=sys.stderr)
    except FileNotFoundError:
        # Should not happen because we created the folder, but ignore if it does
        pass

    # Step 1: Find relevant StructureDefinitions
    sd_map = find_structure_definitions(input_folder, ["TimingDgMP", "TimingDE", "DosageDE", "DosageDgMP"])
    if "TimingDgMP" not in sd_map:
        print("ERROR: StructureDefinition with name 'TimingDgMP' not found in input folder.")
        sys.exit(1)

    # Step 2: Collect constraints
    constraints = []
    constraints += extract_constraints_from_element(sd_map["TimingDgMP"], "Timing.repeat", "Timing.repeat")
    if "TimingDE" in sd_map:
        constraints += extract_constraints_from_element(sd_map["TimingDE"], "Timing.repeat", "Timing.repeat")
    if "DosageDE" in sd_map:
        constraints += extract_constraints_from_element(sd_map["DosageDE"], "Dosage", "Dosage")
    if "DosageDgMP" in sd_map:
        constraints += extract_constraints_from_element(sd_map["DosageDgMP"], "Dosage", "Dosage")

    if not constraints:
        print("ERROR: No constraints found (Timing.repeat or Dosage roots).")
        sys.exit(1)

    # Merge: prefer higher severity (error>warning) and dgMP profile if same severity
    severity_rank = {"error": 2, "warning": 1}
    merged: Dict[str, Dict[str, str]] = {}
    for c in constraints:
        key = c["key"]
        if key not in merged:
            merged[key] = c
            continue
        cur = merged[key]
        if severity_rank.get(c["severity"], 0) > severity_rank.get(cur["severity"], 0):
            merged[key] = c
        elif c["severity"] == cur["severity"] and c.get("profile", "").endswith("DgMP") and not cur.get("profile", "").endswith("DgMP"):
            merged[key] = c

    failures_error: List[str] = []
    failures_warning: List[str] = []
    generated_counts = {"error": 0, "warning": 0}
    for key, meta in sorted(merged.items()):
        out_md = os.path.join(output_folder, f"dosage-constraint-{key}-examples.md")
        found = generate_matrix_for_constraint(input_folder, out_md, key, meta["severity"])
        if not found:
            if meta["severity"] == "error":
                failures_error.append(key)
            else:
                failures_warning.append(key)
        else:
            if meta["severity"] in generated_counts:
                generated_counts[meta["severity"]] += 1
            else:
                generated_counts[meta["severity"]] = 1

    # ANSI colors
    YELLOW = "\033[33m"
    GREEN = "\033[32m"
    RED = "\033[31m"
    RESET = "\033[0m"

    if failures_error:
        print(f"{RED}ERROR: Missing example files for ERROR constraints:{RESET}", file=sys.stderr)
        for k in failures_error:
            print(f"{YELLOW}  - {k}{RESET}", file=sys.stderr)
        if failures_warning:
            print(f"{YELLOW}WARNING: Missing warning-level examples for: {', '.join(failures_warning)}{RESET}", file=sys.stderr)

    # Success path
    summary = (
        f"Generated constraint tables: {generated_counts.get('error',0)} Error-Constraints and {generated_counts.get('warning',0)} Warning-Constraints"
    )
    if failures_warning:
        print(f"{GREEN}{summary}{RESET}")
        print(f"{YELLOW}WARNING: Missing warning-level examples count: {len(failures_warning)} ({', '.join(failures_warning)}){RESET}")
    else:
        print(f"{GREEN}{summary}{RESET}")

if __name__ == "__main__":
    main()