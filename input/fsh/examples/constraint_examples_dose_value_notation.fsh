// Error examples for DosageDoseValueDecimalNotation
// The dose value must use plain decimal notation with at most three decimal places.
// Note: the exponential form (e.g. 50e-2) cannot be authored in FSH, since the FSH
// number syntax has no exponent. It is covered by the same invariant.

Instance: INV-C-DosageDoseValueDecimalNotation-Request-01-of-03
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

Instance: INV-C-DosageDoseValueDecimalNotation-Dispense-02-of-03
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

Instance: INV-C-DosageDoseValueDecimalNotation-Statement-03-of-03
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
