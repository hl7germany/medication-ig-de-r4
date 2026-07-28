// Invalid examples for AsNeededSingleDosageOnly (error)
// Eine reine Bedarfsdosierung ohne timing erlaubt genau ein Dosage-Element.

Instance: INV-C-AsNeededSingleDosageOnly-Request-01-of-03
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid: multiple pure as-needed dosages"
Description: "CAVE: Validation example - the resource contains two pure as-needed dosages without timing."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * asNeededBoolean = true
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosageInstruction[+]
  * asNeededBoolean = true
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-AsNeededSingleDosageOnly-Dispense-02-of-03
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid: multiple pure as-needed dosages"
Description: "CAVE: Validation example - the resource contains two pure as-needed dosages without timing."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * asNeededBoolean = true
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosageInstruction[+]
  * asNeededBoolean = true
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-AsNeededSingleDosageOnly-Statement-03-of-03
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid: multiple pure as-needed dosages"
Description: "CAVE: Validation example - the resource contains two pure as-needed dosages without timing."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * asNeededBoolean = true
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosage[+]
  * asNeededBoolean = true
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"
