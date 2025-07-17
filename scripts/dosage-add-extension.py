import os
import sys
import json
import subprocess
import shutil

REMOVE_EXTENSION_URL = "http://ig.fhir.de/igs/medication/StructureDefinition/GeneratedDosageInstructions"

def filter_extensions(extensions):
    return [ext for ext in extensions if ext.get("url") != REMOVE_EXTENSION_URL]

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

def get_dosage_arrays(resource):
    rtype = resource.get("resourceType")
    if rtype == "MedicationRequest" or rtype == "MedicationDispense":
        return [resource.get("dosageInstruction", [])]
    elif rtype == "MedicationStatement":
        return [resource.get("dosage", [])]
    return []

def run_dosage_to_text(script_path, dosage):
    import tempfile
    with tempfile.NamedTemporaryFile("w", delete=False, suffix=".json", encoding="utf-8") as tf:
        json.dump(dosage, tf, ensure_ascii=False, indent=2)
        temp_path = tf.name
    try:
        output = subprocess.check_output(['python3', script_path, temp_path], text=True).strip()
        return output.replace('\n', '\n')
    except Exception as e:
        return f"Fehler beim Verarbeiten der Dosierung: {e}"
    finally:
        os.unlink(temp_path)

def process_file(input_path, output_path, script_path):
    with open(input_path, 'r', encoding='utf-8') as f:
        resource = json.load(f)

    changed = False
    for dosage_array in get_dosage_arrays(resource):
        for dosage in dosage_array:
            # Skip dosages with a "text" field
            if "text" in dosage:
                continue
            # Remove existing extension
            if "extension" in dosage:
                old = len(dosage["extension"])
                dosage["extension"] = filter_extensions(dosage["extension"])
                if len(dosage["extension"]) != old:
                    changed = True
                if not dosage["extension"]:
                    del dosage["extension"]
                    changed = True

            # Generate text for this dosage
            dosage_text = run_dosage_to_text(script_path, dosage)
            # Only add if there's a result
            if dosage_text:
                if "extension" not in dosage:
                    dosage["extension"] = []
                dosage["extension"].append(build_extension(dosage_text))
                changed = True

    # Write to output folder (overwrite or new file)
    with open(output_path, 'w', encoding='utf-8') as f:
        json.dump(resource, f, indent=2, ensure_ascii=False)

def main():
    if len(sys.argv) != 4:
        print("Usage: python3 add-dosage-extensions.py input_folder output_folder dosage-to-text.py")
        sys.exit(1)

    input_folder = sys.argv[1]
    output_folder = sys.argv[2]
    dosage_to_text_script_path = sys.argv[3]

    os.makedirs(output_folder, exist_ok=True)
    
    # Filter only Valid files
    RESOURCE_PREFIXES = ("MedicationRequest", "MedicationDispense", "MedicationStatement")

    files = [
        f for f in os.listdir(input_folder)
        if (
            f.endswith('.json') and
            os.path.isfile(os.path.join(input_folder, f)) and
            f.startswith(RESOURCE_PREFIXES) and
            "Invalid" not in f and
            "Unsupported" not in f
        )
    ]


    for filename in files:
        input_path = os.path.join(input_folder, filename)
        output_path = os.path.join(output_folder, filename)
        try:
            process_file(input_path, output_path, dosage_to_text_script_path)
        except Exception as e:
            print(f"Error processing {filename}: {e}")
            shutil.copy2(input_path, output_path)

    print(f"Processed add dosage extension.")
    
if __name__ == "__main__":
    main()
