#!/usr/bin/env python3
"""
Enhanced FHIR Medication Dosage Text Generator with Field Validation

BESCHREIBUNG:
    Dieses Script erweitert den ursprünglichen medication-dosage-to-text.py Textgenerator
    um umfassende Validierung verbotener Felder gemäß den DosageDgMP und TimingDgMP 
    FHIR-Profilen. Es kann als Command-Line Tool zur Verarbeitung von FHIR Medication-
    Ressourcen verwendet werden.

FUNKTIONALITÄT:
    • Vollständige Textgenerierung für deutsche Dosierungsanweisungen
    • Validierung von 20+ verbotenen Feldern gemäß FHIR-Profilen
    • Konfigurierbare Fehlerbehandlung (Strict Mode vs. Continue Mode)
    • Strukturierte Fehlerausgabe mit deutschen Beschreibungen
    • Unterstützung für alle FHIR Medication-Ressourcentypen

UNTERSTÜTZTE DOSIERUNGSSCHEMAS:
    • FreeText: Freitext-Dosierungen
    • 4-Schema: Morgen-Mittag-Abend-Nacht Muster (z.B. "1-0-2-0 Stück")
    • TimeOfDay: Uhrzeiten (z.B. "täglich: 08:00 Uhr — je 1 Stück")
    • DayOfWeek: Wochentage (z.B. "montags — je 1 Stück")
    • Interval: Intervalle (z.B. "alle 8 Stunden: je 1 Stück")
    • Kombinationen: Wochentag + Zeit/4-Schema, Interval + Zeit/4-Schema

USAGE:
    # Grundlegende Verwendung (Strict Mode)
    python command_line_interface.py medication.json
    
    # Continue Mode (Fehler anzeigen, aber fortfahren)
    python command_line_interface.py --continue-on-error medication.json
    
    # Mit explizitem Strict Mode
    python command_line_interface.py --strict medication.json
    
    # Hilfe anzeigen
    python command_line_interface.py --help

EXAMPLES:
    # Beispiel 1: Gültige Ressource
    $ python command_line_interface.py valid_medication.json
    täglich: je 1 Stück
    
    # Beispiel 2: Ressource mit verbotenen Feldern (Strict Mode)
    $ python command_line_interface.py invalid_medication.json
    VALIDIERUNGSFEHLER: 2 verbotene Felder gefunden:
    • Verbotenes Feld 'dosageInstruction[0].sequence': Dosier-Sequenz ist nicht vorgesehen (Wert: 1)
    • Verbotenes Feld 'dosageInstruction[0].timing.repeat.count': Wiederholungen sind nicht vorgesehen (Wert: 5)
    Error: Validierungsfehler: 2 verbotene Felder gefunden
    
    # Beispiel 3: Ressource mit verbotenen Feldern (Continue Mode)
    $ python command_line_interface.py --continue-on-error invalid_medication.json
    VALIDIERUNGSFEHLER: 2 verbotene Felder gefunden:
    • Verbotenes Feld 'dosageInstruction[0].sequence': Dosier-Sequenz ist nicht vorgesehen (Wert: 1)
    • Verbotenes Feld 'dosageInstruction[0].timing.repeat.count': Wiederholungen sind nicht vorgesehen (Wert: 5)
    täglich: je 1 Stück

EXIT CODES:
    0  - Erfolgreiche Verarbeitung (keine Fehler oder Continue Mode)
    1  - Validierungsfehler in Strict Mode
    2  - Datei nicht gefunden oder JSON-Parsing-Fehler
    3  - Unerwarteter Fehler

DATEIFORMATE:
    Input: JSON-Datei mit FHIR MedicationRequest, MedicationDispense oder MedicationStatement
    Output: Deutscher Dosierungstext auf stdout, Fehler auf stderr

ABHÄNGIGKEITEN:
    • Python 3.6+
    • Standard Library (json, sys, os, argparse)
    • medication_dosage_validator.py (im selben Verzeichnis)

ENTWICKLER:
    Basiert auf: medication-dosage-to-text.py v1.0.0
    Erweitert um: Verbotene Felder Validierung
    Version: 1.1.0 (Enhanced)
    
SIEHE AUCH:
    • medication_dosage_validator.py - Kern-Implementierung
    • README.md - Detaillierte Dokumentation
    • validation_examples.py - Beispiele und Tests

OPTIONEN:
    medication_file           Pfad zur JSON-Datei mit der FHIR Medication-Ressource
    
    --strict                 Aktiviert Strict Mode (Standard)
                            Bei Validierungsfehlern wird die Verarbeitung abgebrochen
                            Exit Code: 1
                            
    --continue-on-error      Aktiviert Continue Mode
                            Validierungsfehler werden angezeigt, aber Verarbeitung
                            wird fortgesetzt und Dosierungstext wird generiert
                            Exit Code: 0
                            
    -h, --help              Zeigt diese Hilfe an und beendet das Programm
    
    -v, --version           Zeigt Versionsinformationen an

VALIDIERUNG:
    Das Script prüft auf folgende verbotene Felder gemäß DosageDgMP/TimingDgMP:
    
    Dosage-Level:
    • sequence                - Dosier-Sequenz
    • additionalInstruction   - Zusätzliche Anweisungen  
    • patientInstruction      - Patientenanweisungen
    • asNeededBoolean         - Bedarfsdosis (Boolean)
    • asNeededCodeableConcept - Bedarfsdosis (CodeableConcept)
    • site                    - Verabreichungsstelle
    • route                   - Verabreichungsweg
    • method                  - Verabreichungsmethode
    • maxDosePerPeriod        - Maximale Dosis pro Zeitraum
    • maxDosePerAdministration - Maximale Dosis pro Verabreichung
    • maxDosePerLifetime      - Maximale Dosis über Lebenszeit
    
    DoseAndRate-Level:
    • type                    - Dosierungstyp
    • rateQuantity            - Verabreichungsrate (Quantity)
    • rateRatio               - Verabreichungsrate (Ratio)
    • rateRange               - Verabreichungsrate (Range)
    
    Timing.repeat-Level:
    • count                   - Wiederholungen
    • countMax                - Maximale Wiederholungen
    • duration                - Dauer einer Einzelgabe
    • durationMax             - Maximale Dauer einer Einzelgabe
    • durationUnit            - Einheit der Dauer einer Einzelgabe
    • frequencyMax            - Maximale Frequenz
    • periodMax               - Maximale Periodendauer
    • offset                  - Zeitversatz
    
    Timing-Level:
    • event                   - Zeitpunkt des Ereignisses
    • code                    - Timing-Code
    • boundsPeriod            - Periodische Grenzen
    • boundsRange             - Bereichsgrenzen
"""

