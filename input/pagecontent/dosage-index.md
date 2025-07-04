# FHIR Dosierungen für den digital gestützen Medikationsprozess

## Kurzbeschreibung

Dieser Implementation Guide (IG) beinhaltet die standardisierte und interoperable Abbildung von Dosierungsinformationen im Rahmen von FHIR-Ressourcen für das deutsche Gesundheitswesen. Ziel ist es, eine einheitliche, sektorenübergreifende Darstellung und Übermittlung von Dosierungsangaben zu ermöglichen.
Jede Institution und jedes Softwaresystem, was medizinische Daten zur Nutzung in Deutschland produziert kann von den Profilen gebrauch machen, um eine nationale Interoperatbilität zu ermöglichen.

## Profilierung

### DE Profile

Für die Profilierung der strukturierten Dosierinformationen wurde ein allgemein gültiges und grundlegendes Profil für den deutschlandweiten Einsatz gedachtes Profil erstellt:[DosageDE](./StructureDefinition-de-dosage.html) mit Referenz auf [DE_TIMING](./StructureDefinition-timing-de-zeipunkte.html) erstellt.
//TODO Check

Diese Profile bilden ganz grundlegende Vorgaben zu Dosierungen in Deutschland ab und sollen in allen Fachgebieten referenziert werden, wo strutkurierte Dosierungen in FHIR abgebildet werden.

### dgMP Profile
Für den digital gestützten Medikationsprozess (dgMP) wurden die Profile [DosageDgMP](./StructureDefinition-de-dosage-dgmp.html) sowie [DE_TIMING_DGMP](./StructureDefinition-timing-de-dgmp-zeipunkte.html) erstellt. Diese treffen Einschränkungen bezüglich der im dgMP geltenden Einschränkungen und lassen nur solche Schemata zu, die auch genutzt werden.

Die Beteiligten, Akteure und Systeme, die an diesem Prozess beteiligt sind stimmen gemeinsam über die Integration einer Ausbaustufe von strukturierten Dosierungen ab.

## Unterstütze Dosierungen
Der Abschnitt von strukturierten Dosierungen wird kontinuierlich weiterentwickelt. Der digital gestütze Medikationsprozess unterstützt aktuell die folgenden Dosierschemata in Ausbaustufen.

### Ausbaustufe 1

- [Freitext Dosierung](./timing-freetext-scheme.html)
- [Schema für Tageszeiten Bezug](./timing-mman-scheme.html)
- [Schema für Uhrzeit Bezug](./timing-timeofday-scheme.html)
- [Schema für Wochentags-Bezug](./timing-weekday-scheme.html)
- [Schema für Wiederkehrender Interval](./timing-interval-scheme.html)
- [Schema für Kombinationen des Zeitintervalls](./timing-comb-interval-scheme.html)
- [Schema für Kombinationen des Wochentags](./timing-comb-dayofweek-scheme.html)

### Ausbaustufe 2
Alles in Ausbaustufe 1, sowie:

TBD

### Beispiele

Für die jeweiligen Schemata gibt es gültige und ungültige Beispiele in der folgenden [Übersicht](./dosage-to-text-examples.html).


## Zielgruppen

- Softwarehersteller und Systemintegratoren im Gesundheitswesen
- Entwickler von FHIR-basierten Systemen
- Ärzte, Apotheker, Pflegekräfte
- Fachexperten für Interoperabilität und Arzneimitteltherapie


## Inhalte für strukturierte Dosierungen

- Relevante Profile:
  - TODO
- ValueSets für Einheiten, Tageszeiten, Wochentage
- Extensions für spezielle Dosierungsfälle
- Validierungsregeln und Beispiele für unterstützte und nicht unterstützte Felder


## Kontakt und Feedback

Für Fragen und Feedback wenden Sie sich bitte an //TODO oder nutzen Sie das [GitHub-Repository](https://github.com/hl7germany/medication-ig-de-r4/issues).


## Rechtliche Hinweise

Copyright © 2025 HL7 Deutschland e.V.

Lizenz: TODO

