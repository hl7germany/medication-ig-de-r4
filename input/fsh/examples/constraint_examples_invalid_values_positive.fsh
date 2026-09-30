// Invalid examples for TimingValuesPositive (error): period und boundsDuration.value müssen > 0 sein.
// Negative period fängt bereits tim-5 ab; geprüft wird hier der Wert 0.

Instance: INV-C-TimingValuesPositive-MR-01-of-06
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid (Request): period = 0"
Description: "CAVE: Validation example - period = 0 is not allowed; the value must be greater than 0."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * frequency = 1
    * period = 0
    * periodUnit = #d
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-TimingValuesPositive-MD-02-of-06
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid (Dispense): period = 0"
Description: "CAVE: Validation example - period = 0 is not allowed; the value must be greater than 0."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * frequency = 1
    * period = 0
    * periodUnit = #d
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-TimingValuesPositive-MS-03-of-06
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid (Statement): period = 0"
Description: "CAVE: Validation example - period = 0 is not allowed; the value must be greater than 0."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat
    * frequency = 1
    * period = 0
    * periodUnit = #d
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-TimingValuesPositive-MR-04-of-06
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid (Request): boundsDuration = 0 d"
Description: "CAVE: Validation example - boundsDuration = 0 d is not allowed; the value must be greater than 0."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * when[+] = #MORN
    * boundsDuration = 0 $ucum#d "Tag(e)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-TimingValuesPositive-MD-05-of-06
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid (Dispense): boundsDuration = 0 d"
Description: "CAVE: Validation example - boundsDuration = 0 d is not allowed; the value must be greater than 0."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * when[+] = #MORN
    * boundsDuration = 0 $ucum#d "Tag(e)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-TimingValuesPositive-MS-06-of-06
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid (Statement): boundsDuration = 0 d"
Description: "CAVE: Validation example - boundsDuration = 0 d is not allowed; the value must be greater than 0."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat
    * when[+] = #MORN
    * boundsDuration = 0 $ucum#d "Tag(e)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

// Invalid examples for DosageLimitsPositive (error): Mindestabstand und maxDosePerPeriod müssen > 0 sein.

Instance: INV-C-DosageLimitsPositive-MR-01-of-06
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid (Request): Mindestabstand = 0 h"
Description: "CAVE: Validation example - Mindestabstand = 0 h is not allowed; the value must be greater than 0."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * asNeededBoolean = true
  * modifierExtension[minimumIntervalBetweenAdministrations].valueDuration = 0 $ucum#h "Stunde(n)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-DosageLimitsPositive-MD-02-of-06
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid (Dispense): Mindestabstand = 0 h"
Description: "CAVE: Validation example - Mindestabstand = 0 h is not allowed; the value must be greater than 0."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * asNeededBoolean = true
  * modifierExtension[minimumIntervalBetweenAdministrations].valueDuration = 0 $ucum#h "Stunde(n)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-DosageLimitsPositive-MS-03-of-06
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid (Statement): Mindestabstand = 0 h"
Description: "CAVE: Validation example - Mindestabstand = 0 h is not allowed; the value must be greater than 0."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * asNeededBoolean = true
  * modifierExtension[minimumIntervalBetweenAdministrations].valueDuration = 0 $ucum#h "Stunde(n)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-DosageLimitsPositive-MR-04-of-06
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid (Request): maxDosePerPeriod.numerator = 0"
Description: "CAVE: Validation example - maxDosePerPeriod.numerator = 0 is not allowed; the value must be greater than 0."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * asNeededBoolean = true
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * maxDosePerPeriod.numerator = 0 $kbv-dosiereinheit#1 "Stück"
  * maxDosePerPeriod.denominator = 24 $ucum#h "Stunde(n)"

Instance: INV-C-DosageLimitsPositive-MD-05-of-06
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid (Dispense): maxDosePerPeriod.numerator = 0"
Description: "CAVE: Validation example - maxDosePerPeriod.numerator = 0 is not allowed; the value must be greater than 0."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * asNeededBoolean = true
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * maxDosePerPeriod.numerator = 0 $kbv-dosiereinheit#1 "Stück"
  * maxDosePerPeriod.denominator = 24 $ucum#h "Stunde(n)"

Instance: INV-C-DosageLimitsPositive-MS-06-of-06
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid (Statement): maxDosePerPeriod.numerator = 0"
Description: "CAVE: Validation example - maxDosePerPeriod.numerator = 0 is not allowed; the value must be greater than 0."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * asNeededBoolean = true
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * maxDosePerPeriod.numerator = 0 $kbv-dosiereinheit#1 "Stück"
  * maxDosePerPeriod.denominator = 24 $ucum#h "Stunde(n)"
