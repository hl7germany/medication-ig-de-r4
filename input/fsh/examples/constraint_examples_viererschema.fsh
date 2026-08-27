// Error examples for DosageFourSlotPatternInText
// Dosage.text consists solely of a 4-scheme, which must be modelled structurally in dgMP

Instance: INV-C-DosageFourSlotPatternInText-Request-01-of-03
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Ungültig (Request): reines Viererschema im Freitext"
Description: "CAVE: Validierungsbeispiel - Dosage.text besteht ausschließlich aus einem Viererschema (1-0-1-0)."
* status = #active
* intent = #order
* subject.display = "Patient"
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * text = "1-0-1-0"

Instance: INV-C-DosageFourSlotPatternInText-Dispense-02-of-03
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Ungültig (Dispense): reines Viererschema im Freitext"
Description: "CAVE: Validierungsbeispiel - Dosage.text besteht ausschließlich aus einem Viererschema (1-0-1-0)."
* status = #completed
* subject.display = "Patient"
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * text = "1-0-1-0"

Instance: INV-C-DosageFourSlotPatternInText-Statement-03-of-03
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Ungültig (Statement): reines Viererschema im Freitext"
Description: "CAVE: Validierungsbeispiel - Dosage.text besteht ausschließlich aus einem Viererschema mit Einheit (1-0-1-0 Stück)."
* status = #active
* subject.display = "Patient"
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * text = "1-0-1-0 Stück"
