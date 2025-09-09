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
        if schema_type == "FreeText":
            return self._generate_freetext_schema_text(dosages)
        elif schema_type == "4-Schema":
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
        
        # Check for free text schema first (has text but no timing)
        if first_dosage.get('text') and not first_dosage.get('timing'):
            return "FreeText"
        
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
        
        # Check TimeOfDay schema (daily only - period = 1)
        if (has_frequency and has_period and repeat.get('period') == 1 and 
            repeat.get('periodUnit') == 'd' and 
            not has_day_of_week and has_time_of_day and not has_when):
            return "TimeOfDay"
        
        # Check Interval and Time/4-Schema (period > 1 OR not daily)
        if (has_frequency and has_period and has_period_unit and 
            not has_day_of_week and 
            ((has_time_of_day and not has_when) or (has_when and not has_time_of_day)) and
            not (repeat.get('period') == 1 and repeat.get('periodUnit') == 'd')):
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
        bounds_text = ""
        
        for dosage in dosages:
            timing = dosage.get('timing', {})
            repeat = timing.get('repeat', {})
            when_list = repeat.get('when', [])
            
            # Get bounds (should be same across all dosages)
            if not bounds_text:
                bounds_text = self._get_bounds_text(dosage)
            
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
        dose_values = []
        for when in self.when_order:
            dose_value = doses[when]
            # Format the dose value properly - keep decimals if they exist
            if dose_value == int(dose_value):
                dose_values.append(str(int(dose_value)))
            else:
                dose_values.append(str(dose_value))
        dose_text = "-".join(dose_values)
        
        if unit:
            dose_text = f"{dose_text} {unit}"
        
        # Add bounds if present
        if bounds_text:
            return f"{bounds_text}: {dose_text}"
        else:
            return dose_text
    
    def _generate_freetext_schema_text(self, dosages):
        """
        Generate text for FreeText schema: just return the dosage.text directly.
        """
        if not dosages:
            return ""
        
        # For free text, we just concatenate all text values
        texts = []
        for dosage in dosages:
            text = dosage.get('text', '').strip()
            if text:
                texts.append(text)
        
        return " ".join(texts)
    
    def _generate_time_of_day_text(self, dosages):
        """Generate text for TimeOfDay schema."""
        if not dosages:
            return ""
        
        # For TimeOfDay schema, consolidate all times and doses
        parts = []
        bounds_text = ""
        
        for dosage in dosages:
            timing = dosage.get('timing', {})
            repeat = timing.get('repeat', {})
            times = repeat.get('timeOfDay', [])
            
            # Get bounds (should be same across all dosages)
            if not bounds_text:
                bounds_text = self._get_bounds_text(dosage)
            
            if not times:
                continue
                
            # Format times (sort them and format as HH:MM Uhr)
            formatted_times = []
            for time in sorted(times):
                formatted_time = self._format_time(time)
                formatted_times.append(formatted_time)
            
            # Get dose
            dose_text = self._get_dose_text(dosage)
            
            # Combine times and dose for this dosage
            if formatted_times and dose_text:
                times_str = ", ".join(formatted_times)
                parts.append(f"{times_str} — {dose_text}")
        
        if not parts:
            return ""
        
        # Combine multiple parts with "; "
        combined_parts = "; ".join(parts)
        
        # Build final text with bounds
        if bounds_text:
            return f"{bounds_text} täglich: {combined_parts}"
        else:
            return f"täglich: {combined_parts}"
    
    def _format_time(self, time):
        """Format time string to HH:MM Uhr format."""
        try:
            parts = time.split(':')
            hour = int(parts[0])
            minute = parts[1] if len(parts) > 1 else '00'
            return f"{hour:02d}:{minute} Uhr"
        except:
            return time
    
    def _generate_day_of_week_text(self, dosages):
        """Generate text for DayOfWeek schema."""
        if not dosages:
            return ""
        
        # Group dosages by day and dose
        day_doses = {}  # day -> dose_value
        bounds_text = ""
        unit = ""
        
        for dosage in dosages:
            timing = dosage.get('timing', {})
            repeat = timing.get('repeat', {})
            
            days = repeat.get('dayOfWeek', [])
            
            # Get bounds (should be same across all dosages)
            if not bounds_text:
                bounds_text = self._get_bounds_text(dosage)
            
            # Get dose information
            dose_and_rate = dosage.get('doseAndRate', [])
            if dose_and_rate and dose_and_rate[0].get('doseQuantity'):
                dose_qty = dose_and_rate[0]['doseQuantity']
                dose_value = dose_qty.get('value', 0)
                if not unit:
                    unit = dose_qty.get('unit', '')
                
                # For each day, set the dose
                for day in days:
                    day_doses[day] = dose_value
        
        if not day_doses:
            return ""
        
        # Format each day as "dayname — je X unit"
        day_order = ['mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun']
        day_names = {
            'mon': 'montags',
            'tue': 'dienstags', 
            'wed': 'mittwochs',
            'thu': 'donnerstags',
            'fri': 'freitags',
            'sat': 'samstags',
            'sun': 'sonntags'
        }
        
        # Sort days by canonical order
        sorted_days = sorted(day_doses.keys(), key=lambda d: day_order.index(d) if d in day_order else 99)
        
        day_texts = []
        for day in sorted_days:
            dose_value = day_doses[day]
            day_name = day_names.get(day, day)
            
            # Format the dose value properly - keep decimals if they exist
            if dose_value == int(dose_value):
                formatted_dose = str(int(dose_value))
            else:
                formatted_dose = str(dose_value)
            
            # Format as "dayname — je X unit"
            dose_text = f"je {formatted_dose}"
            if unit:
                dose_text += f" {unit}"
            
            day_texts.append(f"{day_name} — {dose_text}")
        
        # Combine all days
        days_text = ", ".join(day_texts)
        
        # Add bounds if present
        if bounds_text:
            return f"{bounds_text}: {days_text}"
        else:
            return days_text
    
    def _generate_interval_text(self, dosages):
        """Generate text for Interval schema."""
        if not dosages:
            return ""
        
        # For interval schema, there should only be one dosage (constraint ensures this)
        dosage = dosages[0]
        
        # Get the frequency pattern
        frequency_text = self._get_frequency_text(dosage)
        
        # Get the dose
        dose_text = self._get_dose_text(dosage)
        
        # Get bounds if present
        bounds_text = self._get_bounds_text(dosage)
        
        # Combine: [bounds] frequency: dose
        parts = []
        if bounds_text:
            parts.append(bounds_text)
        if frequency_text:
            parts.append(frequency_text)
        
        left_part = " ".join(parts)
        
        if left_part and dose_text:
            return f"{left_part}: {dose_text}"
        elif left_part:
            return left_part
        elif dose_text:
            return dose_text
        else:
            return ""
    
    def _get_frequency_text(self, dosage):
        """Get frequency text for a dosage (replicates logic from dosage-to-text.py)."""
        timing = dosage.get('timing', {})
        repeat = timing.get('repeat', {})
        if not repeat:
            return ""
        
        frequency = repeat.get('frequency')
        period = repeat.get('period')
        period_unit = repeat.get('periodUnit')
        
        if frequency is None and period is None and period_unit is None:
            return ""
        
        # Daily patterns
        if period_unit == 'd' and period == 1:
            return "täglich" if frequency == 1 else f"{frequency} x täglich"
        
        # Weekly patterns  
        if period_unit == 'wk' and period == 1:
            return "wöchentlich" if frequency == 1 else f"{frequency} x wöchentlich"
        
        # Interval patterns
        if frequency == 1:
            period_text = self._format_period_unit(period, period_unit)
            return f"alle {period_text}"
        
        freq_text = f"{frequency} x"
        period_text = self._format_period_unit(period, period_unit)
        return f"{freq_text} alle {period_text}"
    
    def _get_dose_text(self, dosage):
        """Get dose text for a dosage."""
        dose_and_rate = dosage.get('doseAndRate', [])
        if not dose_and_rate:
            return ""
        first_dose = dose_and_rate[0]
        if first_dose.get('doseQuantity'):
            return self._format_quantity(first_dose['doseQuantity'], with_je=True)
        return ""
    
    def _get_bounds_text(self, dosage):
        """Get bounds text for a dosage."""
        timing = dosage.get('timing', {})
        repeat = timing.get('repeat', {})
        if repeat.get('boundsDuration'):
            dur = self._format_quantity(repeat['boundsDuration'], with_je=False)
            return f"für {dur}" if dur else ""
        return ""
    
    def _format_quantity(self, quantity, with_je=True):
        """Format a quantity with optional 'je' prefix."""
        value = quantity.get('value', 0)
        unit = quantity.get('unit') or quantity.get('code') or ""
        prefix = "je " if with_je else ""
        return f"{prefix}{value}{' ' + unit if unit else ''}"
    
    def _format_period_unit(self, period, unit):
        """Format period with unit (e.g., '3 Tage', '2 Wochen')."""
        unit_text = self._format_time_unit(period, unit)
        return f"{period} {unit_text}"
    
    def _format_time_unit(self, value, unit):
        """Format time unit with proper German singular/plural."""
        units = {
            's': 'Sekunde',
            'min': 'Minute', 
            'h': 'Stunde',
            'd': 'Tag',
            'wk': 'Woche',
            'mo': 'Monat',
            'a': 'Jahr'
        }
        multi_units = {
            's': 'Sekunden',
            'min': 'Minuten',
            'h': 'Stunden', 
            'd': 'Tage',
            'wk': 'Wochen',
            'mo': 'Monate',
            'a': 'Jahre'
        }
        unit_name = units.get(unit, unit)
        units_name = multi_units.get(unit, unit)
        return unit_name if value == 1 else units_name
    
    def _generate_dayofweek_and_time_schema_text(self, dosages):
        """Generate text for DayOfWeek and Time/4-Schema."""
        if not dosages:
            return ""
        
        # Check if this uses timeOfDay or when codes
        first_dosage = dosages[0]
        timing = first_dosage.get('timing', {})
        repeat = timing.get('repeat', {})
        has_time_of_day = 'timeOfDay' in repeat and repeat['timeOfDay']
        has_when = 'when' in repeat and repeat['when']
        
        if has_time_of_day and not has_when:
            return self._generate_dayofweek_and_timeofday_text(dosages)
        elif has_when and not has_time_of_day:
            return self._generate_dayofweek_and_when_text(dosages)
        else:
            # Fallback to when-based logic
            return self._generate_dayofweek_and_when_text(dosages)
    
    def _generate_dayofweek_and_timeofday_text(self, dosages):
        """Generate text for DayOfWeek + TimeOfDay combination."""
        if not dosages:
            return ""
        
        # Group dosages by day of week
        day_groups = {}  # day -> list of dosages
        bounds_text = ""
        
        for dosage in dosages:
            timing = dosage.get('timing', {})
            repeat = timing.get('repeat', {})
            
            days = repeat.get('dayOfWeek', [])
            
            # Get bounds (should be same across all dosages)
            if not bounds_text:
                bounds_text = self._get_bounds_text(dosage)
            
            # Group by day
            for day in days:
                if day not in day_groups:
                    day_groups[day] = []
                day_groups[day].append(dosage)
        
        # Format each day
        day_order = ['mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun']
        day_names = {
            'mon': 'montags',
            'tue': 'dienstags', 
            'wed': 'mittwochs',
            'thu': 'donnerstags',
            'fri': 'freitags',
            'sat': 'samstags',
            'sun': 'sonntags'
        }
        
        sorted_days = sorted(day_groups.keys(), key=lambda d: day_order.index(d) if d in day_order else 99)
        
        day_texts = []
        for day in sorted_days:
            day_dosages = day_groups[day]
            day_name = day_names.get(day, day)
            
            # Generate time-based text for this day (similar to TimeOfDay schema)
            time_parts = []
            for dosage in day_dosages:
                timing = dosage.get('timing', {})
                repeat = timing.get('repeat', {})
                times = repeat.get('timeOfDay', [])
                
                if not times:
                    continue
                    
                # Format times (sort them and format as HH:MM Uhr)
                formatted_times = []
                for time in sorted(times):
                    formatted_time = self._format_time(time)
                    formatted_times.append(formatted_time)
                
                # Get dose
                dose_text = self._get_dose_text(dosage)
                
                # Combine times and dose for this dosage
                if formatted_times and dose_text:
                    times_str = ", ".join(formatted_times)
                    time_parts.append(f"{times_str} — {dose_text}")
            
            if time_parts:
                combined_times = "; ".join(time_parts)
                day_texts.append(f"{day_name} {combined_times}")
        
        # Combine all days
        days_text = ", ".join(day_texts)
        
        # Add bounds if present
        if bounds_text:
            return f"{bounds_text}: {days_text}"
        else:
            return days_text
    
    def _generate_dayofweek_and_when_text(self, dosages):
        """Generate text for DayOfWeek + When combination (4-Schema pattern)."""
        if not dosages:
            return ""
        
        # Group dosages by day of week and build 4-schema pattern for each day
        day_patterns = {}  # day -> {MORN: dose, NOON: dose, EVE: dose, NIGHT: dose}
        bounds_text = ""
        unit = ""
        
        for dosage in dosages:
            timing = dosage.get('timing', {})
            repeat = timing.get('repeat', {})
            
            days = repeat.get('dayOfWeek', [])
            when_list = repeat.get('when', [])
            
            # Get bounds (should be same across all dosages)
            if not bounds_text:
                bounds_text = self._get_bounds_text(dosage)
            
            # Get dose information
            dose_and_rate = dosage.get('doseAndRate', [])
            if dose_and_rate and dose_and_rate[0].get('doseQuantity'):
                dose_qty = dose_and_rate[0]['doseQuantity']
                dose_value = dose_qty.get('value', 0)
                if not unit:
                    unit = dose_qty.get('unit', '')
                
                # For each day and each when, set the dose
                for day in days:
                    if day not in day_patterns:
                        day_patterns[day] = {'MORN': 0, 'NOON': 0, 'EVE': 0, 'NIGHT': 0}
                    
                    for when in when_list:
                        if when in day_patterns[day]:
                            day_patterns[day][when] = dose_value
        
        if not day_patterns:
            return ""
        
        # Format each day as "dayname 1-2-1-0"
        day_order = ['mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun']
        when_order = ['MORN', 'NOON', 'EVE', 'NIGHT']
        day_names = {
            'mon': 'montags',
            'tue': 'dienstags', 
            'wed': 'mittwochs',
            'thu': 'donnerstags',
            'fri': 'freitags',
            'sat': 'samstags',
            'sun': 'sonntags'
        }
        
        # Sort days by canonical order
        sorted_days = sorted(day_patterns.keys(), key=lambda d: day_order.index(d) if d in day_order else 99)
        
        day_texts = []
        for day in sorted_days:
            pattern = day_patterns[day]
            day_name = day_names.get(day, day)
            
            # Format doses as "1-2-1-0"
            dose_values = []
            for when in when_order:
                dose_value = pattern[when]
                # Format the dose value properly - keep decimals if they exist
                if dose_value == int(dose_value):
                    dose_values.append(str(int(dose_value)))
                else:
                    dose_values.append(str(dose_value))
            
            dose_pattern = "-".join(dose_values)
            day_texts.append(f"{day_name} {dose_pattern}")
        
        # Combine all days
        days_text = ", ".join(day_texts)
        
        # Add unit if available
        if unit:
            days_text += f" {unit}"
        
        # Add bounds if present
        if bounds_text:
            return f"{bounds_text}: {days_text}"
        else:
            return days_text
    
    def _generate_interval_and_time_schema_text(self, dosages):
        """
        Generate text for Interval and Time/4-Schema.
        Example: "alle 2 Tage: 08:00 Uhr — je 1 Stück; 18:00 Uhr — je 2 Stück"
        """
        if not dosages:
            return ""
        
        # Get interval information from first dosage
        first_dosage = dosages[0]
        timing = first_dosage.get('timing', {})
        repeat = timing.get('repeat', {})
        
        # Get bounds text
        bounds_text = self._get_bounds_text(first_dosage)
        
        period = repeat.get('period', 1)
        period_unit = repeat.get('periodUnit', 'd')
        
        # Generate interval text
        if period_unit == 'd':
            if period == 1:
                interval_text = "täglich"
            else:
                interval_text = f"alle {period} Tage"
        elif period_unit == 'wk':
            if period == 1:
                interval_text = "wöchentlich"
            else:
                interval_text = f"alle {period} Wochen"
        else:
            interval_text = f"alle {period} {period_unit}"
        
        # Collect and group dosages by time or when
        time_groups = {}
        
        for dosage in dosages:
            timing = dosage.get('timing', {})
            repeat = timing.get('repeat', {})
            
            # Get time information - process ALL timeOfDay/when entries
            if 'timeOfDay' in repeat and repeat['timeOfDay']:
                # Process all timeOfDay entries
                for time_of_day in repeat['timeOfDay']:
                    if time_of_day not in time_groups:
                        time_groups[time_of_day] = []
                    time_groups[time_of_day].append(dosage)
            elif 'when' in repeat and repeat['when']:
                when_codes = repeat['when']
                # Process all when codes directly (don't convert to times)
                for when_code in when_codes:
                    if when_code in self.when_translations:
                        if when_code not in time_groups:
                            time_groups[when_code] = []
                        time_groups[when_code].append(dosage)
        
        # Generate time-based text parts
        time_parts = []
        
        # Sort time_groups keys properly: when codes in logical order, then times chronologically
        def sort_key(key):
            if key in self.when_order:
                # When codes: use their position in when_order for sorting
                return (0, self.when_order.index(key))
            else:
                # Time codes: sort chronologically
                return (1, key)
        
        for time_key in sorted(time_groups.keys(), key=sort_key):
            dosages_at_time = time_groups[time_key]
            
            # Format time or when code
            if time_key in self.when_translations:
                # This is a when code, use German translation
                time_display = self.when_translations[time_key]
            else:
                # This is a timeOfDay, format as HH:MM Uhr
                time_display = time_key[:5] + " Uhr"
            
            # Calculate total dose at this time
            total_dose = 0
            unit = ""
            for dosage in dosages_at_time:
                dose_and_rate = dosage.get('doseAndRate', [])
                if dose_and_rate and dose_and_rate[0].get('doseQuantity'):
                    dose_qty = dose_and_rate[0]['doseQuantity']
                    dose_value = dose_qty.get('value', 0)
                    total_dose += dose_value
                    if not unit:
                        unit = dose_qty.get('unit', '')
            
            # Format dose value (preserve decimals)
            if total_dose == int(total_dose):
                dose_text = str(int(total_dose))
            else:
                dose_text = str(total_dose)
            
            time_parts.append(f"{time_display} — je {dose_text} {unit}")
        
        # Combine interval and time parts
        times_text = "; ".join(time_parts)
        
        # Add bounds if present
        if bounds_text:
            return f"{bounds_text} {interval_text}: {times_text}"
        else:
            return f"{interval_text}: {times_text}"

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
