#!/usr/bin/env python3
import json
import sys
import os

__version__ = "1.0.0"

class MedicationDosageTextGenerator:
    """
    Generates consolidated dosage text from FHIR MedicationRequest, MedicationDispense, or MedicationStatement resources.
    Supports different dosage schemas as defined in TimingOnlyOneType constraint.
    """
    
    def __init__(self):
        # Order for 4-Schema: morning, noon, evening, night
        self.when_order = ['MORN', 'NOON', 'EVE', 'NIGHT']
        self.when_translations = {
            'MORN': 'morgens',
            'NOON': 'mittags', 
            'EVE': 'abends',
            'NIGHT': 'zur Nacht'
        }
    
    def generate_dosage_text(self, resource):
        """
        Main method to generate consolidated dosage text from a FHIR resource.
        """
        # Extract dosage instructions based on resource type
        dosages = self._extract_dosages(resource)
        if not dosages:
            return ""
        
        # Determine the dosage schema type
        schema_type = self._determine_schema_type(dosages)
        
        # Generate text based on schema type
        if schema_type == "4-Schema":
            return self._generate_4_schema_text(dosages)
        elif schema_type == "TimeOfDay":
            return self._generate_time_of_day_text(dosages)
        elif schema_type == "DayOfWeek":
            return self._generate_day_of_week_text(dosages)
        elif schema_type == "Interval":
            return self._generate_interval_text(dosages)
        elif schema_type == "DayOfWeek and Time/4-Schema":
            return self._generate_dayofweek_and_time_schema_text(dosages)
        elif schema_type == "Interval and Time/4-Schema":
            return self._generate_interval_and_time_schema_text(dosages)
        else:
            return f"Unbekanntes Dosierungsschema: {schema_type}"
    
    def _extract_dosages(self, resource):
        """Extract dosage instructions from different resource types."""
        resource_type = resource.get('resourceType', '')
        
        if resource_type == 'MedicationRequest':
            return resource.get('dosageInstruction', [])
        elif resource_type == 'MedicationDispense':
            return resource.get('dosageInstruction', [])
        elif resource_type == 'MedicationStatement':
            return resource.get('dosage', [])
        else:
            raise ValueError(f"Unsupported resource type: {resource_type}")
    
    def _determine_schema_type(self, dosages):
        """
        Determine the schema type based on TimingOnlyOneType constraint logic.
        """
        if not dosages:
            return "Unknown"
        
        first_dosage = dosages[0]
        timing = first_dosage.get('timing', {})
        repeat = timing.get('repeat', {})
        
        has_frequency = 'frequency' in repeat
        has_period = 'period' in repeat
        has_period_unit = 'periodUnit' in repeat
        has_day_of_week = 'dayOfWeek' in repeat and repeat['dayOfWeek']
        has_when = 'when' in repeat and repeat['when']
        has_time_of_day = 'timeOfDay' in repeat and repeat['timeOfDay']
        
        # Check 4-Schema first (when with daily period) - most specific check
        if (has_frequency and has_period and repeat.get('period') == 1 and 
            repeat.get('periodUnit') == 'd' and has_when and not has_time_of_day and not has_day_of_week):
            return "4-Schema"
        
        # Check DayOfWeek schema
        if (has_day_of_week and has_frequency and has_period and 
            repeat.get('period') == 1 and has_period_unit and 
            not has_when and not has_time_of_day):
            return "DayOfWeek"
        
        # Check DayOfWeek and Time/4-Schema
        if (has_day_of_week and has_frequency and has_period and 
            repeat.get('period') == 1 and has_period_unit and
            ((has_time_of_day and not has_when) or (has_when and not has_time_of_day))):
            return "DayOfWeek and Time/4-Schema"
        
        # Check TimeOfDay schema
        if (has_frequency and has_period and has_period_unit and 
            not has_day_of_week and has_time_of_day and not has_when):
            return "TimeOfDay"
        
        # Check Interval and Time/4-Schema
        if (has_frequency and has_period and has_period_unit and 
            not has_day_of_week and 
            ((has_time_of_day and not has_when) or (has_when and not has_time_of_day))):
            return "Interval and Time/4-Schema"
        
        # Check Interval schema (pure interval without when/timeOfDay)
        if (has_frequency and has_period and has_period_unit and 
            not has_when and not has_time_of_day and not has_day_of_week):
            return "Interval"
        
        return "Unknown"
    
    def _generate_4_schema_text(self, dosages):
        """
        Generate text for 4-Schema: morning-noon-evening-night format.
        Example: "1-0-2-0 Stück"
        """
        # Initialize doses for each time period
        doses = {'MORN': 0, 'NOON': 0, 'EVE': 0, 'NIGHT': 0}
        unit = ""
        
        for dosage in dosages:
            timing = dosage.get('timing', {})
            repeat = timing.get('repeat', {})
            when_list = repeat.get('when', [])
            
            # Get dose information
            dose_and_rate = dosage.get('doseAndRate', [])
            if dose_and_rate and dose_and_rate[0].get('doseQuantity'):
                dose_qty = dose_and_rate[0]['doseQuantity']
                dose_value = dose_qty.get('value', 0)
                if not unit:
                    unit = dose_qty.get('unit', '')
                
                # Assign dose to appropriate time period
                for when in when_list:
                    if when in doses:
                        doses[when] = dose_value
        
        # Format as "morning-noon-evening-night"
        dose_values = [str(int(doses[when])) for when in self.when_order]
        dose_text = "-".join(dose_values)
        
        if unit:
            return f"{dose_text} {unit}"
        else:
            return dose_text
    
    def _generate_time_of_day_text(self, dosages):
        """Generate text for TimeOfDay schema."""
        # For now, return a placeholder - will implement based on requirements
        return "TimeOfDay Schema - noch nicht implementiert"
    
    def _generate_day_of_week_text(self, dosages):
        """Generate text for DayOfWeek schema."""
        # For now, return a placeholder - will implement based on requirements
        return "DayOfWeek Schema - noch nicht implementiert"
    
    def _generate_interval_text(self, dosages):
        """Generate text for Interval schema."""
        # For now, return a placeholder - will implement based on requirements
        return "Interval Schema - noch nicht implementiert"
    
    def _generate_dayofweek_and_time_schema_text(self, dosages):
        """Generate text for DayOfWeek and Time/4-Schema."""
        # For now, return a placeholder - will implement based on requirements
        return "DayOfWeek and Time/4-Schema - noch nicht implementiert"
    
    def _generate_interval_and_time_schema_text(self, dosages):
        """Generate text for Interval and Time/4-Schema."""
        # For now, return a placeholder - will implement based on requirements
        return "Interval and Time/4-Schema - noch nicht implementiert"

def main():
    if len(sys.argv) < 2:
        print('Verwendung: python medication-dosage-to-text.py <medication-resource.json>', file=sys.stderr)
        sys.exit(1)
    
    file_path = sys.argv[1]
    if not os.path.exists(file_path):
        print(f"Fehler: Datei '{file_path}' nicht gefunden.", file=sys.stderr)
        sys.exit(1)
    
    try:
        with open(file_path, 'r', encoding='utf-8') as file:
            resource = json.load(file)
        
        generator = MedicationDosageTextGenerator()
        result = generator.generate_dosage_text(resource)
        print(result)
        
    except json.JSONDecodeError as e:
        print(f"Fehler: Ungültiges JSON in Datei '{file_path}'.", file=sys.stderr)
        print(f"Details: {e}", file=sys.stderr)
        sys.exit(1)
    except Exception as e:
        print(f"Fehler beim Verarbeiten der Datei: {e}", file=sys.stderr)
        sys.exit(1)

if __name__ == "__main__":
    main()
