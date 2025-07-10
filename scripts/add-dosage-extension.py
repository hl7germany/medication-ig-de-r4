import json
import sys

# The URL to filter/remove and use in the new extension
REMOVE_EXTENSION_URL = "http://ig.fhir.de/igs/medication/StructureDefinition/GeneratedDosageInstructions"

def add_extension_to_medicationresource(file_path, dosage_text):
    with open(file_path, 'r', encoding='utf-8') as f:
        data = json.load(f)
    # Build the extension, using the variable
    extension = {
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

    # Helper function to filter extensions
    def filter_extensions(extensions):
        return [ext for ext in extensions if ext.get("url") != REMOVE_EXTENSION_URL]

    # Handle MedicationRequest: dosageInstruction
    if "dosageInstruction" in data and data["dosageInstruction"]:
        for dosage in data["dosageInstruction"]:
            if "extension" in dosage:
                dosage["extension"] = filter_extensions(dosage["extension"])
            else:
                dosage["extension"] = []
            dosage["extension"].append(extension)

    # Handle MedicationStatement: dosage
    if "dosage" in data and data["dosage"]:
        for dosage in data["dosage"]:
            if "extension" in dosage:
                dosage["extension"] = filter_extensions(dosage["extension"])
            else:
                dosage["extension"] = []
            dosage["extension"].append(extension)

    # Overwrite the file (or write to a new file)
    with open(file_path, 'w', encoding='utf-8') as f:
        json.dump(data, f, indent=2, ensure_ascii=False)

if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Usage: python3 add_dosage_extension.py path-to-medicationresource-file dosage-text")
        sys.exit(1)
    add_extension_to_medicationresource(sys.argv[1], sys.argv[2])
