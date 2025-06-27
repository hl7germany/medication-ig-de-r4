# Schema für Wochentags-Bezug

Dieses Schema gibt die Tage, an denen das Medikament angewandt werden soll, im Sinne von Wochentagen über eine Kalenderwoche an. (Es ist damit eine besondere Form des Intervalls mit der Einheit "Woche".)

Im einfachsten Zustand wiederholt sich das Schema jede Woche über einen unbefristeten Zeitraum und trifft bspw. keine Aussage darüber, zu welchen Tages- oder Uhrzeiten das Arzneimittel an den betreffenden Tagen anzuwenden ist.

Alle Anwendungsfälle gehen davon aus, dass das Arzneimittel wöchentlich (für die geplante Dauer) in einem gleichbleibenden Schema angewandt wird.

Es wird ermöglicht, eine abweichende Dosis abhängig vom Wochentag anzugeben.

Es wird ermöglicht, die geplante Dauer der Anwendung zu begrenzen.   
Folgende Beispiele sind in diesem IG dargestellt:

| Beispiel    | Beipspiel Datei |
| -------- | ------- |
| Dienstags und Donnerstags je 2 Tabletten | [Example-MR-Dosage-weekday-2t](./MedicationRequest-Example-MR-Dosage-weekday-2t.html)    |
| Montags 2 Tabletten, Donnerstags 1 Tablette | [Example-MR-Dosage-weekday-2t-1t](./MedicationRequest-Example-MR-Dosage-weekday-2t-1t.html)     |
| Montags 2 Tabl. für 10 Wochen  | [Example-MR-Dosage-weekday-2t-bound](./MedicationRequest-Example-MR-Dosage-weekday-2t-bound.html)    |

## Angabe und Erkennung der Dosierart

Diese Dosierungsart wird daran erkannt, dass ausschließlich ´Dosage.timing.repeat.dayOfWeek´ angegeben ist. An diesem Feld wird dann kodiert der Wochentag angegeben an der eine konkrete Dosierung einzunehmen ist.

Für eine Dosierung kann auch mehrfach eine Angabe für ´.dayOfWeek´ erfolgen und bedeutet, dass wann auch immer einer der Wochentage eintritt, die angegebene Dosierung einzunehmen ist.

Beispiel:
- Dosage.timing.repeat.dayOfWeek = "mon", "fri"
- Dosage.doseAndRate.doseQuantity = 1 Tablette
bedeutet, dass eine Tablette jeweils am Montag und Freitag einzunehmen ist.

Lesende Systeme werten entsprechend auch ´Dosage.timing.repeat´ aus. Wenn nur .dayOfWeek angegeben ist, ist dem Nutzer anzuzeigen, dass die Dosierung nach Wochentagen definiert ist.
