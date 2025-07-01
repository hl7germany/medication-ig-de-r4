# Freitextdosierung

Es ist Möglich die Dosierung als Freitext anzugeben. Hierbei wird ausschließlich das Feld ".text" befüllt. .timing und .doseAndRate werden nicht gesetzt.

Folgende Beispiele sind in diesem IG dargestellt:

| Beispiel    | Beipspiel Datei |
| -------- | ------- |
| 2 Tabletten morgens zum Frühstück  | [Example-MR-Dosage-Freetext](./MedicationRequest-Example-MR-Dosage-Freetext.html)    |

## Angabe und Erkennung der Dosierart

Diese Dosierungsart wird daran erkannt, dass ausschließlich ´Dosage.text´ angegeben ist. An diesem Feld wird die Dosierung angegeben, wie vom Arzt/ Apotheker eingetragen.

Lesende Systeme werten entsprechend ausschließlich ´Dosage.text´ aus.
