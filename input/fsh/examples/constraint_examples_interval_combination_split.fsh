// Interval combination: period 2 d, two Dosage elements with the same dose, one time each.
// Version 1.0.7 checked these rules only for period = 1 d; since 2.0.0 they also apply here (migration case M08/M09).

Instance: INV-C-TimingSingleDosageForTimeOfDay-Request-07-of-09
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid (Request): timeOfDay alle 2 Tage auf zwei Dosages verteilt (gleiche Dosis)"
Description: "Intervall-Kombination alle 2 Tage, 08:00 und 20:00 Uhr je 1 Stück in zwei Dosages mit identischer Dosis - muss zu einer Dosage zusammengeführt werden."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * period = 2
    * periodUnit = #d
    * timeOfDay[+] = "08:00:00"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosageInstruction[+]
  * timing.repeat
    * period = 2
    * periodUnit = #d
    * timeOfDay[+] = "20:00:00"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-TimingSingleDosageForTimeOfDay-Dispense-08-of-09
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid (Dispense): timeOfDay alle 2 Tage auf zwei Dosages verteilt (gleiche Dosis)"
Description: "Intervall-Kombination alle 2 Tage, 08:00 und 20:00 Uhr je 1 Stück in zwei Dosages mit identischer Dosis - muss zu einer Dosage zusammengeführt werden."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * period = 2
    * periodUnit = #d
    * timeOfDay[+] = "08:00:00"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosageInstruction[+]
  * timing.repeat
    * period = 2
    * periodUnit = #d
    * timeOfDay[+] = "20:00:00"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-TimingSingleDosageForTimeOfDay-Statement-09-of-09
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid (Statement): timeOfDay alle 2 Tage auf zwei Dosages verteilt (gleiche Dosis)"
Description: "Intervall-Kombination alle 2 Tage, 08:00 und 20:00 Uhr je 1 Stück in zwei Dosages mit identischer Dosis - muss zu einer Dosage zusammengeführt werden."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat
    * period = 2
    * periodUnit = #d
    * timeOfDay[+] = "08:00:00"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosage[+]
  * timing.repeat
    * period = 2
    * periodUnit = #d
    * timeOfDay[+] = "20:00:00"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: W-TimingSingleDosageForTimeOfDayWarning-MR-07-of-09
InstanceOf: MedicationRequestDE
Usage: #example
Title: "Warning (Request): timeOfDay alle 2 Tage auf zwei Dosages verteilt (gleiche Dosis)"
Description: "Warning example - Intervall-Kombination alle 2 Tage, 08:00 und 20:00 Uhr je 1 Stück in zwei Dosages mit identischer Dosis; sollte zu einer Dosage zusammengeführt werden."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * period = 2
    * periodUnit = #d
    * timeOfDay[+] = "08:00:00"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosageInstruction[+]
  * timing.repeat
    * period = 2
    * periodUnit = #d
    * timeOfDay[+] = "20:00:00"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: W-TimingSingleDosageForTimeOfDayWarning-MD-08-of-09
InstanceOf: MedicationDispenseDE
Usage: #example
Title: "Warning (Dispense): timeOfDay alle 2 Tage auf zwei Dosages verteilt (gleiche Dosis)"
Description: "Warning example - Intervall-Kombination alle 2 Tage, 08:00 und 20:00 Uhr je 1 Stück in zwei Dosages mit identischer Dosis; sollte zu einer Dosage zusammengeführt werden."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * period = 2
    * periodUnit = #d
    * timeOfDay[+] = "08:00:00"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosageInstruction[+]
  * timing.repeat
    * period = 2
    * periodUnit = #d
    * timeOfDay[+] = "20:00:00"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: W-TimingSingleDosageForTimeOfDayWarning-MS-09-of-09
