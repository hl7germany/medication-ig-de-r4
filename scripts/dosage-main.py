import os
import subprocess
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import importlib
fetch_algorithm = importlib.import_module("fetch-algorithm")

def main():
    base_dir = os.path.dirname(os.path.abspath(__file__))

    input_folder = os.path.normpath(os.path.join(base_dir, "../fsh-generated/resources"))
    output_folder = os.path.normpath(os.path.join(base_dir, "../input/includes"))
    extension_script = os.path.join(base_dir, "dosage-add-extension.py")

    # 0. Provide the pinned algorithm version from the external repository.
    #    Its __version__ is written into every resource as algorithmVersion.
    print("Providing the pinned dosage text generation algorithm...")
    medication_dosage_script = fetch_algorithm.main()

    # 1. Add consolidated dosage extensions to resources (using the updated extension script)
    print("Adding renderedDosageInstruction and GeneratedDosageInstructionsMeta extensions to medication resources...")
    subprocess.run([
        'python3', extension_script, input_folder, input_folder, medication_dosage_script
    ], check=True)

    # 1b. Verify example file names before the publisher runs. Both conditions
    #     they check fail late and with misleading messages otherwise.
    print("Checking example file names...")
    name_check_script = os.path.join(base_dir, "check-example-filenames.py")
    subprocess.run(['python3', name_check_script, input_folder], check=True)

    # 2. Generate the supported/unsupported table
    print("Generating unsupported table...")
    unsupported_table_script = os.path.join(base_dir, "dosage-generate-unsupported-table.py")
    subprocess.run(['python3', unsupported_table_script, input_folder, output_folder], check=True)

    # 3. Generate the dosage matrix for constraint examples
    print("Generating dosage matrix for constraint examples...")
    matrix_constraint_script = os.path.join(base_dir, "dosage-generate-constraint-matrix.py")
    subprocess.run(['python3', matrix_constraint_script, input_folder, output_folder], check=True)

    # 4. Generate the dosage summary table with consolidated dosage texts
    print("Generating dosage summary table...")
    summary_table_script = os.path.join(base_dir, "generate-dosage-summary-table.py")
    subprocess.run(['python3', summary_table_script, medication_dosage_script], check=True)

    print("All steps completed.")

if __name__ == "__main__":
    main()
