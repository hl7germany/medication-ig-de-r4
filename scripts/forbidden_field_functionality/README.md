# Enhanced FHIR Medication Dosage Text Generator

Dieses erweiterte Python-Script konvertiert FHIR-Medikationsdosierungen in menschenlesbaren deutschen Text und validiert dabei den Input gegen verbotene Felder, die im DosageDgMP und TimingDgMP Profil mit maximaler Kardinalität 0 definiert sind.

## 🚀 Funktionalitäten

### Textgenerierung
- **Verschiedene Dosierungsschemata**: 4-Schema, TimeOfDay, DayOfWeek, Interval und Kombinationen
- **Deutsche Ausgabe**: Vollständig lokalisierte Textausgabe (z.B. "1-0-2-0 Stück", "täglich: 08:00 Uhr — je 1 Stück")
- **Beibehaltene Originallogik**: Der bewährte Textgenerierungsalgorithmus bleibt unverändert

### Validierung gegen verbotene Felder
- **DosageDgMP Validierung**: Prüft auf verbotene Felder wie `sequence`, `patientInstruction`, `additionalInstruction`
- **TimingDgMP Validierung**: Prüft auf verbotene Timing-Felder wie `count`, `countMax`, `duration`
- **Strukturierte Fehlerausgabe**: Detaillierte Meldungen mit Feldpfad und Beschreibung

### Strict Mode
- **Strenge Validierung**: Standardmäßig wird bei Fehlern die Verarbeitung abgebrochen
- **Continue Mode**: Optional kann bei Fehlern die Verarbeitung fortgesetzt werden
- **Vollständige Fehlersammlung**: Alle Validierungsfehler werden gesammelt und ausgegeben

## 📋 Verbotene Felder

### DosageDgMP (Kardinalität 0..0)
- `sequence` - Dosier-Sequenz ist nicht vorgesehen
- `additionalInstruction` - Zusätzliche Anweisungen sind nicht vorgesehen  
- `patientInstruction` - Patientenanweisungen sind nicht vorgesehen
- `asNeeded[x]` - Bedarfsdosis ist nicht vorgesehen
- `site` - Verabreichungsstelle ist nicht vorgesehen
- `route` - Verabreichungsweg ist nicht vorgesehen
- `method` - Verabreichungsmethode ist nicht vorgesehen
- `maxDosePerPeriod` - Maximale Dosis pro Zeitraum ist nicht vorgesehen
- `maxDosePerAdministration` - Maximale Dosis pro Verabreichung ist nicht vorgesehen
- `maxDosePerLifetime` - Maximale Dosis über Lebenszeit ist nicht vorgesehen
- `doseAndRate.type` - Dosierungstyp ist nicht vorgesehen
- `doseAndRate.rate[x]` - Verabreichungsrate ist nicht vorgesehen

### TimingDgMP.repeat (Kardinalität 0..0)
- `count` - Wiederholungen sind nicht vorgesehen
- `countMax` - Maximale Wiederholungen sind nicht vorgesehen
- `duration` - Dauer einer Einzelgabe ist nicht vorgesehen
- `durationMax` - Maximale Dauer einer Einzelgabe ist nicht vorgesehen
- `durationUnit` - Einheit der Dauer einer Einzelgabe ist nicht vorgesehen
- `frequencyMax` - Maximale Frequenz ist nicht vorgesehen
- `periodMax` - Maximale Periodendauer ist nicht vorgesehen
- `offset` - Zeitversatz ist nicht vorgesehen

### TimingDgMP (Kardinalität 0..0)
- `event` - Zeitpunkt des Ereignisses ist nicht vorgesehen
- `code` - Timing-Code ist nicht vorgesehen

### TimingDgMP.repeat.bounds[x] (nur boundsDuration erlaubt)
- `boundsPeriod` - Periodische Grenzen sind nicht vorgesehen
- `boundsRange` - Bereichsgrenzen sind nicht vorgesehen

## 🔧 Verwendung

### Als Python-Modul

```python
from scripts.forbidden_field_functionality.medication_dosage_validator import
  MedicationDosageTextGenerator

# Standard-Modus (Strict Mode ist jetzt Standard - bricht bei Fehlern ab)
generator = MedicationDosageTextGenerator(strict_mode=True)

# Continue-Modus (Fehler werden gemeldet, aber Verarbeitung fortgesetzt)
generator = MedicationDosageTextGenerator(strict_mode=False)

# FHIR Resource verarbeiten
try:
  text = generator.generate_dosage_text(fhir_resource)
  print(f"Generierter Text: {text}")

  # Validierungsfehler abrufen
  errors = generator.get_validation_errors()
  if errors:
    print(f"Validierungsfehler: {len(errors)}")
    for error in errors:
      print(f"  - {error}")

except ValueError as e:
  print(f"Validierungsfehler im Strict-Modus: {e}")
```

