// Warning examples for FreeTextSingleDosageOnlyWarning

Instance: Dosage-W-FreeTextSingleDosageOnlyWarning-Request-01-of-03
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Warning (Request): multiple free text dosages"
Description: "Warning example - pure free text dosage is split across multiple Dosage elements."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Test Medication"
* dosageInstruction[+]
  * text = "Morgens je 1 Tablette"
* dosageInstruction[+]
  * text = "Abends je 1 Tablette"

Instance: Dosage-W-FreeTextSingleDosageOnlyWarning-Dispense-02-of-03
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Warning (Dispense): multiple free text dosages"
Description: "Warning example - pure free text dosage is split across multiple Dosage elements."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Test Medication"
* dosageInstruction[+]
  * text = "Morgens je 1 Tablette"
* dosageInstruction[+]
  * text = "Abends je 1 Tablette"

Instance: Dosage-W-FreeTextSingleDosageOnlyWarning-Statement-03-of-03
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Warning (Statement): multiple free text dosages"
Description: "Warning example - pure free text dosage is split across multiple Dosage elements."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Test Medication"
* dosage[+]
  * text = "Morgens je 1 Tablette"
* dosage[+]
  * text = "Abends je 1 Tablette"
