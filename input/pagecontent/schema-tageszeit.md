{% include StructureDefinition-WhenSchemeLogical-intro.md %}

{% include StructureDefinition-WhenSchemeLogical-diff.xhtml %}

### Beispiel

{% fragment MedicationRequest/Example-MR-Dosage-1010 JSON %}

Folgende weitere Beispiele sind in diesem IG dargestellt:

| Beispiel    | Beipspiel Datei |
| -------- | ------- |
| 1-0-1/2-0  | [Example-MR-Dosage-10120](./MedicationRequest-Example-MR-Dosage-10120.html)    |
| 1-0-2-0 | [Example-MR-Dosage-1020](./MedicationRequest-Example-MR-Dosage-1020.html)     |
| 1-0-0-0    | [Example-MR-Dosage-1000](./MedicationRequest-Example-MR-Dosage-1000.html)    |
| 1-0-1-0    | [Example-MR-Dosage-1010](./MedicationRequest-Example-MR-Dosage-1010.html)    |
| 1-1-1-1    | [Example-MR-Dosage-1111](./MedicationRequest-Example-MR-Dosage-1111.html)    |
| 1-0-1-0 für 10 Tage   | [Example-MR-Dosage-1010-10-Days](./MedicationRequest-Example-MR-Dosage-1010-10-Days.html)    |
| 1-0-1-0 unsortierte Tageszeiten  | [Example-MR-Dosage-1010-Unsorted](./MedicationRequest-Example-MR-Dosage-1010-Unsorted.html)    |

### Angabe und Erkennung der Dosierart

Diese Dosierungsart wird daran erkannt, dass unter `Dosage.timing.repeat`

- `when`
- opt. Angabe von `frequency` (muss der Anzahl der `when`-Elemente entsprechen)
- opt. Angabe von `period = 1` und `periodUnit = d`
- opt. Angabe von `bounds[x]`
  
angegeben ist. An diesem Feld wird dann kodiert die Tageszeit angegeben an der eine konkrete Dosierung einzunehmen ist.

Folgende FHIR-Path Expression auf Ebene von `Dosage.timing.repeat` liefert die Angabe, ob es sich um das Schema handelt:

```
timing.repeat.when.exists() and
timing.repeat.timeOfDay.empty() and
timing.repeat.dayOfWeek.empty()
```

Die tägliche Wiederholung und die Zahl der Gaben ergeben sich bereits aus
`when`. Als [Legacy-Angaben](./StructureDefinition-TimingDgMP.html) zulässig
sind hier `frequency` — entsprechend der Anzahl der `when`-Elemente — sowie
das Paar `period = 1` und `periodUnit = d`.

Soll das Arzneimittel in derselben Dosierung zu mehreren Tageszeiten angewandt werden, wird dies über mehrere Angaben von "when" ausgedrückt. Die angegebene Dosierung ist dann zu jeder der genannten Tageszeiten anzuwenden. 

Beispiel:
- Dosage.timing.repeat.when = #MORN, #EVE
- Dosage.doseAndRate.doseQuantity = 1 Stück
bedeutet, dass eine Stück morgens und abends einzunehmen ist.

Lesende Systeme werten entsprechend auch `Dosage.timing.repeat` aus. Wenn nur .when angegeben ist, ist dem Nutzer das 4-er Schema anzuzeigen.
