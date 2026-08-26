Es wird ermöglicht, einen Tageszeiten-Bezug oder einen Uhrzeiten-Bezug mit einem Zeitintervall (Einheit mind. „Tag“) zu kombinieren.

Es wird ermöglicht, die geplante Dauer der Anwendung zu begrenzen.

### Beispiel

{% fragment MedicationRequest/Example-MR-Dosage-comb-interval-1 JSON %}

Folgende weitere Beispiele sind in diesem IG dargestellt:

| Beispiel    | Beipspiel Datei |
| -------- | ------- |
| Jeden 2. Tag 1 Stück um 08:00 Uhr und 2 Stück um 18:00 Uhr  | [Example-MR-Dosage-comb-interval-1](./MedicationRequest-Example-MR-Dosage-comb-interval-1.html)    |  |
| Wöchentlich 1 Stück morgens  | [Example-MR-Dosage-comb-interval-2](./MedicationRequest-Example-MR-Dosage-comb-interval-2.html)    |
| Jeden 2. Tag 1 Stück um 08:00 Uhr und jeden 2. Tag 1 Stück um 08:00 Uhr  | [Example-MR-Dosage-comb-interval-3](./MedicationRequest-Example-MR-Dosage-comb-interval-3.html)    |
| Jeden 2. Tag 1 Stück um 08:00 und 20:00 Uhr sowie 2 Stück um 10:00, 14:00 und 22:00 Uhr (ohne `frequency`)  | [Example-MR-Dosage-comb-interval-4](./MedicationRequest-Example-MR-Dosage-comb-interval-4.html)    |

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

`frequency` ist in diesem Schema optional. Die Häufigkeit ergibt sich bereits
aus den konkreten Werten in `when` beziehungsweise `timeOfDay`; eine vorhandene
Angabe muss deren Anzahl entsprechen und wird im generierten Text nicht
ausgegeben.

Die Warnung `TimingVarFreqOrPeriod`, die eine gleichzeitige Erhöhung von
`frequency` und `period` beanstandet, gilt ausschließlich für reine
Intervallangaben ohne Zeitpunkte.

Mit `period` und `periodUnit` wird der Einnahmerhythmus festgelegt. `when` oder
`timeOfDay` ordnet diesem Rhythmus konkrete Tagesabschnitte beziehungsweise
Uhrzeiten zu.

Lesende Systeme werten entsprechend auch `Dosage.timing.repeat` aus. 
Wenn die oben genannten Felder angegeben sind, ist dem Nutzer anzuzeigen, dass die
Dosierung nach einem Einnahmerhythmus mit Tageszeit- oder Uhrzeitbezug definiert
ist.
