// Invalid examples for variable frequency and period constraints

Instance: INV-C-TimingVarFreqOrPeriod-Request-01-of-03
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid: frequencyMax and periodMax together"
Description: "CAVE: Validation example - variable frequency and variable period are both populated."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.frequency = 1
  * timing.repeat.frequencyMax = 2
  * timing.repeat.period = 4
  * timing.repeat.periodMax = 6
  * timing.repeat.periodUnit = #h
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-TimingVarFreqOrPeriod-Dispense-02-of-03
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid: frequencyMax and periodMax together"
Description: "CAVE: Validation example - variable frequency and variable period are both populated."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.frequency = 1
  * timing.repeat.frequencyMax = 2
  * timing.repeat.period = 4
  * timing.repeat.periodMax = 6
  * timing.repeat.periodUnit = #h
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-TimingVarFreqOrPeriod-Statement-03-of-03
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid: frequencyMax and periodMax together"
Description: "CAVE: Validation example - variable frequency and variable period are both populated."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat.frequency = 1
  * timing.repeat.frequencyMax = 2
  * timing.repeat.period = 4
  * timing.repeat.periodMax = 6
  * timing.repeat.periodUnit = #h
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-TimingVarFreqGtMin-Request-01-of-03
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid: frequencyMax is not greater than frequency"
Description: "CAVE: Validation example - frequencyMax is equal to frequency."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.frequency = 2
  * timing.repeat.frequencyMax = 2
  * timing.repeat.period = 1
  * timing.repeat.periodUnit = #d
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-TimingVarFreqGtMin-Dispense-02-of-03
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid: frequencyMax is not greater than frequency"
Description: "CAVE: Validation example - frequencyMax is equal to frequency."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.frequency = 2
  * timing.repeat.frequencyMax = 2
  * timing.repeat.period = 1
  * timing.repeat.periodUnit = #d
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-TimingVarFreqGtMin-Statement-03-of-03
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid: frequencyMax is not greater than frequency"
Description: "CAVE: Validation example - frequencyMax is equal to frequency."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat.frequency = 2
  * timing.repeat.frequencyMax = 2
  * timing.repeat.period = 1
  * timing.repeat.periodUnit = #d
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-VarFreqNoMaxDose-Request-01-of-03
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid: variable frequency with maxDosePerPeriod"
Description: "CAVE: Validation example - frequencyMax and maxDosePerPeriod are populated together."
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
  * maxDosePerPeriod.numerator.value = 6
  * maxDosePerPeriod.numerator.system = $kbv-dosiereinheit
  * maxDosePerPeriod.numerator.code = #1
  * maxDosePerPeriod.numerator.unit = "Stück"
  * maxDosePerPeriod.denominator.value = 24
  * maxDosePerPeriod.denominator.system = $ucum
  * maxDosePerPeriod.denominator.code = #h
  * maxDosePerPeriod.denominator.unit = "Stunde(n)"

Instance: INV-C-VarFreqNoMaxDose-Dispense-02-of-03
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid: variable frequency with maxDosePerPeriod"
Description: "CAVE: Validation example - frequencyMax and maxDosePerPeriod are populated together."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.frequency = 1
  * timing.repeat.frequencyMax = 2
  * timing.repeat.period = 1
  * timing.repeat.periodUnit = #d
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * maxDosePerPeriod.numerator.value = 6
  * maxDosePerPeriod.numerator.system = $kbv-dosiereinheit
  * maxDosePerPeriod.numerator.code = #1
  * maxDosePerPeriod.numerator.unit = "Stück"
  * maxDosePerPeriod.denominator.value = 24
  * maxDosePerPeriod.denominator.system = $ucum
  * maxDosePerPeriod.denominator.code = #h
  * maxDosePerPeriod.denominator.unit = "Stunde(n)"

Instance: INV-C-VarFreqNoMaxDose-Statement-03-of-03
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid: variable frequency with maxDosePerPeriod"
Description: "CAVE: Validation example - frequencyMax and maxDosePerPeriod are populated together."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat.frequency = 1
  * timing.repeat.frequencyMax = 2
  * timing.repeat.period = 1
  * timing.repeat.periodUnit = #d
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * maxDosePerPeriod.numerator.value = 6
  * maxDosePerPeriod.numerator.system = $kbv-dosiereinheit
  * maxDosePerPeriod.numerator.code = #1
  * maxDosePerPeriod.numerator.unit = "Stück"
  * maxDosePerPeriod.denominator.value = 24
  * maxDosePerPeriod.denominator.system = $ucum
  * maxDosePerPeriod.denominator.code = #h
  * maxDosePerPeriod.denominator.unit = "Stunde(n)"

Instance: INV-C-TimingVarPeriodGtMin-Request-01-of-03
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid: periodMax is not greater than period"
Description: "CAVE: Validation example - periodMax is equal to period."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.frequency = 1
  * timing.repeat.period = 4
  * timing.repeat.periodMax = 4
  * timing.repeat.periodUnit = #h
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-TimingVarPeriodGtMin-Dispense-02-of-03
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid: periodMax is not greater than period"
Description: "CAVE: Validation example - periodMax is equal to period."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.frequency = 1
  * timing.repeat.period = 4
  * timing.repeat.periodMax = 4
  * timing.repeat.periodUnit = #h
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-TimingVarPeriodGtMin-Statement-03-of-03
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid: periodMax is not greater than period"
Description: "CAVE: Validation example - periodMax is equal to period."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat.frequency = 1
  * timing.repeat.period = 4
  * timing.repeat.periodMax = 4
  * timing.repeat.periodUnit = #h
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-VarPeriodNoMindestabstand-Request-01-of-03
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid: variable period with MindestabstandZwischenGaben"
Description: "CAVE: Validation example - periodMax and modifierExtension[MindestabstandZwischenGaben] are populated together."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.frequency = 1
  * timing.repeat.period = 4
  * timing.repeat.periodMax = 6
  * timing.repeat.periodUnit = #h
  * modifierExtension[mindestabstandZwischenGaben].valueDuration = 4 $ucum#h "Stunde(n)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-VarPeriodNoMindestabstand-Dispense-02-of-03
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid: variable period with MindestabstandZwischenGaben"
Description: "CAVE: Validation example - periodMax and modifierExtension[MindestabstandZwischenGaben] are populated together."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.frequency = 1
  * timing.repeat.period = 4
  * timing.repeat.periodMax = 6
  * timing.repeat.periodUnit = #h
  * modifierExtension[mindestabstandZwischenGaben].valueDuration = 4 $ucum#h "Stunde(n)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-VarPeriodNoMindestabstand-Statement-03-of-03
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid: variable period with MindestabstandZwischenGaben"
Description: "CAVE: Validation example - periodMax and modifierExtension[MindestabstandZwischenGaben] are populated together."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat.frequency = 1
  * timing.repeat.period = 4
  * timing.repeat.periodMax = 6
  * timing.repeat.periodUnit = #h
  * modifierExtension[mindestabstandZwischenGaben].valueDuration = 4 $ucum#h "Stunde(n)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
