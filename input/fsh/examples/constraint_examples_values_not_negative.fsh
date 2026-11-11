// Examples for the 1.0.8 value checks: negative values are errors, 0 is a warning.

Instance: INV-C-DosageDoseValueNotNegative-Request-01-of-03
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid (Request): negative dose"
Description: "doseQuantity.value -1"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d
    * when = #MORN
  * doseAndRate.doseQuantity = -1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-DosageDoseValueNotNegative-Dispense-02-of-03
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid (Dispense): negative dose"
Description: "doseQuantity.value -1"
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d
    * when = #MORN
  * doseAndRate.doseQuantity = -1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-DosageDoseValueNotNegative-Statement-03-of-03
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid (Statement): negative dose"
Description: "doseQuantity.value -1"
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d
    * when = #MORN
  * doseAndRate.doseQuantity = -1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-TimingBoundsDurationNotNegative-Request-01-of-03
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid (Request): negative duration"
Description: "boundsDuration.value -3 d"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d
    * when = #MORN
    * boundsDuration = -3 $ucum#d "Tag(e)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-TimingBoundsDurationNotNegative-Dispense-02-of-03
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid (Dispense): negative duration"
Description: "boundsDuration.value -3 d"
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d
    * when = #MORN
    * boundsDuration = -3 $ucum#d "Tag(e)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-TimingBoundsDurationNotNegative-Statement-03-of-03
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid (Statement): negative duration"
Description: "boundsDuration.value -3 d"
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d
    * when = #MORN
    * boundsDuration = -3 $ucum#d "Tag(e)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: Dosage-W-DosageDoseValueZeroWarning-Request-01-of-03
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Warning (Request): dose 0"
Description: "doseQuantity.value 0"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d
    * when = #MORN
  * doseAndRate.doseQuantity = 0 $kbv-dosiereinheit#1 "Stück"

Instance: Dosage-W-DosageDoseValueZeroWarning-Dispense-02-of-03
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Warning (Dispense): dose 0"
Description: "doseQuantity.value 0"
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d
    * when = #MORN
  * doseAndRate.doseQuantity = 0 $kbv-dosiereinheit#1 "Stück"

Instance: Dosage-W-DosageDoseValueZeroWarning-Statement-03-of-03
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Warning (Statement): dose 0"
Description: "doseQuantity.value 0"
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d
    * when = #MORN
  * doseAndRate.doseQuantity = 0 $kbv-dosiereinheit#1 "Stück"

Instance: Dosage-W-TimingValuesZeroWarning-Request-01-of-03
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Warning (Request): duration 0"
Description: "boundsDuration.value 0 d"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d
    * when = #MORN
    * boundsDuration = 0 $ucum#d "Tag(e)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: Dosage-W-TimingValuesZeroWarning-Dispense-02-of-03
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Warning (Dispense): duration 0"
Description: "boundsDuration.value 0 d"
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d
    * when = #MORN
    * boundsDuration = 0 $ucum#d "Tag(e)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: Dosage-W-TimingValuesZeroWarning-Statement-03-of-03
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Warning (Statement): duration 0"
Description: "boundsDuration.value 0 d"
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d
    * when = #MORN
    * boundsDuration = 0 $ucum#d "Tag(e)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
