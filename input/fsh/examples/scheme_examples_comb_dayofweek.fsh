
Instance: Example-MR-Dosage-comb-dayofweek-1
InstanceOf: DE_DOSAGE_DGMP_MEDICATIONREQUEST
Usage: #example
Title: "Example-MR-Dosage-comb-dayofweek-1"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung von Montags und Freitags 1-0-1-0 dar"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Medication"
* dosageInstruction[+] = Example-Dosage-comb-dayofweek-1

Instance: Example-Dosage-comb-dayofweek-1
InstanceOf: DE_DOSAGE_DGMP
Usage: #inline
Title: "Dosage with every mon and friday morning and evening"
* text = "tbd"
* timing.repeat
  * dayOfWeek[+] = #mon
  * dayOfWeek[+] = #fri
  * when[+] = #MORN
  * when[+] = #EVE

* doseAndRate.doseQuantity.value = 1
* doseAndRate.doseQuantity.unit = "Tablette"


Instance: Example-MR-Dosage-comb-dayofweek-2
InstanceOf: DE_DOSAGE_DGMP_MEDICATIONREQUEST
Usage: #example
Title: "Example-MR-Dosage-comb-dayofweek-2"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung von Montags und Freitags 1-0-2-0 dar"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Medication"
* dosageInstruction[+] = Example-Dosage-comb-dayofweek-2-1
* dosageInstruction[+] = Example-Dosage-comb-dayofweek-2-2

Instance: Example-Dosage-comb-dayofweek-2-1
InstanceOf: DE_DOSAGE_DGMP
Usage: #inline
Title: "Dosage with every mon and friday morning and evening"
* text = "tbd"
* timing.repeat
  * dayOfWeek[+] = #mon
  * dayOfWeek[+] = #fri
  * when[+] = #MORN
  * when[+] = #EVE

* doseAndRate.doseQuantity.value = 1
* doseAndRate.doseQuantity.unit = "Tablette"

Instance: Example-Dosage-comb-dayofweek-2-2
InstanceOf: DE_DOSAGE_DGMP
Usage: #inline
Title: "Dosage with every mon and friday morning and evening"
* text = "tbd"
* timing.repeat
  * dayOfWeek[+] = #mon
  * dayOfWeek[+] = #fri
  * when[+] = #MORN
  * when[+] = #EVE

* doseAndRate.doseQuantity.value = 2
* doseAndRate.doseQuantity.unit = "Tabletten"

Instance: Example-MR-Dosage-comb-dayofweek-3
InstanceOf: DE_DOSAGE_DGMP_MEDICATIONREQUEST
Usage: #example
Title: "Example-MR-Dosage-comb-dayofweek-3"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung von Montags und Freitags 1 Tablette um 08:00 Uhr und 2 Tabletten um 10:00 Uhr - für 3 Wochen dar"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Medication"
* dosageInstruction[+] = Example-Dosage-comb-dayofweek-3-1
* dosageInstruction[+] = Example-Dosage-comb-dayofweek-3-2

Instance: Example-Dosage-comb-dayofweek-3-1
InstanceOf: DE_DOSAGE_DGMP
Usage: #inline
Title: "Dosage with every mon and friday 08:00"
* text = "tbd"
* timing.repeat
  * dayOfWeek[+] = #mon
  * dayOfWeek[+] = #fri
  * timeOfDay[+] = "08:00:00"
  * boundsDuration.value = 3
  * boundsDuration.unit = "Woche(n)"

* doseAndRate.doseQuantity.value = 1
* doseAndRate.doseQuantity.unit = "Tablette"

Instance: Example-Dosage-comb-dayofweek-3-2
InstanceOf: DE_DOSAGE_DGMP
Usage: #inline
Title: "Dosage with every mon and friday 10:00"
* text = "tbd"
* timing.repeat
  * dayOfWeek[+] = #mon
  * dayOfWeek[+] = #fri
  * timeOfDay[+] = "10:00:00"
  * boundsDuration.value = 3
  * boundsDuration.unit = "Woche(n)"

* doseAndRate.doseQuantity.value = 2
* doseAndRate.doseQuantity.unit = "Tabletten"
