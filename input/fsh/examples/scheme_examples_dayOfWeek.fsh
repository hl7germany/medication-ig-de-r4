Instance: Example-MR-Dosage-weekday-2t
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Dosage-weekday-2t"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung von Dienstags und Donnerstags je 2 Tabletten dar"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek[+] = #tue
    * dayOfWeek[+] = #thu
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MR-Dosage-weekday-3t
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Dosage-weekday-3t"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung von Dienstags, Donnerstags und Samstag je 2 Tabletten dar"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek[+] = #tue
    * dayOfWeek[+] = #thu
    * dayOfWeek[+] = #sat
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MR-Dosage-weekday-2t-1t
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Dosage-2t-1t"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung von Montags 2 Tabletten, Donnerstags 1 Tablette dar"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek[+] = #mon
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek[+] = #thu
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MR-Dosage-weekday-2t-bound
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Dosage-weekday-2t-bound"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung von Montags 2 Tabl. für 10 Wochen dar"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek[+] = #mon
    * boundsDuration = 10 $ucum#wk "Woche(n)"
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"
