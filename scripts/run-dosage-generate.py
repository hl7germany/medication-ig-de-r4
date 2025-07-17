import os
import subprocess
import sys
import json
import tempfile
import json

REMOVE_EXTENSION_URL = "http://ig.fhir.de/igs/medication/StructureDefinition/GeneratedDosageInstructions"

def add_dosage_extensions_to_file(file_path, script_path):
    """For each dosage, generate text and add as extension (removing any existing ones)."""
    with open(file_path, 'r', encoding='utf-8') as f:
        data = json.load(f)

    def filter_extensions(extensions):
        return [ext for ext in extensions if ext.get("url") != REMOVE_EXTENSION_URL]

    # Helper to build the extension for a given text
    def build_extension(dosage_text):
        return {
            "url": REMOVE_EXTENSION_URL,
            "extension": [
                {
                    "url": "text",
                    "valueString": dosage_text
                },
                {
                    "url": "algorithm",
                    "valueCoding": {
                        "code": "GermanDosageTextGenerator",
                        "system": "http://ig.fhir.de/igs/medication/CodeSystem/DosageTextAlgorithms",
                        "version": "1.0.0"
                    }
                }
            ]
        }

    # Handle MedicationRequest: dosageInstruction
    if "dosageInstruction" in data and data["dosageInstruction"]:
        for dosage in data["dosageInstruction"]:
            dosage_text = run_dosage_to_text(script_path, dosage)
            # Remove any old extension
            if "extension" in dosage:
                existing_exts = filter_extensions(dosage["extension"])
            else:
                existing_exts = []
            # Add new extension if text is non-empty
            if dosage_text:
                existing_exts.append(build_extension(dosage_text.replace('<br>', '\n')))
            if existing_exts:
                dosage["extension"] = existing_exts
            else:
                dosage.pop("extension", None)

    # Handle MedicationStatement: dosage
    if "dosage" in data and data["dosage"]:
        for dosage in data["dosage"]:
            dosage_text = run_dosage_to_text(script_path, dosage)
            if "extension" in dosage:
                existing_exts = filter_extensions(dosage["extension"])
            else:
                existing_exts = []
            if dosage_text:
                existing_exts.append(build_extension(dosage_text.replace('<br>', '\n')))
            if existing_exts:
                dosage["extension"] = existing_exts
            else:
                dosage.pop("extension", None)

    # Overwrite the file
    with open(file_path, 'w', encoding='utf-8') as f:
        json.dump(data, f, indent=2, ensure_ascii=False)


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
        output = output.replace('\n', '<br>')
    except Exception as e:
        output = f"Fehler beim Verarbeiten der Dosierung: {e}"
    finally:
        os.unlink(temp_path)
    return output

def add_dosage_extensions_to_file(file_path, script_path):
    """Adds dosage text as extensions to each dosage in the file."""
    with open(file_path, encoding='utf-8') as jf:
        resource = json.load(jf)
    dosages = extract_dosages(resource)
    if not dosages:
        return  # Nothing to do
    for dosage in dosages:
        # Get the text for this dosage
        dosage_text = run_dosage_to_text(script_path, dosage)
        # Add as an extension (FHIR style: "extension": [{"url": "...", "valueString": "..."}])
        extension = {
            "url": "http://example.org/fhir/StructureDefinition/dosage-text",  # Use your real URL
            "valueString": dosage_text.replace('<br>', '\n')
        }
        if "extension" in dosage:
            dosage["extension"].append(extension)
        else:
            dosage["extension"] = [extension]
    # Write the updated resource back to disk (overwrite or as new file)
    with open(file_path, 'w', encoding='utf-8') as jf:
        json.dump(resource, jf, ensure_ascii=False, indent=2)


def run_generate_dosage_matrix(matrix_script_path):
    """Run generate-dosage-matrix.py."""
    try:
        subprocess.run(['python3', matrix_script_path])
    except Exception as e:
        print(f"Fehler beim Generieren der Matrix: {e}")

def process_files(input_folder, script_path, add_extension_script, extension_files):
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
        file_path = os.path.join(input_folder, filename)
        rel_file_path = os.path.relpath(file_path)
        try:
            with open(file_path, encoding="utf-8") as jf:
                resource = json.load(jf)
            dosages = extract_dosages(resource)
            if not dosages:
                result = "Keine Dosierungsanweisung gefunden."
                results = []
            else:
                results = [run_dosage_to_text(script_path, dosage) for dosage in dosages]
                result = "<br><br>".join(results)
                
            # For each dosage, add the extension if this file is in extension_files
            if filename in extension_files and dosages:
                add_dosage_extensions_to_file(file_path, script_path)
                
        except Exception as e:
            result = f"Fehler beim Verarbeiten der Datei: {e}"
        filename_no_ext = os.path.splitext(filename)[0]
        md_link = f"[{filename_no_ext}](./{filename.replace('.json', '.html')})"
        row = f"|{md_link} | {result} |"
        if "Unsupported" in filename:
            unsupported_rows.append(row)
    header = "| Beispiel | Ergebnis |\n| :---: | :---:|"
    unsupported_table = header + "\n" + "\n".join(unsupported_rows)
    return unsupported_table

def get_extension_files(all_files):
    """Filter files for which extensions should be added."""
    return [
        f for f in all_files
        if not (
            "Valid" in f or
            "Invalid" in f or
            "Unsupported" in f
        )
    ]

def main():
    base_dir = os.path.dirname(os.path.abspath(__file__))
    input_folder = os.path.normpath(os.path.join(base_dir, "../fsh-generated/resources"))
    script_path = os.path.join(base_dir, "dosage-to-text.py")
    add_extension_script = os.path.join(base_dir, "add-dosage-extension.py")
    output_dir = os.path.normpath(os.path.join(base_dir, "../input/includes"))
    os.makedirs(output_dir, exist_ok=True)
    # Prepare extension file list
    all_files = [
        f for f in os.listdir(input_folder)
        if (
            f.startswith("MedicationRequest-") or
            f.startswith("MedicationDispense-") or
            f.startswith("MedicationStatement-")
        ) and f.endswith('.json') and os.path.isfile(os.path.join(input_folder, f))
    ]
    extension_files = get_extension_files(all_files)
    # Process all files
    unsupported_table = process_files(
        input_folder, script_path, add_extension_script, extension_files
    )
    
    # Write markdown tables
    with open(os.path.join(output_dir, "unsupported-dosage-examples.md"), "w") as f:
        f.write(unsupported_table)
    print("Markdown tables written")
    # Generate the matrix table
    matrix_script_path = os.path.join(base_dir, "generate-dosage-matrix.py")
    run_generate_dosage_matrix(matrix_script_path)


if __name__ == "__main__":
    main()
