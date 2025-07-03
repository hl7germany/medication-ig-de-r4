import os
import sys
import json
import subprocess

MATRIX_COLUMNS = [
    "description", "duration", "durationUnit", "frequency", "frequencyMax",
    "period", "periodUnit", "periodMax", "Day of Week", "Time Of Day",
    "when", "offset", "bounds[x]", "count"
]

def extract_timing_matrix_fields(timing):
    def get(val, default=""):
        return val if val is not None else default

    fields = {}
    fields["description"] = ""  # will be filled with text from dosage-to-text.py
    fields["duration"] = str(get(timing.get("repeat", {}).get("duration", "")))
    fields["durationUnit"] = get(timing.get("repeat", {}).get("durationUnit", ""))
    fields["frequency"] = str(get(timing.get("repeat", {}).get("frequency", "")))
    fields["frequencyMax"] = str(get(timing.get("repeat", {}).get("frequencyMax", "")))
    fields["period"] = str(get(timing.get("repeat", {}).get("period", "")))
    fields["periodUnit"] = get(timing.get("repeat", {}).get("periodUnit", ""))
    fields["periodMax"] = str(get(timing.get("repeat", {}).get("periodMax", "")))
    fields["Day of Week"] = " | ".join(timing.get("repeat", {}).get("dayOfWeek", []))
    fields["Time Of Day"] = " | ".join(timing.get("repeat", {}).get("timeOfDay", []))
    fields["when"] = " | ".join(timing.get("repeat", {}).get("when", []))
    fields["offset"] = str(get(timing.get("repeat", {}).get("offset", "")))
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
    fields["count"] = str(get(timing.get("repeat", {}).get("count", "")))
    return fields

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
            timing = None
            for dosage in resource.get("dosageInstruction", []):
                if "timing" in dosage:
                    timing = dosage["timing"]
                    break
            if not timing:
                continue  # skip if no timing

            # description (text) from your script
            try:
                result = subprocess.check_output(['python3', script_path, rel_file_path], text=True).strip()
                result = result.replace('\n', '<br>')
            except Exception as e:
                result = f"Fehler beim Verarbeiten der Datei: {e}"

            file_link = f"[{os.path.splitext(filename)[0]}](./{filename.replace('.json', '.html')})"
            fields = extract_timing_matrix_fields(timing)
            row = [file_link, result]
            row += [str(fields.get(col, "")) for col in MATRIX_COLUMNS[1:]]
            matrix_rows.append(row)
        except Exception as e:
            print(f"Error processing {filename}: {e}", file=sys.stderr)

    header = "| " + " | ".join(["File", "description"] + MATRIX_COLUMNS[1:]) + " |"
    sep = "| " + " | ".join([":---:"] * (2 + len(MATRIX_COLUMNS) - 1)) + " |"
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
