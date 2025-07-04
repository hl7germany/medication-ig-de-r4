Profile: TimingDE
Parent: Timing
Id: TimingDE
Title: "Timing DE Zeitpunkte"
Description: "Beschreibt ein Ereignis, das mehrfach auftreten kann. Zeitpläne werden verwendet, um festzuhalten, wann etwas geplant, erwartet oder angefordert ist. Die häufigste Anwendung ist in Dosierungsanweisungen für Medikamente. Sie werden aber auch für die Planung verschiedener Versorgungsleistungen genutzt und können zur Dokumentation von bereits erfolgten oder laufenden Aktivitäten verwendet werden."
// Beschreibungen
* id
  * ^short = "Eindeutige ID zur Referenzierung zwischen Elementen"
  * ^definition = "Eindeutige ID für das Element innerhalb einer Ressource (für interne Verweise). Dies kann jeder beliebige Zeichenfolgenwert sein, der keine Leerzeichen enthält."
  * ^comment = "tbd"

* extension
  * ^short = "Zusätzlicher Inhalt, der von Implementierungen definiert wird"
  * ^definition = "Kann verwendet werden, um zusätzliche Informationen darzustellen, die nicht Teil der Basisdefinition des Elements sind. Um die Verwendung von Erweiterungen sicher und handhabbar zu machen, gibt es einen strikten Governance-Prozess für die Definition und Verwendung von Erweiterungen. Obwohl jeder Implementierer eine Erweiterung definieren kann, gibt es Anforderungen, die im Rahmen der Definition der Erweiterung erfüllt werden MÜSSEN."
  * ^comment = "Es darf kein Stigma mit der Verwendung von Erweiterungen durch eine beliebige Anwendung, ein Projekt oder einen Standard verbunden sein - unabhängig von der Institution oder Gerichtsbarkeit, die die Erweiterungen verwendet oder definiert. Die Verwendung von Erweiterungen ermöglicht es der FHIR-Spezifikation, für alle einen einfachen Kern beizubehalten."

* modifierExtension
  * ^short = "Erweiterungen, die nicht ignoriert werden dürfen, selbst wenn sie nicht erkannt werden"
  * ^definition = "Kann verwendet werden, um zusätzliche Informationen darzustellen, die nicht Teil der Basisdefinition des Elements sind und das Verständnis des Elements, in dem sie enthalten sind, und/oder das Verständnis der Nachkommen des enthaltenen Elements modifizieren. In der Regel bieten Modifizierer-Elemente Negationen oder Qualifikationen. Um die Verwendung von Erweiterungen sicher und handhabbar zu machen, gibt es einen strikten Governance-Prozess für die Definition und Verwendung von Erweiterungen. Obwohl jeder Implementierer eine Erweiterung definieren kann, gibt es Anforderungen, die im Rahmen der Definition der Erweiterung erfüllt werden MÜSSEN. Anwendungen, die eine Ressource verarbeiten, müssen auf Modifizierer-Erweiterungen prüfen. Modifizierer-Erweiterungen DÜRFEN NICHT die Bedeutung von Elementen auf Resource oder DomainResource ändern (einschließlich der Bedeutung von modifierExtension selbst)."
  * ^comment = "Es darf kein Stigma mit der Verwendung von Erweiterungen durch eine beliebige Anwendung, ein Projekt oder einen Standard verbunden sein - unabhängig von der Institution oder Gerichtsbarkeit, die die Erweiterungen verwendet oder definiert. Die Verwendung von Erweiterungen ermöglicht es der FHIR-Spezifikation, für alle einen einfachen Kern beizubehalten."

* event
  * ^short = "Wann das Ereignis eintritt"
  * ^definition = "Gibt bestimmte Zeitpunkte an, zu denen das Ereignis eintritt."
  * ^comment = "tbd"

* repeat
  * ^short = "Wann das Ereignis stattfinden soll"
  * ^definition = "Eine Menge von Regeln, die beschreiben, wann das Ereignis geplant ist."
  * ^comment = "tbd"

* repeat.id
  * ^short = "Eindeutige ID zur Referenzierung zwischen Elementen"
  * ^definition = "Eindeutige ID für das Element innerhalb einer Ressource (für interne Verweise). Dies kann jeder beliebige Zeichenfolgenwert sein, der keine Leerzeichen enthält."
  * ^comment = "tbd"

