## Schema für Kombinationen des Wochentags

Dieses Schema gibt an, an welchen Wochentagen einer Kalenderwoche das Medikament angewandt werden soll und trifft zudem eine Aussage, zu welchen Uhrzeiten oder Tageszeiten die Anwendung an den betreffenden Kalendertagen erfolgen soll. 

In diesem Anwendungsfall wird davon ausgegangen, dass das Arzneimittel wöchentlich (für die geplante Dauer) in einem gleichbleibenden Wochentagsschema angewandt wird. Es wird zudem ermöglicht:

- ein Uhrzeiten-Schema oder Tageszeitenschema für einzelne Wochentage festzulegen 
- eine abweichende Dosis abhängig von der Uhrzeit/Tageszeit/Wochentag anzugeben und
- die geplante Dauer der Anwendung zu begrenzen. 

### Beipiel

{% fragment MedicationRequest/Example-MR-Dosage-comb-dayofweek-1 JSON %}

Folgende weitere Beispiele sind in diesem IG dargestellt:

| Beispiel    | Beipspiel Datei |
| -------- | ------- |
| Montags und Freitags 1-0-1-0  | [Example-MR-Dosage-comb-dayofweek-1](./MedicationRequest-Example-MR-Dosage-comb-dayofweek-1.html)    |  |
| Montags und Freitags 1-0-2-0  | [Example-MR-Dosage-comb-dayofweek-2](./MedicationRequest-Example-MR-Dosage-comb-dayofweek-2.html)    |
| Montags und Freitags 1 Tablette um 08:00 Uhr und 2 Tabletten um 10:00 Uhr – für 3 Wochen  | [Example-MR-Dosage-comb-dayofweek-3](./MedicationRequest-Example-MR-Dosage-comb-dayofweek-3.html)    |

### Angabe und Erkennung der Dosierart 

Diese Dosierungsart wird daran erkannt, dass folgende Felder unter `Dosage.timing.repeat` angegeben sind:

- `when` ODER `dayOfWeek` existieren

Folgende FHIR-Path Expression auf Ebene von `Dosage.timing.repeat` liefert die Angabe, ob es sich um das Schema handelt: 

```
timing.repeat.dayOfWeek.exists() and
timing.repeat.frequency.empty() and
timing.repeat.period.empty() and
timing.repeat.periodUnit.empty() and
  (
    (timing.repeat.timeOfDay.exists() and timing.repeat.when.empty()) or
    (timing.repeat.when.exists() and timing.repeat.timeOfDay.empty())
  )
```

und entweder `when` oder `timeOfDay`. Damit kann diese Dosierangabe verwendet werden um eine Interval angabe auf Tageszeit oder Uhrzeit zu kombinieren.

Lesende Systeme werten entsprechend auch `Dosage.timing.repeat` aus. 
Wenn die oben genannten Felder angegeben sind, ist dem Nutzer anzuzeigen, dass die Dosierung nach einem Interval mit Tageszeit oder Uhrzeitbezug definiert ist.
