Instance: Example-MR-Dosage-interval-8d
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Dosage-interval-8d"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung von 1 Tablette alle 8 Tage dar"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.frequency = 1
  * timing.repeat.period = 8
  * timing.repeat.periodUnit = #d
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MR-Dosage-interval-2wk
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Dosage-interval-2wk"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung von 1 Tablette alle 2 Wochen dar"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.frequency = 1
  * timing.repeat.period = 2
  * timing.repeat.periodUnit = #wk
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MR-Dosage-interval-4times-d
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Dosage-interval-4times-d"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung von 4 x 1 Tablette pro Tag dar"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.frequency = 4
  * timing.repeat.period = 1
  * timing.repeat.periodUnit = #d
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MR-Dosage-interval-3d
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Dosage-interval-3d"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung von Alle 3 Tage 1 Tablette dar"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.frequency = 1
  * timing.repeat.period = 3
  * timing.repeat.periodUnit = #d
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MR-Dosage-interval-2d-bound
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Dosage-interval-2d"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung von Alle 2 Tage 2 Tabletten für 6 Wochen dar"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.frequency = 1
  * timing.repeat.period = 2
  * timing.repeat.periodUnit = #d
  * timing.repeat.boundsDuration = 6 $ucum#wk "Woche(n)"
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"