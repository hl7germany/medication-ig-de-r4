// Warning examples for TimingValuesPositiveWarning: period und boundsDuration.value sollen > 0 sein, boundsRange.low nicht negativ. Fehler in dgMP (ohne boundsRange).

Instance: W-TimingValuesPositiveWarning-MR-01-of-15
InstanceOf: MedicationRequestDE
Usage: #example
Title: "Warning (Request): period = 0"
Description: "Warning example - period = 0; the value should be greater than 0."
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

Instance: W-TimingValuesPositiveWarning-MD-02-of-15
InstanceOf: MedicationDispenseDE
Usage: #example
Title: "Warning (Dispense): period = 0"
Description: "Warning example - period = 0; the value should be greater than 0."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * frequency = 1
    * period = 0
    * periodUnit = #d
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: W-TimingValuesPositiveWarning-MS-03-of-15
InstanceOf: MedicationStatementDE
Usage: #example
Title: "Warning (Statement): period = 0"
Description: "Warning example - period = 0; the value should be greater than 0."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat
    * frequency = 1
    * period = 0
    * periodUnit = #d
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: W-TimingValuesPositiveWarning-MR-04-of-15
InstanceOf: MedicationRequestDE
Usage: #example
Title: "Warning (Request): boundsDuration = 0 d"
Description: "Warning example - boundsDuration = 0 d; the value should be greater than 0."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * when[+] = #MORN
    * boundsDuration = 0 $ucum#d "Tag(e)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: W-TimingValuesPositiveWarning-MD-05-of-15
InstanceOf: MedicationDispenseDE
Usage: #example
Title: "Warning (Dispense): boundsDuration = 0 d"
Description: "Warning example - boundsDuration = 0 d; the value should be greater than 0."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * when[+] = #MORN
    * boundsDuration = 0 $ucum#d "Tag(e)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: W-TimingValuesPositiveWarning-MS-06-of-15
InstanceOf: MedicationStatementDE
Usage: #example
Title: "Warning (Statement): boundsDuration = 0 d"
Description: "Warning example - boundsDuration = 0 d; the value should be greater than 0."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat
    * when[+] = #MORN
    * boundsDuration = 0 $ucum#d "Tag(e)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: W-TimingValuesPositiveWarning-MR-07-of-15
InstanceOf: MedicationRequestDE
Usage: #example
Title: "Warning (Request): boundsRange.low = -1"
Description: "Warning example - boundsRange.low = -1; the lower bound should not be negative."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * when[+] = #MORN
    * boundsRange.low = -1 $ucum#d "Tag(e)"
    * boundsRange.high = 5 $ucum#d "Tag(e)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: W-TimingValuesPositiveWarning-MD-08-of-15
InstanceOf: MedicationDispenseDE
Usage: #example
Title: "Warning (Dispense): boundsRange.low = -1"
Description: "Warning example - boundsRange.low = -1; the lower bound should not be negative."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * when[+] = #MORN
    * boundsRange.low = -1 $ucum#d "Tag(e)"
    * boundsRange.high = 5 $ucum#d "Tag(e)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: W-TimingValuesPositiveWarning-MS-09-of-15
InstanceOf: MedicationStatementDE
Usage: #example
Title: "Warning (Statement): boundsRange.low = -1"
Description: "Warning example - boundsRange.low = -1; the lower bound should not be negative."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat
    * when[+] = #MORN
    * boundsRange.low = -1 $ucum#d "Tag(e)"
    * boundsRange.high = 5 $ucum#d "Tag(e)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: W-TimingValuesPositiveWarning-MR-10-of-15
InstanceOf: MedicationRequestDE
Usage: #example
Title: "Warning (Request): periodMax = -2"
Description: "Warning example - periodMax = -2; the value should be greater than 0."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodMax = -2
    * periodUnit = #d
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: W-TimingValuesPositiveWarning-MD-11-of-15
InstanceOf: MedicationDispenseDE
Usage: #example
Title: "Warning (Dispense): periodMax = -2"
Description: "Warning example - periodMax = -2; the value should be greater than 0."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodMax = -2
    * periodUnit = #d
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: W-TimingValuesPositiveWarning-MS-12-of-15
InstanceOf: MedicationStatementDE
Usage: #example
Title: "Warning (Statement): periodMax = -2"
Description: "Warning example - periodMax = -2; the value should be greater than 0."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodMax = -2
    * periodUnit = #d
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: W-TimingValuesPositiveWarning-MR-13-of-15
InstanceOf: MedicationRequestDE
Usage: #example
Title: "Warning (Request): boundsRange.high = -1"
Description: "Warning example - boundsRange.high = -1; the value should be greater than 0."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * when[+] = #MORN
    * boundsRange.high = -1 $ucum#d "Tag(e)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: W-TimingValuesPositiveWarning-MD-14-of-15
InstanceOf: MedicationDispenseDE
Usage: #example
Title: "Warning (Dispense): boundsRange.high = -1"
Description: "Warning example - boundsRange.high = -1; the value should be greater than 0."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * when[+] = #MORN
    * boundsRange.high = -1 $ucum#d "Tag(e)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: W-TimingValuesPositiveWarning-MS-15-of-15
