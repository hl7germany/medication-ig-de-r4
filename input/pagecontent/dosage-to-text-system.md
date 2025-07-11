## Infrastruktur zur Bereitstellung des Dosierungstextes

Eine zentrale fachliche und technische Herausforderung im digital gestützten Medikationsprozess (dgMP) ist die **einheitliche und konsistente Bereitstellung des generierten Dosierungstextes** über alle beteiligten Systeme hinweg. Ziel ist es, dass unabhängig davon, wo strukturierte Dosierungsdaten verarbeitet oder angezeigt werden, stets derselbe, algorithmisch erzeugte Dosierungstext zur Verfügung steht.

### Zielsetzung

Um Missverständnisse und Abweichungen bei der Darstellung von Dosierungsanweisungen zu vermeiden, wird der Text zur strukturierten Dosierung **nach einem einheitlichen, standardisierten Algorithmus erzeugt**. Dabei sind die Primärsysteme (PVS und AVS) verpflichtet, den Dosierungstext lokal zu generieren und in das entsprechende Feld ([Dosage.extension[GeneratedDosageInstructions]](./StructureDefinition-GeneratedDosageInstructions.html)) einzutragen. Die zentralen Dienste validieren dann, ob der generierte Text korrekt ist.

### Technische Umsetzung und Ablauf

Die Generierung und Bereitstellung des Dosierungstextes im Verordnungsprozess erfolgt in folgenden Schritten:

1. **Erstellung der Verordnung:**
   - Das Primärsystem (PVS) erzeugt die Verordnung mit vollständig strukturierten Dosierungsdaten.
   - Zusätzlich wird der Dosierungstext lokal anhand des festgelegten Algorithmus generiert und im Datensatz eingetragen.

2. **Einstellen der Verordnung:**
   - Die zentralen Dienste (in diesem Fall E-Rezept-Fachdienst) validieren, ob der von den Primärsystemen bereitgestellte Dosierungstext korrekt und regelkonform generiert wurde.
   - Wo möglich, können die zentralen Dienste den Dosierungstext ebenfalls selbst generieren, um eine zusätzliche Prüfmöglichkeit und Konsistenzsicherung zu gewährleisten.

3. **Anzeige und Weitergabe:**
   - Die Fachanwendungen und Frontend-Dienste für Versicherte (FdV) können entweder die strukturierten Daten oder – falls sie diese nicht interpretieren können – den generierten Text anzeigen.
   - Der validierte Text wird für alle Systeme bereitgestellt, die keine strukturierte Anzeige unterstützen.

4. **Übertragung an die ePA:**
   - Der Dosierungstext wird gemeinsam mit den strukturierten Dosierungsdaten an das ePA-Aktensystem übermittelt.
   - Auch dort kann der Text bei Bedarf erneut generiert oder mit dem gelieferten Wert abgeglichen werden.

### Annahmen und Rahmenbedingungen

- **Primärsysteme (PVS und AVS)** müssen in der Lage sein, strukturierte Dosierungsdaten zu verarbeiten und den zugehörigen Dosierungstext lokal, regelkonform und standardisiert zu generieren.
- **Zentrale Dienste** (wie E-Rezept-Fachdienst und ePA-Aktensysteme) validieren die Korrektheit des gelieferten Textes und sind in der Lage, diesen bei Bedarf selbst zu generieren.
- **Frontend-Dienste für Versicherte (FdV)** und andere nachgelagerte Systeme, die keine strukturierte Anzeige unterstützen, greifen auf den generierten Text zurück.
- Die zentrale Validierung und ggf. Generierung des Dosierungstextes stellt die Einheitlichkeit der Information im gesamten dgMP-Prozess sicher.
- Der zugrundeliegende Algorithmus zur Textgenerierung ist standardisiert und muss von allen relevanten Systemen identisch implementiert werden.

### Zusammenfassung

Durch diese Infrastruktur wird gewährleistet, dass der Dosierungstext im gesamten dgMP-Prozess **einheitlich, nachvollziehbar und interoperabel** zur Verfügung steht. Die Verantwortung für die Generierung liegt bei den Primärsystemen, während die zentralen Dienste die Korrektheit validieren und – wo möglich – den Text ebenfalls generieren können. So wird die Qualität und Konsistenz der Dosierungsinformationen im deutschen Gesundheitswesen nachhaltig verbessert.
