// Invalid examples for variable single dose constraints on DosageDgMP

Instance: INV-C-DoseRangeHighRequiredWhenLowPresent-Request-01-of-03
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid: doseRange.low without doseRange.high"
Description: "CAVE: Validation example - doseRange.low is set while doseRange.high is missing."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Metamizol"
* dosageInstruction[+]
  * timing.repeat.frequency = 1
  * timing.repeat.period = 1
  * timing.repeat.periodUnit = #d
  * doseAndRate.doseRange.low.value = 1
  * doseAndRate.doseRange.low.system = $ucum
  * doseAndRate.doseRange.low.code = #mg
  * doseAndRate.doseRange.low.unit = "mg"

Instance: INV-C-DoseRangeHighRequiredWhenLowPresent-Dispense-02-of-03
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid: doseRange.low without doseRange.high"
Description: "CAVE: Validation example - doseRange.low is set while doseRange.high is missing."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Metamizol"
* dosageInstruction[+]
  * timing.repeat.frequency = 1
  * timing.repeat.period = 1
  * timing.repeat.periodUnit = #d
  * doseAndRate.doseRange.low.value = 1
  * doseAndRate.doseRange.low.system = $ucum
  * doseAndRate.doseRange.low.code = #mg
  * doseAndRate.doseRange.low.unit = "mg"

Instance: INV-C-DoseRangeHighRequiredWhenLowPresent-Statement-03-of-03
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid: doseRange.low without doseRange.high"
Description: "CAVE: Validation example - doseRange.low is set while doseRange.high is missing."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Metamizol"
* dosage[+]
  * timing.repeat.frequency = 1
  * timing.repeat.period = 1
  * timing.repeat.periodUnit = #d
  * doseAndRate.doseRange.low.value = 1
  * doseAndRate.doseRange.low.system = $ucum
  * doseAndRate.doseRange.low.code = #mg
  * doseAndRate.doseRange.low.unit = "mg"

Instance: INV-C-DoseRangeLowAndHighSameUnit-Request-01-of-03
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid: doseRange low/high use different units"
Description: "CAVE: Validation example - doseRange.low and doseRange.high use different system/code/unit values."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Metamizol"
* dosageInstruction[+]
  * timing.repeat.frequency = 1
  * timing.repeat.period = 1
  * timing.repeat.periodUnit = #d
  * doseAndRate.doseRange.low.value = 1
  * doseAndRate.doseRange.low.system = $ucum
  * doseAndRate.doseRange.low.code = #mg
  * doseAndRate.doseRange.low.unit = "mg"
  * doseAndRate.doseRange.high.value = 2
  * doseAndRate.doseRange.high.system = $kbv-dosiereinheit
  * doseAndRate.doseRange.high.code = #1
  * doseAndRate.doseRange.high.unit = "Stück"

Instance: INV-C-DoseRangeLowAndHighSameUnit-Dispense-02-of-03
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid: doseRange low/high use different units"
Description: "CAVE: Validation example - doseRange.low and doseRange.high use different system/code/unit values."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Metamizol"
* dosageInstruction[+]
  * timing.repeat.frequency = 1
  * timing.repeat.period = 1
  * timing.repeat.periodUnit = #d
  * doseAndRate.doseRange.low.value = 1
  * doseAndRate.doseRange.low.system = $ucum
  * doseAndRate.doseRange.low.code = #mg
  * doseAndRate.doseRange.low.unit = "mg"
  * doseAndRate.doseRange.high.value = 2
  * doseAndRate.doseRange.high.system = $kbv-dosiereinheit
  * doseAndRate.doseRange.high.code = #1
  * doseAndRate.doseRange.high.unit = "Stück"

Instance: INV-C-DoseRangeLowAndHighSameUnit-Statement-03-of-03
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid: doseRange low/high use different units"
Description: "CAVE: Validation example - doseRange.low and doseRange.high use different system/code/unit values."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Metamizol"
* dosage[+]
  * timing.repeat.frequency = 1
  * timing.repeat.period = 1
  * timing.repeat.periodUnit = #d
  * doseAndRate.doseRange.low.value = 1
  * doseAndRate.doseRange.low.system = $ucum
  * doseAndRate.doseRange.low.code = #mg
  * doseAndRate.doseRange.low.unit = "mg"
  * doseAndRate.doseRange.high.value = 2
  * doseAndRate.doseRange.high.system = $kbv-dosiereinheit
  * doseAndRate.doseRange.high.code = #1
  * doseAndRate.doseRange.high.unit = "Stück"
