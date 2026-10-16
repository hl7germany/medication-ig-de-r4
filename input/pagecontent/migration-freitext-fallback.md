[Zur Migrationsübersicht](./migration-1.0.7-2.0.0.html)

Der Freitext-Fallback gilt, wenn eine strukturierte 1.0.7-Dosierung nach den Normalisierungen M02 und M18 weiterhin eine Invariante des 2.0.0-Profils verletzt. Die Dosierung wird dann als reine Freitext-Dosierung abgebildet. Zahlen, Einheiten und Zeitangaben werden dabei weder korrigiert noch umgerechnet; der Freitext gibt die Quelldosierung so wieder, wie sie strukturiert angegeben war.

### Abbildung

1. **Text bestimmen:**
   - Trägt die Quellressource `renderedDosageInstruction`, wird dieser Text verwendet. Für strukturierte Dosierungen war er in 1.0.7 vorgeschrieben (`DosageStructuredRequiresGeneratedText`) und beschreibt genau die Quellstruktur.
   - Fehlt er, wird der Text mit der [Textgenerierung](./dosierung-textgenerierung.html) aus der Quellstruktur erzeugt.
2. **Dosierung ersetzen:** Die gesamte Dosierungs-Liste wird durch genau ein `Dosage`-Element ersetzt, das nur `text` mit dem Text aus Schritt 1 enthält, also ohne `timing` und ohne `doseAndRate` (`DosageStructuredOrFreeText`, `FreeTextSingleDosageOnly`).
3. **4-Schema prüfen:** Besteht der Text nur aus einem 4-Schema (zum Beispiel `1-0-1-0 Stück`), wird [M04](./migration-m04-viererschema-freitext.html) angewendet.
4. **Text-Extensions setzen:** `renderedDosageInstruction` erhält exakt den Wert von `Dosage.text`. `GeneratedDosageInstructionsMeta` gibt die Sprache und die Algorithmusversion an, mit der der Text erzeugt wurde. Wurde der Text aus der Quelle übernommen, sind das die Angaben aus der `GeneratedDosageInstructionsMeta` der Quelle.

Liefert weder die Quelle einen Text noch die Textgenerierung, beschreibt dieser Leitfaden keine Abbildung.

### Betroffene Fälle

| Fall | Constraint | Anlass | Beispiel für den Zieltext |
|---|---|---|---|
| M01 | `DosageDoseQuantityAllowedFractions` | Dosiswert mit einem Bruchteil außer `.25`, `.33`, `.5`, `.66`, `.75` (zum Beispiel `1.2`) | `täglich: je 1,2 Stück` |
| M03 | `DosageDoseValuePositive` | Dosiswert null oder negativ | `täglich: je 0 Stück` |
| M05 | `TimingBoundsDurationOnlyWholeNumber` | Nicht ganzzahlige Behandlungsdauer (zum Beispiel `1.5 d`) | `für 1,5 Tage täglich: je 1 Stück` |
| M06 | `TimingPeriodOnlyWholeNumber` | Nicht ganzzahlige Periode (zum Beispiel `1.5 d`) | `alle 1,5 Tage: je 1 Stück` |
| M07 | `TimingFreqOrPeriodGtOne` | Reines Intervall, bei dem Frequenz und Periode beide größer als eins sind | `2 x alle 8 Stunden: je 1 Stück` |
| M08 | `TimingOnlyOneTimeForInterval` | Unvollständige oder widersprüchliche Intervallangaben | |
| M09 | `TimingOnlyOneWhen` | Doppelte Tagesabschnitts-Codes | |
| M10 | `TimingOnlyOneTimeOfDay` | Doppelte Uhrzeiten | |
| M11 | `TimingOnlyOneDayOfWeek` | Doppelte Wochentage | |
| M12 | `TimingOnlyWhenOrTimeOfDay` | Tagesabschnitte und Uhrzeiten gemischt | |
| M13 | `TimingSingleDosageForTimeOfDay` | Wiederholte Uhrzeiten über mehrere Dosage-Elemente | |
| M14 | `TimingSingleDosageForWhen` | Wiederholte Tagesabschnitte über mehrere Dosage-Elemente | |
| M15 | `TimingOnlyOneBounds` | Behandlungsdauer nur an einem Teil der Dosage-Elemente | |
| M16 | `DosageStructuredRequiresBoth` | `timing` oder `doseAndRate` fehlt | |
| M17 | `DosageDoseUnitSameCode` | Unterschiedliche Dosis-Codes in einer Dosierung | |
| M22 | `TimingValuesPositive` | `period` oder `boundsDuration.value` null oder negativ | |

Die Beispieltexte zeigen die Form, die die Textgenerierung für die jeweilige Quellstruktur liefert. Ist der Text aus der Quelle übernommen, steht dort der Text aus deren `renderedDosageInstruction`.

### Beispiel

Quelle (1.0.7), `MedicationRequest`:

```text
dosageInstruction[0].doseAndRate.doseQuantity = 1.2 Stück
dosageInstruction[0].timing.repeat           = frequency 1, period 1, periodUnit d
renderedDosageInstruction                    = "täglich: je 1,2 Stück"
GeneratedDosageInstructionsMeta              = language de-DE, algorithmVersion <Version der Quelle>
```

Ziel (2.0.0):

```text
dosageInstruction[0].text                    = "täglich: je 1,2 Stück"
renderedDosageInstruction                    = "täglich: je 1,2 Stück"
GeneratedDosageInstructionsMeta              = language de-DE, algorithmVersion <Version der Quelle>
```

`timing` und `doseAndRate` entfallen. Der Wert `1.2` wird nicht gerundet und nicht in eine andere Einheit umgerechnet.
