Diese Seite beschreibt die strukturierte Angabe einer Anwendungsdauer innerhalb einer einzelnen Dosierung. Die Angabe einer Dauer ermöglicht es, Dosierschemata zeitlich zu begrenzen, ohne einen konkreten Start- oder Endzeitpunkt festzulegen. Sie eignet sich beispielsweise für Dosierungen wie „alle 2 Tage für 6 Wochen“.

Die Seite beschreibt die hierfür geltenden technischen Anforderungen im dgMP-Kontext. Die folgenden fachlichen Definitionen gelten für die Modellierung:

| Information | Beschreibung | FHIR-Modellierung | Datentyp |
| -------- | ------- | ------- | ------- |
| Anwendungsdauer | Die Anwendungsdauer legt fest, wie lange das Dosierschema ab seinem Beginn angewendet werden soll. | `Timing.repeat.boundsDuration` | [Duration](https://hl7.org/fhir/R4/datatypes.html#Duration) |

Die Dauer wird als Wert mit einer UCUM-Einheit angegeben. Im dgMP sind die Einheiten Tage (`d`), Wochen (`wk`), Monate (`mo`) und Jahre (`a`) zulässig. Der numerische Wert der Dauer muss eine ganze Zahl sein.

`boundsDuration` beschreibt die Gesamtdauer der Anwendung. Sie ist von `Timing.repeat.period` zu unterscheiden: `period` beschreibt den Abstand zwischen den einzelnen Einnahmen, während `boundsDuration` die zeitliche Begrenzung des gesamten Dosierschemas angibt.

### Beispiel

{% fragment MedicationRequest/Example-MR-Dosage-interval-2d-bound JSON %}

#### Technische Anforderungen

**Die Angabe von `boundsDuration` und `boundsPeriod` ist nicht zulässig.**

Diese Anforderung wird durch den FHIR-Standard erfüllt. Das Element `bounds[x]`, das die zeitliche Grenze einer Dosieranweisung beschreibt, ist ein Choice-Datentyp, der nur einen Datentyp gleichzeitig zulässt. Damit kann eine Dosierung entweder mit einer Dauer oder mit einem konkreten Start- und/oder Enddatum begrenzt werden.

Für `boundsDuration` gelten im dgMP außerdem folgende Anforderungen:

- Die Einheit wird als UCUM-Code in `Duration.code` angegeben und muss zur Klartextangabe in `Duration.unit` passen.
- `Duration.system` muss auf `http://unitsofmeasure.org` gesetzt sein.
- `Duration.value` muss eine positive ganze Zahl sein.

Eine intendierte Kombination aus Startdatum und Dauer, beispielsweise „Ab 13.05.2026 für 2 Wochen“, muss im Primärsystem berechnet werden und dann mit Start- und Enddatum im Datensatz versehen werden.