* repeat.extension
  * ^short = "Zusätzlicher Inhalt, der von Implementierungen definiert wird"
  * ^definition = "Kann verwendet werden, um zusätzliche Informationen darzustellen, die nicht Teil der Basisdefinition des Elements sind. Um die Verwendung von Erweiterungen sicher und handhabbar zu machen, gibt es einen strikten Governance-Prozess für die Definition und Verwendung von Erweiterungen. Obwohl jeder Implementierer eine Erweiterung definieren kann, gibt es Anforderungen, die im Rahmen der Definition der Erweiterung erfüllt werden MÜSSEN."
  * ^comment = "Es darf kein Stigma mit der Verwendung von Erweiterungen durch eine beliebige Anwendung, ein Projekt oder einen Standard verbunden sein - unabhängig von der Institution oder Gerichtsbarkeit, die die Erweiterungen verwendet oder definiert. Die Verwendung von Erweiterungen ermöglicht es der FHIR-Spezifikation, für alle einen einfachen Kern beizubehalten."

* repeat.bounds[x]
  * ^short = "Länge/Bereich der Längen oder (Start- und/oder End-)Grenzen"
  * ^definition = "Entweder eine Dauer für die Länge des Zeitplans, ein Bereich möglicher Längen oder äußere Begrenzungen für Start- und/oder Endgrenzen des Zeitplans."
  * ^comment = "tbd"

* repeat.boundsDuration MS
  * ^short = "Dauer der Dosieranweisung ausgedrückt in UCUM-Einheiten"
  * ^definition = "Entweder eine Dauer für die Länge des Zeitplans, ein Bereich möglicher Längen oder äußere Begrenzungen für Start- und/oder Endgrenzen des Zeitplans."
  * system = $ucum

* repeat.count
  * ^short = "Anzahl der Wiederholungen"
  * ^definition = "Gesamtanzahl der gewünschten Wiederholungen über die gesamte Dauer des Zeitplans. Falls countMax vorhanden ist, gibt dieses Element die Untergrenze des zulässigen Bereichs der Wiederholungsanzahl an."
  * ^comment = "Wenn sowohl Grenzen als auch Anzahl angegeben sind, sollte dies so verstanden werden, dass innerhalb des Zeitraums bis zu count-mal wiederholt wird."

* repeat.countMax
  * ^short = "Maximale Anzahl der Wiederholungen"
  * ^definition = "Falls vorhanden, zeigt dies an, dass die Anzahl ein Bereich ist - also die Aktion zwischen count und countMax Mal auszuführen ist."
  * ^comment = "tbd"

* repeat.duration
  * ^short = "Wie lange, wenn es passiert"
  * ^definition = "Wie lange dieses Ereignis jeweils andauert. Falls durationMax vorhanden ist, gibt dieses Element die Untergrenze des zulässigen Bereichs der Dauer an."
  * ^comment = "Für manche Ereignisse ist die Dauer Teil der Ereignisdefinition (z. B. Infusionen, bei denen die Dauer durch die angegebene Menge und Rate implizit ist). Für andere ist es Teil der Timing-Spezifikation (z. B. Sport)."

* repeat.durationMax
  * ^short = "Wie lange, wenn es passiert (Max)"
  * ^definition = "Falls vorhanden, zeigt dies an, dass die Dauer ein Bereich ist - also die Aktion zwischen duration und durationMax Zeitlänge auszuführen ist."
  * ^comment = "Für manche Ereignisse ist die Dauer Teil der Ereignisdefinition (z. B. Infusionen, bei denen die Dauer durch die angegebene Menge und Rate implizit ist). Für andere ist es Teil der Timing-Spezifikation (z. B. Sport)."

* repeat.durationUnit
  * ^short = "s | min | h | d | wk | mo | a - Zeiteinheit (UCUM)"
  * ^definition = "Die Zeiteinheit für die Dauer, in UCUM-Einheiten."
  * ^comment = "tbd"

* repeat.frequency
  * ^short = "Ereignis tritt frequency-mal pro Zeitraum auf"
  * ^definition = "Die Anzahl der Wiederholungen innerhalb des angegebenen Zeitraums. Falls frequencyMax vorhanden ist, gibt dieses Element die Untergrenze des zulässigen Bereichs der Häufigkeit an."
  * ^comment = "tbd"

