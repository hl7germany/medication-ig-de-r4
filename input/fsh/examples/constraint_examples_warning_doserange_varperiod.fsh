// Warning examples for DoseRangeNoVarPeriod

Instance: W-DoseRangeNoVarPeriod-Request-01-of-03
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Warning: doseRange with variable period"
Description: "CAVE: Validation example - variable dose and variable period are both populated and should trigger a warning."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.frequency = 1
  * timing.repeat.period = 4
  * timing.repeat.periodMax = 6
  * timing.repeat.periodUnit = #h
  * doseAndRate.doseRange.low.value = 2
  * doseAndRate.doseRange.low.system = $kbv-dosiereinheit
  * doseAndRate.doseRange.low.code = #1
  * doseAndRate.doseRange.low.unit = "Stück"
  * doseAndRate.doseRange.high.value = 3
  * doseAndRate.doseRange.high.system = $kbv-dosiereinheit
  * doseAndRate.doseRange.high.code = #1
  * doseAndRate.doseRange.high.unit = "Stück"

Instance: W-DoseRangeNoVarPeriod-Dispense-02-of-03
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Warning: doseRange with variable period"
Description: "CAVE: Validation example - variable dose and variable period are both populated and should trigger a warning."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.frequency = 1
  * timing.repeat.period = 4
  * timing.repeat.periodMax = 6
  * timing.repeat.periodUnit = #h
  * doseAndRate.doseRange.low.value = 2
  * doseAndRate.doseRange.low.system = $kbv-dosiereinheit
  * doseAndRate.doseRange.low.code = #1
  * doseAndRate.doseRange.low.unit = "Stück"
  * doseAndRate.doseRange.high.value = 3
  * doseAndRate.doseRange.high.system = $kbv-dosiereinheit
  * doseAndRate.doseRange.high.code = #1
  * doseAndRate.doseRange.high.unit = "Stück"

Instance: W-DoseRangeNoVarPeriod-Statement-03-of-03
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Warning: doseRange with variable period"
Description: "CAVE: Validation example - variable dose and variable period are both populated and should trigger a warning."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat.frequency = 1
  * timing.repeat.period = 4
  * timing.repeat.periodMax = 6
  * timing.repeat.periodUnit = #h
  * doseAndRate.doseRange.low.value = 2
  * doseAndRate.doseRange.low.system = $kbv-dosiereinheit
  * doseAndRate.doseRange.low.code = #1
  * doseAndRate.doseRange.low.unit = "Stück"
  * doseAndRate.doseRange.high.value = 3
  * doseAndRate.doseRange.high.system = $kbv-dosiereinheit
  * doseAndRate.doseRange.high.code = #1
  * doseAndRate.doseRange.high.unit = "Stück"
