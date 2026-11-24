// Warnings for 2.0.0 rules on fractions, decimal notation and whole numbers (errors in 2.0.0, warnings in 1.0.8)

Instance: W-DosageDoseQuantityAllowedFractionsWarning-MR-01-of-03
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Warning (Request): dose 1.2"
Description: "doseQuantity.value 1.2 (Bruchteil .2)"
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
  * doseAndRate.doseQuantity = 1.2 $kbv-dosiereinheit#1 "Stück"

Instance: W-DosageDoseQuantityAllowedFractionsWarning-MD-02-of-03
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Warning (Dispense): dose 1.2"
Description: "doseQuantity.value 1.2 (Bruchteil .2)"
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d
    * when = #MORN
  * doseAndRate.doseQuantity = 1.2 $kbv-dosiereinheit#1 "Stück"

Instance: W-DosageDoseQuantityAllowedFractionsWarning-MS-03-of-03
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Warning (Statement): dose 1.2"
Description: "doseQuantity.value 1.2 (Bruchteil .2)"
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d
    * when = #MORN
  * doseAndRate.doseQuantity = 1.2 $kbv-dosiereinheit#1 "Stück"

Instance: W-DosageDoseValueDecimalNotationWarning-MR-01-of-03
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Warning (Request): dose with four decimal places"
Description: "doseQuantity.value 0.0625 (vier Nachkommastellen; Bruchteil .0625 löst zusätzlich DosageDoseQuantityAllowedFractionsWarning aus)"
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
  * doseAndRate.doseQuantity = 0.0625 $kbv-dosiereinheit#1 "Stück"

Instance: W-DosageDoseValueDecimalNotationWarning-MD-02-of-03
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Warning (Dispense): dose with four decimal places"
Description: "doseQuantity.value 0.0625 (vier Nachkommastellen; Bruchteil .0625 löst zusätzlich DosageDoseQuantityAllowedFractionsWarning aus)"
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d
    * when = #MORN
  * doseAndRate.doseQuantity = 0.0625 $kbv-dosiereinheit#1 "Stück"

Instance: W-DosageDoseValueDecimalNotationWarning-MS-03-of-03
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Warning (Statement): dose with four decimal places"
Description: "doseQuantity.value 0.0625 (vier Nachkommastellen; Bruchteil .0625 löst zusätzlich DosageDoseQuantityAllowedFractionsWarning aus)"
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d
    * when = #MORN
  * doseAndRate.doseQuantity = 0.0625 $kbv-dosiereinheit#1 "Stück"

Instance: W-TimingPeriodOnlyWholeNumberWarning-MR-01-of-03
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Warning (Request): period 1.5 d"
Description: "period 1.5 d"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * frequency = 1
    * period = 1.5
    * periodUnit = #d
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: W-TimingPeriodOnlyWholeNumberWarning-MD-02-of-03
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Warning (Dispense): period 1.5 d"
Description: "period 1.5 d"
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * frequency = 1
    * period = 1.5
    * periodUnit = #d
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: W-TimingPeriodOnlyWholeNumberWarning-MS-03-of-03
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Warning (Statement): period 1.5 d"
Description: "period 1.5 d"
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat
    * frequency = 1
    * period = 1.5
    * periodUnit = #d
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: W-TimingBoundsDurationOnlyWholeNumberWarning-MR-01-of-03
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Warning (Request): duration 1.5 d"
Description: "boundsDuration.value 1.5 d"
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
    * boundsDuration = 1.5 $ucum#d "Tag(e)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: W-TimingBoundsDurationOnlyWholeNumberWarning-MD-02-of-03
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Warning (Dispense): duration 1.5 d"
Description: "boundsDuration.value 1.5 d"
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d
    * when = #MORN
    * boundsDuration = 1.5 $ucum#d "Tag(e)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: W-TimingBoundsDurationOnlyWholeNumberWarning-MS-03-of-03
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Warning (Statement): duration 1.5 d"
Description: "boundsDuration.value 1.5 d"
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d
    * when = #MORN
    * boundsDuration = 1.5 $ucum#d "Tag(e)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
