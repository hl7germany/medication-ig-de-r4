### Kurzbeschreibung

Dieser Implementation Guide (IG) beschreibt die standardisierte und interoperable Abbildung medikationsbezogener Informationen und Prozesse im deutschen Gesundheitswesen auf Basis von HL7® FHIR®. Ziel ist es, sektorenübergreifende Anwendungsfälle – wie beispielsweise die strukturierte Dosierungsinformation im E-Rezept oder den elektronischen Medikationsplan – zu ermöglichen und zu harmonisieren.

Der IG enthält die Beschreibung der jeweiligen Anwendungsfälle sowie begleitende Dokumentation.

### Aktuelle Anwendungsfälle

Dieser Implementation Guide wird kontinuierlich weiterentwickelt und verbessert. Aktuell werden folgende Anwendungsfälle unterstützt:

- Strukturierte und textuelle Darstellung von [Dosierungen](./dosierung-einfuehrung.html)

### Must Support

In diesem Implementation Guide – insbesondere in den anwendungsfallspezifischen Profilen – werden [Must Support Flags](https://www.hl7.org/fhir/profiling.html#mustsupport) verwendet. Implementierende Systeme sollen sicherstellen, dass Elemente mit diesem Flag sowohl lesend als auch schreibend unterstützt werden.

**Für schreibende Systeme gilt:**  
Nutzende sollen dabei unterstützt werden, alle verfügbaren Informationen in Must-Support-Elemente einzutragen. Ist eine Information nicht vorhanden, kann das entsprechende Feld ausgelassen werden.

**Für lesende Systeme gilt:**  
Sind Must-Support-Elemente in einer Instanz vorhanden, dürfen sie nicht zu Fehlern in der Anwendung führen. Die enthaltenen Informationen sollen dem Nutzenden angezeigt werden.

### Zielgruppen

- Softwarehersteller und Systemintegratoren im Gesundheitswesen
- Entwickler:innen von FHIR-basierten Systemen
- Ärzt:innen, Apotheker:innen, Pflegekräfte
- Fachexpert:innen für Interoperabilität und Arzneimitteltherapie

### Mitwirkende Organisationen

Durch Input und Feedback haben folgende Organisationen an der Erstellung dieses Implementation Guides mitgewirkt:

- Bundesvereinigung Deutscher Apothekerverbände  
- Deutscher Apothekerverband  
- Deutsche Krankenhausgesellschaft  
- gematik GmbH  
- GKV-Spitzenverband  
- HL7 Deutschland  
- Kassenärztliche Bundesvereinigung  
- Koordinierungsgremium Interoperabilität im Gesundheitswesen (KIG)  
- Verband der Privaten Krankenversicherung  

### Abhängigkeiten

Dieser IG verwendet zur Kodierung der doseQuantity [KBV_VS_SFHIR_BMP_DOSIEREINHEIT](https://fhir.kbv.de/ValueSet/KBV_VS_SFHIR_BMP_DOSIEREINHEIT) & [KBV_CS_SFHIR_BMP_DOSIEREINHEIT](https://fhir.kbv.de/CodeSystem/KBV_CS_SFHIR_BMP_DOSIEREINHEIT) welche bewusst nicht als Abhängigkeit deklariert worden sind.

{% include dependency-table.xhtml %}

### Kontakt und Feedback

Für Fragen und Feedback wenden Sie sich bitte an [info@hl7.de](mailto:info@hl7.de) oder nutzen Sie das [GitHub-Repository](https://github.com/hl7germany/medication-ig-de-r4/issues).

### Rechtliche Hinweise

Dieser Implementation Guide wurde in Zusammenarbeit zwischen   
- [HL7 Deutschland e.V.](https://hl7.de/)  
- [gematik GmbH](https://www.gematik.de/)  

erarbeitet.

Copyright © 2025 HL7 Deutschland e.V.

HL7®, HEALTH LEVEL SEVEN®, FHIR® und das FHIR®-Logo sind Marken von Health Level Seven International, eingetragen beim United States Patent and Trademark Office.
