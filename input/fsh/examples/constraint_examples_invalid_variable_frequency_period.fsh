// Warning/error examples for variable frequency and period constraints

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

// ---------------------------------------------------------------------------
// TimingFreqOrPeriodGtOne — Frequenz und Periode duerfen nicht beide > 1 sein
// ---------------------------------------------------------------------------

Instance: INV-C-TimingFreqOrPeriodGtOne-MR-01-of-03
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid: frequency and period both greater than one"
Description: "CAVE: Validation example - \"6 x innerhalb von 3 Stunden\" is expressed as \"alle 30 Minuten\" instead."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * frequency = 6
    * period = 3
    * periodUnit = #h
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-TimingFreqOrPeriodGtOne-MD-02-of-03
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid: frequency and period both greater than one"
Description: "CAVE: Validation example - \"2 x alle 8 Stunden\" is expressed as \"alle 4 Stunden\" instead."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * frequency = 2
    * period = 8
    * periodUnit = #h
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-TimingFreqOrPeriodGtOne-MS-03-of-03
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid: variable frequency above one with a period above one"
Description: "CAVE: Validation example - frequencyMax exceeds 1 while the period is not 1."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat
    * frequency = 1
    * frequencyMax = 3
    * period = 2
    * periodUnit = #h
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: W-TimingFreqOrPeriodGtOneWarning-MR-01-of-03
InstanceOf: MedicationRequestDE
Usage: #example
Title: "Warning: frequency and period both greater than one"
Description: "CAVE: Validation example - a warning in the generic DE profile."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * frequency = 6
    * period = 3
    * periodUnit = #h
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: W-TimingFreqOrPeriodGtOneWarning-MD-02-of-03
InstanceOf: MedicationDispenseDE
Usage: #example
Title: "Warning: frequency and period both greater than one"
Description: "CAVE: Validation example - a warning in the generic DE profile."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * frequency = 2
    * period = 8
    * periodUnit = #h
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: W-TimingFreqOrPeriodGtOneWarning-MS-03-of-03
InstanceOf: MedicationStatementDE
Usage: #example
Title: "Warning: frequency and period both greater than one"
Description: "CAVE: Validation example - a warning in the generic DE profile."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat
    * frequency = 6
    * period = 3
    * periodUnit = #h
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
