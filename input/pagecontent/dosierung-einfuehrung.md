## Kurzbeschreibung

Der Usecase Dosierung dieses  Implementation Guides (IG) beschreibt die standardisierte und interoperable Abbildung von Dosierungsinformationen mithilfe von FHIR-Ressourcen für das deutsche Gesundheitswesen. Ziel ist es, eine einheitliche, sektorenübergreifende Darstellung und Übermittlung von Dosierungsangaben zu ermöglichen.  
Alle Institutionen und Softwaresysteme, die medizinische Daten für die Nutzung in Deutschland erzeugen, können von diesen Profilen Gebrauch machen, um nationale Interoperabilität zu erreichen.

## Profilierung

Im Rahmen der deutschen FHIR-Implementierung wurden zwei unterschiedliche Profile für die Ressource `Dosage` entwickelt:

- **Offenes Profil: [DosageDE](./StructureDefinition-DosageDE.html)**
- **Geschlossenes Profil: [DosageDgMP](./StructureDefinition-DosageDgMP.html)**

### DE-Profile

Das Profil [DosageDE](./StructureDefinition-DosageDE.html), mit Referenz auf [TimingDE](./StructureDefinition-TimingDE.html), ist bewusst offen gehalten und enthält nur wenige Einschränkungen. Es ist für die allgemeine Interoperabilität konzipiert und ermöglicht eine flexible Abbildung unterschiedlichster Dosierschemata. Das Profil erzwingt keine konkreten Schemata, setzt jedoch ein „Must Support“ (MS) auf alle für die Dosierungsdarstellung notwendigen Felder. Damit wird sichergestellt, dass alle relevanten Informationen vorhanden sind, ohne die Implementierung auf bestimmte Strukturen festzulegen.

**Best Practice:**  
Für die Abbildung der Dosierung sollen die in diesem IG beschriebenen Dosierschemata verwendet werden. 

- [Freitext-Dosierung](./schema-freitext.html)
- [Schema mit Tageszeiten-Bezug](./schema-tageszeit.html)
- [Schema mit Uhrzeiten-Bezug](./schema-uhrzeit.html)
- [Schema mit Wochentags-Bezug](./schema-wochentag.html)
- [Schema für wiederkehrende Intervalle](./schema-intervall.html)
- [Schema für Kombinationen von Zeitintervallen](./schema-intervall-kombination.html)
- [Schema für Kombinationen von Wochentagen](./schema-wochentag-kombination.html)

Auf der Seite [Beispiele für Dosierungen](./dosierung-beispiele.html) sind Beispiele der Dosierschemata aufgeführt.

### dgMP-Profile

Für den digital gestützten Medikationsprozess (dgMP) wurden die technischen Profile [DosageDgMP](./StructureDefinition-DosageDgMP.html) und [TimingDgMP](./StructureDefinition-TimingDgMP.html) erstellt. Sie bilden die spezifischen Anforderungen und Einschränkungen des dgMP ab und erlauben ausschließlich die in der aktuellen Ausbaustufe im Prozess vorgesehenen Dosierschemata. Die dgmP Profile erben von DE Profilen, sind aber geschlossen profiliert und erzwingen die Verwendung der vorgegebenen Dosierschemata. Diese Profile nehmen bewusst Einschränkungen in der Interoperabilität in Kauf, um eine technisch einwandfreie und überprüfbare Dosierungsangabe zu ermöglichen.

Die beteiligten Akteure und Systeme stimmen die Einführung neuer Ausbaustufen für strukturierte Dosierungen gemeinsam ab.

### Empfehlung für Implementierende

