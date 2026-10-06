Diese Seite beschreibt strukturierte variable Angaben innerhalb einer einzelnen Dosierung. Gemeint sind Bereiche statt fixer Einzelwerte, also z. B. eine variable Einzeldosis oder eine variable Häufigkeit bzw. Periode.

Unter variablen Angaben werden in diesem IG folgende Modellierungen verstanden:

- variable Einzeldosis über `Dosage.doseAndRate.doseRange`
- variable Frequenz über `Timing.repeat.frequency` und `Timing.repeat.frequencyMax`
- variable Periode über `Timing.repeat.period` und `Timing.repeat.periodMax`

Die Seite beschreibt die hierfür geltenden technischen Anforderungen im dgMP-Kontext.

Folgende weitere Beispiele sind in diesem IG dargestellt:

| Fall | Beispielstring | Beispiel-Datei |
| -------- | ------- | ------- |
| Variable Einzeldosis | täglich: je 1 bis 2 Stück | [Example-MR-Dosage-variable-doseRange](MedicationRequest-Example-MR-Dosage-variable-doseRange.html) |
| Variable Frequenz | 1 bis 2 x täglich: je 1 Stück | [Example-MR-Dosage-variable-frequency](MedicationRequest-Example-MR-Dosage-variable-frequency.html) |
| Variable Periode | alle 4 bis 6 Tage: je 1 Stück | [Example-MR-Dosage-variable-period](MedicationRequest-Example-MR-Dosage-variable-period.html) |

### Variable Einzeldosis

Eine variable Einzeldosis wird über `Dosage.doseAndRate.doseRange` modelliert. Dabei beschreibt `low` die Untergrenze und `high` die Obergrenze des zulässigen Dosisbereichs.

### Beispiel

{% fragment MedicationRequest/Example-MR-Dosage-variable-doseRange JSON %}

#### Technische Anforderungen

**Untergrenze benötigt immer Obergrenze**

Invariante [DoseRangeHighRequiredWhenLowPresent](./dosierung-constraints.html#doserangehighrequiredwhenlowpresent):

```fhirpath
doseAndRate.dose.ofType(Range).low.empty()
or doseAndRate.dose.ofType(Range).high.exists()
```

**Unter- und Obergrenze müssen dieselbe Maßeinheit verwenden (`system`, `code`, `unit`)**

Invariante [DoseRangeLowAndHighSameUnit](./dosierung-constraints.html#doserangelowandhighsameunit):

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

Durchgesetzt über [TimingFreqOrPeriodGtOne](./dosierung-constraints.html#timingfreqorperiodgtone): Bei einer reinen Intervallangabe darf nur die Frequenz einschließlich `frequencyMax` oder die Periode einschließlich `periodMax` größer als `1` sein. Da `frequencyMax` und `periodMax` stets größer als `1` sind, schließt das die Kombination aus, etwa „1 bis 3 x alle 2 bis 3 Tage".

**Bei variabler Frequenz muss die maximale Frequenz größer als die minimale Frequenz sein**

Invariante [TimingVarFreqGtMin](./dosierung-constraints.html#timingvarfreqgtmin) auf `Timing.repeat`:

```fhirpath
frequencyMax.empty() or frequency.empty() or
  frequency.value.toInteger() < frequencyMax.value.toInteger()
```

**Variable Frequenz und maximale Dosis pro Zeitraum dürfen nicht gemeinsam verwendet werden**

Durchgesetzt über [MaxDoseOnlyPureAsNeeded](./dosierung-constraints.html#maxdoseonlypureasneeded) auf `Dosage`: Eine Maximalmenge ist nur bei einer reinen Bedarfsdosierung ohne `timing` zulässig, also nie zusammen mit einer Frequenz.

```fhirpath
maxDosePerPeriod.exists() implies (asNeeded.ofType(boolean) = true and timing.empty())
```

Folgende Beispiele sind nicht valide, da sie diese Constraints brechen:

{% include dosage-constraint-TimingFreqOrPeriodGtOne-examples.md%}

{% include dosage-constraint-TimingVarFreqGtMin-examples.md%}

{% include dosage-constraint-MaxDoseOnlyPureAsNeeded-examples.md%}


### Variable Periode

Eine variable Periode wird über `Timing.repeat.period` als Untergrenze und `Timing.repeat.periodMax` als Obergrenze modelliert.

### Beispiel

{% fragment MedicationRequest/Example-MR-Dosage-variable-period JSON %}

#### Technische Anforderungen

**Bei variabler Periode muss die maximale Periode größer als die minimale Periode sein**

Invariante [TimingVarPeriodGtMin](./dosierung-constraints.html#timingvarperiodgtmin) auf `Timing.repeat`:

```fhirpath
periodMax.empty() or period.empty() or period < periodMax
```

**Variable Periode und Mindestabstand zwischen zwei Einzelgaben dürfen nicht gemeinsam verwendet werden**

Durchgesetzt über [MinimumIntervalOnlyPureAsNeeded](./dosierung-constraints.html#minimumintervalonlypureasneeded) auf `Dosage`: Ein Mindestabstand ist nur bei einer reinen Bedarfsdosierung ohne `timing` zulässig, also nie zusammen mit einer Periode.

```fhirpath
modifierExtension.where(url='http://ig.fhir.de/igs/medication/StructureDefinition/MinimumIntervalBetweenAdministrations').exists() implies (asNeeded.ofType(boolean) = true and timing.empty())
```

Folgende Beispiele sind nicht valide, da sie diese Constraints brechen:

{% include dosage-constraint-TimingVarPeriodGtMin-examples.md%}

{% include dosage-constraint-MinimumIntervalOnlyPureAsNeeded-examples.md%}