### Kommandozeile

```bash
# Strict-Modus (Standard - bricht bei Fehlern ab)
python medication_dosage_validator.py medication_resource.json

# Continue-Modus (mit verbotenen Feldern fortsetzen)
python enhanced_medication_dosage_text.py --continue-on-error invalid_resource.json
```

## 📊 Beispiel-Ausgaben

### Erfolgreiche Validierung

```
täglich: 08:00 Uhr — je 1 Stück; 20:00 Uhr — je 2 Stück
```

### Validierungsfehler (Continue-Modus)

```
⚠️  VALIDIERUNGSFEHLER: 3 verbotene Felder gefunden:
────────────────────────────────────────────────────────────────────────────────
  • Verbotenes Feld 'dosageInstruction[0].sequence': Dosier-Sequenz ist nicht vorgesehen (Wert: 1)
  • Verbotenes Feld 'dosageInstruction[0].patientInstruction': Patientenanweisungen sind nicht vorgesehen (Wert: "Mit Wasser einnehmen")
  • Verbotenes Feld 'dosageInstruction[0].timing.repeat.count': Wiederholungen sind nicht vorgesehen (Wert: 5)
────────────────────────────────────────────────────────────────────────────────
Diese Felder sind im DosageDgMP/TimingDgMP Profil mit Kardinalität 0..0 definiert.
Strict Mode: INAKTIV (Verarbeitung wird fortgesetzt)

täglich: 08:00 Uhr — je 1 Stück
```

### Strict-Modus (Standard - Fehler führt zum Abbruch)

```
⚠️  VALIDIERUNGSFEHLER: 1 verbotene Felder gefunden:
────────────────────────────────────────────────────────────────────────────────
  • Verbotenes Feld 'dosageInstruction[0].sequence': Dosier-Sequenz ist nicht vorgesehen (Wert: 1)
────────────────────────────────────────────────────────────────────────────────
Diese Felder sind im DosageDgMP/TimingDgMP Profil mit Kardinalität 0..0 definiert.
Strict Mode: AKTIV (Verarbeitung wird abgebrochen)

Fehler: Validierungsfehler: 1 verbotene Felder gefunden
```

## 🧪 Unterstützte Dosierungsschemata

Das Script unterstützt alle im Original definierten Dosierungsschemata:

1. **FreeText**: `"Nach Bedarf bei Schmerzen"`
2. **4-Schema**: `"1-0-2-0 Stück"`
3. **TimeOfDay**: `"täglich: 08:00 Uhr — je 1 Stück; 20:00 Uhr — je 2 Stück"`
4. **DayOfWeek**: `"montags — je 1 Stück, mittwochs — je 2 Stück"`
5. **Interval**: `"alle 8 Stunden: je 1 Stück"`
6. **DayOfWeek + Time/4-Schema**: `"montags 08:00 Uhr — je 1 Stück"`
7. **Interval + Time/4-Schema**: `"alle 2 Tage: 08:00 Uhr — je 1 Stück"`

## 📝 Validierungslogik

Die Validierung erfolgt vor der Textgenerierung und prüft:

1. **Dosage-Ebene**: Alle Felder in der Dosierungsanweisung
2. **DoseAndRate-Ebene**: Felder in `doseAndRate[]` Arrayelementen  
3. **Timing-Ebene**: Felder im `timing` Objekt
4. **Timing.repeat-Ebene**: Felder im `timing.repeat` Objekt

Fehler werden mit vollständigem Feldpfad (z.B. `dosageInstruction[0].timing.repeat.count`) und einer benutzerfreundlichen Beschreibung gemeldet.

## 🔄 Migration vom Original

Das erweiterte Script ist vollständig kompatibel mit dem Original:

- **Gleiche API**: `generate_dosage_text(resource)` funktioniert unverändert
- **Gleiche Ausgabe**: Bei validen Inputs identische Textgenerierung
- **Neue Features**: Zusätzliche Validierung und optionaler Strict-Modus
- **Backward-Compatible**: Bestehender Code funktioniert ohne Änderungen

## 🎯 Technische Details

- **Version**: 1.1.0
- **Sprache**: Python 3.6+
- **Abhängigkeiten**: Nur Python Standard Library
- **Encoding**: UTF-8
- **Ausgabesprache**: Deutsch (de-DE)

Das Script implementiert die vollständige Referenzlogik des deutschen FHIR-Medikationsdosierungs-Implementierungsleitfadens mit zusätzlicher Validierung für die dgMP-Ausbaustufe.