import json
import sys
import os
import argparse
import importlib.util
from typing import Dict, List, Tuple, Any, Optional

# Import the original generator from scripts directory
sys.path.append(os.path.join(os.path.dirname(__file__), 'scripts'))

try:
    # Add scripts directory to path and import
    script_dir = os.path.join(os.path.dirname(__file__), 'scripts')
    if script_dir not in sys.path:
        sys.path.insert(0, script_dir)
    
    # Try to import the original module
    import importlib.util
    spec = importlib.util.spec_from_file_location(
        "medication_dosage_to_text", 
        os.path.join(script_dir, "medication-dosage-to-text.py")
    )
    if spec and spec.loader:
        module = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(module)
        OriginalGenerator = module.MedicationDosageTextGenerator
    else:
        raise ImportError("Original module not found")

except (ImportError, AttributeError, FileNotFoundError) as e:
    # Fallback if import fails - simplified version
    print(f"Warning: Could not import original generator ({e}). Using simplified fallback.", file=sys.stderr)
    class OriginalGenerator:
        def generate_dosage_text(self, resource):
            return "Fallback: Originaler Textgenerierungsalgorithmus nicht verfügbar"

class ValidationError:
    """Represents a validation error for forbidden fields."""
    
    def __init__(self, field_path: str, field_name: str, value: Any, description: str):
        self.field_path = field_path
        self.field_name = field_name
        self.value = value
        self.description = description
    
    def __str__(self):
        return f"Verbotenes Feld '{self.field_path}': {self.description} (Wert: {self.value})"

