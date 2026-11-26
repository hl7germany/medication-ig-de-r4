### Kurzbeschreibung

Dieser Implementation Guide (IG) beschreibt die standardisierte und interoperable Abbildung medikationsbezogener Informationen und Prozesse im deutschen Gesundheitswesen auf Basis von HL7® FHIR®. Ziel ist es, sektorenübergreifende Anwendungsfälle - wie beispielsweise die strukturierte Dosierungsinformation im E-Rezept, den elektronischen Medikationsplan oder den Austausch mittels [ISiK](https://fachportal.gematik.de/informationen-fuer/isik/bestaetigungsverfahren-isik) - zu ermöglichen und zu harmonisieren.

Der IG enthält die Beschreibung der jeweiligen Anwendungsfälle sowie begleitende Dokumentation.

### Aktuelle Anwendungsfälle

Dieser Implementation Guide wird kontinuierlich weiterentwickelt und verbessert. Aktuell werden folgende Anwendungsfälle unterstützt:

- Strukturierte und textuelle Darstellung von [Dosierungen](./dosierung-einfuehrung.html)

### Must Support

Elemente mit der Eigenschaft [mustSupport](https://www.hl7.org/fhir/profiling.html#mustsupport) müssen immer implementiert werden. Hierbei handelt es sich um Elemente, die unabhängig von der Kardinalität (Ausnahme: 0…0) unterstützt werden müssen, sofern die entsprechenden Informationen vorliegen.

Die Software, welche die Dateien erstellt, muss die mit „mustSupport“ gekennzeichneten Elemente (mustSupport value="true") unterstützen - befüllen und übermitteln können.

Die Software, welche die Dateien verarbeitet, muss die mit „mustSupport“ gekennzeichneten Elemente (mustSupport value="true") unterstützen - auslesen und verarbeiten können.

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
- Kompetenzzentrum für Interoperabilität im Gesundheitswesen (KIG) 
- Verband der Privaten Krankenversicherung  

### Abhängigkeiten

Dieser IG verwendet zur Kodierung der doseQuantity [KBV_VS_SFHIR_BMP_DOSIEREINHEIT](https://fhir.kbv.de/ValueSet/KBV_VS_SFHIR_BMP_DOSIEREINHEIT) & [KBV_CS_SFHIR_BMP_DOSIEREINHEIT](https://fhir.kbv.de/CodeSystem/KBV_CS_SFHIR_BMP_DOSIEREINHEIT) welche bewusst nicht als Abhängigkeit deklariert worden sind.

{% include dependency-table.xhtml %}

#### Nutzung von Cross-Version-Extensions

Das dgMP Script schreibt den aggreggierten DosageText für MedicationRequest, MedicationRequest und MedicationStatement nach `.renderedDosageInstruction` - einem R5 Element welches nach R4 ge-backportet wurde. 
Dies ist ein durch die [FHIR Spezifikation definierter Mechanismus](https://hl7.org/fhir/versions.html#extensions) welcher im [Java FHIR Validator](https://confluence.hl7.org/spaces/FHIR/pages/35718580/Using+the+FHIR+Validator) bereits unterstützt wird. Andere Validatoren müssen ggfs. das passende cross-version-Paket laden. 

Die Extensions stammen aus dem offiziellen Cross-Version-Paket [`hl7.fhir.uv.xver-r5.r4`](https://hl7.org/fhir/uv/xver-r5.r4/0.1.0/) in Version `0.1.0`, von dem dieser IG abhängt:

- [MedicationDispense.renderedDosageInstruction](https://hl7.org/fhir/uv/xver-r5.r4/0.1.0/StructureDefinition-ext-R5-MedicationDispense.renderedDosageInstruction.html)
- [MedicationRequest.renderedDosageInstruction](https://hl7.org/fhir/uv/xver-r5.r4/0.1.0/StructureDefinition-ext-R5-MedicationRequest.renderedDosageInstruction.html)
- [MedicationStatement.renderedDosageInstruction](https://hl7.org/fhir/uv/xver-r5.r4/0.1.0/StructureDefinition-ext-R5-MedicationStatement.renderedDosageInstruction.html)

Für `Dosage.asNeededFor` enthält das Paket keine Extension. Dieser IG definiert sie unter der Cross-Version-URL `http://hl7.org/fhir/5.0/StructureDefinition/extension-Dosage.asNeededFor` selbst: [DosageAsNeededFor](./StructureDefinition-extension-Dosage.asNeededFor.html).

### Kontakt und Feedback

Für Fragen und Feedback wenden Sie sich bitte an [info@hl7.de](mailto:info@hl7.de) oder nutzen Sie das [GitHub-Repository](https://github.com/hl7germany/medication-ig-de-r4/issues).

### Rechtliche Hinweise

Dieser Implementation Guide wurde in Zusammenarbeit zwischen   
- [HL7 Deutschland e.V.](https://hl7.de/)  
- [gematik GmbH](https://www.gematik.de/)  

erarbeitet.

Copyright © 2025 HL7 Deutschland e.V.

HL7®, HEALTH LEVEL SEVEN®, FHIR® und das FHIR®-Logo sind Marken von Health Level Seven International, eingetragen beim United States Patent and Trademark Office.
