## Schema für Wiederkehrendes Zeitinterval

Dieses Schema basiert auf definierten Zeitintervallen, anhand derer sich die Anwendung des Arzneimittels wiederholt. Das Intervall kann in verschiedenen Zeiteinheiten angegeben werden, also z.B. in Tagen, Wochen oder Monaten. Für jedes Intervall wird angegeben, in welcher Frequenz die Anwendung innerhalb des Intervalls erfolgen soll. Es trifft  keine Aussage darüber, zu welchem spezifischen Zeitpunkt das Arzneimittel anzuwenden ist (bspw. als Uhrzeit, Tageszeit oder Wochentag). 

In diesem Anwendungsfall wird davon ausgegangen, dass sich das Schema ohne Variation der Länge eines Intervalls oder der Frequenz der Anwendung wiederholt. Es wird zudem ermöglicht:

- die geplante Dauer der Anwendung zu begrenzen (bsp. in Tagen). 

### Beipiel

{% fragment MedicationRequest/Example-MR-Dosage-interval-8d JSON %}

Folgende weitere Beispiele sind in diesem IG dargestellt:

| Beispiel    | Beipspiel Datei |
| -------- | ------- |
| 1 Tablette alle 8 Tage  | [Example-MR-Dosage-interval-8d](./MedicationRequest-Example-MR-Dosage-interval-8d.html)    |  |
| 1 Tablette alle 2 Wochen  | [Example-MR-Dosage-interval-2wk](./MedicationRequest-Example-MR-Dosage-interval-2wk.html)    |
| 4 x 1 Tablette pro Tag  | [Example-MR-Dosage-interval-4times-d](./MedicationRequest-Example-MR-Dosage-interval-4times-d.html)    |
| Alle 3 Tage 1 Tablette  | [Example-MR-Dosage-interval-3d](./MedicationRequest-Example-MR-Dosage-interval-3d.html)    |
| Alle 2 Tage 2 Tabletten für 6 Wochen  | [Example-MR-Dosage-interval-2d-bound](./MedicationRequest-Example-MR-Dosage-interval-2d-bound.html)    |

### Angabe und Erkennung der Dosierart

Diese Dosierungsart wird daran erkannt, dass folgende Felder unter `Dosage.timing.repeat` angegeben sind:

- `frequency`
- `period`
- `periodUnit`
- opt. Angabe von `bounds[x]`

Folgende FHIR-Path Expression auf Ebene von `Dosage.timing.repeat` liefert die Angabe, ob es sich um das Schema handelt: 

```
timing.repeat.frequency.exists() and
timing.repeat.period.exists() and
timing.repeat.periodUnit.exists() and
timing.repeat.when.empty() and
timing.repeat.timeOfDay.empty() and
timing.repeat.dayOfWeek.empty()
```

An diesen Feldern wird kodiert der Zeitinterval angegeben an der eine konkrete Dosierung einzunehmen ist.

Lesende Systeme werten entsprechend auch `Dosage.timing.repeat` aus. Wenn ausschließlich die oben genannten Felder angegeben sind, ist dem Nutzer anzuzeigen, dass die Dosierung nach einem Interval definiert ist.
