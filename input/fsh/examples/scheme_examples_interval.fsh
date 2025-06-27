
Instance: Example-MR-Dosage-interval-8h
InstanceOf: DE_DOSAGE_DGMP_MEDICATIONREQUEST
Usage: #example
Title: "Example-MR-Dosage-interval-8h"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung von 1 Tablette alle 8 Stunden dar"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Medication"
* dosageInstruction[+] = Example-Dosage-Interval-8h

Instance: Example-Dosage-Interval-8h
InstanceOf: DE_DOSAGE_DGMP
Usage: #inline
Title: "Dosage with every 8hrs"
* text = "tbd"
* timing.repeat.frequency = 1
* timing.repeat.period = 8
* timing.repeat.periodUnit = #h
* doseAndRate.doseQuantity.value = 1
* doseAndRate.doseQuantity.unit = "Tablette"

Instance: Example-MR-Dosage-interval-2wk
InstanceOf: DE_DOSAGE_DGMP_MEDICATIONREQUEST
Usage: #example
Title: "Example-MR-Dosage-interval-2wk"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung von 1 Tablette alle 2 Wochen dar"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Medication"
* dosageInstruction[+] = Example-Dosage-Interval-2wk

Instance: Example-Dosage-Interval-2wk
InstanceOf: DE_DOSAGE_DGMP
Usage: #inline
Title: "Dosage with interval every 2 Weeks"
* text = "tbd"
* timing.repeat.frequency = 1
* timing.repeat.period = 2
* timing.repeat.periodUnit = #wk
* doseAndRate.doseQuantity.value = 1
* doseAndRate.doseQuantity.unit = "Tablette"


Instance: Example-MR-Dosage-interval-4times-d
InstanceOf: DE_DOSAGE_DGMP_MEDICATIONREQUEST
Usage: #example
Title: "Example-MR-Dosage-interval-4times-d"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung von 4 x 1 Tablette pro Tag dar"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Medication"
* dosageInstruction[+] = Example-Dosage-Interval-4times-d

Instance: Example-Dosage-Interval-4times-d
InstanceOf: DE_DOSAGE_DGMP
Usage: #inline
Title: "Dosage with 4 times per day"
* text = "tbd"
* timing.repeat.frequency = 4
* timing.repeat.period = 1
* timing.repeat.periodUnit = #d
* doseAndRate.doseQuantity.value = 1
* doseAndRate.doseQuantity.unit = "Tablette"

Instance: Example-MR-Dosage-interval-3d
InstanceOf: DE_DOSAGE_DGMP_MEDICATIONREQUEST
Usage: #example
Title: "Example-MR-Dosage-interval-3d"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung von Alle 3 Tage 1 Tablette dar"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Medication"
* dosageInstruction[+] = Example-Dosage-Interval-3d

Instance: Example-Dosage-Interval-3d
InstanceOf: DE_DOSAGE_DGMP
Usage: #inline
Title: "Dosage with interval every 3 days"
* text = "tbd"
* timing.repeat.frequency = 1
* timing.repeat.period = 3
* timing.repeat.periodUnit = #d
* doseAndRate.doseQuantity.value = 1
* doseAndRate.doseQuantity.unit = "Tablette"

Instance: Example-MR-Dosage-interval-2d-bounds
InstanceOf: DE_DOSAGE_DGMP_MEDICATIONREQUEST
Usage: #example
Title: "Example-MR-Dosage-interval-2d"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung von Alle 2 Tage 2 Tabletten für 6 Wochen dar"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Medication"
* dosageInstruction[+] = Example-Dosage-Interval-2d-bounds

Instance: Example-Dosage-Interval-2d-bounds
InstanceOf: DE_DOSAGE_DGMP
Usage: #inline
Title: "Dosage with every 2 day for 6 weeks"
* text = "tbd"
* timing.repeat.frequency = 1
* timing.repeat.period = 2
* timing.repeat.periodUnit = #d
* timing.repeat.boundsDuration.value = 6
* timing.repeat.boundsDuration.unit = "Woche(n)"
* doseAndRate.doseQuantity.value = 2
* doseAndRate.doseQuantity.unit = "Tablette"