- **Verwenden Sie grundsätzlich das DE-Profil (`DosageDE`)** für die Abbildung und Übertragung von Dosierungsinformationen in Ihren Systemen. Dieses Profil bietet die notwendige Flexibilität für die Interoperabilität im deutschen Gesundheitswesen.
- **Das DgMP-Profil (`DosageDgMP`)** ist für die Implementierung und Verwendung von Dosierungen im Rahmen des dgMP-Prozesses vorgesehen. Es sollte immer dann genutzt werden, wenn eine technische Validierung der Dosierung erforderlich ist – insbesondere im Kontext zentraler Dienste innerhalb der Telematikinfrastruktur (TI), wie beispielsweise beim E-Rezept-Fachdienst.
- **Außerhalb der TI** (z.B. bei der Kommunikation zwischen unterschiedlichen Primärsystemen) sollen die offenen DE-Profile genutzt werden, um maximale Kompatibilität und Austauschbarkeit zu gewährleisten.

#### Unterstützte Dosierungen

Die Abbildung strukturierter Dosierungen wird kontinuierlich weiterentwickelt. Ziel ist es, die strukturierte Angabe von Dosierungen schrittweise in den dgMP-Anwendungsfällen einzuführen. Beteiligte Projekte und Systeme stimmen sich hierzu ab und führen Erweiterungen koordiniert ein.  
Da die Ausbaustufen rückwärtskompatibel sind, können nachgelagerte Systeme schon vor den erzeugenden Systemen neue Ausbaustufen unterstützen.

## Inhalte für strukturierte Dosierungen

### Relevante Ressourcen

Für die strukturierte Abbildung von Dosierungen wurden zwei Profil-Ebenen definiert: DE-Profile und dgMP-Profile.  
Die folgenden Profile der Ressourcen `Dosage` und `Timing` sind für die deutschlandweite Nutzung vorgesehen:

{% capture profilesde %}
StructureDefinition/DosageDE,
StructureDefinition/TimingDE,
{% endcapture %}  
{% include artifacts-table-generator.html render=profilesde %}

Für den dgMP-Kontext:

{% capture profilesdgmp %}
StructureDefinition/DosageDgMP,
StructureDefinition/TimingDgMP,
{% endcapture %}  
{% include artifacts-table-generator.html render=profilesdgmp %}

Diese Profile nutzen folgende Extensions:

{% capture extensionsdgmp %}
StructureDefinition/GeneratedDosageInstructions,
{% endcapture %}  
{% include artifacts-table-generator.html render=extensionsdgmp %}

### Relevante Terminologien

Zur Sicherstellung der semantischen Interoperabilität werden standardisierte Terminologien und Codesysteme verwendet. Diese ermöglichen eine eindeutige und maschinenlesbare Kommunikation zwischen verschiedenen Systemen.

Verwendete Terminologien:

- **UCUM**: zur Abbildung von Dosiereinheiten und Dosierdauer
- **EQDM**: zur Abbildung strukturierter Dosiereinheiten
- **KBV_CS_SFHIR_BMP_DOSIEREINHEIT**: zur Abbildung strukturierter Dosiereinheiten

Ein Mapping zwischen den verschiedenen Kodiersystemen wird aktuell erarbeitet und in einer zukünftigen Version dieses IGs enthalten sein.

## Technische Validierung der Dosierungen

Um die syntaktische Korrektheit von Dosierungen sicherzustellen, wurden folgende technischen Prüfungen implementiert:

### Freitext oder strukturierte Dosierung

Der Constraint `DosageStructuredOrFreeTextWarning` im Profil [DosageDE](./StructureDefinition-DosageDE.html) gibt eine Warnung aus, sobald das Element `.text` zusammen mit einer strukturierten Dosieranweisung verwendet wird.

Der Constraint `DosageStructuredRequiresBoth`im im Profil [DosageDE](./StructureDefinition-DosageDE.html) stellt sicher, dass falls eine strukturierte Dosierungsangabe erfolgt, sowohl timing als auch doseAndRate angegeben werden.

Der Constraint `DosageDoseUnitSameCode`im im Profil [DosageDE](./StructureDefinition-DosageDE.html) stellt sicher, dass die Dosiereinheit über alle Dosierungen gleich ist.