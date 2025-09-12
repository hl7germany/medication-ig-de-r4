// Invalid examples for DosageStructuredOrFreeText (error in DosageDgMP)
// Mixed usage of text plus structured elements should fail

Instance: Invalid-Dosage-C-DosageStructuredOrFreeText-01-of-02
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid: text + timing"
Description: "CAVE: Validation example - contains both text and timing (should be either structured OR text)."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * text = "1-0-1-0"
  * timing.repeat
    * when[+] = #MORN
    * frequency = 1
    * period = 1
    * periodUnit = #d
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: Invalid-Dosage-C-DosageStructuredOrFreeText-02-of-02
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid: text + doseAndRate"
Description: "CAVE: Validation example - contains both text and doseAndRate (should be either structured OR text)."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * text = "2 Stück morgens"
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"
