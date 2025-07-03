Instance: Example-MR-Dosage-Freetext
InstanceOf: DE_DOSAGE_DGMP_MEDICATIONREQUEST
Usage: #example
Title: "Example-MR-Dosage-Freetext"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Freitext-Dosierung dar"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+].text = "2 Tabletten morgens zum Frühstück"
