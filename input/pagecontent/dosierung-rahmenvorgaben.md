Diese Seite beschreibt fachliche Aspekte und Entscheidungen zur Handhabung von strukturierten Dosierungen.

## Nutzung des Feldes `.text`

Die textuelle Angabe von Dosierungen wird im Dosierungsusecase in zwei Varianten unterschieden:
- Vom Menschen beschriebene Dosierung (Freitext)
- Automatisch aus der strukturierten Angabe generierte textuelle Repräsentation

Es wird empfohlen, Dosierungsangaben strukturiert zu erfassen, sofern eine strukturierte Abbildung möglich ist. Eine Freitext-Erfassung in Dosage.text sollte vermieden werden. Systeme sollen dazu geeignete Eingabemasken bereitstellen, um die strukturierte Erfassung zu unterstützen.

Das Feld `Dosage.text` wird für vom Menschen erstellten Freitext vorgesehen. Es soll nicht gleichzeitig mit einer strukturierten Angabe verwendet werden, um widersprüchliche Informationen zu vermeiden.

Die Extension [GeneratedDosageInstructions](./StructureDefinition-GeneratedDosageInstructions.html) dient der Speicherung von Dosieranweisungen, die automatisch aus strukturierten Dosierangaben generiert wurden.

## Verwendung des Dosage Elements


- **Konstante Dosierung:** Bei gleichbleibender Dosierungsstärke innerhalb eines Schemas ist eine einzige `Dosage`-Instanz ausreichend.
- **Variable Dosierung:** Wechselt die Dosierungsstärke (z.B. morgens 1 Stück, abends 2 Stück), muss für jede Dosierungsvariation eine separate `Dosage`-Instanz erstellt werden.

Folgende FHIR Ressourcen unterstützen die Angabe von Dosierungen:
- [MedicationRequest](https://hl7.org/fhir/R4/medicationrequest.html)
- [MedicationDispense](https://hl7.org/fhir/R4/medicationdispense.html)
- [MedicationStatement](https://hl7.org/fhir/R4/medicationstatement.html)
- [ActivityDefinition](https://hl7.org/fhir/R4/activitydefinition.html)
- [MedicationKnowledge](https://hl7.org/fhir/R4/medicationknowledge.html)

Diese Ressourcen ermöglichen die *mehrfache* Angabe einer [FHIR Ressource Dosage](https://hl7.org/fhir/R4/dosage.html) (..*).

Eine Dosage-Instanz kann dabei nur ein Timing Objekt und eine Angabe der Dosierung tragen. Daher kann für eine Art der Dosierung (z.B. 1 Stück) das Timing variabel definiert werden. Unterschiedliche Dosierungen erzeugen jeweils eine eigene Dosage Instanz.

**Beispiele:**

- 1-0-1-0 soll in einer Dosage Instanz mit `timing.repeat.when = MORN, EVE` und `doseAndRate.doseQuantity = 1 Stück` angegeben werden
- 1-0-2-0 benötigt zwei Dosage Instanzen:
  - erste Dosage Instanz: `timing.repeat.when = MORN` und `doseAndRate.doseQuantity = 1 Stück`
  - zweite Dosage Instanz: `timing.repeat.when = EVE` und `doseAndRate.doseQuantity = 2 Stück`

Für eine Dosierung (z.B. 1 Stück) kann ein komplexes Zeitschema angegeben werden, wenn zu jedem der eintretenden Zeitpunkte diese Dosierung einzunehmen ist.

- 1 Stück Montags, Mittwochs, Samstags jeweils 08:00 und 20:00:
  - `doseAndRate.doseQuantity = 1 Stück`
  - `timing.repeat.dayOfWeek = mon, wed, sat`
  - `timing.repeat.timeOfDay = 08:00:00, 20:00:00`

wird in der selben Dosage Instanz abgebildet.

## Strukturierte Angabe der Einheit

Für die Berechnung der Reichweite einer Medikation ist es erforderlich, dass Dosierungseinheiten (z.B. „1 Stück“) strukturiert und semantisch kodiert angegeben werden. Hierfür wurde das  ValueSet `DosageDoseQuantityDEVS` erstellt.