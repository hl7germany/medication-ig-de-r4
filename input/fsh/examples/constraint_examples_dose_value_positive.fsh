// Error examples for DosageDoseValuePositive.
// Every possible numeric dose value in the dgMP dose[x] types is covered:
// Quantity.value, Range.low.value, and Range.high.value.

Instance: INV-C-DosageDoseValuePositive-Request-01-of-03
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Ungültig (Request): doseQuantity.value ist negativ"
Description: "CAVE: Validierungsbeispiel - doseQuantity.value darf nicht negativ sein."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * when[+] = #MORN
  * doseAndRate.doseQuantity = -1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-DosageDoseValuePositive-Dispense-02-of-03
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Ungültig (Dispense): doseRange.low.value ist negativ"
Description: "CAVE: Validierungsbeispiel - doseRange.low.value darf nicht negativ sein."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * when[+] = #MORN
  * doseAndRate.doseRange
    * low = -1 $kbv-dosiereinheit#1 "Stück"
    * high = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-DosageDoseValuePositive-Statement-03-of-03
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Ungültig (Statement): doseRange.high.value ist negativ"
Description: "CAVE: Validierungsbeispiel - doseRange.high.value darf nicht negativ sein."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat
    * when[+] = #MORN
  * doseAndRate.doseRange
    * high = -1 $kbv-dosiereinheit#1 "Stück"

// Positive boundary examples: 0 is explicitly allowed for every numeric
// location covered by the invariant.

Instance: Example-MR-Dosage-Zero-Quantity
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Gültig (Request): doseQuantity.value ist 0"
Description: "Positives Grenzwertbeispiel für doseQuantity.value."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.when = #MORN
  * doseAndRate.doseQuantity = 0 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MD-Dosage-Zero-Range-Low
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Gültig (Dispense): doseRange.low.value ist 0"
Description: "Positives Grenzwertbeispiel für die Dosierung 0 bis 2 Stück."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.when = #MORN
  * doseAndRate.doseRange
    * low = 0 $kbv-dosiereinheit#1 "Stück"
    * high = 2 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MS-Dosage-Zero-Range-High
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Gültig (Statement): doseRange.high.value ist 0"
Description: "Positives Grenzwertbeispiel für doseRange.high.value."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat.when = #MORN
  * doseAndRate.doseRange.high = 0 $kbv-dosiereinheit#1 "Stück"
