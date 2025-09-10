Diese Seite beschreibt fachliche Aspekte und Entscheidungen zur Handhabung von strukturierten Dosierungen im dgMP-Kontext.

### Vorgaben

#### Nutzung des Feldes `.text`

Die textuelle Angabe von Dosierungen wird in diesem Projekt in zwei Varianten unterschieden:
- Vom Menschen beschriebene Dosierung (Freitext)
- Automatisch aus der strukturierten Angabe generierte textuelle Repräsentation

Softwaresysteme müssen Dosierungsangaben stets strukturiert erfassen, sofern eine strukturierte Abbildung möglich ist. Eine Erfassung als Freitext in Dosage.text ist in diesem Fall nicht zulässig. Das System soll den Nutzenden durch geeignete Eingabemasken bei der strukturierten Erfassung unterstützen.

Das Feld `Dosage.text` ist **ausschließlich** für vom Menschen erstelleten Freitext vorgesehen. Es darf nicht gleichzeitig mit einer strukturierten Angabe verwendet werden, um widersprüchliche Informationen zu vermeiden.

Im Kontext des dgMP sorgt die [Infrastruktur zur Bereitstellung des Dosierungstextes](./dosierung-text-hinzufuegen.html) dafür, dass zu jeder strukturierten Dosierung auch eine einheitliche, maschinell generierte textuelle Repräsentation bereitgestellt wird. Dieser Text wird in der Extension `Dosage.extension[GeneratedDosageInstructionsMeta]` hinterlegt.

#### Nutzung von Sequenzen

In der aktuellen Ausbaustufe und im Kontext dgMP ist die Verwendung von `Dosage.sequence` nicht erlaubt. Dieses Feld dient beispielsweise dazu, aufeinander aufbauende Dosierungen (wie Ein- oder Ausschleichen) zu kennzeichnen. Die Nutzung kann in zukünftigen Ausbaustufen geprüft werden.

#### Strukturierte Angabe der Einheit

Für die Berechnung der Reichweite einer Medikation ist es erforderlich, dass Dosierungseinheiten (z.B. „1 Stück) strukturiert über ein Codesystem angegeben werden.  
Dafür wird das ValueSet `KBV_VS_SFHIR_BMP_DOSIEREINHEIT` genutzt.

#### Beispiele

Zur Unterstützung der Implementierenden werden in diesem Projekt verschiedene Beispiele bereitgestellt. Die [Übersicht der Beispiele](./dosierung-beispiele.html) zeigt alle validen Beispiele in einer Matrix mit generierter Dosisinstruktion und einer Übersicht der belegten Felder.  
Darüber hinaus finden sich auf der Seite [Beispiele für Dosierungen](./dosierung-beispiele.html) vollständige Listen von Positiv- und Negativbeispielen, inklusive solcher, die in der aktuellen Ausbaustufe noch nicht unterstützt werden.

### Technische Validierung der Dosierungen

Um sicherzustellen, dass Dosierungen syntaktisch korrekt und den Vorgaben der jeweiligen Ausbaustufe entsprechend erstellt werden, sind folgende technische Prüfungen implementiert:

#### Freitext oder strukturierte Dosierung

Der Constraint `DosageStructuredOrFreeText` im Profil [DosageDgMP](./StructureDefinition-DosageDgMP.html) stellt sicher, dass entweder das Element `.text` oder eine strukturierte Angabe der Dosierung befüllt wird – nicht jedoch beides gleichzeitig. So wird ausgeschlossen, dass widersprüchliche Angaben gemacht werden.

#### Nur ein Dosierungsschema pro Instanz

Die Constraints im Profil [TimingDgMP](./StructureDefinition-TimingDgMP.html) stellen sicher, dass eine Dosierung ausschließlich einem zulässigen Dosierungsschema der aktuellen Ausbaustufe entspricht. Außerdem wird sichergestellt, dass alle Dosierungen innerhalb einer übergeordneten Ressource (z.B. alle Einträge in `MedicationRequest.dosageInstruction`) demselben Dosierungsschema folgen.

Es ist somit bspw. nicht möglich, in einer `MedicationRequest`-Ressource, im dgMP Kontext, gleichzeitig Dosierungen mit Uhrzeiten- und Tageszeiten-Schema zu kombinieren.

### Ausbaustufen

Der digital gestützte Medikationsprozess unterstützt aktuell die folgenden Dosierschemata, gegliedert nach Ausbaustufen. Die jeweiligen Seiten enthalten eine fachliche Beschreibung, Beispiele und technische Hinweise zur Instanziierung.

#### Ausbaustufe 1

- [Freitext-Dosierung](./schema-freitext.html)
- [Schema mit Tageszeiten-Bezug](./schema-tageszeit.html)
- [Schema mit Uhrzeiten-Bezug](./schema-uhrzeit.html)
- [Schema mit Wochentags-Bezug](./schema-wochentag.html)
- [Schema für wiederkehrende Intervalle](./schema-intervall.html)
- [Schema für Kombinationen von Zeitintervallen](./schema-intervall-kombination.html)
- [Schema für Kombinationen von Wochentagen](./schema-wochentag-kombination.html)

#### Folgende Ausbaustufe

