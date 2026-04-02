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

Instance: INV-C-TimingBoundsUnitMatchesCode-Request-04-of-06
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid (Request): boundsDuration day code with week unit"
Description: "boundsDuration.code 'd' with unit 'Woche(n)'"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d
    * boundsDuration = 5 $ucum#d "Woche(n)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-TimingBoundsUnitMatchesCode-Dispense-05-of-06
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid (Dispense): boundsDuration month code with year unit"
Description: "boundsDuration.code 'mo' with unit 'Jahr(e)'"
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d
    * boundsDuration = 2 $ucum#mo "Jahr(e)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-TimingBoundsUnitMatchesCode-Statement-06-of-06
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid (Statement): boundsDuration year code with month unit"
Description: "boundsDuration.code 'a' with unit 'Monat(e)'"
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d
    * boundsDuration = 1 $ucum#a "Monat(e)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