InstanceOf: MedicationStatementDE
Usage: #example
Title: "Warning (Statement): timeOfDay alle 2 Tage auf zwei Dosages verteilt (gleiche Dosis)"
Description: "Warning example - Intervall-Kombination alle 2 Tage, 08:00 und 20:00 Uhr je 1 Stück in zwei Dosages mit identischer Dosis; sollte zu einer Dosage zusammengeführt werden."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat
    * period = 2
    * periodUnit = #d
    * timeOfDay[+] = "08:00:00"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosage[+]
  * timing.repeat
    * period = 2
    * periodUnit = #d
    * timeOfDay[+] = "20:00:00"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-TimingSingleDosageForWhen-Request-07-of-09
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid (Request): when alle 2 Tage auf zwei Dosages verteilt (gleiche Dosis)"
Description: "Intervall-Kombination alle 2 Tage, morgens und abends je 1 Stück in zwei Dosages mit identischer Dosis - muss zu einer Dosage zusammengeführt werden."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * period = 2
    * periodUnit = #d
    * when[+] = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosageInstruction[+]
  * timing.repeat
    * period = 2
    * periodUnit = #d
    * when[+] = #EVE
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-TimingSingleDosageForWhen-Dispense-08-of-09
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid (Dispense): when alle 2 Tage auf zwei Dosages verteilt (gleiche Dosis)"
Description: "Intervall-Kombination alle 2 Tage, morgens und abends je 1 Stück in zwei Dosages mit identischer Dosis - muss zu einer Dosage zusammengeführt werden."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * period = 2
    * periodUnit = #d
    * when[+] = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosageInstruction[+]
  * timing.repeat
    * period = 2
    * periodUnit = #d
    * when[+] = #EVE
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-TimingSingleDosageForWhen-Statement-09-of-09
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid (Statement): when alle 2 Tage auf zwei Dosages verteilt (gleiche Dosis)"
Description: "Intervall-Kombination alle 2 Tage, morgens und abends je 1 Stück in zwei Dosages mit identischer Dosis - muss zu einer Dosage zusammengeführt werden."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat
    * period = 2
    * periodUnit = #d
    * when[+] = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosage[+]
  * timing.repeat
    * period = 2
    * periodUnit = #d
    * when[+] = #EVE
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: W-TimingSingleDosageForWhenWarning-MR-07-of-09
InstanceOf: MedicationRequestDE
Usage: #example
Title: "Warning (Request): when alle 2 Tage auf zwei Dosages verteilt (gleiche Dosis)"
Description: "Warning example - Intervall-Kombination alle 2 Tage, morgens und abends je 1 Stück in zwei Dosages mit identischer Dosis; sollte zu einer Dosage zusammengeführt werden."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * period = 2
    * periodUnit = #d
    * when[+] = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosageInstruction[+]
  * timing.repeat
    * period = 2
    * periodUnit = #d
    * when[+] = #EVE
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: W-TimingSingleDosageForWhenWarning-MD-08-of-09
InstanceOf: MedicationDispenseDE
Usage: #example
Title: "Warning (Dispense): when alle 2 Tage auf zwei Dosages verteilt (gleiche Dosis)"
Description: "Warning example - Intervall-Kombination alle 2 Tage, morgens und abends je 1 Stück in zwei Dosages mit identischer Dosis; sollte zu einer Dosage zusammengeführt werden."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * period = 2
    * periodUnit = #d
    * when[+] = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosageInstruction[+]
  * timing.repeat
    * period = 2
    * periodUnit = #d
    * when[+] = #EVE
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: W-TimingSingleDosageForWhenWarning-MS-09-of-09
InstanceOf: MedicationStatementDE
Usage: #example
Title: "Warning (Statement): when alle 2 Tage auf zwei Dosages verteilt (gleiche Dosis)"
Description: "Warning example - Intervall-Kombination alle 2 Tage, morgens und abends je 1 Stück in zwei Dosages mit identischer Dosis; sollte zu einer Dosage zusammengeführt werden."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat
    * period = 2
    * periodUnit = #d
    * when[+] = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosage[+]
  * timing.repeat
    * period = 2
    * periodUnit = #d
    * when[+] = #EVE
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
