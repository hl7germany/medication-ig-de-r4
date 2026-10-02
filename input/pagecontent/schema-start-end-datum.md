Diese Seite beschreibt strukturierte Angaben von Start- und Enddatum innerhalb einer einzelnen Dosierung. Die Angabe von Start- und/oder Enddatum ermöglicht es, Dosierschemata eindeutig im zeitlichen Verlauf zu verorten, z. B. bei akuten Behandlungen. Die explizite Angabe von Start- und Endzeitpunkten erhöht somit die Eindeutigkeit von Dosierangaben und unterstützt eine korrekte Umsetzung in der Praxis.

Die Seite beschreibt die hierfür geltenden technischen Anforderungen im dgMP-Kontext. Die folgenden fachlichen Definitionen gelten für die Modellierung:

| Information | Beschreibung | FHIR-Modellierung | Datentyp |
| -------- | ------- | ------- | ------- |
| Startdatum | Das Startdatum beziehungsweise der Startzeitpunkt legt fest, ab wann das Dosierschema anzuwenden ist. Ein Startzeitpunkt mit Uhrzeit bezeichnet die erste Gabe.| `Timing.repeat.boundsPeriod.start` | [dateTime](https://hl7.org/fhir/R4/datatypes.html#dateTime) |
| Enddatum | Das Enddatum beziehungsweise der Endzeitpunkt legt fest, bis wann das Dosierschema anzuwenden ist. Ein Endzeitpunkt mit Uhrzeit bezeichnet die letzte Gabe.| `Timing.repeat.boundsPeriod.end` | [dateTime](https://hl7.org/fhir/R4/datatypes.html#dateTime) |

Die Angabe von Start- und Enddatum definiert den zeitlichen Gültigkeitsbereich einer Dosieranweisung. Sie kann nicht mit der Dauer einer Anwendung (`.boundsDuration`) kombiniert werden.

Start und Ende können als vollständiges Kalenderdatum oder als Datum mit Uhrzeit angegeben werden. Enthält ein FHIR-`dateTime` eine Uhrzeit, ist eine Zeitzone verpflichtend. Für die Textdarstellung wird der Zeitpunkt in die IANA-Zeitzone `Europe/Berlin` umgerechnet.

Folgende weitere Beispiele sind in diesem IG dargestellt:

| Beispiel | Beispiel Datei |
| -------- | ------- |
| Dosierung mit Startdatum | [Example-MR-Dosage-1000-startdate](MedicationRequest-Example-MR-Dosage-1000-startdate.html) |
| Dosierung mit Enddatum | [Example-MR-Dosage-1000-enddate](MedicationRequest-Example-MR-Dosage-1000-enddate.html) |
| Dosierung mit Start und Enddatum | [Example-MR-Dosage-1000-startandenddate](MedicationRequest-Example-MR-Dosage-1000-startandenddate.html) |
| Dosierung mit Startzeitpunkt und Zeitzone | [Example-MR-Dosage-1000-startdatetime](MedicationRequest-Example-MR-Dosage-1000-startdatetime.html) |

*Hinweis:* Für eine gute UI eignet es sich das Start-Datum in Kombination mit dem Uhrzeiten- oder Tageszeitenschema entsprechend der Eingabe des Nutzers vorzuschlagen.

**Uhrzeit von Start und Ende im Uhrzeiten- und Tageszeitenschema**

- Im Uhrzeitenschema (`timeOfDay`) muss eine Uhrzeit in `boundsPeriod.start` oder `boundsPeriod.end` einer der angegebenen Uhrzeiten entsprechen ([TimingBoundsPeriodMatchesTime](./dosierung-constraints.html#timingboundsperiodmatchestime)). Die Uhrzeit wird so verglichen, wie sie angegeben ist; sie ist daher in Ortszeit mit dem passenden Zeitzonenversatz anzugeben, z. B. `2026-06-05T08:00:00+02:00` zu `timeOfDay = 08:00:00`.
- Im Tageszeitenschema (`when`) dürfen `boundsPeriod.start` und `boundsPeriod.end` nur ein Datum ohne Uhrzeit enthalten ([TimingBoundsPeriodNotForWhen](./dosierung-constraints.html#timingboundsperiodnotforwhen)). Tagesabschnitte wie „morgens“ haben keine feste Uhrzeit, mit der ein Startzeitpunkt abgeglichen werden könnte.

### Beispiel

{% fragment MedicationRequest/Example-MR-Dosage-1000-startandenddate JSON %}

#### Technische Anforderungen

**Angabe von Dauer und der Kombination aus Start- und Enddatum ist nicht zulässig** sowie **Angabe von Dauer und Enddatum ist nicht zulässig**

Diese Anforderungen werden durch den FHIR-Standard erfüllt. Das Element `bounds[x]`, was die zeitliche Grenze von einer Dosieranweisung beschreibt ist ein Choice-Datatype, der nur einen Datentypen gleichzeitig zulässt. Damit ist es nicht möglich gleichzeitig die Dauer und konkrete Start und Enddaten einer Medikation auszudrücken.

Eine intendierte Kombination aus Startdatum und Dauer, bspw. "Ab 13.05.2026 für 2 Wochen" muss im Primärsystem berechnet werden und dann mit Start- und Enddatum im Datensatz versehen werden.
