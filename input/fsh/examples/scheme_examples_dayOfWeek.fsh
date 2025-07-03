Instance: Example-MR-Dosage-weekday-2t
InstanceOf: DE_DOSAGE_DGMP_MEDICATIONREQUEST
Usage: #example
Title: "Example-MR-Dosage-weekday-2t"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung von Dienstags und Donnerstags je 2 Tabletten dar"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Medication"
* dosageInstruction[+] = Example-Dosage-weekday-2t

Instance: Example-Dosage-weekday-2t
InstanceOf: DE_DOSAGE_DGMP
Usage: #inline
Title: "Dosage with dayOfWeek Tuesday and Thursday"
* timing.repeat
  * dayOfWeek[+] = #tue
  * dayOfWeek[+] = #thu
  * frequency = 1
  * period = 1
  * periodUnit = #d
* doseAndRate.doseQuantity.value = 2
* doseAndRate.doseQuantity.unit = "Tabletten"
// TODO Add Example with 3 Days for render format mon, tue and fri

Instance: Example-MR-Dosage-weekday-2t-1t
InstanceOf: DE_DOSAGE_DGMP_MEDICATIONREQUEST
Usage: #example
Title: "Example-MR-Dosage-2t-1t"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung von Montags 2 Tabletten, Donnerstags 1 Tablette dar"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Medication"
* dosageInstruction[+] = Example-Dosage-weekday-2t-1t-1
* dosageInstruction[+] = Example-Dosage-weekday-2t-1t-2

Instance: Example-Dosage-weekday-2t-1t-1
InstanceOf: DE_DOSAGE_DGMP
Usage: #inline
Title: "Dosage with dayOfWeek Monday"
* timing.repeat
  * dayOfWeek[+] = #mon
  * frequency = 1
  * period = 1
  * periodUnit = #d
* doseAndRate.doseQuantity.value = 2
* doseAndRate.doseQuantity.unit = "Tabletten"

Instance: Example-Dosage-weekday-2t-1t-2
InstanceOf: DE_DOSAGE_DGMP
Usage: #inline
Title: "Dosage with dayOfWeek Thursday"
* timing.repeat
  * dayOfWeek[+] = #thu
  * frequency = 1
  * period = 1
  * periodUnit = #d
* doseAndRate.doseQuantity.value = 1
* doseAndRate.doseQuantity.unit = "Tabletten"

Instance: Example-MR-Dosage-weekday-2t-bound
InstanceOf: DE_DOSAGE_DGMP_MEDICATIONREQUEST
Usage: #example
Title: "Example-MR-Dosage-weekday-2t-bound"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung von Montags 2 Tabl. für 10 Wochen dar"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Medication"
* dosageInstruction[+] = Example-Dosage-weekday-weekday-2t-bound

Instance: Example-Dosage-weekday-weekday-2t-bound
InstanceOf: DE_DOSAGE_DGMP
Usage: #inline
Title: "Dosage with dayOfWeek Monday"
* timing.repeat
  * dayOfWeek[+] = #mon
  * frequency = 1
  * period = 1
  * periodUnit = #d
* timing.repeat.boundsDuration.value = 10
* timing.repeat.boundsDuration.unit = "Wochen"
* doseAndRate.doseQuantity.value = 2
* doseAndRate.doseQuantity.unit = "Tabletten"
