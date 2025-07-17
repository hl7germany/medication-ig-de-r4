import os
import sys
import json
import subprocess
import tempfile

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
        # FHIR allows both 'dosage' (R4) and 'dosageInstruction' (R3)
        return resource.get("dosage", []) or resource.get("dosageInstruction", [])
    elif resource_type == "MedicationDispense":
        return resource.get("dosageInstruction", [])
    return []

def generate_matrix(input_folder, script_path, output_path):
    all_files = [
        f for f in os.listdir(input_folder)
        if (
            (
                f.startswith('MedicationRequest-') or
                f.startswith('MedicationDispense-') or
                f.startswith('MedicationStatement-')
            )
            and os.path.isfile(os.path.join(input_folder, f))
            and "Valid" not in f
            and "Invalid" not in f
            and "Unsupported" not in f
        )
    ]
    matrix_rows = []
    for filename in all_files:
        file_path = os.path.join(input_folder, filename)
        try:
            with open(file_path, "r", encoding="utf-8") as f:
                resource = json.load(f)
            dosages = extract_dosages(resource)
            if not dosages:
                continue  # skip if no dosages
            add_suffix = len(dosages) > 1
            for idx, dosage in enumerate(dosages, start=1):
                if "timing" not in dosage:
                    continue  # skip if no timing
                timing = dosage["timing"]
                # Write dosage to temp file and call script
                try:
                    with tempfile.NamedTemporaryFile("w", delete=False, suffix=".json", encoding="utf-8") as tf:
                        json.dump(dosage, tf, ensure_ascii=False, indent=2)
                        temp_path = tf.name
                    try:
                        result = subprocess.check_output(
                            ['python3', script_path, temp_path],
                            text=True
                        ).strip()
                        result = result.replace('\n', '<br>')
                    except Exception as e:
                        result = f"Fehler beim Verarbeiten der Datei: {e}"
                    finally:
                        os.unlink(temp_path)
                except Exception as e:
                    result = f"Fehler beim Schreiben/Verarbeiten der Dosierung: {e}"
                # Only add -dosage-n to the display name if there are multiple dosages
                display_name = os.path.splitext(filename)[0]
                if add_suffix:
                    display_name = f"{display_name}-dosage-{idx}"
                file_link = f"[{display_name}](./{filename.replace('.json', '.html')})"
                dose_quantity = extract_dose_quantity(dosage)
                fields = extract_timing_matrix_fields(timing)
                row = [file_link, result, dose_quantity]
                row += [str(fields.get(key, "")) for key in COLUMN_KEYS]
                matrix_rows.append(row)
        except Exception as e:
            print(f"Error processing {filename}: {e}", file=sys.stderr)
    header = "| File | description | doseQuantity | " + " | ".join(MATRIX_COLUMNS) + " |"
    sep = "| :---: | :--- | :---: | " + " | ".join([":---:"] * len(MATRIX_COLUMNS)) + " |"
    md_table = header + "\n" + sep + "\n"
    for row in matrix_rows:
        md_table += "| " + " | ".join(row) + " |\n"
    with open(output_path, "w", encoding="utf-8") as f:
        f.write(md_table)
    print(f"Matrix table written")

def main():
    if len(sys.argv) != 4:
        print("Usage: python script.py <input_folder> <output_folder> <dosage_to_text_script>")
        sys.exit(1)

    input_folder = sys.argv[1]
    output_folder = sys.argv[2]
    dosage_to_text_script = sys.argv[3]
    os.makedirs(output_folder, exist_ok=True)

    matrix_md_path = os.path.join(output_folder, "dosage-timing-matrix.md")
    generate_matrix(input_folder, dosage_to_text_script, matrix_md_path)

if __name__ == "__main__":
    main()