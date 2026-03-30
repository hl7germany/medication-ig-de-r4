// Invalid example for FreeTextSingleDosageOnly: multiple Dosage entries with pure free text
Instance: INV-C-FreeTextSingleDosageOnly-Request-01-of-01
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid Dosage - FreeText must be single"
Description: "Invalid: Freitextdosierung vorhanden, aber mehr als ein Dosage-Element vorhanden."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Test Medication"
* dosageInstruction[+]
  * text = "Morgens je 1 Tablette"
* dosageInstruction[+]
  * text = "Abends je 1 Tablette"

Instance: INV-C-FreeTextSingleDosageOnly-Dispense-01-of-01
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid Dosage - FreeText must be single"
Description: "Invalid: Freitextdosierung vorhanden, aber mehr als ein Dosage-Element vorhanden."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Test Medication"
* dosageInstruction[+]
  * text = "Morgens je 1 Tablette"
* dosageInstruction[+]
  * text = "Abends je 1 Tablette"

Instance: INV-C-FreeTextSingleDosageOnly-Statement-01-of-01
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid Dosage - FreeText must be single"
Description: "Invalid: Freitextdosierung vorhanden, aber mehr als ein Dosage-Element vorhanden."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Test Medication"
* dosage[+]
  * text = "Morgens je 1 Tablette"
* dosage[+]
  * text = "Abends je 1 Tablette"

