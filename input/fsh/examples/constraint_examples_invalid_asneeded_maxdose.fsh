// Invalid examples for missing ERROR-constraint coverage in DosageDgMP
// Coverage target: Request, Dispense, Statement for each constraint

Instance: INV-C-AsNeededForOnlyIfAsNeeded-Request-01-of-03
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid: asNeededFor without asNeeded=true"
Description: "CAVE: Validation example - asNeededFor is populated while asNeededBoolean is false."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * text = "Bei Bedarf einnehmen"
  * asNeededBoolean = false
  * extension[asNeededFor].valueCodeableConcept.text = "Kopfschmerzen"

Instance: INV-C-AsNeededForOnlyIfAsNeeded-Dispense-02-of-03
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid: asNeededFor without asNeeded=true"
Description: "CAVE: Validation example - asNeededFor is populated while asNeededBoolean is false."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * text = "Bei Bedarf einnehmen"
  * asNeededBoolean = false
  * extension[asNeededFor].valueCodeableConcept.text = "Kopfschmerzen"

Instance: INV-C-AsNeededForOnlyIfAsNeeded-Statement-03-of-03
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid: asNeededFor without asNeeded=true"
Description: "CAVE: Validation example - asNeededFor is populated while asNeededBoolean is false."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * text = "Bei Bedarf einnehmen"
  * asNeededBoolean = false
  * extension[asNeededFor].valueCodeableConcept.text = "Kopfschmerzen"

Instance: INV-C-MaxDoseSameUnitAsDose-Request-01-of-03
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid: maxDose unit differs from doseQuantity"
Description: "CAVE: Validation example - maxDosePerPeriod.numerator uses a different unit/code/system than doseQuantity."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * maxDosePerPeriod.numerator.value = 400
  * maxDosePerPeriod.numerator.system = $ucum
  * maxDosePerPeriod.numerator.code = #mg
  * maxDosePerPeriod.numerator.unit = "mg"
  * maxDosePerPeriod.denominator.value = 24
  * maxDosePerPeriod.denominator.system = $ucum
  * maxDosePerPeriod.denominator.code = #h
  * maxDosePerPeriod.denominator.unit = "Stunden"

Instance: INV-C-MaxDoseSameUnitAsDose-Dispense-02-of-03
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid: maxDose unit differs from doseQuantity"
Description: "CAVE: Validation example - maxDosePerPeriod.numerator uses a different unit/code/system than doseQuantity."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * maxDosePerPeriod.numerator.value = 400
  * maxDosePerPeriod.numerator.system = $ucum
  * maxDosePerPeriod.numerator.code = #mg
  * maxDosePerPeriod.numerator.unit = "mg"
  * maxDosePerPeriod.denominator.value = 24
  * maxDosePerPeriod.denominator.system = $ucum
  * maxDosePerPeriod.denominator.code = #h
  * maxDosePerPeriod.denominator.unit = "Stunden"

Instance: INV-C-MaxDoseSameUnitAsDose-Statement-03-of-03
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid: maxDose unit differs from doseQuantity"
Description: "CAVE: Validation example - maxDosePerPeriod.numerator uses a different unit/code/system than doseQuantity."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * maxDosePerPeriod.numerator.value = 400
  * maxDosePerPeriod.numerator.system = $ucum
  * maxDosePerPeriod.numerator.code = #mg
  * maxDosePerPeriod.numerator.unit = "mg"
  * maxDosePerPeriod.denominator.value = 24
  * maxDosePerPeriod.denominator.system = $ucum
  * maxDosePerPeriod.denominator.code = #h
  * maxDosePerPeriod.denominator.unit = "Stunden"
