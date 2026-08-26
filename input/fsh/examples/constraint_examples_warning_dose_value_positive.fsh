// Warning examples for DosageDoseValuePositiveWarning in the generic DE profiles.
// The dgMP profiles tighten the same rule through DosageDoseValuePositive.

Instance: Dosage-W-DosageDoseValuePositiveWarning-01-of-03
InstanceOf: MedicationRequestDE
Usage: #example
Title: "Warning (Request): negative doseQuantity.value"
Description: "Warning example - doseQuantity.value should not be negative."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.when = #MORN
  * doseAndRate.doseQuantity = -1 $kbv-dosiereinheit#1 "Stück"

Instance: Dosage-W-DosageDoseValuePositiveWarning-02-of-03
InstanceOf: MedicationDispenseDE
Usage: #example
Title: "Warning (Dispense): negative doseRange.low.value"
Description: "Warning example - doseRange.low.value should not be negative."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.when = #MORN
  * doseAndRate.doseRange
    * low = -1 $kbv-dosiereinheit#1 "Stück"
    * high = 1 $kbv-dosiereinheit#1 "Stück"

Instance: Dosage-W-DosageDoseValuePositiveWarning-03-of-03
InstanceOf: MedicationStatementDE
Usage: #example
Title: "Warning (Statement): negative doseRange.high.value"
Description: "Warning example - doseRange.high.value should not be negative."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat.when = #MORN
  * doseAndRate.doseRange.high = -1 $kbv-dosiereinheit#1 "Stück"
