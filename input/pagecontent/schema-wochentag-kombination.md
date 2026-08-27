{% include StructureDefinition-WeekdayCombinationSchemeLogical-intro.md %}

{% include StructureDefinition-WeekdayCombinationSchemeLogical-diff.xhtml %}

### Beispiel

{% fragment MedicationRequest/Example-MR-Dosage-comb-dayofweek-1 JSON %}

Folgende weitere Beispiele sind in diesem IG dargestellt:

| Beispiel    | Beipspiel Datei |
| -------- | ------- |
| Montags und Freitags 1-0-1-0  | [Example-MR-Dosage-comb-dayofweek-1](./MedicationRequest-Example-MR-Dosage-comb-dayofweek-1.html)    |  |
| Montags und Freitags 1-0-2-0  | [Example-MR-Dosage-comb-dayofweek-2](./MedicationRequest-Example-MR-Dosage-comb-dayofweek-2.html)    |
| Unsortierte Wochentage  | [Example-MR-Dosage-comb-dayofweek-unsorted](./MedicationRequest-Example-MR-Dosage-comb-dayofweek-unsorted.html)    |
| Montags und Freitags 1 Stück um 08:00 Uhr und 2 Stück um 10:00 Uhr - für 3 Wochen  | [Example-MR-Dosage-comb-dayofweek-3](./MedicationRequest-Example-MR-Dosage-comb-dayofweek-3.html)    |

### Angabe und Erkennung der Dosierart 

Diese Dosierungsart wird daran erkannt, dass folgende Felder unter `Dosage.timing.repeat` angegeben sind:

- `dayOfWeek`
- opt. Angabe von `frequency`
- opt. Angabe des Paars `period = 1` und `periodUnit = wk` als redundante Angabe
- und `when` ODER `timeOfDay` existieren
- opt. Angabe von `bounds[x]`

Folgende FHIR-Path Expression auf Ebene von `Dosage.timing.repeat` liefert die Angabe, ob es sich um das Schema handelt: 

```
timing.repeat.dayOfWeek.exists() and
  (
    (timing.repeat.timeOfDay.exists() and timing.repeat.when.empty()) or
    (timing.repeat.when.exists() and timing.repeat.timeOfDay.empty())
  )
```

Die Werte in `dayOfWeek` und `when` beziehungsweise `timeOfDay` legen die
Anwendungstage und Gaben eindeutig fest. Als
[Legacy-Angaben](./StructureDefinition-TimingDgMP.html) zulässig sind hier
`frequency` — entsprechend dem Produkt aus der Anzahl der Wochentage und der
Anzahl der `when`- beziehungsweise `timeOfDay`-Werte — sowie das Paar
`period = 1` und `periodUnit = wk`.

Lesende Systeme werten entsprechend auch `Dosage.timing.repeat` aus. 
Wenn die oben genannten Felder angegeben sind, ist dem Nutzer anzuzeigen, dass
die Dosierung nach Wochentagen mit Tageszeit- oder Uhrzeitbezug definiert ist.
