Instance: Example-MR-Dosage-variable-doseRange
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Dosage-variable-doseRange"
Description: "Dieses Beispiel stellt eine variable Einzeldosis mit einem Dosisbereich von 1 bis 2 Stück dar."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Metamizol"
* dosageInstruction[+]
  * timing.repeat.frequency = 1
  * timing.repeat.period = 1
  * timing.repeat.periodUnit = #d
  * doseAndRate.doseRange.low.value = 1
  * doseAndRate.doseRange.low.system = $kbv-dosiereinheit
  * doseAndRate.doseRange.low.code = #1
  * doseAndRate.doseRange.low.unit = "Stück"
  * doseAndRate.doseRange.high.value = 2
  * doseAndRate.doseRange.high.system = $kbv-dosiereinheit
  * doseAndRate.doseRange.high.code = #1
  * doseAndRate.doseRange.high.unit = "Stück"

Instance: Example-MR-Dosage-variable-frequency
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Dosage-variable-frequency"
Description: "Dieses Beispiel stellt eine variable Frequenz von 1 bis 2 Gaben pro Tag dar."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.frequency = 1
  * timing.repeat.frequencyMax = 2
  * timing.repeat.period = 1
  * timing.repeat.periodUnit = #d
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MR-Dosage-variable-period
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Dosage-variable-period"
Description: "Dieses Beispiel stellt eine variable Periode von 4 bis 6 Stunden zwischen den Gaben dar."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.frequency = 1
  * timing.repeat.period = 4
  * timing.repeat.periodMax = 6
  * timing.repeat.periodUnit = #h
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