In weiteren Ausbaustufen sollen weitere Schemata entwickelt, die bestehenden Schemata ergänzt und Regeln für die übergeordnete Beziehung zwischen mehreren Schemata aufgebaut werden. Untenstehend findet sich eine Übersicht über Erweiterungen, die in zukünftigen Ausbaustufen berücksichtigt werden sollen, mitsamt Erläuterungen und/oder Beispielen. Diese Liste kann in der Zukunft erweitert oder angepasst werden. Für eine zweite Ausbaustufe wird empfohlen, die folgenden zwei bzw. drei Punkte anzugehen:

- Schema für Bedarfsmedikation
- Alternativen zur eindeutigen “Gesamtdauer”, um die gesamte Anwendung eines Arzneimittels zeitlich zu begrenzen
- Einführung eines Start- und Enddatums
- Evaluation hinsichtlich der zeitnahen Umsetzbarkeit von Wertelisten
  - für die Körperstelle, an der das Arzneimittel angewandt werden soll
  - für die Technik, mit der das Arzneimittel angewandt werden soll
  - für den Weg, über den das Arzneimittel in den Körper gelangen soll

Sobald diesbezüglich eine Entscheidung getroffen wurde, wird die Planung zur zweiten Ausbaustufe hier kommuniziert.

##### Weitere Schemata und Erläuterungen

| Weitere Schemata                                   | Erläuterungen                                                                                                                                                                                                                                                                                                                                 |
|----------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Bedarfsmedikation                                 | Bedarfsmedikation bezeichnet ein Arzneimittel, das nicht nach einem festen Einnahmeplan, sondern nur bei tatsächlich auftretendem Bedarf verabreicht wird. Die Verordnung einer Bedarfsmedikation erfordert i.d.R. die Angabe des Einnahmeanlasses, des Abstands zwischen zwei Anwendungen sowie von Höchstdosen (pro Anwendung/pro Tag/insgesamt). |
| Konkreter Anwendungszeitpunkt                     | Bei manchen Arzneimitteln kann es sinnvoll sein, einen konkreten Anwendungszeitpunkt inkl. Datum und ggf. Uhrzeit zu benennen. Dies kann bspw. bei Arzneimitteln der Fall sein, für welche ein Termin in einer medizinischen Einrichtung vereinbart wird (bspw. Infusionen).                                                                       |
| Festlegung der Dosis einer Anwendung in Abhängigkeit zu bestimmten Bedingungen | Bestimmte Arzneimittel werden bspw. in Abhängigkeit von Labor- oder Selbstmesswerten oder von Art und Menge einer Mahlzeit dosiert. Hierzu gehören bspw. Insulinschemata, deren Dosis in Abhängigkeit zum Blut-Glukose-Wert und zum Kohlenhydrat-Gehalt einer Mahlzeit bestimmt wird.                                                               |

##### Ergänzung bestehender Schemata

**Alternative Zeitangaben und Dosierungen**

| Ergänzung / Alternative                                  | Beispiel                                               |
|----------------------------------------------------------|--------------------------------------------------------|
| Ungefähre Gesamtdauer                                    | Täglich 1 Stück für 1–2 Wochen                      |
| Start- und Enddatum                                      | Täglich 1 Stück vom 01.12.2025 bis zum 15.12.2025   |
| Gesamtzahl an Anwendungen bis zum Therapieabschluss      | Täglich 1 Stück, insgesamt 20 Stück                 |
| Ungefähre Dosierung                                      | Täglich 1–2 Stück                                  |

**Wertelisten & Ereignisbezug**

| Ergänzung / Werteliste / Ereignis                        | Beispiel                                               |
|----------------------------------------------------------|--------------------------------------------------------|
| Körperstelle, an der das Arzneimittel angewandt wird     | Täglich 10 Tropfen in das linke Ohr                    |
| Technik der Anwendung                                   | Injektion                                              |
| Applikationsweg                                         | Intramuskuläre Anwendung                               |
| Anwendung in Bezug zu Ereignis (inkl. zeitlichem Abstand)| Mit dem Frühstück / 30 min vor dem Frühstück           |
| Laufzeit einzelner Anwendungen                           | Infusion mit Gesamtmenge 500 ml, max. Laufrate 125 ml/h|


##### Übergeordnete Beziehung zwischen bestehenden Schemata

| Übergeordnete Beziehung zwischen bestehenden Schemata           | Beispiel                                                                                                 |
|-----------------------------------------------------------------|----------------------------------------------------------------------------------------------------------|
| Änderung von Dosis oder Anwendungshäufigkeit im Zeitverlauf     | Täglich 1 Stück morgens für 1 Woche. Anschließend täglich 2 Stück morgens für 1 Woche. (Einschleichen) |
| Kombination verschiedener Anwendungsintervalle                  | Abwechselnd: Jeden zweiten Tag 1 Stück morgens und jeden zweiten Tag 2 Stück morgens              |

##### Beispiele für komplexe Beziehungen zwischen Arzneimitteln

| Beziehungstyp                                        | Beispiel                                                                                                             |
|------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------|
| Gabe von zwei oder mehr Arzneimitteln in zeitlicher Beziehung zueinander | Das Arzneimittel „Acetylsalicylsäure” sollte mindestens eine halbe Stunde vor dem Arzneimittel „Ibuprofen” eingenommen werden. |
| Gabe von zwei oder mehr Arzneimitteln in bedingter Beziehung zueinander  | Wenn > 5 Tage Ibuprofen 600mg als Bedarfsmedikation, dann 1x täglich Omeprazol 20 mg.                                         |