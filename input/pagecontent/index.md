# FHIR Implementation Guide für medikationsbezogene Anwendungsfälle im deutschen Gesundheitswesen

## Kurzbeschreibung

Dieser Implementation Guide (IG) beschreibt die standardisierte und interoperable Abbildung medikationsbezogener Informationen und Prozesse im deutschen Gesundheitswesen auf Basis von HL7® FHIR®. Ziel ist es, sektorenübergreifende Anwendungsfälle – wie beispielsweise die strukturierte Dosierungsinformation im E-Rezept oder den elektronischen Medikationsplan – zu ermöglichen und zu harmonisieren.

Der IG enthält die Beschreibung der jeweiligen Anwendungsfälle sowie begleitende Dokumentation.

## Aktuelle Anwendungsfälle

Dieser Implementation Guide wird kontinuierlich weiterentwickelt und verbessert. Aktuell werden folgende Anwendungsfälle unterstützt:

- Strukturierte und textuelle Darstellung von [Dosierungen](./dosage-index.html)

## Terminologien und Codesysteme

Zur Sicherstellung der Interoperabilität werden in diesem Implementation Guide standardisierte Terminologien und Codesysteme verwendet. Diese ermöglichen eine eindeutige und maschinenlesbare Kommunikation zwischen verschiedenen Systemen.

Folgende Terminologien werden eingesetzt:

- **EQDM**: Angabe strukturierter Dosiereinheiten
//TODO

Die jeweils verwendeten ValueSets und Codesysteme sind in den Profilen und Ressourcen dieses IG dokumentiert und referenziert. Bei der Implementierung ist darauf zu achten, die jeweils angegebenen Terminologien zu verwenden und die korrekten Codes zu übermitteln.

## Must Support

In diesem Implementation Guide – insbesondere in den anwendungsfallspezifischen Profilen – werden [Must Support Flags](https://www.hl7.org/fhir/profiling.html#mustsupport) verwendet. Implementierende Systeme sollen sicherstellen, dass Elemente mit diesem Flag sowohl lesend als auch schreibend unterstützt werden.

**Für schreibende Systeme gilt:**  
Nutzende sollen dabei unterstützt werden, alle verfügbaren Informationen in Must-Support-Elemente einzutragen. Ist eine Information nicht vorhanden, kann das entsprechende Feld ausgelassen werden.

**Für lesende Systeme gilt:**  
Sind Must-Support-Elemente in einer Instanz vorhanden, dürfen sie nicht zu Fehlern in der Anwendung führen. Die enthaltenen Informationen sollen dem Nutzenden angezeigt werden.

## Zielgruppen

- Softwarehersteller und Systemintegratoren im Gesundheitswesen
- Entwickler:innen von FHIR-basierten Systemen
- Ärzt:innen, Apotheker:innen, Pflegekräfte
- Fachexpert:innen für Interoperabilität und Arzneimitteltherapie

## Abhängigkeiten

{% include dependency-table.xhtml %}

## Kontakt und Feedback

Für Fragen und Feedback wenden Sie sich bitte an [info@hl7.de](mailto:info@hl7.de) oder nutzen Sie das [GitHub-Repository](https://github.com/hl7germany/medication-ig-de-r4/issues).

## Rechtliche Hinweise

Dieser Implementation Guide wurde in Zusammenarbeit von  
- [HL7 Deutschland e.V.](https://hl7.de/)  
- [gematik GmbH](https://www.gematik.de/)  

erarbeitet.

Copyright © 2025 HL7 Deutschland e.V.

HL7®, HEALTH LEVEL SEVEN®, FHIR® und das FHIR®-Logo sind Marken von Health Level Seven International, eingetragen beim United States Patent and Trademark Office.
