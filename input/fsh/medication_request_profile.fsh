Profile: DE_DOSAGE_MEDICATIONREQUEST
Parent: MedicationRequest
Id: de-dosage-medicationrequest
Title: "DE DOSAGE MEDICATIONREQUEST"
* obeys medication-request-dosage-only-one-kind
* dosageInstruction only DE_DOSAGE
  * ^short = "Angabe der Dosierinformationen strukturiert oder als Freiteixt"
  * ^definition = """
## Dosierangaben
In der aktuellen Ausbaustufe der Dosierangaben sind fünf Kategorien von Dosierangaben erlaubt:
1. Freitextdosierung
2. Dosierangabe nach 4-er Schema
3. Dosierangabe nach Uhrzeit
4. Dosierangabe nach Interval
5. Dosierangabe nach Wochentag

Für eine ausführliche Diskussion der Kategorien und Profilierung siehe DOSAGE_IG[link]

### Profilierungen
Die Dosierungen sind so profiliert, dass für jede Kategorie ein entsprechendes Profil zur Verfügung steht, welches die Angabe der Dosierung nach den fachlichen Vorgaben ermöglicht.
Für jeden Zeitpunkt einer Dosierung muss eine Dosage Instanz erstellt werden. So werden bspw. für das Schema 1-1-1-0 drei DosageInstanzen benötigt, die jeweils die einzunehmende Menge, sowie den Einnahmepunkt definieren.
Durch Constraints wird durchgesetzt, dass in einem MedicationRequest nur jeweils ein Schema verwendet werden darf, d.h. eine Mischung wie '1-0-0-0 und 20:00' ist nicht erlaubt.

### Freitext
Es ist möglich die Dosierinformationen als Freitext unter dosageInstruction.text anzugeben. Dann darf keine strukturierte Anweisung vorliegen und vice versa.
  """

Invariant: medication-request-dosage-only-one-kind
Description: "Only one kind of dosage is allowed"
Expression: "dosageInstruction.extension.where(url = 'http://de.gematik.dosage/StructureDefinition/dosage-category-ex').value.code.distinct().count() = 1"
Severity: #error

