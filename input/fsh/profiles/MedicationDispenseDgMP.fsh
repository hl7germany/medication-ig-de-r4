Profile: MedicationDispenseDgMP
Parent: MedicationDispense
Id: MedicationDispenseDgMP
Title: "Medication Dispense dgMP"
Description: "Dieses Profil dient ausschließlich der Validierung des Implementation Guides und ist nicht für den produktiven Einsatz gedacht. Stattdessen sollte das jeweils passende Dosage-Profil direkt in das eigene Profil eingebunden werden."
* ^abstract = true
* dosageInstruction only DosageDgMP
  * ^short = "Angabe der Dosierinformationen strukturiert oder als Freitext"
  * extension contains $medicationDispense-renderedDosageInstruction-r5 named renderedDosageInstruction 0..1 MS //TODO: 1..1??

Instance: TestMRIns
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Test MR Ins"
Description: "test"
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction.extension[renderedDosageInstruction].valueMarkdown = "Test"