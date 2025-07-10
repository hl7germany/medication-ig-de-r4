Instance: Example-MR-Dosage-comb-interval-1
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Dosage-comb-interval-1"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung von Jeden 2. Tag 1 Tablette um 08:00 Uhr und 1 Tablette um 10:00 Uhr dar"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * frequency = 1
    * period = 2
    * periodUnit = #d
    * timeOfDay[+] = "08:00:00"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

* dosageInstruction[+]
  * timing.repeat
    * frequency = 1
    * period = 2
    * periodUnit = #d
    * timeOfDay[+] = "18:00:00"
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MR-Dosage-comb-interval-2
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Dosage-comb-interval-2"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung von 1 x pro Woche 1 Tablette morgens dar"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodUnit = #wk
    * when[+] = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MR-Dosage-comb-interval-3
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Dosage-comb-interval-3"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung von Jeden 2. Tag 1 Tablette um 08:00 Uhr und jeden 2. Tag 1 Tablette um 08:00 Uhr dar"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * frequency = 1
    * period = 2
    * periodUnit = #d
    * timeOfDay[+] = "08:00:00"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

* dosageInstruction[+]
  * timing.repeat
    * frequency = 1
    * period = 2
    * periodUnit = #d
    * timeOfDay[+] = "20:00:00"
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"