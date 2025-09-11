import os
import sys
import json
import subprocess

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

def run_medication_dosage_to_text(script_path, resource_file_path):
    """Run the medication-dosage-to-text.py script on a complete medication resource."""
    try:
        output = subprocess.check_output(['python3', script_path, resource_file_path], text=True).strip()
        return output.replace('\n', '<br>')
    except Exception as e:
        return f"Fehler beim Verarbeiten der Dosierung: {e}"

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
            display_name = os.path.splitext(filename)[0]
            file_link = f"[{display_name}](./{filename.replace('.json', '.html')})"
            
            # Generate consolidated dosage text for the entire resource
            dosage_text = run_medication_dosage_to_text(script_path, file_path)
            
            # Create a row with consolidated information for all dosages
            # Extract all dose quantities and timing fields from all dosages
            all_dose_quantities = []
            all_timing_fields = {}
            
            for dosage in dosages:
                # Collect dose quantity
                dose_quantity = extract_dose_quantity(dosage)
                if dose_quantity:
                    all_dose_quantities.append(dose_quantity)
                
                # Collect timing information if present
                if "timing" in dosage:
                    timing_fields = extract_timing_matrix_fields(dosage["timing"])
                    for key, value in timing_fields.items():
                        if value:  # Only include non-empty values
                            if key not in all_timing_fields:
                                all_timing_fields[key] = []
                            if value not in all_timing_fields[key]:
                                all_timing_fields[key].append(value)
            
            # Combine multiple values with <br> for display
            combined_dose_quantity = "<br>".join(all_dose_quantities) if all_dose_quantities else ""
            
            # Build the row with consolidated timing information
            row = [file_link, dosage_text, combined_dose_quantity]
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
    header = "| File | generated dosage instruction text | doseQuantity | " + " | ".join(MATRIX_COLUMNS) + " |"
    sep = "| :---: | :--- | :---: | " + " | ".join([":---:"] * len(MATRIX_COLUMNS)) + " |"
    md_table = header + "\n" + sep + "\n"
    for row in matrix_rows:
        md_table += "| " + " | ".join(row) + " |\n"
    with open(output_path, "w", encoding="utf-8") as f:
        f.write(md_table)
    print(f"Matrix table written")

def main():
    if len(sys.argv) != 4:
        print("Usage: python script.py <input_folder> <output_folder> <medication_dosage_to_text_script>")
        sys.exit(1)

    input_folder = sys.argv[1]
    output_folder = sys.argv[2]
    medication_dosage_to_text_script = sys.argv[3]
    os.makedirs(output_folder, exist_ok=True)

    matrix_md_path = os.path.join(output_folder, "dosage-timing-matrix.md")
    generate_matrix(input_folder, medication_dosage_to_text_script, matrix_md_path)

if __name__ == "__main__":
    main()
