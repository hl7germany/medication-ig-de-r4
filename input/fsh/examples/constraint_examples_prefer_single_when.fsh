Instance: INV-C-TimingSingleDosageForWhen-Request-01-of-03
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid (Request): split when into two dosages (same period/dose)"
Description: "Zwei Dosages mit identischem Intervall und Dosis, jeweils ein Zeitraum (MORN/EVE) - sollte zu einer Dosage zusammengeführt werden."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * when[+] = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosageInstruction[+]
  * timing.repeat
    * when[+] = #EVE
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-TimingSingleDosageForWhen-Dispense-02-of-03
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid (Dispense): split when into two dosages (same period/dose)"
Description: "Zwei Dosages mit identischem Intervall und Dosis, jeweils ein Zeitraum (MORN/EVE) - sollte zu einer Dosage zusammengeführt werden."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * when[+] = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosageInstruction[+]
  * timing.repeat
    * when[+] = #EVE
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-TimingSingleDosageForWhen-Statement-03-of-03
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid (Statement): split when into two dosages (same period/dose)"
Description: "Zwei Dosages mit identischem Intervall und Dosis, jeweils ein Zeitraum (MORN/EVE) - sollte zu einer Dosage zusammengeführt werden."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat
    * when[+] = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosage[+]
  * timing.repeat
    * when[+] = #EVE
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
