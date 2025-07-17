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
    * frequency = 4
    * period = 1
    * periodUnit = #wk
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
    * frequency = 6
    * period = 1
    * periodUnit = #wk
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
    * frequency = 4
    * period = 1
    * periodUnit = #wk
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek[+] = #mon
    * dayOfWeek[+] = #fri
    * when[+] = #MORN
    * when[+] = #EVE
    * frequency = 4
    * period = 1
    * periodUnit = #wk
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MR-Dosage-comb-dayofweek-3
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Dosage-comb-dayofweek-3"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung von Montags und Freitags 1 Tablette Morgens und 2 Tabletten Mittags (1-1-0-0) - für 3 Wochen dar"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek[+] = #mon
    * dayOfWeek[+] = #fri
    * when[+] = #MORN
    * frequency = 2
    * period = 1
    * periodUnit = #wk
    * boundsDuration = 3 $ucum#wk "Woche(n)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek[+] = #mon
    * dayOfWeek[+] = #fri
    * when[+] = #NOON
    * frequency = 2
    * period = 1
    * periodUnit = #wk
    * boundsDuration = 3 $ucum#wk "Woche(n)"
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"
