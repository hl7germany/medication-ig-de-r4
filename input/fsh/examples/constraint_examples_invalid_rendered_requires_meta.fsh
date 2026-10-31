Instance: INV-C-RenderedRequiresMeta-MR
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid (Request): renderedDosageInstruction without GeneratedDosageInstructionsMeta"
Description: "Invalid: renderedDosageInstruction ist vorhanden, aber GeneratedDosageInstructionsMeta fehlt."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction.text = "Morgens 1 Tablette"
* extension[+]
  * url = "http://hl7.org/fhir/5.0/StructureDefinition/extension-MedicationRequest.renderedDosageInstruction"
  * valueMarkdown = "Morgens 1 Tablette"

Instance: INV-C-RenderedRequiresMeta-MD
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid (Dispense): renderedDosageInstruction without GeneratedDosageInstructionsMeta"
Description: "Invalid: renderedDosageInstruction ist vorhanden, aber GeneratedDosageInstructionsMeta fehlt."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction.text = "Morgens 1 Tablette"
* extension[+]
  * url = "http://hl7.org/fhir/5.0/StructureDefinition/extension-MedicationDispense.renderedDosageInstruction"
  * valueMarkdown = "Morgens 1 Tablette"

Instance: INV-C-RenderedRequiresMeta-MS
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid (Statement): renderedDosageInstruction without GeneratedDosageInstructionsMeta"
Description: "Invalid: renderedDosageInstruction ist vorhanden, aber GeneratedDosageInstructionsMeta fehlt."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage.text = "Morgens 1 Tablette"
* extension[+]
  * url = "http://hl7.org/fhir/5.0/StructureDefinition/extension-MedicationStatement.renderedDosageInstruction"
  * valueMarkdown = "Morgens 1 Tablette"
