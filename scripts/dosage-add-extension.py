import os
import sys
import json
import subprocess
import shutil

# Extension URLs for different resource types
EXTENSION_URLS = {
    "MedicationRequest": "http://hl7.org/fhir/5.0/StructureDefinition/extension-MedicationRequest.renderedDosageInstruction",
    "MedicationDispense": "http://hl7.org/fhir/5.0/StructureDefinition/extension-MedicationDispense.renderedDosageInstruction",
    "MedicationStatement": "http://hl7.org/fhir/5.0/StructureDefinition/extension-MedicationStatement.renderedDosageInstruction"
}

# All renderedDosageInstruction URLs (useful for cleaning placeholders)
ALL_RENDERED_DOSAGE_URLS = set(EXTENSION_URLS.values())

# Meta extension URL (same for all resource types)
META_EXTENSION_URL = "http://ig.fhir.de/igs/medication/StructureDefinition/GeneratedDosageInstructionsMeta"

def filter_rendered_dosage_extensions(extensions, resource_type):
    """Remove existing renderedDosageInstruction (only for this resource type) and GeneratedDosageInstructionsMeta extensions."""
    extension_url = EXTENSION_URLS.get(resource_type)
    if not extension_url:
        return extensions
    return [
        ext for ext in extensions
        if ext.get("url") not in [extension_url, META_EXTENSION_URL]
    ]

def build_rendered_dosage_extension(dosage_text, resource_type):
    """Build a renderedDosageInstruction extension with the consolidated dosage text."""
    extension_url = EXTENSION_URLS.get(resource_type)
    if not extension_url:
        return None
    
    return {
        "url": extension_url,
        "valueMarkdown": dosage_text
    }

def build_meta_extension():
    """Build the GeneratedDosageInstructionsMeta extension with metadata (without 'algorithm' slice)."""
    return {
        "url": META_EXTENSION_URL,
        "extension": [
            {
                "url": "algorithmVersion",
                "valueString": "1.0.2"
            },
            {
                "url": "language",
                "valueCode": "de-DE"
            }
        ]
    }

def has_dosages(resource):
    """Check if the resource has any dosage entries at all (structured or free text)."""
    rtype = resource.get("resourceType")
    if rtype in ("MedicationRequest", "MedicationDispense"):
        return bool(resource.get("dosageInstruction"))
    elif rtype == "MedicationStatement":
        return bool(resource.get("dosage"))
    return False

def should_skip_extension_generation(filename: str) -> bool:
    """Detect instances where extensions should NOT be generated at all (e.g., constraint test examples)."""
    name = os.path.basename(filename)
    # Skip generation for constraint test examples that intentionally lack extensions
    skip_markers = (
        "Invalid-Dosage-C-DosageRequiresGeneratedText",
        "Invalid-Dosage-C-DosageStructuredRequiresGeneratedText",
    )
    return any(marker in name for marker in skip_markers)

def remove_all_placeholders(resource: dict) -> bool:
    """Remove any renderedDosageInstruction (all variants) and GeneratedDosageInstructionsMeta."""
    if "extension" not in resource:
        return False
    old_count = len(resource["extension"])
    cleaned = []
    for ext in resource["extension"]:
        url = ext.get("url")
        if url in ALL_RENDERED_DOSAGE_URLS or url == META_EXTENSION_URL:
            continue
        cleaned.append(ext)
    resource["extension"] = cleaned
    if not resource["extension"]:
        del resource["extension"]
    return len(cleaned) != old_count

def run_consolidated_dosage_to_text(script_path, resource_file_path):
    """Run dosage text generation and return status + output based on exit code."""
    try:
        result = subprocess.run(
            ['python3', script_path, resource_file_path],
            capture_output=True,
            text=True
        )
        if result.returncode != 0:
            error_output = (result.stderr or result.stdout or "").strip()
            return False, "", error_output, result.returncode
        return True, result.stdout.strip(), "", 0
    except Exception as e:
        return False, "", str(e), -1

