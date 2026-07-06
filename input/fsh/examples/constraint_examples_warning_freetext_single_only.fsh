// Warning examples for FreeTextSingleDosageOnlyWarning

Instance: W-FreeTextSingleDosageOnlyWarning-MR
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

Instance: W-FreeTextSingleDosageOnlyWarning-MD
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

Instance: W-FreeTextSingleDosageOnlyWarning-MS
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
