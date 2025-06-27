# Erstellen und Auswerten mehrerer Dosierungen

Folgende FHIR Ressourcen unterstützen die Angabe von Dosierungen:
- [MedicationRequest](https://hl7.org/fhir/R4/medicationrequest.html)
- [MedicationDispense](https://hl7.org/fhir/R4/medicationdispense.html)
- [MedicationStatement](https://hl7.org/fhir/R4/medicationstatement.html)
- [ActivityDefinition](https://hl7.org/fhir/R4/activitydefinition.html)
- [MedicationKnowledge](https://hl7.org/fhir/R4/medicationknowledge.html)

Diese Ressourcen ermöglichen die *mehrfache* Angabe einer [FHIR Ressource Dosage](https://hl7.org/fhir/R4/dosage.html) (..*).

Eine Dosage-Instanz kann dabei nur ein Timing Objekt und eine Angabe der Dosierung tragen. Daher kann für eine Art der Dosierung (z.B. 1 Tablette) das Timing variabel definiert werden. Unterschiedliche Dosierungen erzeugen jeweils eine eigene Dosage Instanz.

## Verschiedene Dosierungen

Beispiele:
- 1-0-1-0 kann in einer Dosage Instanz mit ´timing.repeat.when= MORN, EVE´ und ´doseAndRate.doseQuantity = 1 Tablette´ angegeben werden
- 1-0-2-0 benötigt zwei Dosage Instanzen:
  - erste Dosage Instanz: ´timing.repeat.when= MORN und ´doseAndRate.doseQuantity = 1 Tablette´
  - zweite Dosage Instanz: ´timing.repeat.when= EVE und ´doseAndRate.doseQuantity = 2 Tabletten´

## Einheitliche Dosierungen

Für eine Dosierung (z.B. 1 Tablette) kann jedoch ein komplexes Zeitschema angegeben werden, wenn zu jedem der eintretenden Zeitpunkte diese Dosierung einzunehmen ist.

Beispiel:
- 1 Tablette Montags, Mittwochs, Samstags jeweils 08:00 und 20:00:
  - ´doseAndRate.doseQuantity = 1 Tablette´
  - ´timing.repeat.dayOfWeek = mon, wed, sat´
  - ´timing.repeat.timeOfDay = 08:00:00, 20:00:00´

wird in der selben Dosage Instanz abgebildet.