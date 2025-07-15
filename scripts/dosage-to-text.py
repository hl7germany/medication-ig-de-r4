#!/usr/bin/env python3
import json
import sys
import os

class GermanDosageTextGenerator:
    def generate_single_dosage_text(self, dosage):
        elements = []
        # Check for unsupported features
        unsupported_fields = self.get_unsupported_fields(dosage)
        if unsupported_fields:
            felder = ", ".join(unsupported_fields)
            return f"Die Dosiskonfiguration mit den Feldern {felder} wird in der aktuellen Ausbaustufe nicht unterstützt."
        
        # Frequency
        frequency = self.get_frequency(dosage)
        if frequency:
            elements.append(frequency)
        # Days of week
        days_of_week = self.get_days_of_week(dosage)
        if days_of_week:
            elements.append(days_of_week)
         # Wenn weder frequency noch days_of_week gesetzt sind, "täglich" einfügen
        if not frequency and not days_of_week:
            elements.append("täglich")
        # Dose
        dose = self.get_dose(dosage)
        if dose:
            elements.append(dose)
        # Times of day
        times_of_day = self.get_times_of_day(dosage)
        if times_of_day:
            elements.append(times_of_day)
        # When/offset
        when_and_offset = self.get_when_and_offset(dosage)
        if when_and_offset:
            elements.append(when_and_offset)
        # Duration
        bounds = self.get_bounds(dosage)
        if bounds:
            elements.append(bounds)
        # Free text
        if dosage.get('text'):
            elements.append(dosage['text'])
        return " — ".join(elements)
    
    def get_unsupported_fields(self, dosage):
        deny_dosage_fields = {
            "asNeededBoolean", "asNeededCodeableConcept", "method", "route", "site",
            "additionalInstruction", "maxDosePerPeriod", "maxDosePerAdministration", "maxDosePerLifetime"
        }
        deny_timing_fields = {"event"}
        deny_timing_repeat_fields = {
            "count", "countMax", "boundsPeriod", "boundsRange", "offset"
        }
        deny_doseAndRate_subfields = {"doseRange", "rateQuantity", "rateRange", "rateRatio"}

        unsupported = set()
        
        # Top-level deny fields
        for key in dosage.keys():
            if key in deny_dosage_fields:
                unsupported.add(key)
        # doseAndRate subfields
        if "doseAndRate" in dosage:
            for dr in dosage["doseAndRate"]:
                for subkey in dr.keys():
                    if subkey in deny_doseAndRate_subfields:
                        unsupported.add(f"doseAndRate.{subkey}")
        # timing deny fields
        timing = dosage.get('timing', {})
        for key in timing.keys():
            if key in deny_timing_fields:
                unsupported.add(f"timing.{key}")
        # timing.repeat deny fields
        repeat = timing.get('repeat', {})
        for key in repeat.keys():
            if key in deny_timing_repeat_fields:
                unsupported.add(f"timing.repeat.{key}")
            
        return list(unsupported)


    def get_dose(self, dosage):
        dose_and_rate = dosage.get('doseAndRate', [])
        if not dose_and_rate:
            return ""
        first_dose = dose_and_rate[0]
        if first_dose.get('doseQuantity'):
            return self.format_quantity(first_dose['doseQuantity'])
        return ""

    def get_frequency(self, dosage):
        timing = dosage.get('timing', {})
        repeat = timing.get('repeat', {})
        if not repeat:
            return ""
        frequency = repeat.get('frequency')
        frequency_max = repeat.get('frequencyMax')
        period = repeat.get('period')
        period_max = repeat.get('periodMax')
        period_unit = repeat.get('periodUnit')
        if frequency is None and period is None and period_unit is None:
            return ""
        if period_unit == 'd' and period == 1:
            if frequency == 1:
                return "einmal täglich"
            elif frequency == 2:
                return "zweimal täglich"
            elif frequency == 3:
                return "dreimal täglich"
            elif frequency == 4:
                return "viermal täglich"
            elif frequency_max:
                return f"{frequency}-{frequency_max}mal täglich"
            else:
                return f"{frequency}mal täglich"
        if period_unit == 'wk' and period == 1:
            if frequency == 1:
                return "einmal wöchentlich"
            elif frequency == 2:
                return "zweimal wöchentlich"
            elif frequency_max:
                return f"{frequency}-{frequency_max}mal wöchentlich"
            else:
                return f"{frequency}mal wöchentlich"
        if frequency == 1:
            period_text = self.format_period_unit(period, period_max, period_unit)
            return f"alle {period_text}"
        freq_text = f"{frequency}-{frequency_max}mal" if frequency_max and frequency_max != frequency else f"{frequency}mal"
        period_text = self.format_period_unit(period, period_max, period_unit)
        return f"{freq_text} pro {period_text}"

    def get_days_of_week(self, dosage):
        timing = dosage.get('timing', {})
        repeat = timing.get('repeat', {})
        days = repeat.get('dayOfWeek', [])
        if not days:
            return ""
        return self.format_days_of_week(days)

    def get_times_of_day(self, dosage):
        timing = dosage.get('timing', {})
        repeat = timing.get('repeat', {})
        times = repeat.get('timeOfDay', [])
        if not times:
            return ""
        # Sort the times as strings (works for HH:MM or HH:MM:SS)
        sorted_times = sorted(times)
        return "um " + ", ".join([self.format_time(time) for time in sorted_times])


    def get_when_and_offset(self, dosage):
        timing = dosage.get('timing', {})
        repeat = timing.get('repeat', {})
        parts = []
        when_list = repeat.get('when', [])
        when_order = ['MORN', 'NOON', 'AFT', 'EVE', 'NIGHT']
        order_map = {key: idx for idx, key in enumerate(when_order)}
        when_list_sorted = sorted(when_list, key=lambda w: order_map.get(w, len(when_order)))
        if when_list_sorted:
            when_names = [self.translate_when_code(w) for w in when_list_sorted]
            if len(when_names) == 1:
                when_text = when_names[0]
            elif len(when_names) == 2:
                when_text = f"{when_names[0]} und {when_names[1]}"
            else:
                when_text = f"{', '.join(when_names[:-1])} und {when_names[-1]}"
            parts.append(when_text)
        return ", ".join(parts)

    def get_bounds(self, dosage):
        timing = dosage.get('timing', {})
        repeat = timing.get('repeat', {})
        if repeat.get('boundsDuration'):
            dur = self.format_quantity(repeat['boundsDuration'], with_je=False)
            return f"für {dur}" if dur else ""
        return ""


    def format_quantity(self, quantity, with_je=True):
        value = quantity.get('value', 0)
        unit = quantity.get('unit') or quantity.get('code') or ""
        prefix = "je " if with_je else ""
        return f"{prefix}{value}{' ' + unit if unit else ''}"


    def format_time(self, time):
        try:
            parts = time.split(':')
            hour = int(parts[0])
            minute = parts[1] if len(parts) > 1 else '00'
            return f"{hour:02d}:{minute} Uhr"
        except:
            return time

    def format_time_unit(self, value, unit):
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
        return unit_name if value == 1 else f"{units_name}"

    def format_period_unit(self, period, period_max, unit):
        unit_text = self.format_time_unit(period, unit)
        if period_max and period_max != period:
            return f"{period}-{period_max} {unit_text}"
        return f"{period} {unit_text}"

    def format_days_of_week(self, days):
        day_order = ['mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun']
        day_names = {
            'mon': 'Montag',
            'tue': 'Dienstag',
            'wed': 'Mittwoch',
            'thu': 'Donnerstag',
            'fri': 'Freitag',
            'sat': 'Samstag',
            'sun': 'Sonntag'
        }
        # Lowercase all input days for matching
        days_lower = [d.lower() for d in days]
        # Sort by the canonical order
        sorted_days = sorted(days_lower, key=lambda d: day_order.index(d) if d in day_order else 99)
        names = [day_names.get(day, day) for day in sorted_days]
        if not names:
            return ""
        if len(names) == 1:
            return names[0]
        if len(names) == 2:
            return f"{names[0]} und {names[1]}"
        return f"{', '.join(names[:-1])} und {names[-1]}"


    def translate_when_code(self, when):
        when_codes = {
            'MORN': 'morgens',
            'NOON': 'mittags',
            'EVE': 'abends',
            'NIGHT': 'nachts'
        }
        return when_codes.get(when.upper(), when)
    
    def is_only_key_and_bounds(self, repeat, key):
        allowed = {key}
        # boundsDuration, boundsRange, boundsPeriod sind erlaubt
        allowed.update([k for k in repeat if k.startswith('bounds')])
        # Gibt es noch andere Schlüssel mit Wert?
        for k, v in repeat.items():
            if k not in allowed and v:
                return False
        return key in repeat and repeat[key]

def main():
    if len(sys.argv) < 2:
        print('Verwendung: python dosage-generator.py <dosage.json>', file=sys.stderr)
        sys.exit(1)
    file_path = sys.argv[1]
    if not os.path.exists(file_path):
        print(f"Fehler: Datei '{file_path}' nicht gefunden.", file=sys.stderr)
        sys.exit(1)
    try:
        with open(file_path, 'r', encoding='utf-8') as file:
            dosage = json.load(file)
        generator = GermanDosageTextGenerator()
        result = generator.generate_single_dosage_text(dosage)
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