InstanceOf: MedicationStatementDE
Usage: #example
Title: "Warning (Statement): boundsRange.high = -1"
Description: "Warning example - boundsRange.high = -1; the value should be greater than 0."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat
    * when[+] = #MORN
    * boundsRange.high = -1 $ucum#d "Tag(e)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

// Warning examples for DosageLimitsPositiveWarning: Mindestabstand und maxDosePerPeriod sollen > 0 sein. Fehler in dgMP.

Instance: W-DosageLimitsPositiveWarning-MR-01-of-09
InstanceOf: MedicationRequestDE
Usage: #example
Title: "Warning (Request): Mindestabstand = 0 h"
Description: "Warning example - Mindestabstand = 0 h; the value should be greater than 0."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * asNeededBoolean = true
  * modifierExtension[minimumIntervalBetweenAdministrations].valueDuration = 0 $ucum#h "Stunde(n)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: W-DosageLimitsPositiveWarning-MD-02-of-09
InstanceOf: MedicationDispenseDE
Usage: #example
Title: "Warning (Dispense): Mindestabstand = 0 h"
Description: "Warning example - Mindestabstand = 0 h; the value should be greater than 0."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * asNeededBoolean = true
  * modifierExtension[minimumIntervalBetweenAdministrations].valueDuration = 0 $ucum#h "Stunde(n)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: W-DosageLimitsPositiveWarning-MS-03-of-09
InstanceOf: MedicationStatementDE
Usage: #example
Title: "Warning (Statement): Mindestabstand = 0 h"
Description: "Warning example - Mindestabstand = 0 h; the value should be greater than 0."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * asNeededBoolean = true
  * modifierExtension[minimumIntervalBetweenAdministrations].valueDuration = 0 $ucum#h "Stunde(n)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: W-DosageLimitsPositiveWarning-MR-04-of-09
InstanceOf: MedicationRequestDE
Usage: #example
Title: "Warning (Request): maxDosePerPeriod.numerator = 0"
Description: "Warning example - maxDosePerPeriod.numerator = 0; the value should be greater than 0."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * asNeededBoolean = true
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * maxDosePerPeriod.numerator = 0 $kbv-dosiereinheit#1 "Stück"
  * maxDosePerPeriod.denominator = 24 $ucum#h "Stunde(n)"

Instance: W-DosageLimitsPositiveWarning-MD-05-of-09
InstanceOf: MedicationDispenseDE
Usage: #example
Title: "Warning (Dispense): maxDosePerPeriod.numerator = 0"
Description: "Warning example - maxDosePerPeriod.numerator = 0; the value should be greater than 0."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * asNeededBoolean = true
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * maxDosePerPeriod.numerator = 0 $kbv-dosiereinheit#1 "Stück"
  * maxDosePerPeriod.denominator = 24 $ucum#h "Stunde(n)"

Instance: W-DosageLimitsPositiveWarning-MS-06-of-09
InstanceOf: MedicationStatementDE
Usage: #example
Title: "Warning (Statement): maxDosePerPeriod.numerator = 0"
Description: "Warning example - maxDosePerPeriod.numerator = 0; the value should be greater than 0."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * asNeededBoolean = true
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * maxDosePerPeriod.numerator = 0 $kbv-dosiereinheit#1 "Stück"
  * maxDosePerPeriod.denominator = 24 $ucum#h "Stunde(n)"

Instance: W-DosageLimitsPositiveWarning-MR-07-of-09
InstanceOf: MedicationRequestDE
Usage: #example
Title: "Warning (Request): maxDosePerPeriod.denominator = -24 h"
Description: "Warning example - maxDosePerPeriod.denominator = -24 h; the value should be greater than 0."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * asNeededBoolean = true
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * maxDosePerPeriod.numerator = 1 $kbv-dosiereinheit#1 "Stück"
  * maxDosePerPeriod.denominator = -24 $ucum#h "Stunde(n)"

Instance: W-DosageLimitsPositiveWarning-MD-08-of-09
InstanceOf: MedicationDispenseDE
Usage: #example
Title: "Warning (Dispense): maxDosePerPeriod.denominator = -24 h"
Description: "Warning example - maxDosePerPeriod.denominator = -24 h; the value should be greater than 0."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * asNeededBoolean = true
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * maxDosePerPeriod.numerator = 1 $kbv-dosiereinheit#1 "Stück"
  * maxDosePerPeriod.denominator = -24 $ucum#h "Stunde(n)"

Instance: W-DosageLimitsPositiveWarning-MS-09-of-09
InstanceOf: MedicationStatementDE
Usage: #example
Title: "Warning (Statement): maxDosePerPeriod.denominator = -24 h"
Description: "Warning example - maxDosePerPeriod.denominator = -24 h; the value should be greater than 0."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * asNeededBoolean = true
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * maxDosePerPeriod.numerator = 1 $kbv-dosiereinheit#1 "Stück"
  * maxDosePerPeriod.denominator = -24 $ucum#h "Stunde(n)"
