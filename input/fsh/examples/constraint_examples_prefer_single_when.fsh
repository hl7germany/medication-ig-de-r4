Instance: Invalid-Dosage-C-TimingSingleDosageForWhen-01-of-01
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid: split when into two dosages (same period/dose)"
Description: "Zwei Dosages mit identischem Intervall und Dosis, jeweils ein Zeitraum (MORN/EVE) - sollte zu einer Dosage zusammengeführt werden."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d
    * when[+] = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosageInstruction[+]
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d
    * when[+] = #EVE
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
