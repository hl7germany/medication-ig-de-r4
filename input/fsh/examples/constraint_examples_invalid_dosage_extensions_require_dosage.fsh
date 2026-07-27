Instance: INV-C-ExtRequiresDosage-MR-01
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid (Request): dosage extension without dosageInstruction"
Description: "Invalid: Eine Dosierungs-Extension ist vorhanden, aber keine dosageInstruction."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* extension[+]
  * url = "http://hl7.org/fhir/5.0/StructureDefinition/extension-MedicationRequest.renderedDosageInstruction"
  * valueMarkdown = "Morgens 1 Tablette"

Instance: INV-C-ExtRequiresDosage-MD-01
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid (Dispense): dosage extension without dosageInstruction"
Description: "Invalid: Eine Dosierungs-Extension ist vorhanden, aber keine dosageInstruction."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* extension[+]
  * url = "http://hl7.org/fhir/5.0/StructureDefinition/extension-MedicationDispense.renderedDosageInstruction"
  * valueMarkdown = "Morgens 1 Tablette"

Instance: INV-C-ExtRequiresDosage-MS-01
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid (Statement): dosage extension without dosage"
Description: "Invalid: Eine Dosierungs-Extension ist vorhanden, aber keine dosage."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* extension[+]
  * url = "http://hl7.org/fhir/5.0/StructureDefinition/extension-MedicationStatement.renderedDosageInstruction"
  * valueMarkdown = "Morgens 1 Tablette"
