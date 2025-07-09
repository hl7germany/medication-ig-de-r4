import os
import subprocess
import sys
import json
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

def process_files(input_folder, script_path):
    supported_rows = []
    unsupported_rows = []
    # Only include files that start with the correct prefixes
    all_files = [
        f for f in os.listdir(input_folder)
        if (
            f.startswith("MedicationRequest-") or
            f.startswith("MedicationDispense-") or
            f.startswith("MedicationStatement-")
        ) and f.endswith('.json') and os.path.isfile(os.path.join(input_folder, f))
    ]
    for filename in all_files:
        file_path = os.path.join(input_folder, filename)
        rel_file_path = os.path.relpath(file_path)
        try:
            with open(file_path, encoding="utf-8") as jf:
                resource = json.load(jf)
            dosages = extract_dosages(resource)
            if not dosages:
                result = "Keine Dosierungsanweisung gefunden."
            else:
                results = []
                for dosage in dosages:
                    with tempfile.NamedTemporaryFile("w", delete=False, suffix=".json", encoding="utf-8") as tf:
                        json.dump(dosage, tf, ensure_ascii=False, indent=2)
                        temp_path = tf.name
                    try:
                        output = subprocess.check_output(['python3', script_path, temp_path], text=True).strip()
                        output = output.replace('\n', '<br>')
                        results.append(output)
                    except Exception as e:
                        results.append(f"Fehler beim Verarbeiten der Dosierung: {e}")
                    finally:
                        os.unlink(temp_path)
                result = "<br><br>".join(results)
            # Also add the extension
            add_extension_script = os.path.join(base_dir, "add-dosage-extension.py")
            try:
                subprocess.run(['python3', add_extension_script, rel_file_path, result.replace('<br>', '\n')])
            except Exception:
                pass
        except Exception as e:
            result = f"Fehler beim Verarbeiten der Datei: {e}"
        filename_no_ext = os.path.splitext(filename)[0]
        md_link = f"[{filename_no_ext}](./{filename.replace('.json', '.html')})"
        row = f"|{md_link} | {result} |"
        if "Unsupported" in filename:
            unsupported_rows.append(row)
        elif "Invalid" not in filename and "Valid" not in filename:
            supported_rows.append(row)
    header = "| Beispiel | Ergebnis |\n| :---: | :---:|"
    supported_table = header + "\n" + "\n".join(supported_rows)
    unsupported_table = header + "\n" + "\n".join(unsupported_rows)
    return supported_table, unsupported_table

if __name__ == "__main__":
    base_dir = os.path.dirname(os.path.abspath(__file__))
    input_folder = os.path.normpath(os.path.join(base_dir, "../fsh-generated/resources"))
    script_path = os.path.join(base_dir, "dosage-to-text.py")
    output_dir = os.path.normpath(os.path.join(base_dir, "../input/includes"))
    os.makedirs(output_dir, exist_ok=True)
    supported_table, unsupported_table = process_files(input_folder, script_path)
    with open(os.path.join(output_dir, "supported-dosage-examples.md"), "w") as f:
        f.write(supported_table)
    with open(os.path.join(output_dir, "unsupported-dosage-examples.md"), "w") as f:
        f.write(unsupported_table)
    print("Markdown tables written to:")
    print(f"- {os.path.join(output_dir, 'supported-dosage-examples.md')}")
    print(f"- {os.path.join(output_dir, 'unsupported-dosage-examples.md')}")
    # Generate the matrix table
    matrix_script_path = os.path.join(base_dir, "generate-dosage-matrix.py")
    subprocess.run(['python3', matrix_script_path])
