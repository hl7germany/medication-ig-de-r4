Diese Seite beschreibt strukturierte Angaben von Start- und Enddatum innerhalb einer einzelnen Dosierung. Die Angabe von Start- und/oder Enddatum ermöglicht es, Dosierschemata eindeutig im zeitlichen Verlauf zu verorten, z. B. bei akuten Behandlungen. Die explizite Angabe von Start- und Endzeitpunkten erhöht somit die Eindeutigkeit von Dosierangaben und unterstützt eine korrekte Umsetzung in der Praxis.

Die Seite beschreibt die hierfür geltenden technischen Anforderungen im dgMP-Kontext. Die folgenden fachlichen Definitionen gelten für die Modellierung:

| Information | Beschreibung | FHIR-Modellierung | Datentyp |
| -------- | ------- | ------- | ------- |
| Startdatum | Das Startdatum legt fest, ab wann das Dosierschema anzuwenden ist.| `Timing.repeat.boundsPeriod.start` | [dateTime](https://hl7.org/fhir/R4/datatypes.html#dateTime) |
| Enddatum | Das Enddatum legt fest, bis wann das Dosierschema anzuwenden ist.| `Timing.repeat.boundsPeriod.end` | [dateTime](https://hl7.org/fhir/R4/datatypes.html#dateTime) |

Die Angabe von Start- und Enddatum definiert den zeitlichen Gültigkeitsbereich einer Dosieranweisung. Sie kann nicht mit der Dauer einer Anwendung (`.boundsDuration`) kombiniert werden.

Folgende weitere Beispiele sind in diesem IG dargestellt:

| Beispiel | Beispiel Datei |
| -------- | ------- |
| Dosierung mit Startdatum | [Example-MR-Dosage-1000-startdate](MedicationRequest-Example-MR-Dosage-1000-startdate.html) |
| Dosierung mit Enddatum | [Example-MR-Dosage-1000-enddate](MedicationRequest-Example-MR-Dosage-1000-enddate.html) |
| Dosierung mit Start und Enddatum | [Example-MR-Dosage-1000-startandenddate](MedicationRequest-Example-MR-Dosage-1000-startandenddate.html) |

*Hinweis:* Für eine gute UI eignet es sich das Start-Datum in Kombination mit dem Uhrzeiten- oder Tageszeitenschema entsprechend der Eingabe des Nutzers vorzuschlagen.

### Beispiel

{% fragment MedicationRequest/Example-MR-Dosage-1000-startandenddate JSON %}

#### Technische Anforderungen

**Angabe von Dauer und der Kombination aus Start- und Enddatum ist nicht zulässig** sowie **Angabe von Dauer und Enddatum ist nicht zulässig**

Diese Anforderungen werden durch den FHIR-Standard erfüllt. Das Element `bounds[x]`, was die zeitliche Grenze von einer Dosieranweisung beschreibt ist ein Choice-Datatype, der nur einen Datentypen gleichzeitig zulässt. Damit ist es nicht möglich gleichzeitig die Dauer und konkrete Start und Enddaten einer Medikation auszudrücken.

Eine intendierte Kombination aus Startdatum und Dauer, bspw. "Ab 13.05.2026 für 2 Wochen" muss im Primärsystem berechnet werden und dann mit Start- und Enddatum im Datensatz versehen werden.
