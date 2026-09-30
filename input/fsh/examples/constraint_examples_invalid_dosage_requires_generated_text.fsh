Instance: INV-C-DosageRequiresGeneratedText-MR-01-of-06
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid (Request): structured dosage without generated text extensions"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for invalid Permutations"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * when[+] = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-DosageRequiresGeneratedText-MD-02-of-06
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid (Dispense): structured dosage without generated text extensions"
Description: "CAVE: This MedicationDispense is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for invalid Permutations"
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * when[+] = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-DosageRequiresGeneratedText-MS-03-of-06
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid (Statement): structured dosage without generated text extensions"
Description: "CAVE: This MedicationStatement is for validation purposes and does NOT represent a valid dosage. It only checks for invalid Permutations"
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat
    * when[+] = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-DosageRequiresGeneratedText-MR-04-of-06
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid (Request): free-text dosage without generated text extensions"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for invalid Permutations"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * text = "Morgens 1 Stück zum Frühstück"

Instance: INV-C-DosageRequiresGeneratedText-MD-05-of-06
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid (Dispense): free-text dosage without generated text extensions"
Description: "CAVE: This MedicationDispense is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for invalid Permutations"
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * text = "Morgens 1 Stück zum Frühstück"

Instance: INV-C-DosageRequiresGeneratedText-MS-06-of-06
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid (Statement): free-text dosage without generated text extensions"
Description: "CAVE: This MedicationStatement is for validation purposes and does NOT represent a valid dosage. It only checks for invalid Permutations"
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * text = "Morgens 1 Stück zum Frühstück"
