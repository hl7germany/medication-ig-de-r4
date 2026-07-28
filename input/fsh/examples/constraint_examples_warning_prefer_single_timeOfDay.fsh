// Warning examples for TimingSingleDosageForTimeOfDayWarning
// Two dosages with identical dose, each carrying a single time of day.
// Allowed as a warning in DE, error in dgMP.

Instance: W-TimingSingleDosageForTimeOfDayWarning-Request-01-of-03
InstanceOf: MedicationRequestDE
Usage: #example
Title: "Warning (Request): split timeOfDay into two dosages (same dose)"
Description: "Warning example - zwei Dosages mit identischer Dosis, jeweils eine Uhrzeit; sollte zu einer Dosage zusammengeführt werden."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * timeOfDay[+] = "08:00:00"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosageInstruction[+]
  * timing.repeat
    * timeOfDay[+] = "20:00:00"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: W-TimingSingleDosageForTimeOfDayWarning-Dispense-02-of-03
InstanceOf: MedicationDispenseDE
Usage: #example
Title: "Warning (Dispense): split timeOfDay into two dosages (same dose)"
Description: "Warning example - zwei Dosages mit identischer Dosis, jeweils eine Uhrzeit; sollte zu einer Dosage zusammengeführt werden."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * timeOfDay[+] = "08:00:00"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosageInstruction[+]
  * timing.repeat
    * timeOfDay[+] = "20:00:00"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: W-TimingSingleDosageForTimeOfDayWarning-Statement-03-of-03
InstanceOf: MedicationStatementDE
Usage: #example
Title: "Warning (Statement): split timeOfDay into two dosages (same dose)"
Description: "Warning example - zwei Dosages mit identischer Dosis, jeweils eine Uhrzeit; sollte zu einer Dosage zusammengeführt werden."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat
    * timeOfDay[+] = "08:00:00"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosage[+]
  * timing.repeat
    * timeOfDay[+] = "20:00:00"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
