# Schema für Kombinationen des Zeitintervalls

Es wird ermöglicht, einen Tageszeiten-Bezug oder einen Uhrzeiten-Bezug mit einem Zeitintervall (Einheit mind. „Tag“) zu kombinieren.

Es wird ermöglicht, die geplante Dauer der Anwendung zu begrenzen.

## Beipiel

{% fragment MedicationRequest/Example-MR-Dosage-comb-interval-1 JSON %}

Folgende weitere Beispiele sind in diesem IG dargestellt:

| Beispiel    | Beipspiel Datei |
| -------- | ------- |
| Jeden 2. Tag 1 Tablette um 08:00 Uhr und 2 Tabletten um 18:00 Uhr  | [Example-MR-Dosage-comb-interval-1](./MedicationRequest-Example-MR-Dosage-comb-interval-1.html)    |  |
| 1 x pro Woche 1 Tablette morgens  | [Example-MR-Dosage-comb-interval-2](./MedicationRequest-Example-MR-Dosage-comb-interval-2.html)    |

## Angabe und Erkennung der Dosierart 

Diese Dosierungsart wird daran erkannt, dass folgende Felder unter ´Dosage.timing.repeat´ angegeben sind:
- frequency
- period
- periodUnit
- timeOfDay ODER when

Folgende FHIR-Path Expression auf Ebene von ´Dosage.timing.repeat´ liefert die Angabe, ob es sich um das Schema handelt: `(frequency.exists() and period.exists() and periodUnit.exists() and ((timeOfDay.exists() and when.empty()) or (when.exists() and timeOfDay.empty())))`

und entweder ´when´ oder ´timeOfDay´. Damit kann diese Dosierangabe verwendet werden um eine Interval angabe auf Tageszeit oder Uhrzeit zu kombinieren.

Lesende Systeme werten entsprechend auch ´Dosage.timing.repeat´ aus. 
Wenn die oben genannten Felder angegeben sind, ist dem Nutzer anzuzeigen, dass die Dosierung nach einem Interval mit Tageszeit oder Uhrzeitbezug definiert ist.
