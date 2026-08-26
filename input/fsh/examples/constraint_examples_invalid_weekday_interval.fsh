// Negative matrix: a non-redundant period with dayOfWeek is a forbidden
// weekday/interval combination. wk is chosen so TimingPeriodUnit itself passes
// and TimingOnlyOneType is isolated.

Instance: INV-C-TimingOnlyOneType-Request
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid MedicationRequest: weekday plus real interval"
Description: "CAVE: period 2 wk is not redundant and cannot be combined with dayOfWeek."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Test Medication"
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek = #tue
    * frequency = 1
    * period = 2
    * periodUnit = #wk
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-TimingOnlyOneType-Dispense
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid MedicationDispense: weekday plus real interval"
Description: "CAVE: period 2 wk is not redundant and cannot be combined with dayOfWeek."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Test Medication"
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek = #tue
    * frequency = 1
    * period = 2
    * periodUnit = #wk
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-TimingOnlyOneType-Statement
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid MedicationStatement: weekday plus real interval"
Description: "CAVE: period 2 wk is not redundant and cannot be combined with dayOfWeek."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Test Medication"
* dosage[+]
  * timing.repeat
    * dayOfWeek = #tue
    * frequency = 1
    * period = 2
    * periodUnit = #wk
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-TimingOnlyOneType-MR-01-of-02
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid MedicationRequest: weekday and when plus real interval"
Description: "CAVE: period 2 wk is not redundant and cannot be combined with dayOfWeek and when."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Test Medication"
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek = #tue
    * when = #MORN
    * frequency = 1
    * period = 2
    * periodUnit = #wk
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-TimingOnlyOneType-MR-02-of-02
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid MedicationRequest: weekday and timeOfDay plus real interval"
Description: "CAVE: period 2 wk is not redundant and cannot be combined with dayOfWeek and timeOfDay."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Test Medication"
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek = #tue
    * timeOfDay = "08:00:00"
    * frequency = 1
    * period = 2
    * periodUnit = #wk
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-TimingOnlyOneType-MD-01-of-02
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid MedicationDispense: weekday and when plus real interval"
Description: "CAVE: period 2 wk is not redundant and cannot be combined with dayOfWeek and when."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Test Medication"
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek = #tue
    * when = #MORN
    * frequency = 1
    * period = 2
    * periodUnit = #wk
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-TimingOnlyOneType-MD-02-of-02
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid MedicationDispense: weekday and timeOfDay plus real interval"
Description: "CAVE: period 2 wk is not redundant and cannot be combined with dayOfWeek and timeOfDay."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Test Medication"
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek = #tue
    * timeOfDay = "08:00:00"
    * frequency = 1
    * period = 2
    * periodUnit = #wk
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-TimingOnlyOneType-MS-01-of-02
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid MedicationStatement: weekday and when plus real interval"
Description: "CAVE: period 2 wk is not redundant and cannot be combined with dayOfWeek and when."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Test Medication"
* dosage[+]
  * timing.repeat
    * dayOfWeek = #tue
    * when = #MORN
    * frequency = 1
    * period = 2
    * periodUnit = #wk
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-TimingOnlyOneType-MS-02-of-02
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid MedicationStatement: weekday and timeOfDay plus real interval"
Description: "CAVE: period 2 wk is not redundant and cannot be combined with dayOfWeek and timeOfDay."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Test Medication"
* dosage[+]
  * timing.repeat
    * dayOfWeek = #tue
    * timeOfDay = "08:00:00"
    * frequency = 1
    * period = 2
    * periodUnit = #wk
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
