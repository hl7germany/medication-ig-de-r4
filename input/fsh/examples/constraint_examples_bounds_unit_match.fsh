// Examples for TimingBoundsUnitMatchesCode constraint

Instance: Valid-Dosage-C-TimingBoundsUnitMatchesCode-01-of-02
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Valid boundsDuration unit/code match"
Description: "boundsDuration.code 'wk' with unit 'Woche(n)'"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * frequency = 1
    * period = 2
    * periodUnit = #d
    * boundsDuration = 3 $ucum#wk "Woche(n)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: Invalid-Dosage-C-TimingBoundsUnitMatchesCode-02-of-02
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid boundsDuration unit/code mismatch"
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

