import os
import sys
import json
import subprocess

MATRIX_COLUMNS = [
    "duration", "durationUnit", "frequency", "period", "periodUnit",
    "Day<br>of<br>Week", "Time<br>Of<br>Day", "when", "bounds[x]"
    # Removed frequencyMax, periodMax, offset, count
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


def generate_matrix(input_folder, script_path, output_path):
    all_files = [
        f for f in os.listdir(input_folder)
        if (
            f.startswith('MedicationRequest-')
            and os.path.isfile(os.path.join(input_folder, f))
            and "Valid" not in f
            and "Invalid" not in f
            and "Unsupported" not in f
        )
    ]

    matrix_rows = []
    for filename in all_files:
        file_path = os.path.join(input_folder, filename)
        rel_file_path = os.path.relpath(file_path)
        try:
            with open(file_path, "r", encoding="utf-8") as f:
                resource = json.load(f)
            dosages = resource.get("dosageInstruction", [])
            if not dosages:
                continue  # skip if no dosages
            for idx, dosage in enumerate(dosages, start=1):
                if "timing" not in dosage:
                    continue  # skip if no timing

                timing = dosage["timing"]

                # description (text) from your script
                try:
                    # If your script supports dosage index, add str(idx-1) as an argument
                    result = subprocess.check_output(
                        ['python3', script_path, rel_file_path, str(idx-1)],
                        text=True
                    ).strip()
                    result = result.replace('\n', '<br>')
                except Exception as e:
                    result = f"Fehler beim Verarbeiten der Datei: {e}"

                file_link = f"[{os.path.splitext(filename)[0]}-dosage-{idx}](./{filename.replace('.json', f'-dosage-{idx}.html')})"
                fields = extract_timing_matrix_fields(timing)
                dose_quantity = extract_dose_quantity(dosage)
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
    print(f"Matrix table written to: {output_path}")

if __name__ == "__main__":
    base_dir = os.path.dirname(os.path.abspath(__file__))
    input_folder = os.path.normpath(os.path.join(base_dir, "../fsh-generated/resources"))
    script_path = os.path.join(base_dir, "dosage-to-text.py")
    output_dir = os.path.normpath(os.path.join(base_dir, "../input/includes"))
    os.makedirs(output_dir, exist_ok=True)

    matrix_md_path = os.path.join(output_dir, "dosage-timing-matrix.md")
    generate_matrix(input_folder, script_path, matrix_md_path)
