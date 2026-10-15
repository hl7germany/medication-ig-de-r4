// Invalid examples for MaxDoseNotBelowDose (error): Die Maximalmenge darf nicht kleiner als die
// Einzeldosis sein (bei doseRange: die Obergrenze).

Instance: INV-C-MaxDoseNotBelowDose-MR-01-of-06
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid (Request): doseQuantity = 2, maxDosePerPeriod = 1"
Description: "CAVE: Validation example - the maximum amount per period is smaller than the single dose."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * asNeededBoolean = true
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"
  * maxDosePerPeriod.numerator = 1 $kbv-dosiereinheit#1 "Stück"
  * maxDosePerPeriod.denominator = 24 $ucum#h "Stunde(n)"

Instance: INV-C-MaxDoseNotBelowDose-MD-02-of-06
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid (Dispense): doseQuantity = 2, maxDosePerPeriod = 1"
Description: "CAVE: Validation example - the maximum amount per period is smaller than the single dose."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * asNeededBoolean = true
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"
  * maxDosePerPeriod.numerator = 1 $kbv-dosiereinheit#1 "Stück"
  * maxDosePerPeriod.denominator = 24 $ucum#h "Stunde(n)"

Instance: INV-C-MaxDoseNotBelowDose-MS-03-of-06
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid (Statement): doseQuantity = 2, maxDosePerPeriod = 1"
Description: "CAVE: Validation example - the maximum amount per period is smaller than the single dose."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * asNeededBoolean = true
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"
  * maxDosePerPeriod.numerator = 1 $kbv-dosiereinheit#1 "Stück"
  * maxDosePerPeriod.denominator = 24 $ucum#h "Stunde(n)"

Instance: INV-C-MaxDoseNotBelowDose-MR-04-of-06
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid (Request): doseRange 1-3, maxDosePerPeriod = 2"
Description: "CAVE: Validation example - the maximum amount per period is smaller than the single dose."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * asNeededBoolean = true
  * doseAndRate.doseRange.low = 1 $kbv-dosiereinheit#1 "Stück"
  * doseAndRate.doseRange.high = 3 $kbv-dosiereinheit#1 "Stück"
  * maxDosePerPeriod.numerator = 2 $kbv-dosiereinheit#1 "Stück"
  * maxDosePerPeriod.denominator = 24 $ucum#h "Stunde(n)"

Instance: INV-C-MaxDoseNotBelowDose-MD-05-of-06
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid (Dispense): doseRange 1-3, maxDosePerPeriod = 2"
Description: "CAVE: Validation example - the maximum amount per period is smaller than the single dose."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * asNeededBoolean = true
  * doseAndRate.doseRange.low = 1 $kbv-dosiereinheit#1 "Stück"
  * doseAndRate.doseRange.high = 3 $kbv-dosiereinheit#1 "Stück"
  * maxDosePerPeriod.numerator = 2 $kbv-dosiereinheit#1 "Stück"
  * maxDosePerPeriod.denominator = 24 $ucum#h "Stunde(n)"

Instance: INV-C-MaxDoseNotBelowDose-MS-06-of-06
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid (Statement): doseRange 1-3, maxDosePerPeriod = 2"
Description: "CAVE: Validation example - the maximum amount per period is smaller than the single dose."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * asNeededBoolean = true
  * doseAndRate.doseRange.low = 1 $kbv-dosiereinheit#1 "Stück"
  * doseAndRate.doseRange.high = 3 $kbv-dosiereinheit#1 "Stück"
  * maxDosePerPeriod.numerator = 2 $kbv-dosiereinheit#1 "Stück"
  * maxDosePerPeriod.denominator = 24 $ucum#h "Stunde(n)"
