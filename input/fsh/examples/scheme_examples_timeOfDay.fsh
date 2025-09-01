Instance: Example-MR-Dosage-tod-1t-8am
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Dosage-tod-1t-8am"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung von 1 Stück um 08:00"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * timeOfDay[+] = "08:00:00"
    * frequency = 1
    * period = 1
    * periodUnit = #d
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MR-Dosage-tod-2-12am
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Dosage-tod-2-12am"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung von 2 Stück um 12:00 Uhr"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * timeOfDay[+] = "12:00:00"
    * frequency = 1
    * period = 1
    * periodUnit = #d
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MR-Dosage-tod-multi
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Dosage-tod-multi"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung von 8 Uhr: 2 Stück - 11 Uhr: 1 Stück - 14 Uhr: 1 Stück - 17 Uhr: 1 Stück - 20 Uhr: 1 Stück - 23 Uhr: 1 Stück dar"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * timeOfDay[+] = "08:00:00"
    * frequency = 1
    * period = 1
    * periodUnit = #d
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

* dosageInstruction[+]
  * timing.repeat
    * timeOfDay[+] = "11:00:00"
    * timeOfDay[+] = "14:00:00"
    * timeOfDay[+] = "17:00:00"
    * timeOfDay[+] = "20:00:00"
    * timeOfDay[+] = "23:00:00"
    * frequency = 5
    * period = 1
    * periodUnit = #d
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MR-Dosage-tod-multi-bound
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Dosage-tod-multi-bound"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung 8 Uhr: 2 Stück - 11 Uhr: 1 Stück - 14 Uhr: 1 Stück - 17 Uhr: 1 Stück - 20 Uhr: 1 Stück - 23 Uhr: 1 Stück, für 10 Tage"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * timeOfDay[+] = "08:00:00" 
    * frequency = 1
    * period = 1
    * periodUnit = #d
    * boundsDuration = 10 $ucum#d "Tag(e)"
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

* dosageInstruction[+]
  * timing.repeat
    * timeOfDay[+] = "11:00:00"
    * timeOfDay[+] = "14:00:00"
    * timeOfDay[+] = "17:00:00"
    * timeOfDay[+] = "20:00:00"
    * timeOfDay[+] = "23:00:00"
    * frequency = 5
    * period = 1
    * periodUnit = #d
    * boundsDuration = 10 $ucum#d "Tag(e)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MR-Dosage-tod-unsorted
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Dosage-tod-unsorted"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung von 1 Stück und unsortierten Zeiten dar"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * timeOfDay[+] = "15:00:00"
    * timeOfDay[+] = "08:00:00"
    * frequency = 2
    * period = 1
    * periodUnit = #d
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"