// Error examples for DosageDoseValuePositive.
// Every possible numeric dose value in the dgMP dose[x] types is covered:
// Quantity.value, Range.low.value, and Range.high.value — each with a negative
// value and, where 0 is not a valid dose either, with the value 0.

Instance: INV-C-DosageDoseValuePositive-Request-01-of-05
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Ungültig (Request): doseQuantity.value ist negativ"
Description: "CAVE: Validierungsbeispiel - doseQuantity.value muss größer als 0 sein."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * when[+] = #MORN
  * doseAndRate.doseQuantity = -1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-DosageDoseValuePositive-Dispense-02-of-05
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

Instance: INV-C-DosageDoseValuePositive-Statement-03-of-05
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Ungültig (Statement): doseRange.high.value ist negativ"
Description: "CAVE: Validierungsbeispiel - doseRange.high.value muss größer als 0 sein."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat
    * when[+] = #MORN
  * doseAndRate.doseRange
    * high = -1 $kbv-dosiereinheit#1 "Stück"

// Der Wert 0 ist ausschließlich als Untergrenze eines Bereichs zulässig. Als
// Einzeldosis oder als Obergrenze beschreibt er keine Anwendung und wird
// deshalb wie ein negativer Wert zurückgewiesen.

Instance: INV-C-DosageDoseValuePositive-Request-04-of-05
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Ungültig (Request): doseQuantity.value ist 0"
Description: "CAVE: Validierungsbeispiel - eine Einzeldosis von 0 beschreibt keine verabreichbare Arzneimittelmenge."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * when[+] = #MORN
  * doseAndRate.doseQuantity = 0 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-DosageDoseValuePositive-Dispense-05-of-05
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Ungültig (Dispense): doseRange.high.value ist 0"
Description: "CAVE: Validierungsbeispiel - eine Obergrenze von 0 beschreibt keine verabreichbare Arzneimittelmenge, auch wenn 0 als Untergrenze zulässig wäre."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * when[+] = #MORN
  * doseAndRate.doseRange
    * low = 0 $kbv-dosiereinheit#1 "Stück"
    * high = 0 $kbv-dosiereinheit#1 "Stück"

// Positives Grenzwertbeispiel: 0 als Untergrenze eines Bereichs.

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
