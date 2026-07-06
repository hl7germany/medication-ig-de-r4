// Warning examples for DosageStructuredOrFreeTextWarning

Instance: Dosage-W-DosageStructuredOrFreeTextWarning-01-of-03
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Warning (Request): text and structured dosage"
Description: "Warning example - dosage contains free text and structured dosage elements."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * text = "Nach ärztlicher Anweisung"
  * timing.repeat.frequency = 1
  * timing.repeat.period = 1
  * timing.repeat.periodUnit = #d
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: Dosage-W-DosageStructuredOrFreeTextWarning-02-of-03
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Warning (Dispense): text and structured dosage"
Description: "Warning example - dosage contains free text and structured dosage elements."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * text = "Nach ärztlicher Anweisung"
  * timing.repeat.frequency = 1
  * timing.repeat.period = 1
  * timing.repeat.periodUnit = #d
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: Dosage-W-DosageStructuredOrFreeTextWarning-03-of-03
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Warning (Statement): text and structured dosage"
Description: "Warning example - dosage contains free text and structured dosage elements."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * text = "Nach ärztlicher Anweisung"
  * timing.repeat.frequency = 1
  * timing.repeat.period = 1
  * timing.repeat.periodUnit = #d
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
