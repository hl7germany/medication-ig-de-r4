// Warning/error examples for variable frequency and period constraints

Instance: INV-C-TimingVarFreqOrPeriod-Request-01-of-03
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid: frequencyMax and periodMax together"
Description: "CAVE: Validation example - variable frequency and variable period must not both be populated for a pure interval."
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
Description: "CAVE: Validation example - variable frequency and variable period must not both be populated for a pure interval."
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
Description: "CAVE: Validation example - variable frequency and variable period must not both be populated for a pure interval."
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

Instance: INV-C-MinimumIntervalOnlyPureAsNeeded-Request-01-of-03
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid: Mindestabstand together with a structured timing"
Description: "CAVE: Validation example - modifierExtension[MinimumIntervalBetweenAdministrations] is only allowed for a pure as-needed dosage, i.e. with asNeededBoolean = true and without timing."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.frequency = 1
  * timing.repeat.period = 4
  * timing.repeat.periodMax = 6
  * timing.repeat.periodUnit = #h
  * modifierExtension[minimumIntervalBetweenAdministrations].valueDuration = 4 $ucum#h "Stunde(n)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-MinimumIntervalOnlyPureAsNeeded-Dispense-02-of-03
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid: Mindestabstand together with a structured timing"
Description: "CAVE: Validation example - modifierExtension[MinimumIntervalBetweenAdministrations] is only allowed for a pure as-needed dosage, i.e. with asNeededBoolean = true and without timing."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.frequency = 1
  * timing.repeat.period = 4
  * timing.repeat.periodMax = 6
  * timing.repeat.periodUnit = #h
  * modifierExtension[minimumIntervalBetweenAdministrations].valueDuration = 4 $ucum#h "Stunde(n)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-MinimumIntervalOnlyPureAsNeeded-Statement-03-of-03
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid: Mindestabstand together with a structured timing"
Description: "CAVE: Validation example - modifierExtension[MinimumIntervalBetweenAdministrations] is only allowed for a pure as-needed dosage, i.e. with asNeededBoolean = true and without timing."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat.frequency = 1
  * timing.repeat.period = 4
  * timing.repeat.periodMax = 6
  * timing.repeat.periodUnit = #h
  * modifierExtension[minimumIntervalBetweenAdministrations].valueDuration = 4 $ucum#h "Stunde(n)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-TimingVarFreqOrPeriod-Request-04-of-04
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid: variable frequency and variable period with doseRange"
Description: "CAVE: Validation example - \"1 bis 3 x alle 2 bis 3 Tage: 20-40 Tropfen\" varies both axes at once."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Baldriantropfen"
* dosageInstruction[+]
  * timing.repeat.frequency = 1
  * timing.repeat.frequencyMax = 3
  * timing.repeat.period = 2
  * timing.repeat.periodMax = 3
  * timing.repeat.periodUnit = #d
  * doseAndRate.doseRange.low = 20 $kbv-dosiereinheit#14 "Tropfen"
  * doseAndRate.doseRange.high = 40 $kbv-dosiereinheit#14 "Tropfen"

// ---------------------------------------------------------------------------
// TimingVarFreqOrPeriodWarning — im generischen DE-Profil nur eine Warnung
// ---------------------------------------------------------------------------

Instance: W-TimingVarFreqOrPeriodWarning-MR-01-of-03
InstanceOf: MedicationRequestDE
Usage: #example
Title: "Warning: frequencyMax and periodMax together"
Description: "CAVE: Validation example - variable frequency and variable period are both populated; a warning in the generic DE profile."
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

Instance: W-TimingVarFreqOrPeriodWarning-MD-02-of-03
InstanceOf: MedicationDispenseDE
Usage: #example
Title: "Warning: frequencyMax and periodMax together"
Description: "CAVE: Validation example - variable frequency and variable period are both populated; a warning in the generic DE profile."
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

Instance: W-TimingVarFreqOrPeriodWarning-MS-03-of-03
InstanceOf: MedicationStatementDE
Usage: #example
Title: "Warning: frequencyMax and periodMax together"
Description: "CAVE: Validation example - variable frequency and variable period are both populated; a warning in the generic DE profile."
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
