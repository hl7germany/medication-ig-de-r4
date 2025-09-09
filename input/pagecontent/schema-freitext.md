Es ist Möglich die Dosierung als Freitext anzugeben. Hierbei wird ausschließlich das Feld ".text" befüllt. .timing und .doseAndRate werden nicht gesetzt.

### Beispiel

{% fragment MedicationRequest/Example-MR-Dosage-Freetext JSON %}

Folgende weitere Beispiele sind in diesem IG dargestellt:

| Beispiel    | Beipspiel Datei |
| -------- | ------- |
| 2 Stück morgens zum Frühstück  | [Example-MR-Dosage-Freetext](./MedicationRequest-Example-MR-Dosage-Freetext.html)    |

### Angabe und Erkennung der Dosierart

Diese Dosierungsart wird daran erkannt, dass ausschließlich `Dosage.text` angegeben ist. An diesem Feld wird die Dosierung angegeben, wie vom Arzt/ Apotheker eingetragen.

Folgende FHIR-Path Expression auf Ebene von `Dosage` liefert die Angabe, ob es sich um das Schema handelt: `(text.exists() and timing.empty() and doseAndRate.empty())`

Lesende Systeme werten entsprechend ausschließlich `Dosage.text` aus.
