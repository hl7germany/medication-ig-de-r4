Es wird ermöglicht, einen Tageszeiten-Bezug oder einen Uhrzeiten-Bezug mit einem Zeitintervall (Einheit mind. „Tag“) zu kombinieren.

Es wird ermöglicht, die geplante Dauer der Anwendung zu begrenzen.

### Beispiel

{% fragment MedicationRequest/Example-MR-Dosage-comb-interval-1 JSON %}

Für eine Übersicht von weiteren Beispielen inklusive Belegung der Felder siehe [Beispielliste Dosierung](./dosierung-beispiele.html).

### Angabe und Erkennung der Dosierart 

Diese Dosierungsart wird daran erkannt, dass folgende Felder unter `Dosage.timing.repeat` angegeben sind:

- `frequency`
- `period`
- `periodUnit`
- `timeOfDay` ODER `when`
- opt. Angabe von `bounds[x]`

Folgende FHIR-Path Expression auf Ebene von `Dosage.timing.repeat` liefert die Angabe, ob es sich um das Schema handelt:

```
timing.repeat.frequency.exists() and
timing.repeat.period.exists() and
timing.repeat.periodUnit.exists() and
timing.repeat.dayOfWeek.empty() and
  (
    (timing.repeat.timeOfDay.exists() and timing.repeat.when.empty()) or
    (timing.repeat.when.exists() and timing.repeat.timeOfDay.empty())
  )
```

Der Wert von frequency entspricht dabei der Anzahl an Elementen in `when`, bzw. `timeOfDay`.

und entweder `when` oder `timeOfDay`. Damit kann diese Dosierangabe verwendet werden um eine Interval angabe auf Tageszeit oder Uhrzeit zu kombinieren.

Lesende Systeme werten entsprechend auch `Dosage.timing.repeat` aus. 
Wenn die oben genannten Felder angegeben sind, ist dem Nutzer anzuzeigen, dass die Dosierung nach einem Interval mit Tageszeit oder Uhrzeitbezug definiert ist.
