
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
* text = "tbd"
* timing.repeat.dayOfWeek[+] = #tue
* timing.repeat.dayOfWeek[+] = #thu
* doseAndRate.doseQuantity.value = 2
* doseAndRate.doseQuantity.unit = "Tabletten"


Instance: Example-MR-Dosage-2t-1t
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
* text = "tbd"
* timing.repeat.dayOfWeek[+] = #mon
* doseAndRate.doseQuantity.value = 2
* doseAndRate.doseQuantity.unit = "Tabletten"

Instance: Example-Dosage-weekday-2t-1t-2
InstanceOf: DE_DOSAGE_DGMP
Usage: #inline
Title: "Dosage with dayOfWeek Thursday"
* text = "tbd"
* timing.repeat.dayOfWeek[+] = #thu
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
* text = "tbd"
* timing.repeat.dayOfWeek[+] = #mon
* timing.repeat.boundsDuration.value = 10
* timing.repeat.boundsDuration.unit = "Wochen"
* doseAndRate.doseQuantity.value = 2
* doseAndRate.doseQuantity.unit = "Tabletten"
