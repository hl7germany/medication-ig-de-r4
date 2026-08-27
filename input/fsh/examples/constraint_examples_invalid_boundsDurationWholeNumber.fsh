// MedicationRequest

Instance: INV-C-TimingBoundsDurationOnlyWholeNumber-MR-01-of-02
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid Dosage"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for invalid Permutations"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d
    * boundsDuration = 1.5 $ucum#d "Tag(e)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-TimingBoundsDurationOnlyWholeNumber-MR-02-of-02
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid Dosage"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for invalid Permutations"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d
    * boundsDuration = 1.000000001 $ucum#d "Tag(e)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

// MedicationDispense

Instance: INV-C-TimingBoundsDurationOnlyWholeNumber-MD-01-of-02
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid Dosage"
Description: "CAVE: This MedicationDispense is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for invalid Permutations"
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d
    * boundsDuration = 1.5 $ucum#d "Tag(e)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-TimingBoundsDurationOnlyWholeNumber-MD-02-of-02
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid Dosage"
Description: "CAVE: This MedicationDispense is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for invalid Permutations"
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d
    * boundsDuration = 1.000000001 $ucum#d "Tag(e)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

// MedicationStatement

Instance: INV-C-TimingBoundsDurationOnlyWholeNumber-MS-01-of-02
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid Dosage"
Description: "CAVE: This MedicationStatement is for validation purposes and does NOT represent a valid dosage. It only checks for invalid Permutations"
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d
    * boundsDuration = 1.5 $ucum#d "Tag(e)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-TimingBoundsDurationOnlyWholeNumber-MS-02-of-02
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid Dosage"
Description: "CAVE: This MedicationStatement is for validation purposes and does NOT represent a valid dosage. It only checks for invalid Permutations"
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d
    * boundsDuration = 1.000000001 $ucum#d "Tag(e)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
