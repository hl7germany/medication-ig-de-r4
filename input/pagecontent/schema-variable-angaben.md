Diese Seite beschreibt strukturierte variable Angaben innerhalb einer einzelnen Dosierung. Gemeint sind Bereiche statt fixer Einzelwerte, also z. B. eine variable Einzeldosis oder eine variable Häufigkeit bzw. Periode.

Unter variablen Angaben werden in diesem IG folgende Modellierungen verstanden:

- variable Einzeldosis über `Dosage.doseAndRate.doseRange`
- variable Frequenz über `Timing.repeat.frequency` und `Timing.repeat.frequencyMax`
- variable Periode über `Timing.repeat.period` und `Timing.repeat.periodMax`

Die Seite beschreibt die hierfür geltenden technischen Anforderungen im dgMP-Kontext.

Folgende weitere Beispiele sind in diesem IG dargestellt:

| Beispiel | Beispiel Datei |
| -------- | ------- |
| Variable Einzeldosis: 1 bis 2 Stück täglich | [Example-MR-Dosage-variable-doseRange](MedicationRequest-Example-MR-Dosage-variable-doseRange.html) |
| Variable Frequenz: 1 bis 2 Stück pro Tag | [Example-MR-Dosage-variable-frequency](MedicationRequest-Example-MR-Dosage-variable-frequency.html) |
| Variable Periode: 1 Stück alle 4 bis 6 Stunden | [Example-MR-Dosage-variable-period](MedicationRequest-Example-MR-Dosage-variable-period.html) |

### Variable Einzeldosis

Eine variable Einzeldosis wird über `Dosage.doseAndRate.doseRange` modelliert. Dabei beschreibt `low` die Untergrenze und `high` die Obergrenze des zulässigen Dosisbereichs.

### Beispiel

{% fragment MedicationRequest/Example-MR-Dosage-variable-doseRange JSON %}

#### Technische Anforderungen

**Untergrenze benötigt immer Obergrenze**

```fhirpath
doseAndRate.dose.ofType(Range).low.empty()
or doseAndRate.dose.ofType(Range).high.exists()
```

**Unter- und Obergrenze müssen dieselbe Maßeinheit verwenden (`system`, `code`, `unit`)**

```fhirpath
doseAndRate.dose.ofType(Range).low.empty()
or doseAndRate.dose.ofType(Range).high.empty()
or (
  doseAndRate.dose.ofType(Range).low.system = doseAndRate.dose.ofType(Range).high.system
  and doseAndRate.dose.ofType(Range).low.code = doseAndRate.dose.ofType(Range).high.code
  and doseAndRate.dose.ofType(Range).low.unit = doseAndRate.dose.ofType(Range).high.unit
)
```

Folgende Beispiele sind nicht valide, da sie diese Constraints brechen:

{% include dosage-constraint-DoseRangeHighRequiredWhenLowPresent-examples.md%}

{% include dosage-constraint-DoseRangeLowAndHighSameUnit-examples.md%}

### Variable Frequenz

Eine variable Frequenz wird über `Timing.repeat.frequency` als Untergrenze und `Timing.repeat.frequencyMax` als Obergrenze modelliert.

### Beispiel

{% fragment MedicationRequest/Example-MR-Dosage-variable-frequency JSON %}

#### Technische Anforderungen

**Variable Frequenz und variable Periode dürfen nicht gemeinsam verwendet werden**

```fhirpath
repeat.frequencyMax.empty() or repeat.periodMax.empty()
```

**Bei variabler Frequenz muss die maximale Frequenz größer als die minimale Frequenz sein**

```fhirpath
repeat.frequencyMax.empty()
or repeat.frequency.empty()
or repeat.frequency < repeat.frequencyMax
```

**Variable Frequenz und maximale Dosis pro Zeitraum dürfen nicht gemeinsam verwendet werden**

Constraint auf Ebene von `Dosage`:

```fhirpath
timing.repeat.frequencyMax.empty() or maxDosePerPeriod.empty()
```

Folgende Beispiele sind nicht valide, da sie diese Constraints brechen:

{% include dosage-constraint-TimingVarFreqOrPeriod-examples.md%}

{% include dosage-constraint-TimingVarFreqGtMin-examples.md%}

{% include dosage-constraint-VarFreqNoMaxDose-examples.md%}

### Variable Periode

Eine variable Periode wird über `Timing.repeat.period` als Untergrenze und `Timing.repeat.periodMax` als Obergrenze modelliert.

### Beispiel

{% fragment MedicationRequest/Example-MR-Dosage-variable-period JSON %}

#### Technische Anforderungen

**Bei variabler Periode muss die maximale Periode größer als die minimale Periode sein**

```fhirpath
repeat.periodMax.empty() or repeat.period.empty() or repeat.period < repeat.periodMax
```

**Variable Periode und Mindestabstand zwischen zwei Einzelgaben dürfen nicht gemeinsam verwendet werden**

```fhirpath
timing.repeat.periodMax.empty()
or modifierExtension.where(url='http://ig.fhir.de/igs/medication/StructureDefinition/MindestabstandZwischenGaben').empty()
```

Folgende Beispiele sind nicht valide, da sie diese Constraints brechen:

{% include dosage-constraint-TimingVarPeriodGtMin-examples.md%}

{% include dosage-constraint-VarPeriodNoMindestabstand-examples.md%}
