Instance: Example-MR-Dosage-Freetext
InstanceOf: DE_DOSAGE_DGMP_MEDICATIONREQUEST
Usage: #example
Title: "Example-MR-Dosage-Freetext"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Freitext-Dosierung dar"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Medication"
* dosageInstruction[+] = Example-Dosage-Freetext

Instance: Example-Dosage-Freetext
InstanceOf: DE_DOSAGE_DGMP
Usage: #inline
Title: "Dosage with every freetextrs"
* text = "2 Tabletten morgens zum Frühstück"
