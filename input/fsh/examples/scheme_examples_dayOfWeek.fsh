Instance: Example-MR-Dosage-weekday-2t
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Dosage-weekday-2t"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung von Dienstags und Donnerstags je 2 Stück dar"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek[+] = #tue
    * dayOfWeek[+] = #thu
    * frequency = 2
    * period = 1
    * periodUnit = #wk
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MR-Dosage-weekday-3t
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Dosage-weekday-3t"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung von Dienstags, Donnerstags und Samstag je 2 Stück dar"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek[+] = #tue
    * dayOfWeek[+] = #thu
    * dayOfWeek[+] = #sat
    * frequency = 3
    * period = 1
    * periodUnit = #wk
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MR-Dosage-weekday-2t-1t
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Dosage-2t-1t"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung von Montags 2 Stück, Donnerstags 1 Stück dar"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek[+] = #mon
    * frequency = 1
    * period = 1
    * periodUnit = #wk
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek[+] = #thu
    * frequency = 1
    * period = 1
    * periodUnit = #wk
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
    * frequency = 1
    * period = 1
    * periodUnit = #wk
    * boundsDuration = 10 $ucum#wk "Woche(n)"
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MR-Dosage-weekday-unsorted
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Dosage-weekday-unsorted"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung von unsortierten Wochentagen je 2 Stück dar"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek[+] = #fri
    * dayOfWeek[+] = #tue
    * dayOfWeek[+] = #thu
    * dayOfWeek[+] = #mon
    * frequency = 4
    * period = 1
    * periodUnit = #wk
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"