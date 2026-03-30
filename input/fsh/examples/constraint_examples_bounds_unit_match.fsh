// Examples for TimingBoundsUnitMatchesCode constraint

Instance: INV-C-TimingBoundsUnitMatchesCode-Request-01-of-03
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid (Request): boundsDuration unit/code mismatch"
Description: "boundsDuration.code 'wk' with unit 'Tag(e)'"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * frequency = 1
    * period = 2
    * periodUnit = #d
    * boundsDuration = 3 $ucum#wk "Tag(e)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-TimingBoundsUnitMatchesCode-Dispense-02-of-03
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid (Dispense): boundsDuration unit/code mismatch"
Description: "boundsDuration.code 'wk' with unit 'Tag(e)'"
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * frequency = 1
    * period = 2
    * periodUnit = #d
    * boundsDuration = 3 $ucum#wk "Tag(e)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-TimingBoundsUnitMatchesCode-Statement-03-of-03
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid (Statement): boundsDuration unit/code mismatch"
Description: "boundsDuration.code 'wk' with unit 'Tag(e)'"
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat
    * frequency = 1
    * period = 2
    * periodUnit = #d
    * boundsDuration = 3 $ucum#wk "Tag(e)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
