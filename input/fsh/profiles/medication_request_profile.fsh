Profile: MedicationRequestDgMP
Parent: MedicationRequest
Id: MedicationRequestDgMP
Title: "MedicationRequest zur Nutzung von Dosierungen für dgMP"
Description: "Dieses Profil enthält eine Referenz der dosageInstruction auf das Dosierungsprofil für den Kontext dgMP"

* dosageInstruction only DosageDgMP
  * ^short = "Angabe der Dosierinformationen strukturiert oder als Freiteixt"
  * ^definition = """
## Dosierangaben
TODO
In der aktuellen Ausbaustufe der Dosierangaben sind fünf Kategorien von Dosierangaben erlaubt:
1. Freitextdosierung
2. Dosierangabe nach 4-er Schema
3. Dosierangabe nach Uhrzeit
4. Dosierangabe nach Interval
5. Dosierangabe nach Wochentag
6. Dosierangabe nach Wochentag und Uhrzeit/4-Schema
7. Dosierangabe nach Interval und Uhrzeit/4-Schema

Für eine ausführliche Diskussion der Kategorien und Profilierung siehe DOSAGE_IG[link]

### Profilierungen
Die Dosierungen sind so profiliert, dass für jede Kategorie ein entsprechendes Profil zur Verfügung steht, welches die Angabe der Dosierung nach den fachlichen Vorgaben ermöglicht.
Für jeden Zeitpunkt einer Dosierung muss eine Dosage Instanz erstellt werden. So werden bspw. für das Schema 1-1-1-0 drei DosageInstanzen benötigt, die jeweils die einzunehmende Menge, sowie den Einnahmepunkt definieren.
Durch Constraints wird durchgesetzt, dass in einem MedicationRequest nur jeweils ein Schema verwendet werden darf, d.h. eine Mischung wie '1-0-0-0 und 20:00' ist nicht erlaubt.

### Freitext
Es ist möglich die Dosierinformationen als Freitext unter dosageInstruction.text anzugeben. Dann darf keine strukturierte Anweisung vorliegen und vice versa.
  """

