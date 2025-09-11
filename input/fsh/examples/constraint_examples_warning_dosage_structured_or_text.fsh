// Warning examples for DosageStructuredOrFreeTextWarning (valid scenarios)

Instance: Warning-Dosage-W-DosageStructuredOrFreeTextWarning-01-of-01
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Valid: only text"
Description: "Valid example - purely text dosage; allowed but structured dosage preferred."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * text = "1-0-1-0"

