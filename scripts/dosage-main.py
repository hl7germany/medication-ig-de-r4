import os
import subprocess

def main():
    base_dir = os.path.dirname(os.path.abspath(__file__))

    input_folder = os.path.normpath(os.path.join(base_dir, "../fsh-generated/resources"))
    output_folder = os.path.normpath(os.path.join(base_dir, "../input/includes"))
    dosage_to_text_script = os.path.join(base_dir, "dosage-to-text.py")
    consolidated_dosage_script = os.path.join(base_dir, "medication-dosage-to-text.py")
    extension_script = os.path.join(base_dir, "dosage-add-extension.py")

    # 1. Add consolidated dosage extensions to resources (using the updated extension script)
    print("Adding renderedDosageInstruction and GeneratedDosageInstructionsMeta extensions to medication resources...")
    subprocess.run([
        'python3', extension_script, input_folder, input_folder, consolidated_dosage_script
    ], check=True)

    # 2. Generate the supported/unsupported table
    print("Generating unsupported table...")
    unsupported_table_script = os.path.join(base_dir, "dosage-generate-unsupported-table.py")
    subprocess.run(['python3', unsupported_table_script, input_folder, output_folder, dosage_to_text_script], check=True)

    # 3. Generate the dosage matrix
    print("Generating dosage matrix...")
    matrix_script = os.path.join(base_dir, "dosage-generate-matrix.py")
    subprocess.run(['python3', matrix_script, input_folder, output_folder, dosage_to_text_script], check=True)
    
    # 4. Generate the dosage matrix for constraint examples
    print("Generating dosage matrix for constraint examples...")
    matrix_constraint_script = os.path.join(base_dir, "dosage-generate-constraint-matrix.py")
    subprocess.run(['python3', matrix_constraint_script, input_folder, output_folder, dosage_to_text_script], check=True)

    # 5. Generate the dosage summary table with consolidated dosage texts
    print("Generating dosage summary table...")
    summary_table_script = os.path.join(base_dir, "generate-dosage-summary-table.py")
    subprocess.run(['python3', summary_table_script], check=True)

    print("All steps completed.")

if __name__ == "__main__":
    main()
