## Dosierungs-Profile im deutschen FHIR-Kontext

In diesem Abschnitt werden die beiden im deutschen FHIR-Kontext entwickelten Dosierungs-Profile erläutert und deren jeweiliger Anwendungsbereich beschrieben. Ziel ist es, Implementierenden eine klare Orientierung zu geben, welches Profil in welchem Szenario sinnvoll eingesetzt werden sollte.

### Überblick über die Profile

Im Rahmen der deutschen FHIR-Implementierung wurden zwei unterschiedliche Profile für die Ressource `Dosage` entwickelt:

- **Offenes Profil: [DosageDE](./StructureDefinition-DosageDE.html)**
- **Strenges Profil: [DosageDgMP](./StructureDefinition-DosageDgMP.html)**

#### DosageDE (offenes Profil)

Das Profil `DosageDE` ist bewusst offen gehalten und enthält nur wenige Einschränkungen. Es ist für die allgemeine Interoperabilität konzipiert und ermöglicht eine flexible Abbildung unterschiedlichster Dosierschemata. Das Profil erzwingt keine konkreten Schemata, setzt jedoch ein „Must Support“ (MS) auf alle für die Dosierungsdarstellung notwendigen Felder. Damit wird sichergestellt, dass alle relevanten Informationen vorhanden sind, ohne die Implementierung auf bestimmte Strukturen festzulegen.

**Best Practice:**  
Für die Abbildung der Dosierung sollten die in diesem IG beschriebenen Dosierschemata verwendet werden. Weitere Informationen und Beispiele dazu finden Sie unter [Unterstützte Dosierungen](./dosage-index.html#unterst%C3%BCtzte-dosierungen).

#### DosageDgMP (strenges Profil)

Das Profil `DosageDgMP` ist ein technisches Profil, das speziell für die Validierung von Dosierungsangaben entwickelt wurde. Es enthält zahlreiche Einschränkungen und Vorgaben, um die Einhaltung definierter Dosierschemata sicherzustellen. Dieses Profil nimmt bewusst Einschränkungen in der Interoperabilität in Kauf, um eine technisch einwandfreie und überprüfbare Dosierungsangabe zu ermöglichen.

**Hinweis:**  
Das Profil `DosageDgMP` ist insbesondere für zentrale Systeme wie den E-Rezept-Fachdienst und ePA Aktensystem relevant. Hier werden Dosierungen nach diesem strengen Profil validiert.
{:.note}

### Empfehlung für Implementierende

- **Verwenden Sie grundsätzlich das DE-Profil (`DosageDE`)** für die Abbildung und Übertragung von Dosierungsinformationen in Ihren Systemen. Dieses Profil bietet die notwendige Flexibilität für die Interoperabilität im deutschen Gesundheitswesen.
- **Das DgMP-Profil (`DosageDgMP`)** ist für die Implementierung und Verwendung von Dosierungen im Rahmen des dgMP-Prozesses vorgesehen. Es sollte immer dann genutzt werden, wenn eine technische Validierung der Dosierung erforderlich ist – insbesondere im Kontext zentraler Dienste innerhalb der Telematikinfrastruktur (TI), wie beispielsweise beim E-Rezept-Fachdienst.
- **Außerhalb der TI** (z.B. bei der Kommunikation zwischen unterschiedlichen Primärsystemen) kann und sollte das offenere DE-Profil genutzt werden, um maximale Kompatibilität und Austauschbarkeit zu gewährleisten.