* repeat.frequencyMax
  * ^short = "Ereignis tritt bis zu frequencyMax-mal pro Zeitraum auf"
  * ^definition = "Falls vorhanden, zeigt dies an, dass die Häufigkeit ein Bereich ist - also zwischen frequency und frequencyMax Mal pro Zeitraum oder Zeitraumspanne wiederholt wird."
  * ^comment = "tbd"

* repeat.period
  * ^short = "Ereignis tritt frequency-mal pro Zeitraum auf"
  * ^definition = "Gibt die Zeitspanne an, über die die Wiederholungen stattfinden sollen; z. B. um „3-mal täglich“ auszudrücken, wäre 3 die Häufigkeit und „1 Tag“ der Zeitraum. Falls periodMax vorhanden ist, gibt dieses Element die Untergrenze des zulässigen Bereichs der Zeitspanne an."
  * ^comment = "tbd"

* repeat.periodMax
  * ^short = "Obergrenze des Zeitraums (z. B. 3-4 Stunden)"
  * ^definition = "Falls vorhanden, zeigt dies an, dass der Zeitraum ein Bereich von period bis periodMax ist, was z. B. Konzepte wie „einmal alle 3-5 Tage“ ausdrücken kann."
  * ^comment = "tbd"

* repeat.periodUnit
  * ^short = "s | min | h | d | wk | mo | a - Zeiteinheit (UCUM)"
  * ^definition = "Die Zeiteinheit für den Zeitraum, in UCUM-Einheiten."
  * ^comment = "tbd"

* repeat.dayOfWeek
  * ^short = "mon | tue | wed | thu | fri | sat | sun"
  * ^definition = "Wenn ein oder mehrere Wochentage angegeben sind, findet die Aktion nur an den angegebenen Tagen statt."
  * ^comment = "Wenn keine Tage angegeben sind, wird angenommen, dass die Aktion an jedem Tag wie sonst angegeben stattfindet. Die Elemente frequency und period können nicht zusammen mit dayOfWeek verwendet werden."

* repeat.timeOfDay
  * ^short = "Tageszeit für die Aktion"
  * ^definition = "Angegebene Tageszeit, zu der die Aktion stattfinden soll."
  * ^comment = "Wenn eine Tageszeit angegeben ist, wird angenommen, dass die Aktion jeden Tag (ggf. gefiltert durch dayOfWeek) zu den angegebenen Zeiten stattfindet. Die Elemente when, frequency und period können nicht zusammen mit timeOfDay verwendet werden."

* repeat.when
  * ^short = "Code für den Zeitraum des Auftretens"
  * ^definition = "Ein ungefährer Zeitraum während des Tages, der möglicherweise mit einem Ereignis des täglichen Lebens verknüpft ist und angibt, wann die Aktion stattfinden soll."
  * ^comment = "Wenn mehr als ein Ereignis angegeben ist, bezieht sich das Ereignis auf die Vereinigung der angegebenen Ereignisse."

* repeat.offset
  * ^short = "Minuten vom Ereignis (vorher oder nachher)"
  * ^definition = "Die Anzahl der Minuten vom Ereignis. Wenn der Ereigniscode nicht angibt, ob die Minuten vor oder nach dem Ereignis liegen, wird angenommen, dass der Offset nach dem Ereignis ist."
  * ^comment = "tbd"

* code
  * ^short = "BID | TID | QID | AM | PM | QD | QOD | +"
  * ^definition = "Ein Code für den Zeitplan (oder nur Text in code.text). Einige Codes wie BID sind weit verbreitet, aber viele Institutionen definieren eigene zusätzliche Codes. Wenn ein Code angegeben ist, wird er als vollständige Aussage dessen verstanden, was in den strukturierten Timing-Daten angegeben ist, und entweder der Code oder die Daten können zur Interpretation des Timings verwendet werden, mit der Ausnahme, dass .repeat.bounds weiterhin für den Code gilt (und nicht im Code enthalten ist)."
  * ^comment = "BID usw. sind als „zu institutionell festgelegten Zeiten“ definiert. Zum Beispiel kann eine Institution festlegen, dass BID immer um 7 Uhr und 18 Uhr ist. Wenn es nicht angebracht ist, dass diese Wahl getroffen wird, sollte der Code BID nicht verwendet werden. Stattdessen sollte ein spezifischer, organisationsspezifischer Code anstelle des HL7-definierten BID-Codes verwendet und/oder eine strukturierte Darstellung genutzt werden (in diesem Fall mit Angabe der beiden Ereigniszeiten)."