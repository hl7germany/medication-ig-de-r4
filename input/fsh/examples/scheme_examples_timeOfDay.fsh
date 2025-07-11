Instance: Example-MR-Dosage-tod-1t-8am
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Dosage-tod-1t-8am"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung von 1 Tablette um 08:00"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * timeOfDay[+] = "08:00:00"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MR-Dosage-tod-2-12am
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Dosage-tod-2-12am"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung von 2 Tabletten um 12:00 Uhr"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * timeOfDay[+] = "12:00:00"
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MR-Dosage-tod-multi
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Dosage-tod-multi"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung von 8 Uhr 2 Tabletten - 11 Uhr 1 Tablette - 14 Uhr 1 Tablette - 17 Uhr 1 Tablette - 20 Uhr 1 Tablette - 23 Uhr 1 Tablette dar"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * timeOfDay[+] = "08:00:00"
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

* dosageInstruction[+]
  * timing.repeat
    * timeOfDay[+] = "11:00:00"
  * timing.repeat
    * timeOfDay[+] = "14:00:00"
  * timing.repeat
    * timeOfDay[+] = "17:00:00"
  * timing.repeat
    * timeOfDay[+] = "20:00:00"
  * timing.repeat
    * timeOfDay[+] = "23:00:00"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MR-Dosage-tod-multi-bound
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Dosage-tod-multi-bound"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung 8 Uhr 2 Tabletten - 11 Uhr 1 Tablette - 14 Uhr 1 Tablette - 17 Uhr 1 Tablette - 20 Uhr 1 Tablette - 23 Uhr 1 Tablette, für 10 Tage"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * timeOfDay[+] = "08:00:00" 
    * boundsDuration = 10 $ucum#d "Tag(e)"
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

* dosageInstruction[+]
  * timing.repeat.boundsDuration = 10 $ucum#d "Tag(e)"
  * timing.repeat
    * timeOfDay[+] = "11:00:00"
  * timing.repeat
    * timeOfDay[+] = "14:00:00"
  * timing.repeat
    * timeOfDay[+] = "17:00:00"
  * timing.repeat
    * timeOfDay[+] = "20:00:00"
  * timing.repeat
    * timeOfDay[+] = "23:00:00"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"