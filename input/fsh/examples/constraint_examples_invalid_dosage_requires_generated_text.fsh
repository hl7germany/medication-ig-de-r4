Instance: INV-C-DosageRequiresGeneratedText-MR-01-of-15
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

Instance: INV-C-DosageRequiresGeneratedText-MD-02-of-15
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

Instance: INV-C-DosageRequiresGeneratedText-MS-03-of-15
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

Instance: INV-C-DosageRequiresGeneratedText-MR-04-of-15
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

Instance: INV-C-DosageRequiresGeneratedText-MD-05-of-15
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid (Dispense): free-text dosage without generated text extensions"
Description: "CAVE: This MedicationDispense is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for invalid Permutations"
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * text = "Morgens 1 Stück zum Frühstück"

Instance: INV-C-DosageRequiresGeneratedText-MS-06-of-15
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid (Statement): free-text dosage without generated text extensions"
Description: "CAVE: This MedicationStatement is for validation purposes and does NOT represent a valid dosage. It only checks for invalid Permutations"
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * text = "Morgens 1 Stück zum Frühstück"

Instance: INV-C-DosageRequiresGeneratedText-MR-07-of-15
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid (Request): pure as-needed dosage without generated text extensions"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosage. It only checks for invalid Permutations"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * asNeededBoolean = true
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-DosageRequiresGeneratedText-MD-08-of-15
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid (Dispense): pure as-needed dosage without generated text extensions"
Description: "CAVE: This MedicationDispense is for validation purposes and does NOT represent a valid dosage. It only checks for invalid Permutations"
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * asNeededBoolean = true
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-DosageRequiresGeneratedText-MS-09-of-15
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid (Statement): pure as-needed dosage without generated text extensions"
Description: "CAVE: This MedicationStatement is for validation purposes and does NOT represent a valid dosage. It only checks for invalid Permutations"
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * asNeededBoolean = true
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-DosageRequiresGeneratedText-MR-10-of-15
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid (Request): free-text dosage with renderedDosageInstruction only"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosage. It only checks for invalid Permutations"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * text = "Morgens 1 Stück zum Frühstück"
* extension[+]
  * url = "http://hl7.org/fhir/5.0/StructureDefinition/extension-MedicationRequest.renderedDosageInstruction"
  * valueMarkdown = "Morgens 1 Stück zum Frühstück"

Instance: INV-C-DosageRequiresGeneratedText-MD-11-of-15
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid (Dispense): free-text dosage with renderedDosageInstruction only"
Description: "CAVE: This MedicationDispense is for validation purposes and does NOT represent a valid dosage. It only checks for invalid Permutations"
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * text = "Morgens 1 Stück zum Frühstück"
* extension[+]
  * url = "http://hl7.org/fhir/5.0/StructureDefinition/extension-MedicationDispense.renderedDosageInstruction"
  * valueMarkdown = "Morgens 1 Stück zum Frühstück"

Instance: INV-C-DosageRequiresGeneratedText-MS-12-of-15
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid (Statement): free-text dosage with renderedDosageInstruction only"
Description: "CAVE: This MedicationStatement is for validation purposes and does NOT represent a valid dosage. It only checks for invalid Permutations"
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * text = "Morgens 1 Stück zum Frühstück"
* extension[+]
  * url = "http://hl7.org/fhir/5.0/StructureDefinition/extension-MedicationStatement.renderedDosageInstruction"
  * valueMarkdown = "Morgens 1 Stück zum Frühstück"

Instance: INV-C-DosageRequiresGeneratedText-MR-13-of-15
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid (Request): free-text dosage with GeneratedDosageInstructionsMeta only"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosage. It only checks for invalid Permutations"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * text = "Morgens 1 Stück zum Frühstück"
* extension[+]
  * url = "http://ig.fhir.de/igs/medication/StructureDefinition/GeneratedDosageInstructionsMeta"
  * extension[+]
    * url = "algorithmVersion"
    * valueString = "2.0.0-ballot"
  * extension[+]
    * url = "language"
    * valueCode = #de-DE

Instance: INV-C-DosageRequiresGeneratedText-MD-14-of-15
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid (Dispense): free-text dosage with GeneratedDosageInstructionsMeta only"
Description: "CAVE: This MedicationDispense is for validation purposes and does NOT represent a valid dosage. It only checks for invalid Permutations"
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * text = "Morgens 1 Stück zum Frühstück"
* extension[+]
  * url = "http://ig.fhir.de/igs/medication/StructureDefinition/GeneratedDosageInstructionsMeta"
  * extension[+]
    * url = "algorithmVersion"
    * valueString = "2.0.0-ballot"
  * extension[+]
    * url = "language"
    * valueCode = #de-DE

Instance: INV-C-DosageRequiresGeneratedText-MS-15-of-15
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid (Statement): free-text dosage with GeneratedDosageInstructionsMeta only"
Description: "CAVE: This MedicationStatement is for validation purposes and does NOT represent a valid dosage. It only checks for invalid Permutations"
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * text = "Morgens 1 Stück zum Frühstück"
* extension[+]
  * url = "http://ig.fhir.de/igs/medication/StructureDefinition/GeneratedDosageInstructionsMeta"
  * extension[+]
    * url = "algorithmVersion"
    * valueString = "2.0.0-ballot"
  * extension[+]
    * url = "language"
    * valueCode = #de-DE
