// Invalid examples for DosageRequiresGeneratedText: missing required extensions

Instance: Invalid-Dosage-C-DosageRequiresGeneratedText-01-of-02
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid Dosage - Missing renderedDosageInstruction extension"
Description: "Invalid: Strukturierte Dosierung vorhanden, aber Extension renderedDosageInstruction fehlt."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Test Medication"
* dosageInstruction[+]
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d
    * when = #MORN
  * doseAndRate[+]
    * doseQuantity = 1 '{Stueck}' "Stück"
* extension[+]
  * url = "http://ig.fhir.de/igs/medication/StructureDefinition/GeneratedDosageInstructionsMeta"
  * extension[+]
    * url = "algorithmVersion"
    * valueString = "1.0.1"
  * extension[+]
    * url = "language"
    * valueCode = #de-DE

Instance: Invalid-Dosage-C-DosageRequiresGeneratedText-02-of-02
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid Dosage - Missing GeneratedDosageInstructionsMeta extension"
Description: "Invalid: Freitext-Dosierung vorhanden, aber Extension GeneratedDosageInstructionsMeta fehlt."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Test Medication"
* dosageInstruction[+]
  * text = "Morgens je 1 Tablette einnehmen"
* extension[+]
  * url = "http://hl7.org/fhir/5.0/StructureDefinition/extension-MedicationRequest.renderedDosageInstruction"
  * valueMarkdown = "Morgens je 1 Tablette einnehmen"
