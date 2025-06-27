# Schema für Tageszeiten Bezug

Dieses Schema unterteilt den Tag in die Tageszeiten "Morgen", "Mittag", "Abend" und "Nacht".

Es gibt an, zu welchen dieser vier Tageszeiten das Medikament angewandt werden soll. Das Tageszeitenschema wird auch "Viererschema" oder "MMAN-Schema" genannt und häufig als Kette von vier Zahlen abgebildet (z.B. 1-0-1-0).

Es trifft damit eine Aussage über einen Tag. Es muss deshalb ergänzt werden um die Information, für welche Tage es gültig ist.

In der einfachsten Konstellation wiederholt sich das Schema jeden Tag über einen unbefristeten Zeitraum. Dieser Zustand ist das einzige Dosierschema, das vollständig strukturiert im bundeseinheitlichen Medikationsplan abgebildet werden kann.

Folgende Beispiele sind in diesem IG dargestellt:

| Beispiel    | Beipspiel Datei |
| -------- | ------- |
| 1-0-1/2-0  | [Example-MR-Dosage-10120](./MedicationRequest-Example-MR-Dosage-10120.html)    |
| 1-0-2-0 | [Example-MR-Dosage-1020]()./MedicationRequest-Example-MR-Dosage-1020.html     |
| 1-0-0-0    | [Example-MR-Dosage-1000](./MedicationRequest-Example-MR-Dosage-1000.html)    |
| 1-0-1-0    | [Example-MR-Dosage-1010](./MedicationRequest-Example-MR-Dosage-1010.html)    |
| 1-0-1-0 für 10 Tage   | [Example-MR-Dosage-1010-10-Days](./MedicationRequest-Example-MR-Dosage-1010-10-Days.html)    |

## Angabe und Erkennung der Dosierart

Diese Dosierungsart wird daran erkannt, dass ausschließlich ´Dosage.timing.repeat.when´ angegeben ist. An diesem Feld wird dann kodiert die Tageszeit angegeben an der eine konkrete Dosierung einzunehmen ist.

Für eine Dosierung kann auch mehrfach eine Angabe für .when erfolgen und bedeutet, dass wann auch immer einer der Tageszeiten eintritt, die angegebene Dosierung einzunehmen ist.

Beispiel:
- Dosage.timing.repeat.when = #MORN, #EVE
- Dosage.doseAndRate.doseQuantity = 1 Tablette
bedeutet, dass eine Tablette morgens und abends einzunehmen ist.

Lesende Systeme werten entsprechend auch ´Dosage.timing.repeat´ aus. Wenn nur .when angegeben ist, ist dem Nutzer das 4-er Schema anzuzeigen.