class EnhancedMedicationDosageTextGenerator(OriginalGenerator):
    """
    Enhanced FHIR medication dosage text generator with field validation.
    
    Extends the original generator with validation for forbidden fields
    according to DosageDgMP and TimingDgMP profiles.
    """
    
    # Forbidden fields according to DosageDgMP and TimingDgMP profiles
    FORBIDDEN_DOSAGE_FIELDS = {
        'sequence': 'Dosier-Sequenz ist nicht vorgesehen',
        'additionalInstruction': 'Zusätzliche Anweisungen sind nicht vorgesehen',
        'patientInstruction': 'Patientenanweisungen sind nicht vorgesehen',
        'asNeededBoolean': 'Bedarfsdosis (Boolean) ist nicht vorgesehen',
        'asNeededCodeableConcept': 'Bedarfsdosis (CodeableConcept) ist nicht vorgesehen',
        'site': 'Verabreichungsstelle ist nicht vorgesehen',
        'route': 'Verabreichungsweg ist nicht vorgesehen',
        'method': 'Verabreichungsmethode ist nicht vorgesehen',
        'maxDosePerPeriod': 'Maximale Dosis pro Zeitraum ist nicht vorgesehen',
        'maxDosePerAdministration': 'Maximale Dosis pro Verabreichung ist nicht vorgesehen',
        'maxDosePerLifetime': 'Maximale Dosis über Lebenszeit ist nicht vorgesehen'
    }
    
    FORBIDDEN_DOSE_AND_RATE_FIELDS = {
        'type': 'Dosierungstyp ist nicht vorgesehen',
        'rateQuantity': 'Verabreichungsrate (Quantity) ist nicht vorgesehen',
        'rateRatio': 'Verabreichungsrate (Ratio) ist nicht vorgesehen',
        'rateRange': 'Verabreichungsrate (Range) ist nicht vorgesehen'
    }
    
    FORBIDDEN_TIMING_REPEAT_FIELDS = {
        'count': 'Wiederholungen sind nicht vorgesehen',
        'countMax': 'Maximale Wiederholungen sind nicht vorgesehen',
        'duration': 'Dauer einer Einzelgabe ist nicht vorgesehen',
        'durationMax': 'Maximale Dauer einer Einzelgabe ist nicht vorgesehen',
        'durationUnit': 'Einheit der Dauer einer Einzelgabe ist nicht vorgesehen',
        'frequencyMax': 'Maximale Frequenz ist nicht vorgesehen',
        'periodMax': 'Maximale Periodendauer ist nicht vorgesehen',
        'offset': 'Zeitversatz ist nicht vorgesehen'
    }
    
    FORBIDDEN_TIMING_FIELDS = {
        'event': 'Zeitpunkt des Ereignisses ist nicht vorgesehen',
        'code': 'Timing-Code ist nicht vorgesehen'
    }
    
    FORBIDDEN_TIMING_BOUNDS_FIELDS = {
        'boundsPeriod': 'Periodische Grenzen sind nicht vorgesehen',
        'boundsRange': 'Bereichsgrenzen sind nicht vorgesehen'
    }
    
    def __init__(self, strict_mode: bool = True):
        """
        Initialize the enhanced dosage text generator.
        
        Args:
            strict_mode (bool): If True, raises ValueError on forbidden fields.
                               If False, reports errors but continues processing.
        """
        super().__init__()
        self.strict_mode = strict_mode
        self.validation_errors: List[ValidationError] = []
    
    def generate_dosage_text(self, resource: Dict[str, Any]) -> str:
        """
        Generate dosage text with validation.
        
        Args:
            resource (dict): FHIR resource
            
        Returns:
            str: German dosage text
            
        Raises:
            ValueError: If strict_mode is True and forbidden fields are found
        """
        # Clear previous validation errors
        self.validation_errors = []
        
        # Step 1: Validate input against forbidden fields
        self._validate_resource(resource)
        
        # Report validation errors
        if self.validation_errors:
            self._report_validation_errors()
            
            if self.strict_mode:
                raise ValueError(f"Validierungsfehler: {len(self.validation_errors)} verbotene Felder gefunden")
        
        # Step 2: Generate text using original algorithm
        return super().generate_dosage_text(resource)
    
    def get_validation_errors(self) -> List[ValidationError]:
        """Return list of validation errors from last processing."""
        return self.validation_errors.copy()
    
    def _validate_resource(self, resource: Dict[str, Any]) -> None:
        """Validate the entire FHIR resource against forbidden fields."""
        resource_type = resource.get('resourceType', '')
        
        if resource_type in ['MedicationRequest', 'MedicationDispense']:
            dosage_instructions = resource.get('dosageInstruction', [])
            field_path = 'dosageInstruction'
        elif resource_type == 'MedicationStatement':
            dosage_instructions = resource.get('dosage', [])
            field_path = 'dosage'
        else:
            return  # Skip validation for unsupported resource types
        
        for i, dosage in enumerate(dosage_instructions):
            self._validate_dosage(dosage, f"{field_path}[{i}]")
    
    def _validate_dosage(self, dosage: Dict[str, Any], path: str) -> None:
        """Validate a single dosage instruction against forbidden fields."""
        
        # Check forbidden dosage-level fields
        for field, description in self.FORBIDDEN_DOSAGE_FIELDS.items():
            if field in dosage:
                self.validation_errors.append(
                    ValidationError(f"{path}.{field}", field, dosage[field], description)
                )
        
        # Check doseAndRate fields
        dose_and_rate_list = dosage.get('doseAndRate', [])
        for i, dose_rate in enumerate(dose_and_rate_list):
            self._validate_dose_and_rate(dose_rate, f"{path}.doseAndRate[{i}]")
        
        # Check timing fields
        timing = dosage.get('timing', {})
        if timing:
            self._validate_timing(timing, f"{path}.timing")
    
    def _validate_dose_and_rate(self, dose_rate: Dict[str, Any], path: str) -> None:
        """Validate doseAndRate fields against forbidden fields."""
        
        for field, description in self.FORBIDDEN_DOSE_AND_RATE_FIELDS.items():
            if field in dose_rate:
                self.validation_errors.append(
                    ValidationError(f"{path}.{field}", field, dose_rate[field], description)
                )
    
    def _validate_timing(self, timing: Dict[str, Any], path: str) -> None:
        """Validate timing fields against forbidden fields."""
        
        # Check timing-level forbidden fields
        for field, description in self.FORBIDDEN_TIMING_FIELDS.items():
            if field in timing:
                self.validation_errors.append(
                    ValidationError(f"{path}.{field}", field, timing[field], description)
                )
        
        # Check repeat fields
        repeat = timing.get('repeat', {})
        if repeat:
            self._validate_timing_repeat(repeat, f"{path}.repeat")
    
    def _validate_timing_repeat(self, repeat: Dict[str, Any], path: str) -> None:
        """Validate timing.repeat fields against forbidden fields."""
        
        # Check forbidden repeat fields
        for field, description in self.FORBIDDEN_TIMING_REPEAT_FIELDS.items():
            if field in repeat:
                self.validation_errors.append(
                    ValidationError(f"{path}.{field}", field, repeat[field], description)
                )
        
        # Check forbidden bounds types (only boundsDuration is allowed)
        for field, description in self.FORBIDDEN_TIMING_BOUNDS_FIELDS.items():
            if field in repeat:
                self.validation_errors.append(
                    ValidationError(f"{path}.{field}", field, repeat[field], description)
                )
    
    def _report_validation_errors(self) -> None:
        """Report all validation errors to stderr."""
        if not self.validation_errors:
            return
        
        print(f"\n⚠️  VALIDIERUNGSFEHLER: {len(self.validation_errors)} verbotene Felder gefunden:", file=sys.stderr)
        print("─" * 80, file=sys.stderr)
        
        for error in self.validation_errors:
            print(f"  • {error}", file=sys.stderr)
        
        print("─" * 80, file=sys.stderr)
        print("Diese Felder sind im DosageDgMP/TimingDgMP Profil mit Kardinalität 0..0 definiert.", file=sys.stderr)
        print(f"Strict Mode: {'AKTIV' if self.strict_mode else 'INAKTIV'} " + 
              ("(Verarbeitung wird abgebrochen)" if self.strict_mode else "(Verarbeitung wird fortgesetzt)"), file=sys.stderr)
        print("", file=sys.stderr)

