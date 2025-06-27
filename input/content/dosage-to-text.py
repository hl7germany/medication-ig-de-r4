#!/usr/bin/env python3

import json
import sys
import os
from datetime import datetime
from typing import Dict, List, Optional, Union, Any

class GermanDosageTextGenerator:
    
    def generate_dosage_text(self, data: Dict[str, Any]) -> str:
      # Header: Medikament, Darreichungsform, Hersteller
      header_parts = []
      medication_name = self.get_medication_name(data)
      if medication_name:
          header_parts.append(medication_name)
      medication_form = self.get_medication_form(data)
      if medication_form:
          header_parts.append(medication_form)
      manufacturer = self.get_manufacturer(data)
      if manufacturer:
          header_parts.append(manufacturer)
      header = " - ".join(header_parts)

      # Dosierungsanweisungen
      dosage_instructions = self.get_dosage_instructions(data)
      dosage_lines = []
      for dosage in dosage_instructions:
          dosage_line = self.generate_single_dosage_text(dosage)
          if dosage_line:
              dosage_lines.append(dosage_line)
      # Output: Header (if present) and all dosage lines, each as its own line
      output_lines = []
      if header:
          output_lines.append(header)
      output_lines.extend(dosage_lines)
      return "\n".join(output_lines)

    def generate_single_dosage_text(self, dosage: Dict[str, Any]) -> str:
        # In exact logical display order, only non-empty fields, no labels
        elements = []
        # 1. method
        method = self.get_method(dosage)
        if method:
            elements.append(method)
        # 2. doseAndRate.doseQuantity / .doseRange
        dose = self.get_dose(dosage)
        if dose:
            elements.append(dose)
        # 3. doseAndRate.rateRatio / .rateQuantity / .rateRange
        rate = self.get_rate(dosage)
        if rate:
            elements.append(rate)
        # 4. duration, durationMax
        duration = self.get_duration(dosage)
        if duration:
            elements.append(duration)
        # 5. frequency, frequencyMax, period and periodMax
        frequency = self.get_frequency(dosage)
        if frequency:
            elements.append(frequency)
        # 6. offset, when(s)
        when_and_offset = self.get_when_and_offset(dosage)
        if when_and_offset:
            elements.append(when_and_offset)
        # 7. dayOfWeek(s)
        days_of_week = self.get_days_of_week(dosage)
        if days_of_week:
            elements.append(days_of_week)
        # 8. timeOfDay(s)
        times_of_day = self.get_times_of_day(dosage)
        if times_of_day:
            elements.append(times_of_day)
        # 9. route
        route = self.get_route(dosage)
        if route:
            elements.append(route)
        # 10. site
        site = self.get_site(dosage)
        if site:
            elements.append(site)
        # 11. asNeededCodeableConcept / asNeeded
        as_needed = self.get_as_needed(dosage)
        if as_needed:
            elements.append(as_needed)
        # 12. boundsDuration / boundsRange
        bounds = self.get_bounds(dosage)
        if bounds:
            elements.append(bounds)
        # 13. count, countMax
        count = self.get_count(dosage)
        if count:
            elements.append(count)
        # 14. event(s)
        events = self.get_events(dosage)
        if events:
            elements.append(events)
        # 15. maxDosePerPeriod / maxDosePerAdministration / maxDosePerLifetime
        max_dose = self.get_max_dose(dosage)
        if max_dose:
            elements.append(max_dose)
        # 16. additionalInstruction(s)
        additional_instructions = self.get_additional_instructions(dosage)
        if additional_instructions:
            elements.append(additional_instructions)
        # Patientenanweisungen (falls vorhanden)
        if dosage.get('patientInstruction'):
            elements.append(dosage['patientInstruction'])

        # Join all non-empty elements with " - "
        return " - ".join(elements)

    def get_medication_name(self, data: Dict[str, Any]) -> str:
        medication = data.get('medication', {})
        if medication.get('code'):
            return self.get_codeable_concept_text(medication['code'])
        
        medication_request = data.get('medicationRequest', {})
        if medication_request.get('medicationCodeableConcept'):
            return self.get_codeable_concept_text(medication_request['medicationCodeableConcept'])
        
        medication_ref = medication_request.get('medicationReference', {})
        if medication_ref.get('display'):
            return medication_ref['display']
        
        return ""

    def get_medication_form(self, data: Dict[str, Any]) -> str:
        medication = data.get('medication', {})
        if medication.get('form'):
            return self.get_codeable_concept_text(medication['form'])
        return ""

    def get_manufacturer(self, data: Dict[str, Any]) -> str:
        medication = data.get('medication', {})
        manufacturer = medication.get('manufacturer', {})
        if manufacturer.get('display'):
            return manufacturer['display']
        return ""

    def get_dosage_instructions(self, data: Dict[str, Any]) -> List[Dict[str, Any]]:
        if data.get('dosageInstruction'):
            return data['dosageInstruction']
        
        medication_request = data.get('medicationRequest', {})
        if medication_request.get('dosageInstruction'):
            return medication_request['dosageInstruction']
        
        if data.get('dosage'):
            return [data['dosage']]
        
        return []

    def get_method(self, dosage: Dict[str, Any]) -> str:
        if dosage.get('method'):
            return self.get_codeable_concept_text(dosage['method'])
        return ""

    def get_dose(self, dosage: Dict[str, Any]) -> str:
        dose_and_rate = dosage.get('doseAndRate', [])
        if not dose_and_rate:
            return ""

        first_dose = dose_and_rate[0]
        if first_dose.get('doseQuantity'):
            return self.format_quantity(first_dose['doseQuantity'])
        if first_dose.get('doseRange'):
            return self.format_range(first_dose['doseRange'])
        return ""

    def get_rate(self, dosage: Dict[str, Any]) -> str:
        dose_and_rate = dosage.get('doseAndRate', [])
        if not dose_and_rate:
            return ""

        first_dose = dose_and_rate[0]
        if first_dose.get('rateQuantity'):
            return self.format_quantity(first_dose['rateQuantity'])
        if first_dose.get('rateRange'):
            return self.format_range(first_dose['rateRange'])
        if first_dose.get('rateRatio'):
            return self.format_ratio(first_dose['rateRatio'])
        return ""

    def get_duration(self, dosage: Dict[str, Any]) -> str:
      timing = dosage.get('timing', {})
      repeat = timing.get('repeat', {})
      
      if not repeat.get('duration'):
          return ""

      duration = repeat['duration']
      duration_max = repeat.get('durationMax')
      unit = repeat.get('durationUnit', 'min')

      unit_text = self.format_time_unit(duration, unit)
      if duration_max and duration_max != duration:
          return f"für {duration}-{duration_max} {unit_text}"
      return f"für {duration} {unit_text}"


    def get_frequency(self, dosage: Dict[str, Any]) -> str:
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


        # Häufige Muster
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

        # "alle X Stunden/Tage/Wochen" Muster
        if frequency == 1:
            period_text = self.format_period_unit(period, period_max, period_unit)
            return f"alle {period_text}"

        # Allgemeiner Fall
        freq_text = f"{frequency}-{frequency_max}mal" if frequency_max and frequency_max != frequency else f"{frequency}mal"
        period_text = self.format_period_unit(period, period_max, period_unit)
        return f"{freq_text} pro {period_text}"

    def get_when_and_offset(self, dosage: Dict[str, Any]) -> str:
        timing = dosage.get('timing', {})
        repeat = timing.get('repeat', {})
        
        parts = []

        when_list = repeat.get('when', [])
        if when_list:
            when_text = " und ".join([self.translate_when_code(w) for w in when_list])
            parts.append(when_text)

        offset = repeat.get('offset')
        if offset is not None:
            parts.append(f"{offset} Minuten Versatz")

        return ", ".join(parts)

    def get_days_of_week(self, dosage: Dict[str, Any]) -> str:
        timing = dosage.get('timing', {})
        repeat = timing.get('repeat', {})
        
        days = repeat.get('dayOfWeek', [])
        if not days:
            return ""

        return self.format_days_of_week(days)

    def get_times_of_day(self, dosage: Dict[str, Any]) -> str:
      timing = dosage.get('timing', {})
      repeat = timing.get('repeat', {})
      
      times = repeat.get('timeOfDay', [])
      if not times:
          return ""

      # Add "je " before the times
      return "je " + ", ".join([self.format_time(time) for time in times])


    def get_route(self, dosage: Dict[str, Any]) -> str:
        if dosage.get('route'):
            return self.get_codeable_concept_text(dosage['route'])
        return ""

    def get_site(self, dosage: Dict[str, Any]) -> str:
        if dosage.get('site'):
            return self.get_codeable_concept_text(dosage['site'])
        return ""

    def get_as_needed(self, dosage: Dict[str, Any]) -> str:
        if dosage.get('asNeededBoolean'):
            return "ja"
        if dosage.get('asNeededCodeableConcept'):
            return self.get_codeable_concept_text(dosage['asNeededCodeableConcept'])
        return ""

    def get_bounds(self, dosage: Dict[str, Any]) -> str:
      timing = dosage.get('timing', {})
      repeat = timing.get('repeat', {})

      if repeat.get('boundsPeriod'):
          period = self.format_period(repeat['boundsPeriod'])
          return f"für {period}" if period else ""
      if repeat.get('boundsRange'):
          rng = self.format_range(repeat['boundsRange'])
          return f"für {rng}" if rng else ""
      if repeat.get('boundsDuration'):
          dur = self.format_quantity(repeat['boundsDuration'])
          return f"für {dur}" if dur else ""
      return ""


    def get_count(self, dosage: Dict[str, Any]) -> str:
        timing = dosage.get('timing', {})
        repeat = timing.get('repeat', {})
        
        count = repeat.get('count')
        if not count:
            return ""

        count_max = repeat.get('countMax')
        if count_max and count_max != count:
            return f"{count}-{count_max}mal insgesamt"
        return f"{count}mal insgesamt"

    def get_events(self, dosage: Dict[str, Any]) -> str:
        timing = dosage.get('timing', {})
        events = timing.get('event', [])
        
        if not events:
            return ""

        return ", ".join([self.format_datetime(event) for event in events])

    def get_max_dose(self, dosage: Dict[str, Any]) -> str:
        constraints = []

        if dosage.get('maxDosePerPeriod'):
            constraints.append(f"{self.format_ratio(dosage['maxDosePerPeriod'])} pro Zeitraum")

        if dosage.get('maxDosePerAdministration'):
            constraints.append(f"{self.format_quantity(dosage['maxDosePerAdministration'])} pro Gabe")

        if dosage.get('maxDosePerLifetime'):
            constraints.append(f"{self.format_quantity(dosage['maxDosePerLifetime'])} lebenslang")

        return "; ".join(constraints)

    def get_additional_instructions(self, dosage: Dict[str, Any]) -> str:
        instructions = dosage.get('additionalInstruction', [])
        if not instructions:
            return ""

        texts = [self.get_codeable_concept_text(inst) for inst in instructions]
        return ", ".join([text for text in texts if text])

    # Hilfsmethoden für Formatierung

    def get_codeable_concept_text(self, concept: Dict[str, Any]) -> str:
        if concept.get('text'):
            return concept['text']
        
        coding = concept.get('coding', [])
        if coding:
            first_coding = coding[0]
            return first_coding.get('display') or first_coding.get('code') or ""
        
        return ""

    def format_quantity(self, quantity: Dict[str, Any]) -> str:
        value = quantity.get('value', 0)
        unit = quantity.get('unit') or quantity.get('code') or ""
        return f"{value}{' ' + unit if unit else ''}"

    def format_range(self, range_obj: Dict[str, Any]) -> str:
        low = self.format_quantity(range_obj['low']) if range_obj.get('low') else ""
        high = self.format_quantity(range_obj['high']) if range_obj.get('high') else ""
        
        if low and high:
            return f"{low} bis {high}"
        return low or high or ""

    def format_ratio(self, ratio: Dict[str, Any]) -> str:
        numerator = self.format_quantity(ratio['numerator']) if ratio.get('numerator') else ""
        denominator = self.format_quantity(ratio['denominator']) if ratio.get('denominator') else ""
        return f"{numerator} pro {denominator}"

    def format_period(self, period: Dict[str, Any]) -> str:
        start = self.format_datetime(period['start']) if period.get('start') else ""
        end = self.format_datetime(period['end']) if period.get('end') else ""
        
        if start and end:
            return f"von {start} bis {end}"
        elif start:
            return f"ab {start}"
        elif end:
            return f"bis {end}"
        return ""

    def format_datetime(self, date_time: str) -> str:
        try:
            dt = datetime.fromisoformat(date_time.replace('Z', '+00:00'))
            return dt.strftime('%d.%m.%Y %H:%M')
        except:
            return date_time

    def format_time(self, time: str) -> str:
        try:
            parts = time.split(':')
            hour = int(parts[0])
            minute = parts[1] if len(parts) > 1 else '00'
            return f"{hour:02d}:{minute} Uhr"
        except:
            return time

    def format_time_unit(self, value: int, unit: Optional[str]) -> str:
        units = {
            's': 'Sekunde',
            'min': 'Minute',
            'h': 'Stunde',
            'd': 'Tag',
            'wk': 'Woche',
            'mo': 'Monat',
            'a': 'Jahr'
        }
        unit_name = units.get(unit or 'd', unit or 'Tag')
        return unit_name if value == 1 else f"{unit_name}e"

    def format_period_unit(self, period: int, period_max: Optional[int], unit: Optional[str]) -> str:
        unit_text = self.format_time_unit(period, unit)
        if period_max and period_max != period:
            return f"{period}-{period_max} {unit_text}"
        return f"{period} {unit_text}"

    def format_days_of_week(self, days: List[str]) -> str:
        day_names = {
            'mon': 'Montag',
            'tue': 'Dienstag',
            'wed': 'Mittwoch',
            'thu': 'Donnerstag',
            'fri': 'Freitag',
            'sat': 'Samstag',
            'sun': 'Sonntag'
        }
        return ", ".join([day_names.get(day.lower(), day) for day in days])

    def translate_when_code(self, when: str) -> str:
        when_codes = {
            'MORN': 'morgens',
            'AFT': 'nachmittags',
            'EVE': 'abends',
            'NIGHT': 'nachts',
            'AC': 'vor den Mahlzeiten',
            'PC': 'nach den Mahlzeiten',
            'HS': 'vor dem Schlafengehen',
            'WAKE': 'beim Aufwachen',
            'C': 'zu den Mahlzeiten',
            'CM': 'zu den Mahlzeiten',
            'CD': 'zum Abendessen',
            'CV': 'zum Abendessen'
        }
        return when_codes.get(when.upper(), when)

def main():
    if len(sys.argv) < 2:
        print('Verwendung: python dosage-generator.py <datei.json>', file=sys.stderr)
        print('', file=sys.stderr)
        print('Beispiel:', file=sys.stderr)
        print('  python dosage-generator.py dosage.json', file=sys.stderr)
        sys.exit(1)

    file_path = sys.argv[1]
    
    if not os.path.exists(file_path):
        print(f"Fehler: Datei '{file_path}' nicht gefunden.", file=sys.stderr)
        sys.exit(1)

    try:
        with open(file_path, 'r', encoding='utf-8') as file:
            data = json.load(file)
        
        generator = GermanDosageTextGenerator()
        result = generator.generate_dosage_text(data)

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
