Instance: Invalid-Dosage-C-TimingSingleDosageForTimeOfDay-01-of-01
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid: split timeOfDay into two dosages (same period/dose)"
Description: "Zwei Dosages mit identischem Intervall und Dosis, jeweils eine Uhrzeit - sollte zu einer Dosage zusammengeführt werden."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d
    * timeOfDay[+] = "08:00:00"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosageInstruction[+]
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d
    * timeOfDay[+] = "20:00:00"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
