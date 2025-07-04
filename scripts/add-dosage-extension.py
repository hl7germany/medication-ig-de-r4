import json
import sys
import os

def add_extension_to_medicationrequest(file_path, dosage_text):
    with open(file_path, 'r', encoding='utf-8') as f:
        data = json.load(f)

    # Build the extension
    extension = {
        "url": "http://fhir.de/StructureDefinition/GeneratedDosageInstructions",
        "extension": [
            {
                "url": "text",
                "valueString": dosage_text
            },
            {
                "url": "algorithm",
                "valueCoding": {
                    "code": "GermanDosageTextGenerator",
                    "system": "http://fhir.de/CodeSystem/DosageTextAlgorithms",
                    "version": "1.0.0"
                }
            }
        ]
    }

    # Ensure dosageInstruction exists
    if "dosageInstruction" not in data or not data["dosageInstruction"]:
        return

    # Add the extension to each dosageInstruction
    for dosage in data["dosageInstruction"]:
        if "extension" not in dosage:
            dosage["extension"] = []
        dosage["extension"].append(extension)

    # Overwrite the file (or write to a new file)
    with open(file_path, 'w', encoding='utf-8') as f:
        json.dump(data, f, indent=2, ensure_ascii=False)

if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Usage: python3 add_dosage_extension.py path-to-medicationrequest-file dosage-text")
        sys.exit(1)
    add_extension_to_medicationrequest(sys.argv[1], sys.argv[2])
