## Überführung von Dosierung zu Text

*Hinweis:*  
Ein Großteil der Logik basiert auf den Empfehlungen aus Dose to Text Translation ([UK Core Implementation Guide for Medicines](https://simplifier.net/guide/ukcoreimplementationguideformedicines/ReferenceArchitectures2?version=current)).

Für eine menschenlesbare Darstellung der Dosierung ist das Feld .text derart zu befüllen, dass die strukturierten Dosierinformationen textuell dargestellt werden.  
Diese Seite beschreibt den Algorithmus, wie die strukturierten Dosierinformationen in einen String überführt werden können.

### Grundlegende Festlegungen

Der generierte Text, der sich aus einer Dosierung ableitet muss im digital gestützten Medikationsprozess (dgMP) immer exakt der strukturierten Darstellung entsprechen. Diese Seite beschreibt die Spezifikation dieses Algorithmus, der in einer [Python Referenzimplementierung](./dosage-to-text.py) umgesetzt wurde.
Für Informationen wie im dgMP sichergestellt wird, dass der Text an einer Dosierung korrekt ist siehe [Infrastruktur zur Bereitstellung des Textes der Dosierung](./dosage-to-text-system.html).

### Algorithmus zur Textgenerierung

Das Skript unterstützt aktuell nur eine Teilmenge der möglichen Felder für Dosierungsangaben.  
Nicht unterstützte Felder führen dazu, dass die Konfiguration als „nicht unterstützt“ zurückgewiesen wird. Die nicht unterstützten Felder werden explizit benannt.

Die unterstützten Felder in Dosage sind:
  - doseAndRate.doseQuantity
  - timing.repeat.boundsDuration
  - timing.repeat.frequency
  - timing.repeat.period
  - timing.repeat.periodUnit
  - timing.repeat.dayOfWeek
  - timing.repeat.timeOfDay
  - timing.repeat.when

Für alle anderen Felder (z. B. doseAndRate.doseRange, doseAndRate.rateQuantity, timing.event, timing.repeat.count, asNeededBoolean, route, site usw.) gibt das Skript zurück:
Die Dosiskonfiguration mit den Feldern <Liste> wird derzeit nicht unterstützt. Die Fachdienste in der TI werden diese Instanzen entsprechend auch zurückweisen.

Die Umwandlung der strukturierten Felder erfolgt nur, wenn ausschließlich unterstützte Felder verwendet werden.

#### Versionierung des Algorithmus

Die Aktuelle Version des Algortimus mit unterstützten Felder ist in der [Python Referenzimplementierung](./dosage-to-text.py) unter `__version__` angegeben und reflektiert die Version des IG's.

### Komponenten und Trennzeichen

Die Reihenfolge der Komponenten entspricht der folgenden Logik:

  1. Gesamtdauer der Anwendung (timing.repeat.boundsDuration)
  2. Interval (frequency, period, periodUnit)
  3. Wochentag (dayOfWeek)
  4. Uhrzeit ODER Tageszeit (timeOfDay ODER when)
  5. Angaben zur Einzeldosis (doseAndRate)

Das Format des Strings entspricht folgender Struktur:
```
<Gesamtdauer der Anwendung> <Interval>: <Wochentag> — <Uhrzeit ODER Tageszeit> - <Angaben zur Einzeldosis>
```

### Validierung und Fehlerbehandlung

Wenn in der Dosierungskonfiguration Felder verwendet werden, die aktuell nicht unterstützt sind, wird eine entsprechende Fehlermeldung generiert, z. B.:
Die Dosiskonfiguration mit den Feldern timing.event, doseAndRate[0].doseRange wird derzeit nicht unterstützt.

Die Prüfung erfolgt sowohl für Felder auf oberster Ebene der Dosierung, als auch für Unterfelder (z. B. innerhalb von doseAndRate oder timing).

### Erweiterbarkeit

Die Skriptstruktur ist so angelegt, dass künftig weitere Felder durch einfaches Entfernen von Kommentaren und Anpassen der Validierungslogik unterstützt werden können.
Die Liste der unterstützten Felder sollte mit jeder Version gepflegt und dokumentiert werden.

### Beispiel für unterstützte Felder

Für eine Auflistung von Unterstüzten und nicht-unterstützten Dosierkonfigurationen siehe [Beispiele für Dosierungen](./dosage-to-text-examples.html).

### Weiterführende Hinweise

Die vollständige Liste der unterstützten und nicht unterstützten Felder ist im Quelltext dokumentiert und sollte bei Erweiterungen aktualisiert werden.

Die Logik zur eigentlichen Textgenerierung (z. B. Pluralbildung, Formatierung der Zeitangaben) orientiert sich an folgenden Empfehlungen:
- [Medications Management – Medications List, User Interface Design Guidance, NHS CUI Programme Team, June 2015](https://webarchive.nationalarchives.gov.uk/ukgwa/20160921150545/http://systems.digital.nhs.uk/data/cui/uig)
- [National Guidelines for On-Screen Display of Medicines Information, Australian Commission on Safety and Quality in Health Care, December 2017](https://www.safetyandquality.gov.au/sites/default/files/migrated/National-guidelines-for-on-screen-display-of-medicines-information.pdf)


und wird kontinuierlich weiterentwickelt.

Hinweis:  
Diese Seite beschreibt den aktuellen Stand der unterstützten Felder und die daraus resultierende Textgenerierung.  
Für die vollständige Abdeckung aller FHIR-Dosierungsfelder ist eine schrittweise Erweiterung des Skripts vorgesehen.

### Übersetzungslogik

Im folgenden wird für jedes Element ein Beispiel angegeben, wie die Überführung von strukturierter Angabe zu textueller Repräsentation aussieht.

#### Dosage

| Element                       | Darstellung (Deutsch)         | Beispiel(e)           |
|-------------------------------|-------------------------------|-----------------------|
| **doseAndRate.doseQuantity**  | `{value} {unit}`              | `50 Milligramm`<br>`2 Tabletten` |

#### Timing

| Element                | Darstellung (Deutsch)                    | Beispiel(e)                    |
|------------------------|------------------------------------------|--------------------------------|
| **repeat.boundsDuration** | `für {value} {unit}`                 | `für 7 Tage`                   |
| **repeat.frequency**      | `{frequency} mal`<br>oder, wenn `period`/`periodUnit` gesetzt:<br>`{frequency} mal pro {period} {periodUnit}` | `3 mal täglich`<br>`2 mal pro Woche` |
| **repeat.period**         | (falls `frequency` gesetzt)<br>`{frequency} mal alle {period} {periodUnit}` | `3 mal alle 8 Stunden`         |
| **repeat.periodUnit**     | Zeit-Einheiten:<br>- `s` = Sekunden<br>- `min` = Minuten<br>- `h` = Stunden<br>- `d` = Tage<br>- `wk` = Wochen<br>- `mo` = Monate<br>- `a` = Jahre |                                |
| **repeat.dayOfWeek**      | `am {dayOfWeek}`<br>Bei mehreren Tagen:<br>`am Montag, Mittwoch und Freitag`<br>(vollständige deutsche Wochentagsnamen verwenden) | `am Dienstag`<br>`am Montag, Mittwoch und Freitag` |
| **repeat.timeOfDay**      | `um {timeOfDay}`<br>Bei mehreren Zeiten:<br>`um 10:00 und 15:00` | `um 8:00`<br>`um 10:00 und 15:00` |
| **repeat.when**           | `{when}`<br>(z. B. `morgens`, `mittags`, `abends`, `nachts`)<br>Bei mehreren:<br>`morgens und abends` | `morgens`<br>`morgens und abends` |
