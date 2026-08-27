// Invalid examples for missing ERROR-constraint coverage in DosageDgMP
// Coverage target: Request, Dispense, Statement for each constraint

Instance: INV-C-MaxDoseOnlyPureAsNeeded-Request-01-of-03
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid: maxDosePerPeriod without asNeeded"
Description: "CAVE: Validation example - maxDosePerPeriod ist gesetzt, obwohl asNeededBoolean nicht true ist (nur bei Bedarfsmedikation zulässig)."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.frequency = 1
  * timing.repeat.period = 8
  * timing.repeat.periodUnit = #h
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * maxDosePerPeriod.numerator.value = 6
  * maxDosePerPeriod.numerator.system = $kbv-dosiereinheit
  * maxDosePerPeriod.numerator.code = #1
  * maxDosePerPeriod.numerator.unit = "Stück"
  * maxDosePerPeriod.denominator.value = 24
  * maxDosePerPeriod.denominator.system = $ucum
  * maxDosePerPeriod.denominator.code = #h
  * maxDosePerPeriod.denominator.unit = "Stunde(n)"

Instance: INV-C-MaxDoseOnlyPureAsNeeded-Dispense-02-of-03
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid: maxDosePerPeriod without asNeeded"
Description: "CAVE: Validation example - maxDosePerPeriod ist gesetzt, obwohl asNeededBoolean nicht true ist (nur bei Bedarfsmedikation zulässig)."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.frequency = 1
  * timing.repeat.period = 8
  * timing.repeat.periodUnit = #h
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * maxDosePerPeriod.numerator.value = 6
  * maxDosePerPeriod.numerator.system = $kbv-dosiereinheit
  * maxDosePerPeriod.numerator.code = #1
  * maxDosePerPeriod.numerator.unit = "Stück"
  * maxDosePerPeriod.denominator.value = 24
  * maxDosePerPeriod.denominator.system = $ucum
  * maxDosePerPeriod.denominator.code = #h
  * maxDosePerPeriod.denominator.unit = "Stunde(n)"

Instance: INV-C-MaxDoseOnlyPureAsNeeded-Statement-03-of-03
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid: maxDosePerPeriod without asNeeded"
Description: "CAVE: Validation example - maxDosePerPeriod ist gesetzt, obwohl asNeededBoolean nicht true ist (nur bei Bedarfsmedikation zulässig)."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat.frequency = 1
  * timing.repeat.period = 8
  * timing.repeat.periodUnit = #h
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * maxDosePerPeriod.numerator.value = 6
  * maxDosePerPeriod.numerator.system = $kbv-dosiereinheit
  * maxDosePerPeriod.numerator.code = #1
  * maxDosePerPeriod.numerator.unit = "Stück"
  * maxDosePerPeriod.denominator.value = 24
  * maxDosePerPeriod.denominator.system = $ucum
  * maxDosePerPeriod.denominator.code = #h
  * maxDosePerPeriod.denominator.unit = "Stunde(n)"

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
  * asNeededBoolean = true
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
  * asNeededBoolean = true
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
  * asNeededBoolean = true
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * maxDosePerPeriod.numerator.value = 400
  * maxDosePerPeriod.numerator.system = $ucum
  * maxDosePerPeriod.numerator.code = #mg
  * maxDosePerPeriod.numerator.unit = "mg"
  * maxDosePerPeriod.denominator.value = 24
  * maxDosePerPeriod.denominator.system = $ucum
  * maxDosePerPeriod.denominator.code = #h
  * maxDosePerPeriod.denominator.unit = "Stunden"

Instance: INV-C-MaxDoseOnlyPureAsNeeded-MR-04-of-04
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid: maxDosePerPeriod with a structured rhythm"
Description: "CAVE: Validation example - maxDosePerPeriod ist nur bei reiner Bedarfsdosierung zulaessig, also mit asNeededBoolean = true und ohne timing."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * asNeededBoolean = true
  * timing.repeat.frequency = 1
  * timing.repeat.period = 8
  * timing.repeat.periodUnit = #h
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * maxDosePerPeriod.numerator.value = 4
  * maxDosePerPeriod.numerator.system = $kbv-dosiereinheit
  * maxDosePerPeriod.numerator.code = #1
  * maxDosePerPeriod.numerator.unit = "Stück"
  * maxDosePerPeriod.denominator.value = 24
  * maxDosePerPeriod.denominator.system = $ucum
  * maxDosePerPeriod.denominator.code = #h
  * maxDosePerPeriod.denominator.unit = "Stunde(n)"
