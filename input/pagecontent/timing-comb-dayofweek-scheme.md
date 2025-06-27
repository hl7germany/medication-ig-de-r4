# Schema für Kombinationen des Wochentags

Es wird ermöglicht, einen Tageszeiten-Bezug oder einen Uhrzeiten-Bezug mit einem Wochentags-Bezug zu kombinieren.

Es wird ermöglicht, eine abweichende Dosis abhängig von der Tageszeit anzugeben.

Es wird ermöglicht, die geplante Dauer der Anwendung zu begrenzen (im Sinne der Eindeutigkeit nur mit der Einheit „Woche“).

Folgende Beispiele sind in diesem IG dargestellt:

| Beispiel    | Beipspiel Datei |
| -------- | ------- |
| Montags und Freitags 1-0-1-0  | [Example-MR-Dosage-comb-dayofweek-1](./MedicationRequest-Example-MR-Dosage-comb-dayofweek-1.html)    |  |
| Montags und Freitags 1-0-2-0  | [Example-MR-Dosage-comb-dayofweek-2](./MedicationRequest-Example-MR-Dosage-comb-dayofweek-2.html)    |
| Montags und Freitags 1 Tablette um 08:00 Uhr und 2 Tabletten um 10:00 Uhr – für 3 Wochen  | [Example-MR-Dosage-comb-dayofweek-3](./MedicationRequest-Example-MR-Dosage-comb-dayofweek-3.html)    |

## Angabe und Erkennung der Dosierart 

Diese Dosierungsart wird daran erkannt, dass folgende Felder unter ´Dosage.timing.repeat´ angegeben sind:
- frequency
- period
- periodUnit

und entweder ´when´ oder ´timeOfDay´. Damit kann diese Dosierangabe verwendet werden um eine Interval angabe auf Tageszeit oder Uhrzeit zu kombinieren.

Lesende Systeme werten entsprechend auch ´Dosage.timing.repeat´ aus. 
Wenn die oben genannten Felder angegeben sind, ist dem Nutzer anzuzeigen, dass die Dosierung nach einem Interval mit Tageszeit oder Uhrzeitbezug definiert ist.
