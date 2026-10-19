// Error examples for DosageDoseValueDecimalNotation
// The dose value must use plain decimal notation with at most three decimal places.
// Note: the exponential form (e.g. 50e-2) cannot be authored in FSH, since the FSH
// number syntax has no exponent. It is covered by the same invariant.
// Example 05-of-05 (0.1250, trailing zero) is maintained as JSON under input/examples,
// because SUSHI drops trailing zeros. It violates only this invariant, not
// DosageDoseQuantityAllowedFractions.

Instance: INV-C-DosageDoseValueDecimalNotation-Request-01-of-05
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Ungültig (Request): Dosiswert mit vier Nachkommastellen"
Description: "CAVE: Validierungsbeispiel - doseQuantity.value = 0.0625 überschreitet die zulässigen drei Nachkommastellen."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * when[+] = #MORN
  * doseAndRate.doseQuantity = 0.0625 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-DosageDoseValueDecimalNotation-Dispense-02-of-05
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Ungültig (Dispense): Dosiswert mit vier Nachkommastellen"
Description: "CAVE: Validierungsbeispiel - doseQuantity.value = 0.0625 überschreitet die zulässigen drei Nachkommastellen."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * when[+] = #MORN
  * doseAndRate.doseQuantity = 0.0625 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-DosageDoseValueDecimalNotation-Statement-03-of-05
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Ungültig (Statement): Dosisbereich mit vier Nachkommastellen"
Description: "CAVE: Validierungsbeispiel - doseRange.low.value = 0.0625 überschreitet die zulässigen drei Nachkommastellen."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat
    * when[+] = #MORN
  * doseAndRate.doseRange
    * low = 0.0625 $kbv-dosiereinheit#1 "Stück"
    * high = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-DosageDoseValueDecimalNotation-Dispense-04-of-05
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Ungültig (Dispense): Dosisbereich-Obergrenze mit vier Nachkommastellen"
Description: "CAVE: Validierungsbeispiel - doseRange.high.value = 1.0625 überschreitet die zulässigen drei Nachkommastellen."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * when[+] = #MORN
  * doseAndRate.doseRange
    * low = 1 $kbv-dosiereinheit#1 "Stück"
    * high = 1.0625 $kbv-dosiereinheit#1 "Stück"
