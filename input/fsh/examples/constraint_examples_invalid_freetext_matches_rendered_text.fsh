// Invalid example for FreeTextMatchesRenderedText: text mismatch

Instance: INV-C-FreeTextMatchesRenderedText-Request-01-of-01
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid Dosage - FreeText doesn't match renderedDosageInstruction"
Description: "Invalid: Freitext-Dosierung vorhanden, aber der Wert in dosageInstruction.text stimmt nicht mit renderedDosageInstruction überein."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Test Medication"
* dosageInstruction[+]
  * text = "Morgens je 1 Tablette einnehmen"
* extension[+]
  * url = "http://hl7.org/fhir/5.0/StructureDefinition/extension-MedicationRequest.renderedDosageInstruction"
  * valueMarkdown = "Abends je 2 Tabletten einnehmen"
* extension[+]
  * url = "http://ig.fhir.de/igs/medication/StructureDefinition/GeneratedDosageInstructionsMeta"
  * extension[+]
    * url = "algorithmVersion"
    * valueString = "1.0.1"
  * extension[+]
    * url = "language"
    * valueCode = #de-DE

Instance: INV-C-FreeTextMatchesRenderedText-Dispense-01-of-01
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid Dosage - FreeText doesn't match renderedDosageInstruction"
Description: "Invalid: Freitext-Dosierung vorhanden, aber der Wert in dosageInstruction.text stimmt nicht mit renderedDosageInstruction überein."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Test Medication"
* dosageInstruction[+]
  * text = "Morgens je 1 Tablette einnehmen"
* extension[+]
  * url = "http://hl7.org/fhir/5.0/StructureDefinition/extension-MedicationDispense.renderedDosageInstruction"
  * valueMarkdown = "Abends je 2 Tabletten einnehmen"
* extension[+]
  * url = "http://ig.fhir.de/igs/medication/StructureDefinition/GeneratedDosageInstructionsMeta"
  * extension[+]
    * url = "algorithmVersion"
    * valueString = "1.0.1"
  * extension[+]
    * url = "language"
    * valueCode = #de-DE

Instance: INV-C-FreeTextMatchesRenderedText-Statement-01-of-01
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid Dosage - FreeText doesn't match renderedDosageInstruction"
Description: "Invalid: Freitext-Dosierung vorhanden, aber der Wert in dosage.text stimmt nicht mit renderedDosageInstruction überein."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Test Medication"
* dosage[+]
  * text = "Morgens je 1 Tablette einnehmen"
* extension[+]
  * url = "http://hl7.org/fhir/5.0/StructureDefinition/extension-MedicationStatement.renderedDosageInstruction"
  * valueMarkdown = "Abends je 2 Tabletten einnehmen"
* extension[+]
  * url = "http://ig.fhir.de/igs/medication/StructureDefinition/GeneratedDosageInstructionsMeta"
  * extension[+]
    * url = "algorithmVersion"
    * valueString = "1.0.1"
  * extension[+]
    * url = "language"
    * valueCode = #de-DE
