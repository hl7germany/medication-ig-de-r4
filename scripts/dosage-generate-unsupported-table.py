import os
import sys
import json

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

def process_files(input_folder):
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
            # Just check if dosages exist, but don't generate text
            if not dosages:
                continue  # Skip files without dosages
        except Exception as e:
            continue  # Skip files that can't be processed
        row = f"|{md_link} |"
        unsupported_rows.append(row)
    header = "| Beispiel |\n| :---: |"
    unsupported_table = header + "\n" + "\n".join(unsupported_rows)
    return unsupported_table

def main():
    if len(sys.argv) != 3:
        print("Usage: python script.py <input_folder> <output_folder>")
        sys.exit(1)

    input_folder = sys.argv[1]
    output_folder = sys.argv[2]
    os.makedirs(output_folder, exist_ok=True)

    unsupported_table = process_files(input_folder)
    
    # Write markdown tables
    output_path = os.path.join(output_folder, "unsupported-schema-beispiele.md")
    with open(output_path, "w") as f:
        f.write(unsupported_table)
    print(f"Markdown tables written to {output_path}")

if __name__ == "__main__":
    main()
