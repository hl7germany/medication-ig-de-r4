## Schema für Tageszeiten Bezug

Dieses Schema unterteilt den Tag in die Tageszeiten "Morgen", "Mittag", "Abend" und "Nacht".
Es gibt an, zu welchen dieser vier Tageszeiten das Medikament angewandt werden soll. Das Tageszeitenschema wird auch "Viererschema" oder "MMAN-Schema" genannt und häufig als Kette von vier Zahlen abgebildet (z.B. 1-0-1-0). 
In diesem Anwendungsfall wird davon ausgegangen, dass das Arzneimittel (für die geplante Dauer) täglich in einem gleichbleibenden Tageszeitenschema angewandt wird. Es wird zudem ermöglicht:

- eine abweichende Dosis abhängig von der Tageszeit anzugeben
- die geplante Dauer der Anwendung zu begrenzen (bsp. in Tagen). 

### Beipiel

{% fragment MedicationRequest/Example-MR-Dosage-1010 JSON %}

Folgende weitere Beispiele sind in diesem IG dargestellt:

| Beispiel    | Beipspiel Datei |
| -------- | ------- |
| 1-0-1/2-0  | [Example-MR-Dosage-10120](./MedicationRequest-Example-MR-Dosage-10120.html)    |
| 1-0-2-0 | [Example-MR-Dosage-1020](./MedicationRequest-Example-MR-Dosage-1020.html)     |
| 1-0-0-0    | [Example-MR-Dosage-1000](./MedicationRequest-Example-MR-Dosage-1000.html)    |
| 1-0-1-0    | [Example-MR-Dosage-1010](./MedicationRequest-Example-MR-Dosage-1010.html)    |
| 1-1-1-1    | [Example-MR-Dosage-1111](./MedicationRequest-Example-MR-Dosage-1111.html)    |
| 1-0-1-0 für 10 Tage   | [Example-MR-Dosage-1010-10-Days](./MedicationRequest-Example-MR-Dosage-1010-10-Days.html)    |

### Angabe und Erkennung der Dosierart

Diese Dosierungsart wird daran erkannt, dass unter `Dosage.timing.repeat`

- ausschließliche Angabe von `when`
- opt. Angabe von `bounds[x]`
  
angegeben ist. An diesem Feld wird dann kodiert die Tageszeit angegeben an der eine konkrete Dosierung einzunehmen ist.

Folgende FHIR-Path Expression auf Ebene von `Dosage.timing.repeat` liefert die Angabe, ob es sich um das Schema handelt:

```
timing.repeat.when.exists() and
timing.repeat.frequency.empty() and
timing.repeat.period.empty() and
timing.repeat.periodUnit.empty() and
timing.repeat.timeOfDay.empty() and
timing.repeat.dayOfWeek.empty()
```

Soll das Arzneimittel in derselben Dosierung zu mehreren Tageszeiten angewandt werden, wird dies über mehrere Angaben von "when" ausgedrückt. Die angegebene Dosierung ist dann zu jeder der genannten Tageszeiten anzuwenden. 

Beispiel:
- Dosage.timing.repeat.when = #MORN, #EVE
- Dosage.doseAndRate.doseQuantity = 1 Tablette
bedeutet, dass eine Tablette morgens und abends einzunehmen ist.

Lesende Systeme werten entsprechend auch `Dosage.timing.repeat` aus. Wenn nur .when angegeben ist, ist dem Nutzer das 4-er Schema anzuzeigen.
