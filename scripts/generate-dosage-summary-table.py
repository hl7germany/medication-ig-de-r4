#!/usr/bin/env python3
import json
import os
import sys
import subprocess
from pathlib import Path

__version__ = "1.0.0"

def find_medication_resources(resources_dir):
    """Find all MedicationRequest, MedicationDispense, and MedicationStatement JSON files."""
    resources = []
    
    for file_path in Path(resources_dir).glob("*.json"):
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                resource = json.load(f)
                resource_type = resource.get('resourceType', '')
                
                if resource_type in ['MedicationRequest', 'MedicationDispense', 'MedicationStatement']:
                    resources.append({
                        'file_path': file_path,
                        'file_name': file_path.name,
                        'resource': resource,
                        'resource_type': resource_type
                    })
        except (json.JSONDecodeError, Exception) as e:
            print(f"Warnung: Konnte {file_path} nicht verarbeiten: {e}", file=sys.stderr)
    
    return sorted(resources, key=lambda x: x['file_name'])

def get_dosage_text(file_path, script_path):
    """Get consolidated dosage text using the medication-dosage-to-text.py script."""
    try:
        result = subprocess.run(
            ['python3', str(script_path), str(file_path)],
            capture_output=True,
            text=True,
            check=True
        )
        return result.stdout.strip()
    except subprocess.CalledProcessError as e:
        return f"Fehler: {e.stderr.strip()}"
    except Exception as e:
        return f"Fehler: {str(e)}"

def extract_dosage_details(resource):
    """Extract dosage details for the table."""
    dosages = []
    
    # Get dosage instructions based on resource type
    if resource['resourceType'] == 'MedicationRequest':
        dosage_instructions = resource.get('dosageInstruction', [])
    elif resource['resourceType'] == 'MedicationDispense':
        dosage_instructions = resource.get('dosageInstruction', [])
    elif resource['resourceType'] == 'MedicationStatement':
        dosage_instructions = resource.get('dosage', [])
    else:
        return dosages
    
    for dosage in dosage_instructions:
        details = {}
        
        # Dose quantity
        dose_and_rate = dosage.get('doseAndRate', [])
        if dose_and_rate and dose_and_rate[0].get('doseQuantity'):
            dose_qty = dose_and_rate[0]['doseQuantity']
            value = dose_qty.get('value', '')
            unit = dose_qty.get('unit', '')
            details['doseQuantity'] = f"{value} {unit}".strip()
        else:
            details['doseQuantity'] = ""
        
        # Timing details
        timing = dosage.get('timing', {})
        repeat = timing.get('repeat', {})
        
        details['frequency'] = repeat.get('frequency', '')
        details['period'] = repeat.get('period', '')
        details['periodUnit'] = repeat.get('periodUnit', '')
        details['dayOfWeek'] = ', '.join(repeat.get('dayOfWeek', []))
        details['timeOfDay'] = ', '.join(repeat.get('timeOfDay', []))
        details['when'] = ', '.join(repeat.get('when', []))
        
        # Bounds
        bounds = repeat.get('boundsDuration')
        if bounds:
            details['bounds'] = str(bounds)
        else:
            details['bounds'] = ""
        
        dosages.append(details)
    
    return dosages

def generate_markdown_table(resources, script_path):
    """Generate the markdown table."""
    lines = []
    
    # Header
    lines.append("| File | Consolidated Dosage Text | doseQuantity | frequency | period | periodUnit | Day<br>of<br>Week | Time<br>Of<br>Day | when | bounds[x] |")
    lines.append("| :---: | :--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |")
    
    for resource_info in resources:
        file_name = resource_info['file_name']
        file_path = resource_info['file_path']
        resource = resource_info['resource']
        
        # Get consolidated dosage text
        consolidated_text = get_dosage_text(file_path, script_path)
        
        # Get individual dosage details
        dosage_details = extract_dosage_details(resource)
        
        if dosage_details:
            # First row with file name
            first_detail = dosage_details[0]
            file_link = f"[{file_name.replace('.json', '')}](./{file_name.replace('.json', '.html')})"
            
            lines.append(f"| {file_link} | {consolidated_text} | {first_detail['doseQuantity']} | {first_detail['frequency']} | {first_detail['period']} | {first_detail['periodUnit']} | {first_detail['dayOfWeek']} | {first_detail['timeOfDay']} | {first_detail['when']} | {first_detail['bounds']} |")
            
            # Additional rows for multiple dosages (if any)
            for detail in dosage_details[1:]:
                lines.append(f"|  |  | {detail['doseQuantity']} | {detail['frequency']} | {detail['period']} | {detail['periodUnit']} | {detail['dayOfWeek']} | {detail['timeOfDay']} | {detail['when']} | {detail['bounds']} |")
        else:
            # No dosage details found
            file_link = f"[{file_name.replace('.json', '')}](./{file_name.replace('.json', '.html')})"
            lines.append(f"| {file_link} | {consolidated_text} |  |  |  |  |  |  |  |  |")
    
    return '\n'.join(lines)

def main():
    # Get the script directory
    script_dir = Path(__file__).parent
    project_root = script_dir.parent
    
    # Paths
    resources_dir = project_root / "fsh-generated" / "resources"
    output_file = project_root / "input" / "includes" / "dosage-summary-matrix.md"
    dosage_script = script_dir / "medication-dosage-to-text.py"
    
    if not resources_dir.exists():
        print(f"Fehler: Ressourcen-Verzeichnis nicht gefunden: {resources_dir}", file=sys.stderr)
        sys.exit(1)
    
    if not dosage_script.exists():
        print(f"Fehler: Dosage-Script nicht gefunden: {dosage_script}", file=sys.stderr)
        sys.exit(1)
    
    print(f"Suche nach Medication-Ressourcen in: {resources_dir}")
    resources = find_medication_resources(resources_dir)
    print(f"Gefunden: {len(resources)} Ressourcen")
    
    if not resources:
        print("Keine Medication-Ressourcen gefunden.")
        sys.exit(0)
    
    print("Generiere Markdown-Tabelle...")
    markdown_content = generate_markdown_table(resources, dosage_script)
    
    # Write output file
    output_file.parent.mkdir(parents=True, exist_ok=True)
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write(markdown_content)
    
    print(f"Tabelle erfolgreich erstellt: {output_file}")
    print(f"Verarbeitete Ressourcen: {len(resources)}")

if __name__ == "__main__":
    main()
