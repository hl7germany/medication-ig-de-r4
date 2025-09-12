Instance: Example-MR-Dosage-Freetext
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Dosage-Freetext"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Freitext-Dosierung dar"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+].text = "2 Stück morgens zum Frühstück"
