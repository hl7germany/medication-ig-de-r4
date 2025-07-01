import os
import subprocess
import sys

def process_files(input_folder, script_path):
    supported_rows = []
    unsupported_rows = []

    all_files = [
        f for f in os.listdir(input_folder)
        if f.startswith('MedicationRequest-') and os.path.isfile(os.path.join(input_folder, f))
    ]

    for filename in all_files:
        file_path = os.path.join(input_folder, filename)
        rel_file_path = os.path.relpath(file_path)
        try:
            result = subprocess.check_output(['python3', script_path, rel_file_path], text=True).strip()
            result = result.replace('\n', '<br>')
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
    # Corrected output directory
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
