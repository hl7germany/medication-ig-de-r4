// Invalid example for FreeTextSingleDosageOnly: multiple Dosage entries with pure free text
Instance: Invalid-Dosage-C-FreeTextSingleDosageOnly-01-of-01
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid Dosage - FreeText must be single"
Description: "Invalid: Freitextdosierung vorhanden, aber mehr als ein Dosage-Element vorhanden."
* insert InsertMandatoryExStubs
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Test Medication"
* dosageInstruction[+]
  * text = "Morgens je 1 Tablette"
* dosageInstruction[+]
  * text = "Abends je 1 Tablette"

