// Regression examples: three separate Dosage elements with the doses 1, 1 and 2.
// A distinct-count check of only "> 1" accepted these examples incorrectly.

Instance: INV-C-TimingSingleDosageForTimeOfDay-Request-04-of-06
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid (Request): teilweise identische Dosis bei timeOfDay"
Description: "Drei Dosages mit den Dosen 1, 1 und 2 Stück. Die beiden Dosages mit identischer Dosis müssen zusammengeführt werden."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.timeOfDay[+] = "08:00:00"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosageInstruction[+]
  * timing.repeat.timeOfDay[+] = "12:00:00"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosageInstruction[+]
  * timing.repeat.timeOfDay[+] = "20:00:00"
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-TimingSingleDosageForTimeOfDay-Dispense-05-of-06
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid (Dispense): teilweise identische Dosis bei timeOfDay"
Description: "Drei Dosages mit den Dosen 1, 1 und 2 Stück. Die beiden Dosages mit identischer Dosis müssen zusammengeführt werden."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.timeOfDay[+] = "08:00:00"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosageInstruction[+]
  * timing.repeat.timeOfDay[+] = "12:00:00"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosageInstruction[+]
  * timing.repeat.timeOfDay[+] = "20:00:00"
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-TimingSingleDosageForTimeOfDay-Statement-06-of-06
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid (Statement): teilweise identische Dosis bei timeOfDay"
Description: "Drei Dosages mit den Dosen 1, 1 und 2 Stück. Die beiden Dosages mit identischer Dosis müssen zusammengeführt werden."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat.timeOfDay[+] = "08:00:00"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosage[+]
  * timing.repeat.timeOfDay[+] = "12:00:00"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosage[+]
  * timing.repeat.timeOfDay[+] = "20:00:00"
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-TimingSingleDosageForWhen-Request-04-of-06
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid (Request): teilweise identische Dosis bei when"
Description: "Drei Dosages mit den Dosen 1, 1 und 2 Stück. Die beiden Dosages mit identischer Dosis müssen zusammengeführt werden."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.when[+] = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosageInstruction[+]
  * timing.repeat.when[+] = #NOON
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosageInstruction[+]
  * timing.repeat.when[+] = #EVE
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-TimingSingleDosageForWhen-Dispense-05-of-06
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid (Dispense): teilweise identische Dosis bei when"
Description: "Drei Dosages mit den Dosen 1, 1 und 2 Stück. Die beiden Dosages mit identischer Dosis müssen zusammengeführt werden."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.when[+] = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosageInstruction[+]
  * timing.repeat.when[+] = #NOON
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosageInstruction[+]
  * timing.repeat.when[+] = #EVE
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-TimingSingleDosageForWhen-Statement-06-of-06
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid (Statement): teilweise identische Dosis bei when"
Description: "Drei Dosages mit den Dosen 1, 1 und 2 Stück. Die beiden Dosages mit identischer Dosis müssen zusammengeführt werden."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat.when[+] = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosage[+]
  * timing.repeat.when[+] = #NOON
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosage[+]
  * timing.repeat.when[+] = #EVE
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

Instance: W-TimingSingleDosageForTimeOfDayWarning-MR-04-of-06
InstanceOf: MedicationRequestDE
Usage: #example
Title: "Warning (Request): teilweise identische Dosis bei timeOfDay"
Description: "Warning example - drei Dosages mit den Dosen 1, 1 und 2 Stück; die beiden Dosages mit identischer Dosis sollten zusammengeführt werden."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.timeOfDay[+] = "08:00:00"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosageInstruction[+]
  * timing.repeat.timeOfDay[+] = "12:00:00"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosageInstruction[+]
  * timing.repeat.timeOfDay[+] = "20:00:00"
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

Instance: W-TimingSingleDosageForTimeOfDayWarning-MD-05-of-06
InstanceOf: MedicationDispenseDE
Usage: #example
Title: "Warning (Dispense): teilweise identische Dosis bei timeOfDay"
Description: "Warning example - drei Dosages mit den Dosen 1, 1 und 2 Stück; die beiden Dosages mit identischer Dosis sollten zusammengeführt werden."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.timeOfDay[+] = "08:00:00"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosageInstruction[+]
  * timing.repeat.timeOfDay[+] = "12:00:00"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosageInstruction[+]
  * timing.repeat.timeOfDay[+] = "20:00:00"
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

Instance: W-TimingSingleDosageForTimeOfDayWarning-MS-06-of-06
InstanceOf: MedicationStatementDE
Usage: #example
Title: "Warning (Statement): teilweise identische Dosis bei timeOfDay"
Description: "Warning example - drei Dosages mit den Dosen 1, 1 und 2 Stück; die beiden Dosages mit identischer Dosis sollten zusammengeführt werden."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat.timeOfDay[+] = "08:00:00"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosage[+]
  * timing.repeat.timeOfDay[+] = "12:00:00"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosage[+]
  * timing.repeat.timeOfDay[+] = "20:00:00"
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

Instance: W-TimingSingleDosageForWhenWarning-MR-04-of-06
InstanceOf: MedicationRequestDE
Usage: #example
Title: "Warning (Request): teilweise identische Dosis bei when"
Description: "Warning example - drei Dosages mit den Dosen 1, 1 und 2 Stück; die beiden Dosages mit identischer Dosis sollten zusammengeführt werden."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.when[+] = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosageInstruction[+]
  * timing.repeat.when[+] = #NOON
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosageInstruction[+]
  * timing.repeat.when[+] = #EVE
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

Instance: W-TimingSingleDosageForWhenWarning-MD-05-of-06
InstanceOf: MedicationDispenseDE
Usage: #example
Title: "Warning (Dispense): teilweise identische Dosis bei when"
Description: "Warning example - drei Dosages mit den Dosen 1, 1 und 2 Stück; die beiden Dosages mit identischer Dosis sollten zusammengeführt werden."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.when[+] = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosageInstruction[+]
  * timing.repeat.when[+] = #NOON
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosageInstruction[+]
  * timing.repeat.when[+] = #EVE
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

Instance: W-TimingSingleDosageForWhenWarning-MS-06-of-06
InstanceOf: MedicationStatementDE
Usage: #example
Title: "Warning (Statement): teilweise identische Dosis bei when"
Description: "Warning example - drei Dosages mit den Dosen 1, 1 und 2 Stück; die beiden Dosages mit identischer Dosis sollten zusammengeführt werden."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat.when[+] = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosage[+]
  * timing.repeat.when[+] = #NOON
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosage[+]
  * timing.repeat.when[+] = #EVE
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"