def process_file(input_path, output_path, script_path):
    """Process a single medication resource file to add consolidated dosage text."""
    with open(input_path, 'r', encoding='utf-8') as f:
        resource = json.load(f)

    resource_type = resource.get("resourceType")
    
    # Skip if resource type is not supported
    if resource_type not in EXTENSION_URLS:
        # Just copy the file unchanged
        with open(output_path, 'w', encoding='utf-8') as f:
            json.dump(resource, f, indent=2, ensure_ascii=False)
        return

    # Skip extension generation for constraint test examples
    if should_skip_extension_generation(input_path):
        # Remove any existing extensions (renderedDosageInstruction and GeneratedDosageInstructionsMeta)
        if "extension" in resource:
            resource["extension"] = filter_rendered_dosage_extensions(resource["extension"], resource_type)
            if not resource["extension"]:
                del resource["extension"]
        # Write the file without extensions
        with open(output_path, 'w', encoding='utf-8') as f:
            json.dump(resource, f, indent=2, ensure_ascii=False)
        return

    # Proceed only if the resource actually has any dosage entries
    if not has_dosages(resource):
        with open(output_path, 'w', encoding='utf-8') as f:
            json.dump(resource, f, indent=2, ensure_ascii=False)
        return

    changed = False

    # Remove only type-specific rendered extension + meta (same for all files)
    if "extension" in resource:
        old_count = len(resource["extension"])
        resource["extension"] = filter_rendered_dosage_extensions(resource["extension"], resource_type)
        if len(resource["extension"]) != old_count:
            changed = True
        if not resource["extension"]:
            del resource["extension"]
            changed = True

    # Generate consolidated dosage text for the entire resource
    success, dosage_text, error_output, return_code = run_consolidated_dosage_to_text(script_path, input_path)

    # Only add extensions if generation succeeded and returned a non-empty text.
    if success and dosage_text:
        # Build the renderedDosageInstruction extension
        dosage_extension = build_rendered_dosage_extension(dosage_text, resource_type)
        # Build the meta extension
        meta_extension = build_meta_extension()

        if dosage_extension and meta_extension:
            if "extension" not in resource:
                resource["extension"] = []
            resource["extension"].append(dosage_extension)
            resource["extension"].append(meta_extension)
            changed = True
    elif not success:
        filename = os.path.basename(input_path)
        print(f"Skipping extension for {filename}: dosage generation failed (exit {return_code}): {error_output}")

    # Write to output folder
    with open(output_path, 'w', encoding='utf-8') as f:
        json.dump(resource, f, indent=2, ensure_ascii=False)

def main():
    if len(sys.argv) != 4:
        print("Usage: python3 dosage-add-extension.py input_folder output_folder medication-dosage-to-text.py")
        sys.exit(1)

    input_folder = sys.argv[1]
    output_folder = sys.argv[2]
    consolidated_script_path = sys.argv[3]

    os.makedirs(output_folder, exist_ok=True)
    
    # Filter only valid medication resource files
    RESOURCE_PREFIXES = ("MedicationRequest", "MedicationDispense", "MedicationStatement")

    files = [
        f for f in os.listdir(input_folder)
        if (
            f.endswith('.json') and
            os.path.isfile(os.path.join(input_folder, f)) and
            f.startswith(RESOURCE_PREFIXES)
        )
    ]

    processed_count = 0
    for filename in files:
        input_path = os.path.join(input_folder, filename)
        output_path = os.path.join(output_folder, filename)
        try:
            process_file(input_path, output_path, consolidated_script_path)
            processed_count += 1
        except Exception as e:
            print(f"Error processing {filename}: {e}")
            shutil.copy2(input_path, output_path)

    print(f"Processed {processed_count} files and added renderedDosageInstruction and GeneratedDosageInstructionsMeta extensions.")
    
if __name__ == "__main__":
    main()
