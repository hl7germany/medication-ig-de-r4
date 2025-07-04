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
    * frequency = 1
    * period = 1
    * periodUnit = #d
  * doseAndRate.doseQuantity.value = 1
  * doseAndRate.doseQuantity.unit = "Tablette"


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
    * frequency = 1
    * period = 1
    * periodUnit = #d
  * doseAndRate.doseQuantity.value = 1
  * doseAndRate.doseQuantity.unit = "Tablette"

* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek[+] = #mon
    * dayOfWeek[+] = #fri
    * when[+] = #MORN
    * when[+] = #EVE
    * frequency = 1
    * period = 1
    * periodUnit = #d
  * doseAndRate.doseQuantity.value = 2
  * doseAndRate.doseQuantity.unit = "Tabletten"

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
    * boundsDuration.value = 3
    * boundsDuration.unit = "Woche(n)"
    * frequency = 1
    * period = 1
    * periodUnit = #d
  * doseAndRate.doseQuantity.value = 1
  * doseAndRate.doseQuantity.unit = "Tablette"

* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek[+] = #mon
    * dayOfWeek[+] = #fri
    * when[+] = #NOON
    * boundsDuration.value = 3
    * boundsDuration.unit = "Woche(n)"
    * frequency = 1
    * period = 1
    * periodUnit = #d
  * doseAndRate.doseQuantity.value = 2
  * doseAndRate.doseQuantity.unit = "Tabletten"
