// Warning examples for DosageDoseUnitMatchesCodeWarning
// The dose unit is not the display of its KBV code.
// Allowed as a warning in DE, error in dgMP.

Instance: W-DosageDoseUnitMatchesCodeWarning-Request-01-of-03
InstanceOf: MedicationRequestDE
Usage: #example
Title: "Warning (Request): dose unit does not match the code"
Description: "Warning example - doseQuantity.code '1' (Stück) mit unit 'Tablette'."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.when = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Tablette"

Instance: W-DosageDoseUnitMatchesCodeWarning-Dispense-02-of-03
InstanceOf: MedicationDispenseDE
Usage: #example
Title: "Warning (Dispense): dose unit does not match the code"
Description: "Warning example - doseQuantity.code '1' (Stück) mit unit 'Tablette'."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.when = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Tablette"

Instance: W-DosageDoseUnitMatchesCodeWarning-Statement-03-of-03
InstanceOf: MedicationStatementDE
Usage: #example
Title: "Warning (Statement): dose unit does not match the code"
Description: "Warning example - doseQuantity.code '1' (Stück) mit unit 'Tablette'."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat.when = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Tablette"
