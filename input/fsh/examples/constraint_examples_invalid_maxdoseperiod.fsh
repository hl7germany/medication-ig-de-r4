// Invalid examples for MaxDosePerPeriodOnly24hOr1d (error)
// maxDosePerPeriod darf nur mit einem Bezugszeitraum von 24 h oder 1 d angegeben werden.
// Hier ist der Nenner 6 h (z. B. "maximal 3 alle 6 Stunden") -> Verstoß.

Instance: INV-C-MaxDosePerPeriodOnly24hOr1d-Request-01-of-03
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid: maxDosePerPeriod denominator 6h"
Description: "CAVE: Validation example - maxDosePerPeriod.denominator is 6 h instead of 24 h or 1 d."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * asNeededBoolean = true
  * extension[asNeededFor].valueCodeableConcept.text = "Kopfschmerzen"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * maxDosePerPeriod.numerator.value = 3
  * maxDosePerPeriod.numerator.system = $kbv-dosiereinheit
  * maxDosePerPeriod.numerator.code = #1
  * maxDosePerPeriod.numerator.unit = "Stück"
  * maxDosePerPeriod.denominator.value = 6
  * maxDosePerPeriod.denominator.system = $ucum
  * maxDosePerPeriod.denominator.code = #h
  * maxDosePerPeriod.denominator.unit = "Stunde(n)"

Instance: INV-C-MaxDosePerPeriodOnly24hOr1d-Dispense-02-of-03
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid: maxDosePerPeriod denominator 6h"
Description: "CAVE: Validation example - maxDosePerPeriod.denominator is 6 h instead of 24 h or 1 d."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * asNeededBoolean = true
  * extension[asNeededFor].valueCodeableConcept.text = "Kopfschmerzen"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * maxDosePerPeriod.numerator.value = 3
  * maxDosePerPeriod.numerator.system = $kbv-dosiereinheit
  * maxDosePerPeriod.numerator.code = #1
  * maxDosePerPeriod.numerator.unit = "Stück"
  * maxDosePerPeriod.denominator.value = 6
  * maxDosePerPeriod.denominator.system = $ucum
  * maxDosePerPeriod.denominator.code = #h
  * maxDosePerPeriod.denominator.unit = "Stunde(n)"

Instance: INV-C-MaxDosePerPeriodOnly24hOr1d-Statement-03-of-03
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid: maxDosePerPeriod denominator 6h"
Description: "CAVE: Validation example - maxDosePerPeriod.denominator is 6 h instead of 24 h or 1 d."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * asNeededBoolean = true
  * extension[asNeededFor].valueCodeableConcept.text = "Kopfschmerzen"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * maxDosePerPeriod.numerator.value = 3
  * maxDosePerPeriod.numerator.system = $kbv-dosiereinheit
  * maxDosePerPeriod.numerator.code = #1
  * maxDosePerPeriod.numerator.unit = "Stück"
  * maxDosePerPeriod.denominator.value = 6
  * maxDosePerPeriod.denominator.system = $ucum
  * maxDosePerPeriod.denominator.code = #h
  * maxDosePerPeriod.denominator.unit = "Stunde(n)"
