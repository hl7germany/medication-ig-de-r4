Instance: INVALID-Example-MR-Multiple-Dosage
InstanceOf: DE_DOSAGE_MEDICATIONREQUEST
Usage: #example
Title: "INVALID Example MR Multiple Dosage"
* subject.display = "Invalid by multiple different Dosages"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Test Medication"
* dosageInstruction[+] = Example-Dosage-Freetext
* dosageInstruction[+] = Example-Dosage-DailyFourScheme-1-MORN