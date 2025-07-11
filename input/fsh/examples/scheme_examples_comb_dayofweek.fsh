Instance: Example-MR-Dosage-comb-dayofweek-1
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Dosage-comb-dayofweek-1"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung von Montags und Freitags 1-0-1-0 dar"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek[+] = #mon
    * dayOfWeek[+] = #fri
    * when[+] = #MORN
    * when[+] = #EVE
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MR-Dosage-comb-dayofweek-unsorted
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Dosage-comb-dayofweek-unsorted"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung von unsortierten Wochentagen dar"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek[+] = #sat
    * dayOfWeek[+] = #mon
    * dayOfWeek[+] = #thu
    * when[+] = #EVE
    * when[+] = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"


Instance: Example-MR-Dosage-comb-dayofweek-2
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Dosage-comb-dayofweek-2"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung von Montags und Freitags 1-0-2-0 dar"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek[+] = #mon
    * dayOfWeek[+] = #fri
    * when[+] = #MORN
    * when[+] = #EVE
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek[+] = #tue
    * dayOfWeek[+] = #sat
    * when[+] = #MORN
    * when[+] = #EVE
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MR-Dosage-comb-dayofweek-3
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Dosage-comb-dayofweek-3"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung von Montags und Freitags 1 Tablette um 08:00 Uhr und 2 Tabletten um 10:00 Uhr - für 3 Wochen dar"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek[+] = #mon
    * dayOfWeek[+] = #fri
    * when[+] = #MORN
    * boundsDuration = 3 $ucum#wk "Woche(n)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek[+] = #mon
    * dayOfWeek[+] = #fri
    * when[+] = #NOON
    * boundsDuration = 3 $ucum#wk "Woche(n)"
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"
