Instance: Example-MR-Dosage-comb-interval-1
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Dosage-comb-interval-1"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung von Jeden 2. Tag 1 Stück um 08:00 Uhr und 1 Stück um 18:00 Uhr dar"
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
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung von 1 x pro Woche 1 Stück morgens dar"
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

Instance: Example-MR-Dosage-comb-interval-3
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Dosage-comb-interval-3"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung von Jeden 2. Tag 1 Stück um 08:00 Uhr und jeden 2. Tag 1 Stück um 20:00 Uhr dar"
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

Instance: Example-MR-Dosage-comb-interval-4
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Dosage-comb-interval-4"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung von Jeden 2. Tag 1 Stück um 08:00 & 20:00 Uhr und jeden 2. Tag 1 Stück um 08:00, 14:00 und 22:00 Uhr dar"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * frequency = 2
    * period = 2
    * periodUnit = #d
    * timeOfDay[+] = "08:00:00"
    * timeOfDay[+] = "20:00:00"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

* dosageInstruction[+]
  * timing.repeat
    * frequency = 3
    * period = 2
    * periodUnit = #d
    * timeOfDay[+] = "10:00:00"
    * timeOfDay[+] = "14:00:00"
    * timeOfDay[+] = "22:00:00"
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

