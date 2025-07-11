# Schema für Uhrzeit Bezug

Dieses Schema bietet die Möglichkeit, die Dosierung zu exakt festgelegten Zeiten an einem Tag zu planen (z.B. 08:00 und 12:00 Uhr). 
In diesem Anwendungsfall wird davon ausgegangen, dass das Arzneimittel (für die geplante Dauer) täglich in einem gleichbleibenden Uhrzeitenschema angewandt wird. Es wird zudem ermöglicht:

- eine abweichende Dosis abhängig von der Uhrzeit anzugeben und
- die geplante Dauer der Anwendung zu begrenzen (bsp. in Tagen). 

## Beipiel

{% fragment MedicationRequest/Example-MR-Dosage-tod-1t-8am JSON %}

Folgende weitere Beispiele sind in diesem IG dargestellt:

| Beispiel    | Beipspiel Datei |
| -------- | ------- |
| 1 Tablette um 08:00 Uhr | [Example-MR-Dosage-tod-1t-8am](./MedicationRequest-Example-MR-Dosage-tod-1t-8am.html)    |
| 2 Tablette um 12:00 Uhr | [Example-MR-Dosage-tod-2-12am](./MedicationRequest-Example-MR-Dosage-tod-2-12am.html)     |
| 8 Uhr 2 Tabletten - 11 Uhr 1 Tablette - 14 Uhr 1 Tablette - 17 Uhr 1 Tablette - 20 Uhr 1 Tablette - 23 Uhr 1 Tablette    | [Example-MR-Dosage-tod-multi](./MedicationRequest-Example-MR-Dosage-tod-multi.html)    |
| 8 Uhr 2 Tabletten - 11 Uhr 1 Tablette - 14 Uhr 1 Tablette - 17 Uhr 1 Tablette - 20 Uhr 1 Tablette - 23 Uhr 1 Tablette, für 10 Tage    | [Example-MR-Dosage-tod-multi-bound](./MedicationRequest-Example-MR-Dosage-tod-multi-bound.html)    |

## Angabe und Erkennung der Dosierart

Diese Dosierungsart wird daran erkannt, dass unter `Dosage.timing.repeat`

- ausschließliche Angabe von `timeOfDay`
- opt. Angabe von `bounds[x]`

angegeben ist. An diesem Feld wird dann kodiert die Uhrzeit angegeben an der eine konkrete Dosierung einzunehmen ist.

Folgende FHIR-Path Expression auf Ebene von `Dosage.timing.repeat` liefert die Angabe, ob es sich um das Schema handelt: 

```
timing.repeat.timeOfDay.exists() and
timing.repeat.frequency.empty() and
timing.repeat.period.empty() and
timing.repeat.periodUnit.empty() and
timing.repeat.when.empty() and
timing.repeat.dayOfWeek.empty()
```

Soll das Arzneimittel in derselben Dosierung zu mehreren Uhrzeiten angewandt werden, wird dies über mehrere Angaben von `.timeOfDay` ausgedrückt. Die angegebene Dosierung ist dann zu jeder der genannten Uhrzeiten anzuwenden.

Beispiel:
- Dosage.timing.repeat.timeOfDay` = "08:00:00", "12:00:00"
- Dosage.doseAndRate.doseQuantity = 1 Tablette
bedeutet, dass eine Tablette jeweils um 08:00 und um 12:00 einzunehmen ist.

Lesende Systeme werten entsprechend auch `Dosage.timing.repeat` aus. Wenn nur .timeOfDay angegeben ist, ist dem Nutzer anzuzeigen, dass die Dosierung nach Uhrzeizen definiert ist.
