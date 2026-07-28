Instance: INV-C-DosageStructuredRequiresGeneratedText-MR-01-of-03
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid (Request): structured dosage without GeneratedDosageInstructionsMeta"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for invalid Permutations"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * when[+] = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-DosageStructuredRequiresGeneratedText-MD-02-of-03
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid (Dispense): structured dosage without GeneratedDosageInstructionsMeta"
Description: "CAVE: This MedicationDispense is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for invalid Permutations"
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * when[+] = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-DosageStructuredRequiresGeneratedText-MS-03-of-03
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid (Statement): structured dosage without GeneratedDosageInstructionsMeta"
Description: "CAVE: This MedicationStatement is for validation purposes and does NOT represent a valid dosage. It only checks for invalid Permutations"
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat
    * when[+] = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
