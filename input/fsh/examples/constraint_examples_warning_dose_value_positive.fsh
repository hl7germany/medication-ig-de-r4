// Warning examples for DosageDoseValuePositiveWarning in the generic DE profiles.
// The dgMP profiles tighten the same rule through DosageDoseValuePositive.

Instance: W-DosageDoseValuePositiveWarning-01-of-05
InstanceOf: MedicationRequestDE
Usage: #example
Title: "Warning (Request): negative doseQuantity.value"
Description: "Warning example - doseQuantity.value should be greater than 0."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.when = #MORN
  * doseAndRate.doseQuantity = -1 $kbv-dosiereinheit#1 "Stück"

Instance: W-DosageDoseValuePositiveWarning-02-of-05
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

Instance: W-DosageDoseValuePositiveWarning-03-of-05
InstanceOf: MedicationStatementDE
Usage: #example
Title: "Warning (Statement): negative doseRange.high.value"
Description: "Warning example - doseRange.high.value should be greater than 0."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat.when = #MORN
  * doseAndRate.doseRange.high = -1 $kbv-dosiereinheit#1 "Stück"

Instance: W-DosageDoseValuePositiveWarning-04-of-05
InstanceOf: MedicationRequestDE
Usage: #example
Title: "Warning (Request): doseQuantity.value is 0"
Description: "Warning example - a single dose of 0 does not describe an administrable amount."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.when = #MORN
  * doseAndRate.doseQuantity = 0 $kbv-dosiereinheit#1 "Stück"

Instance: W-DosageDoseValuePositiveWarning-05-of-05
InstanceOf: MedicationDispenseDE
Usage: #example
Title: "Warning (Dispense): doseRange.high.value is 0"
Description: "Warning example - an upper bound of 0 does not describe an administrable amount, even though 0 is allowed as the lower bound."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.when = #MORN
  * doseAndRate.doseRange
    * low = 0 $kbv-dosiereinheit#1 "Stück"
    * high = 0 $kbv-dosiereinheit#1 "Stück"
