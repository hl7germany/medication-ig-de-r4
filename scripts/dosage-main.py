import os
import subprocess

def main():
    base_dir = os.path.dirname(os.path.abspath(__file__))

    input_folder = os.path.normpath(os.path.join(base_dir, "../fsh-generated/resources"))
    output_folder = os.path.normpath(os.path.join(base_dir, "../input/includes"))
    dosage_to_text_script = os.path.join(base_dir, "dosage-to-text.py")
    extension_script = os.path.join(base_dir, "add-dosage-extension.py")

    # 1. Add dosage extensions to resources
    print("Adding dosage extensions...")
    subprocess.run([
        'python3', extension_script, input_folder, input_folder, dosage_to_text_script
    ], check=True)

    # 2. Generate the supported/unsupported table
    print("Generating unsupported table...")
    unsupported_table_script = os.path.join(base_dir, "generate-unsupported-table.py")
    subprocess.run(['python3', unsupported_table_script, input_folder, output_folder, dosage_to_text_script], check=True)

    # # 3. Generate the dosage matrix
    # print("Generating dosage matrix...")
    # matrix_script = os.path.join(base_dir, "generate-dosage-matrix.py")
    # subprocess.run(['python3', matrix_script], check=True)

    print("All steps completed.")

if __name__ == "__main__":
    main()
