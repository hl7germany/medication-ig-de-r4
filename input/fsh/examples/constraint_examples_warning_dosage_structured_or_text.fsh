// Warning examples for DosageStructuredOrFreeTextWarning (valid scenarios)

Instance: Dosage-W-DosageStructuredOrFreeTextWarning-01-of-03
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Valid (Request): only text"
Description: "Valid example - purely text dosage; allowed but structured dosage preferred."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * text = "1-0-1-0"

Instance: Dosage-W-DosageStructuredOrFreeTextWarning-02-of-03
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Valid (Dispense): only text"
Description: "Valid example - purely text dosage; allowed but structured dosage preferred."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * text = "1-0-1-0"

Instance: Dosage-W-DosageStructuredOrFreeTextWarning-03-of-03
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Valid (Statement): only text"
Description: "Valid example - purely text dosage; allowed but structured dosage preferred."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * text = "1-0-1-0"
