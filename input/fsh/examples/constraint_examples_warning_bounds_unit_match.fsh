// Warning examples for TimingBoundsUnitMatchesCodeWarning
// boundsDuration.code and boundsDuration.unit contradict each other.
// Allowed as a warning in DE, error in dgMP.

Instance: W-TimingBoundsUnitMatchesCodeWarning-Request-01-of-03
InstanceOf: MedicationRequestDE
Usage: #example
Title: "Warning (Request): boundsDuration unit/code mismatch"
Description: "Warning example - boundsDuration.code 'wk' mit unit 'Tag(e)'."
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

Instance: W-TimingBoundsUnitMatchesCodeWarning-Dispense-02-of-03
InstanceOf: MedicationDispenseDE
Usage: #example
Title: "Warning (Dispense): boundsDuration unit/code mismatch"
Description: "Warning example - boundsDuration.code 'wk' mit unit 'Tag(e)'."
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

Instance: W-TimingBoundsUnitMatchesCodeWarning-Statement-03-of-03
InstanceOf: MedicationStatementDE
Usage: #example
Title: "Warning (Statement): boundsDuration unit/code mismatch"
Description: "Warning example - boundsDuration.code 'wk' mit unit 'Tag(e)'."
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
