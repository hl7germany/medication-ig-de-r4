// Warning examples for TimingSingleDosageForWhenWarning
// Two dosages with identical dose, each carrying a single period of day.
// Allowed as a warning in DE, error in dgMP.

Instance: W-TimingSingleDosageForWhenWarning-MR-01-of-03
InstanceOf: MedicationRequestDE
Usage: #example
Title: "Warning (Request): split when into two dosages (same dose)"
Description: "Warning example - zwei Dosages mit identischer Dosis, jeweils ein Zeitraum (MORN/EVE); sollte zu einer Dosage zusammengeführt werden."
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

Instance: W-TimingSingleDosageForWhenWarning-MD-02-of-03
InstanceOf: MedicationDispenseDE
Usage: #example
Title: "Warning (Dispense): split when into two dosages (same dose)"
Description: "Warning example - zwei Dosages mit identischer Dosis, jeweils ein Zeitraum (MORN/EVE); sollte zu einer Dosage zusammengeführt werden."
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

Instance: W-TimingSingleDosageForWhenWarning-MS-03-of-03
InstanceOf: MedicationStatementDE
Usage: #example
Title: "Warning (Statement): split when into two dosages (same dose)"
Description: "Warning example - zwei Dosages mit identischer Dosis, jeweils ein Zeitraum (MORN/EVE); sollte zu einer Dosage zusammengeführt werden."
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
