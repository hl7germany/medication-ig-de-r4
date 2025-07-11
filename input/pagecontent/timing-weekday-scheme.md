## Schema für Wochentags-Bezug

Dieses Schema gibt an, an welchen Wochentagen einer Kalenderwoche das Medikament angewandt werden soll.

In diesem Anwendungsfall wird davon ausgegangen, dass das Arzneimittel wöchentlich (für die geplante Dauer) in einem gleichbleibenden Wochentagsschema angewandt wird. Es wird zudem ermöglicht:

- die geplante Dauer der Anwendung zu begrenzen (bspw. in Tagen)
- eine abweichende Dosis abhängig vom Wochentag anzugeben (in einer weiteren Dosage-Instanz).

Es konkretisiert dabei nicht, zu welchem Zeitpunkt das Arzneimittel an dem betreffenden Wochentag anzuwenden ist.

Es wird ermöglicht, die geplante Dauer der Anwendung zu begrenzen.   

### Beipiel

{% fragment MedicationRequest/Example-MR-Dosage-weekday-2t JSON %}

Folgende Beispiele sind in diesem IG dargestellt:

| Beispiel    | Beipspiel Datei |
| -------- | ------- |
| Dienstags und Donnerstags je 2 Tabletten | [Example-MR-Dosage-weekday-2t](./MedicationRequest-Example-MR-Dosage-weekday-2t.html)    |
| Dienstags, Donnerstags und Samstags je 2 Tabletten | [Example-MR-Dosage-weekday-3t](./MedicationRequest-Example-MR-Dosage-weekday-3t.html)    |
| Montags 2 Tabletten, Donnerstags 1 Tablette | [Example-MR-Dosage-weekday-2t-1t](./MedicationRequest-Example-MR-Dosage-weekday-2t-1t.html)     |
| Montags 2 Tabl. für 10 Wochen  | [Example-MR-Dosage-weekday-2t-bound](./MedicationRequest-Example-MR-Dosage-weekday-2t-bound.html)    |

### Angabe und Erkennung der Dosierart

Diese Dosierungsart wird daran erkannt, dass unter `Dosage.timing.repeat`

- ausschließliche Angabe von `dayOfWeek`
- opt. Angabe von `bounds[x]`

angegeben ist. An diesem Feld wird dann kodiert der Wochentag angegeben an der eine konkrete Dosierung einzunehmen ist.

Folgende FHIR-Path Expression auf Ebene von `Dosage.timing.repeat` liefert die Angabe, ob es sich um das Schema handelt: 

```
timing.repeat.dayOfWeek.exists() and
timing.repeat.frequency.empty() and
timing.repeat.period.empty() and
timing.repeat.periodUnit.empty() and
timing.repeat.when.empty() and
timing.repeat.timeOfDay.empty()
```

Soll das Arzneimittel in derselben Dosierung an mehreren Tagen angewandt werden, wird dies über mehrere Angaben von `dayOfWeek` ausgedrückt. Die angegebene Dosierung ist dann zu jedem der genannten Tage anzuwenden.

Beispiel:
- Dosage.timing.repeat.dayOfWeek = "mon", "fri"
- Dosage.doseAndRate.doseQuantity = 1 Tablette
bedeutet, dass eine Tablette jeweils am Montag und Freitag einzunehmen ist.

Lesende Systeme werten entsprechend auch `Dosage.timing.repeat` aus. Wenn nur .dayOfWeek angegeben ist, ist dem Nutzer anzuzeigen, dass die Dosierung nach Wochentagen definiert ist.