def create_parser():
    """Create command line argument parser with comprehensive help."""
    parser = argparse.ArgumentParser(
        prog='command_line_interface.py',
        description='''Enhanced FHIR Medication Dosage Text Generator with Field Validation

Dieses Tool generiert deutsche Dosierungsanweisungen aus FHIR Medication-Ressourcen
und validiert gleichzeitig auf verbotene Felder gemäß DosageDgMP/TimingDgMP Profilen.

UNTERSTÜTZTE RESSOURCENTYPEN:
  • MedicationRequest      - Medikationsverordnungen
  • MedicationDispense     - Medikationsabgaben  
  • MedicationStatement    - Medikationsangaben

VALIDIERUNG:
  Prüft auf 20+ verbotene Felder in verschiedenen FHIR-Strukturen:
  • Dosage-Level (sequence, patientInstruction, site, route, etc.)
  • DoseAndRate-Level (type, rateQuantity, rateRatio, etc.)
  • Timing.repeat-Level (count, duration, offset, etc.)
  • Timing-Level (event, code, bounds*, etc.)

MODI:
  Strict Mode (Standard): Verarbeitung wird bei Validierungsfehlern abgebrochen
  Continue Mode: Fehler werden angezeigt, Verarbeitung wird fortgesetzt''',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog='''VERWENDUNGSBEISPIELE:

  Grundlegende Verwendung (Strict Mode, Standard):
    python command_line_interface.py medication.json
    
  Continue Mode aktivieren:
    python command_line_interface.py --continue-on-error medication.json
    
  Version anzeigen:
    python command_line_interface.py --version

BEISPIELAUSGABEN:

  Gültige Ressource:
    $ python command_line_interface.py valid.json
    täglich: je 1 Stück
    
  Ungültige Ressource (Strict Mode):
    $ python command_line_interface.py invalid.json
    VALIDIERUNGSFEHLER: 2 verbotene Felder gefunden:
    • Verbotenes Feld 'dosageInstruction[0].sequence': Dosier-Sequenz ist nicht vorgesehen (Wert: 1)
    • Verbotenes Feld 'dosageInstruction[0].timing.repeat.count': Wiederholungen sind nicht vorgesehen (Wert: 5)
    Fehler: Validierungsfehler: 2 verbotene Felder gefunden
    
  Ungültige Ressource (Continue Mode):
    $ python command_line_interface.py --continue-on-error invalid.json
    VALIDIERUNGSFEHLER: 2 verbotene Felder gefunden:
    • Verbotenes Feld 'dosageInstruction[0].sequence': Dosier-Sequenz ist nicht vorgesehen (Wert: 1)
    • Verbotenes Feld 'dosageInstruction[0].timing.repeat.count': Wiederholungen sind nicht vorgesehen (Wert: 5)
    täglich: je 1 Stück

EXIT CODES:
  0  Erfolgreiche Verarbeitung (keine Fehler oder Continue Mode)
  1  Datei-/JSON-Fehler
  2  Validierungsfehler in Strict Mode

DATEIEN:
  Input:  JSON-Datei mit FHIR Medication-Ressource
  Output: Deutscher Dosierungstext (stdout), Fehler (stderr)

WEITERE INFORMATIONEN:
  Siehe README.md für detaillierte Dokumentation und Beispiele.
        ''')
    
    parser.add_argument('file_path', 
                       metavar='MEDICATION_FILE',
                       help='Pfad zur JSON-Datei mit der FHIR Medication-Ressource (MedicationRequest, MedicationDispense oder MedicationStatement)')
    
    parser.add_argument('--continue-on-error', 
                       action='store_true',
                       help='Continue Mode: Validierungsfehler anzeigen, aber Verarbeitung fortsetzen (deaktiviert Strict Mode). Standard: Strict Mode (Abbruch bei Fehlern)')
    
    parser.add_argument('--version', 
                       action='version', 
                       version='Enhanced FHIR Medication Dosage Text Generator v1.1.0\nBasiert auf: medication-dosage-to-text.py v1.0.0\nMit Validierung für DosageDgMP/TimingDgMP Profile')
    
    return parser

