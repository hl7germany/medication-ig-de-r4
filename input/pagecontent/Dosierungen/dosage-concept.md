## Fachliche Rahmenvorgaben für Dosierungen

Diese Seite beschreibt fachliche Aspekte und Entscheidungen zur Handhabung von strukturierten Dosierungen im dgMP-Kontext.

### Kardinalitäten und Weiterentwicklung der dgMP-Profile

Das Projekt wird iterativ weiterentwickelt. In den dgMP-Profilen werden Felder, die in der aktuellen Ausbaustufe nicht berücksichtigt werden, durch die Kardinalität 0..0 ausgeschlossen.  
Dies bedeutet jedoch nicht, dass diese Felder in zukünftigen Ausbaustufen nicht relevant werden. Implementierungen sollten daher so gestaltet sein, dass sie zusätzliche, bislang nicht genutzte Angaben beim Lesen ignorieren und keine Fehler verursachen. Es gilt: Verarbeitet werden soll, was verarbeitet werden kann – alles Weitere wird ignoriert.

### Nutzung des Feldes `.text`

Die textuelle Angabe von Dosierungen wird in diesem Projekt in zwei Varianten unterschieden:
- Vom Menschen beschriebene Dosierung (Freitext)
- Automatisch aus der strukturierten Angabe generierte textuelle Repräsentation

Softwaresysteme müssen Dosierungsangaben stets strukturiert erfassen, sofern eine strukturierte Abbildung möglich ist. Eine Erfassung als Freitext in Dosage.text ist in diesem Fall nicht zulässig. Das System soll den Nutzenden durch geeignete Eingabemasken bei der strukturierten Erfassung unterstützen.

Das Feld `Dosage.text` ist **ausschließlich** für vom Menschen erzeugten Freitext vorgesehen. Es darf nicht gleichzeitig mit einer strukturierten Angabe verwendet werden, um widersprüchliche Informationen zu vermeiden.

Im Kontext des dgMP sorgt die [Infrastruktur zur Bereitstellung des Dosierungstextes](./dosage-to-text-system.html) dafür, dass zu jeder strukturierten Dosierung auch eine einheitliche, maschinell generierte textuelle Repräsentation bereitgestellt wird. Dieser Text wird in der Extension `Dosage.extension[GeneratedDosageInstructionsEx]` hinterlegt.

### Verwendung mehrerer Dosages

Jede `Dosage`-Instanz beschreibt eine Kombination aus Einnahmerhythmus (z.B. „3x täglich“) und der zugehörigen Dosis pro Einnahmeereignis (z.B. „2 Tabletten“). Der Einnahmerhythmus wird in `Dosage.timing` abgebildet.

Wichtig:
- Jede `Dosage`-Instanz bildet *nur ein Dosierschema* ab.
- Für verschiedene Dosierungen innerhalb desselben Schemas (z.B. morgens 1 Tablette, abends 2 Tabletten) sind separate `Dosage`-Instanzen erforderlich.

**Beispiel:**

Ein Patient soll morgens 1 Tablette und abends 2 Tabletten einnehmen.

- Es werden zwei `Dosage`-Instanzen erstellt:
    1. Erste Dosage:  
        - `Dosage.timing`: morgens  
        - `Dosage.doseAndRate`: 1 Tablette
    2. Zweite Dosage:  
        - `Dosage.timing`: abends  
        - `Dosage.doseAndRate`: 2 Tabletten

Jede dieser Instanzen beschreibt ein eigenes Dosierschema, auch wenn sie im selben Medikationsauftrag stehen.
Eine Instanz dieser Dosierung ist im Beispiel [MedicationRequest-Example-MR-Dosage-1010](./MedicationRequest-Example-MR-Dosage-1010.html) einzusehen.

Für weitere Details siehe [Erstellen und Auswerten mehrerer Dosierungen](./multiple-dosages.html).

### Nutzung von Sequenzen

In der aktuellen Ausbaustufe und im Kontext dgMP ist die Verwendung von `Dosage.sequence` nicht erlaubt. Dieses Feld dient beispielsweise dazu, aufeinander aufbauende Dosierungen (wie Ein- oder Ausschleichen) zu kennzeichnen. Die Nutzung kann in zukünftigen Ausbaustufen geprüft werden.

### Strukturierte Angabe der Einheit

Für die Berechnung der Reichweite einer Medikation ist es erforderlich, dass Dosierungseinheiten (z.B. „1 Tablette“) strukturiert über ein Codesystem angegeben werden.  
Dafür steht ein eingeschränktes ValueSet (`DosageDoseQuantityDE` bzw. `DosageDoseQuantityDGMP`) zur Verfügung, das alle zulässigen Dosiereinheiten enthält.  
Die strukturierte Angabe der Einheit bildet die Grundlage für mögliche Reichweitenberechnungen und fördert die Interoperabilität.
