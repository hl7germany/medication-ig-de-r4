# FHIR Dosierungen für den digital gestützten Medikationsprozess

## Kurzbeschreibung

Dieser Implementation Guide (IG) beschreibt die standardisierte und interoperable Abbildung von Dosierungsinformationen mithilfe von FHIR-Ressourcen für das deutsche Gesundheitswesen. Ziel ist es, eine einheitliche, sektorenübergreifende Darstellung und Übermittlung von Dosierungsangaben zu ermöglichen.  
Alle Institutionen und Softwaresysteme, die medizinische Daten für die Nutzung in Deutschland erzeugen, können von diesen Profilen Gebrauch machen, um nationale Interoperabilität zu erreichen.

## Profilierung

### DE-Profile

Für die strukturierte Abbildung von Dosierinformationen wurde ein grundlegendes, deutschlandweit einsetzbares Profil entwickelt: [DosageDE](./StructureDefinition-DosageDE.html) mit Referenz auf [TimingDE](./StructureDefinition-TimingDE.html).

Diese Profile enthalten deutsche Feldbeschreibungen, bilden grundlegende Vorgaben zu Dosierungen in Deutschland ab und sollen in allen Fachgebieten verwendet werden, in denen strukturierte Dosierungen mit FHIR abgebildet werden.

### dgMP-Profile

Für den digital gestützten Medikationsprozess (dgMP) wurden die Profile [DosageDgMP](./StructureDefinition-DosageDgMP.html) und [TimingDgMP](./StructureDefinition-TimingDgMP.html) erstellt. Sie bilden die spezifischen Anforderungen und Einschränkungen des dgMP ab und erlauben ausschließlich die im Prozess vorgesehenen Dosierschemata.

Die beteiligten Akteure und Systeme stimmen die Einführung neuer Ausbaustufen für strukturierte Dosierungen gemeinsam ab.

## Unterstützte Dosierungen

Die Abbildung strukturierter Dosierungen wird kontinuierlich weiterentwickelt. Ziel ist es, die strukturierte Angabe von Dosierungen schrittweise in den dgMP-Anwendungsfällen einzuführen. Beteiligte Projekte und Systeme stimmen sich hierzu ab und führen Erweiterungen koordiniert ein.  
Da die Ausbaustufen rückwärtskompatibel sind, können nachgelagerte Systeme (z.B. ePA) schon vor den erzeugenden Systemen neue Ausbaustufen unterstützen.

Der digital gestützte Medikationsprozess unterstützt aktuell die folgenden Dosierschemata, gegliedert nach Ausbaustufen. Die jeweiligen Seiten enthalten eine fachliche Beschreibung, Beispiele und technische Hinweise zur Instanziierung.

### Ausbaustufe 1

- [Freitext-Dosierung](./timing-freetext-scheme.html)
- [Schema mit Tageszeiten-Bezug](./timing-mman-scheme.html)
- [Schema mit Uhrzeiten-Bezug](./timing-timeofday-scheme.html)
- [Schema mit Wochentags-Bezug](./timing-weekday-scheme.html)
- [Schema für wiederkehrende Intervalle](./timing-interval-scheme.html)
- [Schema für Kombinationen von Zeitintervallen](./timing-comb-interval-scheme.html)
- [Schema für Kombinationen von Wochentagen](./timing-comb-dayofweek-scheme.html)

### Ausbaustufe 2

Enthält alle Schemata aus Ausbaustufe 1 sowie:

*TBD //TODO: Weitere Schemata und Details ergänzen*

## Beispiele

Zur Unterstützung der Implementierenden werden in diesem Projekt verschiedene Beispiele bereitgestellt. Die [Übersicht der Beispiele](./dosage-to-text-examples.html) zeigt alle validen Beispiele in einer Matrix mit generierter Dosisinstruktion und einer Übersicht der belegten Felder.  
Darüber hinaus finden sich auf der Seite [Beispiele für Dosierungen](./dosage-examples.html) vollständige Listen von Positiv- und Negativbeispielen, inklusive solcher, die in der aktuellen Ausbaustufe noch nicht unterstützt werden.

## Inhalte für strukturierte Dosierungen

### Relevante Ressourcen

Für die strukturierte Abbildung von Dosierungen wurden zwei Profil-Ebenen definiert: DE-Profile und dgMP-Profile.  
Die folgenden Profile der Ressourcen `Dosage` und `Timing` sind für die deutschlandweite Nutzung vorgesehen:

{% capture profilesde %} StructureDefinition/DosageDE, StructureDefinition/TimingDE {% endcapture %}  
{% include artifacts-table-generator.html render=profilesde %}

Für den dgMP-Kontext:

{% capture profilesdgmp %} StructureDefinition/DosageDgMP, StructureDefinition/TimingDgMP {% endcapture %}  
{% include artifacts-table-generator.html render=profilesdgmp %}

Zur Unterstützung von Spezifikateuren stehen folgende Profile zur Verfügung, die Ressourcen mit Referenz auf den Datentyp `Dosage` profilieren:

{% capture supportprofilesdgmp %} StructureDefinition/MedicationRequestDgMP, StructureDefinition/MedicationDispenseDgMP, StructureDefinition/MedicationStatementDgMP {% endcapture %}  
{% include artifacts-table-generator.html render=supportprofilesdgmp %}

Diese Profile nutzen folgende Extensions:

{% capture extensionsdgmp %} StructureDefinition/GeneratedDosageInstructions {% endcapture %}  
{% include artifacts-table-generator.html render=extensionsdgmp %}

### Relevante Terminologien

Zur Sicherstellung der Interoperabilität werden standardisierte Terminologien und Codesysteme verwendet. Diese ermöglichen eine eindeutige und maschinenlesbare Kommunikation zwischen verschiedenen Systemen.

Verwendete Terminologien (Beispiele):

- **EQDM**: Für strukturierte Dosiereinheiten  
//TODO: Weitere Terminologien und Codesysteme aufführen und verlinken

Die jeweils verwendeten ValueSets und Codesysteme sind in den Profilen und Ressourcen dieses IG dokumentiert und referenziert. Bei der Implementierung ist darauf zu achten, die jeweils angegebenen Terminologien zu verwenden und die korrekten Codes zu übermitteln.

## Technische Validierung der Dosierungen

Um sicherzustellen, dass Dosierungen syntaktisch korrekt und den Vorgaben der jeweiligen Ausbaustufe entsprechend erstellt werden, sind folgende technische Prüfungen implementiert:

### Freitext oder strukturierte Dosierung

Der Constraint `DosageStructuredOrFreeText` im Profil [DosageDgMP](./StructureDefinition-DosageDgMP.html) stellt sicher, dass entweder das Element `.text` oder eine strukturierte Angabe der Dosierung befüllt wird – nicht jedoch beides gleichzeitig. So wird ausgeschlossen, dass widersprüchliche Angaben gemacht werden.

### Nur ein Dosierungsschema pro Instanz

Der Constraint `timing-only-one-type` im Profil [TimingDgMP](./StructureDefinition-TimingDgMP.html) stellt sicher, dass eine Dosierung ausschließlich einem zulässigen Dosierungsschema der aktuellen Ausbaustufe entspricht. Außerdem wird sichergestellt, dass alle Dosierungen innerhalb einer übergeordneten Ressource (z.B. alle Einträge in `MedicationRequest.dosageInstruction`) demselben Dosierungsschema folgen.

Es ist somit nicht möglich, in einer `MedicationRequest`-Ressource gleichzeitig Dosierungen mit Uhrzeiten- und Tageszeiten-Schema zu kombinieren.
