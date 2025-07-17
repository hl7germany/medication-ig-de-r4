import os
import sys
import json
import subprocess
import tempfile

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

def run_dosage_to_text(script_path, dosage):
    """Run the dosage-to-text.py script on a single dosage."""
    with tempfile.NamedTemporaryFile("w", delete=False, suffix=".json", encoding="utf-8") as tf:
        json.dump(dosage, tf, ensure_ascii=False, indent=2)
        temp_path = tf.name
    try:
        output = subprocess.check_output(['python3', script_path, temp_path], text=True).strip()
        return output.replace('\n', '<br>')
    except Exception as e:
        return f"Fehler beim Verarbeiten der Dosierung: {e}"
    finally:
        os.unlink(temp_path)

def process_files(input_folder, script_path):
    unsupported_rows = []
    all_files = [
        f for f in os.listdir(input_folder)
        if (
            f.startswith("MedicationRequest-") or
            f.startswith("MedicationDispense-") or
            f.startswith("MedicationStatement-")
        ) and f.endswith('.json') and os.path.isfile(os.path.join(input_folder, f))
    ]
    for filename in all_files:
        if "Unsupported" not in filename:
            continue
        file_path = os.path.join(input_folder, filename)
        filename_no_ext = os.path.splitext(filename)[0]
        md_link = f"[{filename_no_ext}](./{filename.replace('.json', '.html')})"
        try:
            with open(file_path, encoding="utf-8") as jf:
                resource = json.load(jf)
            dosages = extract_dosages(resource)
            if not dosages:
                result = "Keine Dosierungsanweisung gefunden."
            else:
                results = [run_dosage_to_text(script_path, dosage) for dosage in dosages]
                result = "<br><br>".join(results)
        except Exception as e:
            result = f"Fehler beim Verarbeiten der Datei: {e}"
        row = f"|{md_link} | {result} |"
        unsupported_rows.append(row)
    header = "| Beispiel | Ergebnis |\n| :---: | :---:|"
    unsupported_table = header + "\n" + "\n".join(unsupported_rows)
    return unsupported_table

def main():
    if len(sys.argv) != 4:
        print("Usage: python script.py <input_folder> <output_folder> <dosage_to_text_script>")
        sys.exit(1)

    input_folder = sys.argv[1]
    output_folder = sys.argv[2]
    dosage_to_text_script = sys.argv[3]
    os.makedirs(output_folder, exist_ok=True)

    unsupported_table = process_files(input_folder, dosage_to_text_script)
    
    # Write markdown tables
    output_path = os.path.join(output_folder, "unsupported-dosage-examples.md")
    with open(output_path, "w") as f:
        f.write(unsupported_table)
    print(f"Markdown tables written to {output_path}")

if __name__ == "__main__":
    main()
