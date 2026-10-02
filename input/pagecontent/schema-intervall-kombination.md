{% include StructureDefinition-IntervalCombinationSchemeLogical-intro.md %}

{% include StructureDefinition-IntervalCombinationSchemeLogical-diff.xhtml %}

### Beispiel

{% fragment MedicationRequest/Example-MR-Dosage-comb-interval-1 JSON %}

Folgende weitere Beispiele sind in diesem IG dargestellt:

| Beispiel    | Beipspiel Datei |
| -------- | ------- |
| alle 2 Tage: 08:00 Uhr — je 1 Stück, 18:00 Uhr — je 2 Stück  | [Example-MR-Dosage-comb-interval-1](./MedicationRequest-Example-MR-Dosage-comb-interval-1.html)    |  |
| wöchentlich: morgens — je 1 Stück  | [Example-MR-Dosage-comb-interval-2](./MedicationRequest-Example-MR-Dosage-comb-interval-2.html)    |
| alle 2 Tage: 08:00 Uhr — je 1 Stück, 20:00 Uhr — je 2 Stück  | [Example-MR-Dosage-comb-interval-3](./MedicationRequest-Example-MR-Dosage-comb-interval-3.html)    |
| alle 2 Tage: 08:00 Uhr — je 1 Stück, 10:00 Uhr — je 2 Stück, 14:00 Uhr — je 2 Stück, 20:00 Uhr — je 1 Stück, 22:00 Uhr — je 2 Stück | [Example-MR-Dosage-comb-interval-4](./MedicationRequest-Example-MR-Dosage-comb-interval-4.html)    |

### Angabe und Erkennung der Dosierart 

Diese Dosierungsart wird daran erkannt, dass folgende Felder unter `Dosage.timing.repeat` angegeben sind:

- `period`
- `periodUnit`
- `timeOfDay` ODER `when`
- opt. Angabe von `frequency`
- opt. Angabe von `bounds[x]`

Folgende FHIR-Path Expression auf Ebene von `Dosage.timing.repeat` liefert die Angabe, ob es sich um das Schema handelt:

```
timing.repeat.period.exists() and
timing.repeat.periodUnit.exists() and
timing.repeat.dayOfWeek.empty() and
  (
    (timing.repeat.timeOfDay.exists() and timing.repeat.when.empty()) or
    (timing.repeat.when.exists() and timing.repeat.timeOfDay.empty())
  )
```

`frequency` ist in diesem Schema als
[Legacy-Angabe](./StructureDefinition-TimingDgMP.html) zulässig. Die Häufigkeit
ergibt sich bereits aus den konkreten Werten in `when` beziehungsweise
`timeOfDay`; eine vorhandene Angabe muss deren Anzahl entsprechen und wird im
generierten Text nicht ausgegeben. `period` und `periodUnit` sind hier dagegen
keine Legacy-Angaben, sondern legen den Rhythmus fest.

Die Regel `TimingFreqOrPeriodGtOne`, nach der von Frequenz und Periode nur eine
größer als `1` sein darf, gilt ausschließlich für reine Intervallangaben ohne
Zeitpunkte. Hier legen `when` beziehungsweise `timeOfDay` die Zahl der Gaben
fest, und eine Periode größer als `1` beschreibt den Abstand der Anwendungstage.
Im dgMP-Profil ist die Regel ein Fehler, im generischen Profil `TimingDE` eine
Warnung.

Mit `period` und `periodUnit` wird der Einnahmerhythmus festgelegt. `when` oder
`timeOfDay` ordnet diesem Rhythmus konkrete Tagesabschnitte beziehungsweise
Uhrzeiten zu.

Lesende Systeme werten entsprechend auch `Dosage.timing.repeat` aus. 
Wenn die oben genannten Felder angegeben sind, ist dem Nutzer anzuzeigen, dass die
Dosierung nach einem Einnahmerhythmus mit Tageszeit- oder Uhrzeitbezug definiert
ist.
