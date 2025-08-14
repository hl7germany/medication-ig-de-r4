Eine zentrale fachliche und technische Herausforderung im digital gestützten Medikationsprozess (dgMP) besteht darin, den aus strukturierten Dosierungen generierten Dosierungstext über alle beteiligten Systeme hinweg **einheitlich und konsistent** bereitzustellen. Unabhängig davon, wo strukturierte Dosierungsdaten verarbeitet oder angezeigt werden, soll stets derselbe algorithmisch erzeugte Dosierungstext verwendet werden.

### Definition der Akteure

- **Erfassende Systeme** sind Systeme, die Verordnungen anlegen und strukturierte Dosierungsdaten erfassen.
- **Validierende Systeme** sind Dienste oder Komponenten, die den Dosierungstext validieren und auf Regelkonformität sowie Konsistenz prüfen.
- **Darstellende Systeme** sind Frontends oder Viewer, die den generierten Dosierungstext anzeigen.

### Zielsetzung

Um Missverständnisse und Abweichungen bei der Darstellung von Dosierungsanweisungen zu vermeiden, wird der Text zur strukturierten Dosierung **nach einem einheitlichen, standardisierten Algorithmus erzeugt**. Dabei sind die Primärsysteme verpflichtet, den Dosierungstext einer strukturierten Dosierung lokal zu generieren und in das entsprechende Feld ([Dosage.extension[GeneratedDosageInstructions]](./StructureDefinition-GeneratedDosageInstructions.html)) einzutragen. Die zentralen Dienste validieren dann, ob der generierte Text korrekt ist.

### Technische Umsetzung und Ablauf

Sofern keine Freitextdosierung angegeben wird, erfolgt die Generierung und Bereitstellung des Dosierungstextes im Verordnungsprozess in folgenden Schritten:

1. **Erstellung der Verordnung:**
   - Erfassende Systeme erzeugen die Verordnung mit vollständig strukturierten Dosierungsdaten.
   - Zusätzlich wird der Dosierungstext lokal anhand des festgelegten Algorithmus generiert und im Datensatz eingetragen.

2. **Einstellen der Verordnung:**
   - Validierende Systeme generieren den Dosierungstext mittels des festgelegten Algorithmus erneut und vergleichen ihn mit dem von den Erfassenden Systemen übermittelten Text, um Regelkonformität und Konsistenz sicherzustellen.

3. **Anzeige und Weitergabe:**
   - Darstellende Systeme können entweder die strukturierten Daten oder – falls sie diese nicht interpretieren können – den generierten Text anzeigen.
   - Der validierte Text wird für alle Systeme bereitgestellt, die keine strukturierte Anzeige unterstützen.

### Annahmen und Rahmenbedingungen

- **Erfassende Systeme** müssen in der Lage sein, strukturierte Dosierungsdaten zu verarbeiten und den zugehörigen Dosierungstext lokal, regelkonform und standardisiert zu generieren.
- **Validierende Systeme** prüfen die Regelkonformität des generierten Dosierungstextes.
- **Darstellende Systeme** greifen auf den generierten Dosierungstext zurück, wenn sie strukturierte Daten nicht interpretieren können.
- Die zentrale Validierung und ggf. Generierung des Dosierungstextes stellt die Einheitlichkeit der Information im gesamten dgMP-Prozess sicher.
- Der zugrundeliegende Algorithmus zur Textgenerierung ist standardisiert und muss von allen relevanten Systemen identisch implementiert werden.

### Zusammenfassung

Durch diese Infrastruktur wird gewährleistet, dass der Dosierungstext im gesamten dgMP-Prozess **einheitlich, nachvollziehbar und interoperabel** zur Verfügung steht. Erfassende Systeme sind für die initiale Generierung verantwortlich, Validierende Systeme prüfen die Regelkonformität und Konsistenz, und Darstellende Systeme nutzen den validierten Text zur Anzeige. So wird die Qualität und Konsistenz der Dosierungsinformationen im deutschen Gesundheitswesen nachhaltig verbessert.