def main():
    """
    Main entry point for command line interface.
    
    Verarbeitet Command-Line-Argumente, lädt die FHIR-Ressource, 
    führt Validierung und Textgenerierung durch und gibt entsprechende
    Exit-Codes zurück.
    
    Exit Codes:
        0: Erfolgreiche Verarbeitung (keine Validierungsfehler oder Continue Mode)
        1: Datei nicht gefunden oder JSON-Parsing-Fehler
        2: Validierungsfehler in Strict Mode
        3: Unerwarteter Fehler
    
    Workflow:
        1. Argumente parsen
        2. Datei-Existenz prüfen
        3. JSON laden und parsen
        4. Generator mit entsprechendem Modus erstellen
        5. Validierung und Textgenerierung durchführen
        6. Ergebnis ausgeben und Exit-Code setzen
    """
    
    # Parse command line arguments
    parser = create_parser()
    args = parser.parse_args()
    
    # Check if input file exists
    if not os.path.exists(args.file_path):
        print(f"Fehler: Datei '{args.file_path}' nicht gefunden.", file=sys.stderr)
        print(f"Bitte überprüfen Sie den Dateipfad und versuchen Sie es erneut.", file=sys.stderr)
        sys.exit(1)
    
    try:
        # Load and parse FHIR resource from JSON file
        with open(args.file_path, 'r', encoding='utf-8') as file:
            resource = json.load(file)
        
        # Validate that this looks like a FHIR resource
        if not isinstance(resource, dict) or 'resourceType' not in resource:
            print(f"Fehler: Die Datei '{args.file_path}' enthält keine gültige FHIR-Ressource.", file=sys.stderr)
            print("Erwartetes Format: JSON-Objekt mit 'resourceType' Feld.", file=sys.stderr)
            sys.exit(1)
        
        # Create generator with specified mode 
        # Note: strict mode is default (True), disabled with --continue-on-error (False)
        strict_mode = not args.continue_on_error
        generator = EnhancedMedicationDosageTextGenerator(strict_mode=strict_mode)
        
        # Generate text with validation
        result = generator.generate_dosage_text(resource)
        
        # Output result to stdout
        print(result)
        
        # Determine exit code based on validation results and mode
        validation_errors = generator.get_validation_errors()
        if validation_errors and strict_mode:
            # Strict mode: exit with error code if validation failed
            sys.exit(2)  
        elif validation_errors and not strict_mode:
            # Continue mode: exit successfully despite errors (errors already reported)
            sys.exit(0)  
        else:
            # No validation errors: successful processing
            sys.exit(0)  
        
    except json.JSONDecodeError as e:
        print(f"Fehler: Ungültiges JSON in Datei '{args.file_path}'.", file=sys.stderr)
        print(f"JSON-Parsing-Details: {e}", file=sys.stderr)
        print("Bitte überprüfen Sie die JSON-Syntax der Datei.", file=sys.stderr)
        sys.exit(1)
    except ValueError as e:
        # ValueError from strict mode validation
        print(f"Validierungsfehler: {e}", file=sys.stderr)
        sys.exit(2)
    except Exception as e:
        print(f"Unerwarteter Fehler beim Verarbeiten der Datei: {e}", file=sys.stderr)
        print("Bitte melden Sie diesen Fehler an die Entwickler.", file=sys.stderr)
        sys.exit(3)

if __name__ == "__main__":
    main()
