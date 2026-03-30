// Test cases for TimingOnlyOnePeriodForDayOfWeek and TimingNoRedundantDosageForDay invariants
// These test instances verify:
// 1. When the same weekday appears in multiple dosageInstructions, the associated timeOfDay/when values must be unique
// 2. Multiple dosageInstructions with the same dayOfWeek and doseQuantity should be combined into one dosageInstruction

// ============================================================================
// VALID CASES - Same weekday with DIFFERENT doses
// ============================================================================

Instance: MR-Test-SameDayDifferentDoses-Valid
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "MedicationRequest - Same Day Different Doses (Valid)"
Description: "Valid: Monday appears twice but with different doseQuantity values (1 vs 2 Stück)"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Test Medication"
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek = #mon
    * timeOfDay = "08:00:00"
    * frequency = 1
    * period = 1
    * periodUnit = #wk
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek = #mon
    * timeOfDay = "20:00:00"
    * frequency = 1
    * period = 1
    * periodUnit = #wk
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

Instance: MR-Test-MultipleDaysDifferentDoses-Valid
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "MedicationRequest - Multiple Days Different Doses (Valid)"
Description: "Valid: Wed and Fri each appear twice but all dose values differ"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Test Medication"
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek = #wed
    * timeOfDay = "08:00:00"
    * frequency = 1
    * period = 1
    * periodUnit = #wk
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek = #wed
    * timeOfDay = "18:00:00"
    * frequency = 1
    * period = 1
    * periodUnit = #wk
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek = #fri
    * timeOfDay = "09:00:00"
    * frequency = 1
    * period = 1
    * periodUnit = #wk
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek = #fri
    * timeOfDay = "21:00:00"
    * frequency = 1
    * period = 1
    * periodUnit = #wk
  * doseAndRate.doseQuantity = 3 $kbv-dosiereinheit#1 "Stück"

Instance: MR-Test-DifferentDaysEachOnce-Valid
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "MedicationRequest - Different Days Each Once (Valid)"
Description: "Valid: Monday (MORN) and Saturday (EVE) each appear only once — invariant does not apply since no weekday appears more than once"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Test Medication"
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek = #mon
    * when = #MORN
    * frequency = 1
    * period = 1
    * periodUnit = #wk
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek = #sat
    * when = #EVE
    * frequency = 1
    * period = 1
    * periodUnit = #wk
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

// ============================================================================
// INVALID CASES - Same weekday with SAME dose (redundant, should be combined)
// ============================================================================

Instance: INV-redundant-01-of-04-C-TimingNoRedundantDosageForDay
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "MedicationRequest - Same Day Same Dose (INVALID)"
Description: "Invalid: Tuesday appears twice with same doseQuantity (1 Stück). Should be combined into one dosageInstruction with when=[MORN, EVE]"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Test Medication"
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek = #tue
    * when = #MORN
    * frequency = 1
    * period = 1
    * periodUnit = #wk
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek = #tue
    * when = #EVE
    * frequency = 1
    * period = 1
    * periodUnit = #wk
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-redundant-02-of-04-C-TimingNoRedundantDosageForDay
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "MedicationRequest - Multiple Days Same Dose (INVALID)"
Description: "Invalid: Wed appears twice with same dose (1 Stück), should be combined"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Test Medication"
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek = #wed
    * timeOfDay = "08:00:00"
    * frequency = 1
    * period = 1
    * periodUnit = #wk
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek = #wed
    * timeOfDay = "18:00:00"
    * frequency = 1
    * period = 1
    * periodUnit = #wk
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

// ============================================================================
// INVALID CASES - Duplicate time/when combinations
// ============================================================================

Instance: INV-period-01-of-06-C-TimingOnlyOnePeriodForDayOfWeek
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "MedicationRequest - Same Day Same Time (INVALID)"
Description: "Invalid: Thursday appears twice with the same timeOfDay (12:00). This should trigger TimingOnlyOnePeriodForDayOfWeek error."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Test Medication"
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek = #thu
    * timeOfDay = "12:00:00"
    * frequency = 1
    * period = 1
    * periodUnit = #wk
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek = #thu
    * timeOfDay = "12:00:00"
    * frequency = 1
    * period = 1
    * periodUnit = #wk
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

Instance: INV-period-02-of-06-C-TimingOnlyOnePeriodForDayOfWeek
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "MedicationRequest - Same Day Same When (INVALID)"
Description: "Invalid: Saturday appears twice with the same when code (NIGHT). This should trigger TimingOnlyOnePeriodForDayOfWeek error."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Test Medication"
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek = #sat
    * when = #NIGHT
    * frequency = 1
    * period = 1
    * periodUnit = #wk
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek = #sat
    * when = #NIGHT
    * frequency = 1
    * period = 1
    * periodUnit = #wk
  * doseAndRate.doseQuantity = 3 $kbv-dosiereinheit#1 "Stück"

// ============================================================================
// MedicationDispense equivalents
// ============================================================================

Instance: MD-Test-SameDayDifferentDoses-Valid
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "MedicationDispense - Same Day Different Doses (Valid)"
Description: "Valid: Monday appears twice but with different doseQuantity values"
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Test Medication"
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek = #mon
    * timeOfDay = "08:00:00"
    * frequency = 1
    * period = 1
    * periodUnit = #wk
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek = #mon
    * timeOfDay = "20:00:00"
    * frequency = 1
    * period = 1
    * periodUnit = #wk
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

Instance: MD-Test-DifferentDaysEachOnce-Valid
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "MedicationDispense - Different Days Each Once (Valid)"
Description: "Valid: Monday (MORN) and Saturday (EVE) each appear only once — invariant does not apply since no weekday appears more than once"
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Test Medication"
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek = #mon
    * when = #MORN
    * frequency = 1
    * period = 1
    * periodUnit = #wk
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek = #sat
    * when = #EVE
    * frequency = 1
    * period = 1
    * periodUnit = #wk
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-redundant-03-of-04-C-TimingNoRedundantDosageForDay-MD
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "MedicationDispense - Same Day Same Dose (INVALID)"
Description: "Invalid: Tuesday appears twice with same dose. Should be combined."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Test Medication"
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek = #tue
    * when = #MORN
    * frequency = 1
    * period = 1
    * periodUnit = #wk
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek = #tue
    * when = #EVE
    * frequency = 1
    * period = 1
    * periodUnit = #wk
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-period-03-of-06-C-TimingOnlyOnePeriodForDayOfWeek-MD
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "MedicationDispense - Same Day Same Time (INVALID)"
Description: "Invalid: Friday appears twice with the same timeOfDay (duplicate time). Should trigger TimingOnlyOnePeriodForDayOfWeek error."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Test Medication"
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek = #fri
    * timeOfDay = "14:00:00"
    * frequency = 1
    * period = 1
    * periodUnit = #wk
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek = #fri
    * timeOfDay = "14:00:00"
    * frequency = 1
    * period = 1
    * periodUnit = #wk
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

Instance: INV-period-04-of-06-C-TimingOnlyOnePeriodForDayOfWeek-MD
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "MedicationDispense - Same Day Same When (INVALID)"
Description: "Invalid: Sunday appears twice with the same when code (duplicate when). Should trigger TimingOnlyOnePeriodForDayOfWeek error."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Test Medication"
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek = #sun
    * when = #MORN
    * frequency = 1
    * period = 1
    * periodUnit = #wk
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek = #sun
    * when = #MORN
    * frequency = 1
    * period = 1
    * periodUnit = #wk
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

// ============================================================================
// MedicationStatement equivalents
// ============================================================================

Instance: MS-Test-SameDayDifferentDoses-Valid
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "MedicationStatement - Same Day Different Doses (Valid)"
Description: "Valid: Monday appears twice but with different doseQuantity values"
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Test Medication"
* dosage[+]
  * timing.repeat
    * dayOfWeek = #mon
    * timeOfDay = "08:00:00"
    * frequency = 1
    * period = 1
    * periodUnit = #wk
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosage[+]
  * timing.repeat
    * dayOfWeek = #mon
    * timeOfDay = "20:00:00"
    * frequency = 1
    * period = 1
    * periodUnit = #wk
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

Instance: MS-Test-DifferentDaysEachOnce-Valid
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "MedicationStatement - Different Days Each Once (Valid)"
Description: "Valid: Monday (MORN) and Saturday (EVE) each appear only once — invariant does not apply since no weekday appears more than once"
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Test Medication"
* dosage[+]
  * timing.repeat
    * dayOfWeek = #mon
    * when = #MORN
    * frequency = 1
    * period = 1
    * periodUnit = #wk
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosage[+]
  * timing.repeat
    * dayOfWeek = #sat
    * when = #EVE
    * frequency = 1
    * period = 1
    * periodUnit = #wk
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-redundant-04-of-04-C-TimingNoRedundantDosageForDay-MS
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "MedicationStatement - Same Day Same Dose (INVALID)"
Description: "Invalid: Tuesday appears twice with same dose. Should be combined."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Test Medication"
* dosage[+]
  * timing.repeat
    * dayOfWeek = #tue
    * when = #MORN
    * frequency = 1
    * period = 1
    * periodUnit = #wk
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosage[+]
  * timing.repeat
    * dayOfWeek = #tue
    * when = #EVE
    * frequency = 1
    * period = 1
    * periodUnit = #wk
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-period-05-of-06-C-TimingOnlyOnePeriodForDayOfWeek-MS
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "MedicationStatement - Same Day Same Time (INVALID)"
Description: "Invalid: Wednesday appears twice with the same timeOfDay (duplicate time). Should trigger TimingOnlyOnePeriodForDayOfWeek error."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Test Medication"
* dosage[+]
  * timing.repeat
    * dayOfWeek = #wed
    * timeOfDay = "10:00:00"
    * frequency = 1
    * period = 1
    * periodUnit = #wk
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosage[+]
  * timing.repeat
    * dayOfWeek = #wed
    * timeOfDay = "10:00:00"
    * frequency = 1
    * period = 1
    * periodUnit = #wk
  * doseAndRate.doseQuantity = 3 $kbv-dosiereinheit#1 "Stück"

Instance: INV-period-06-of-06-C-TimingOnlyOnePeriodForDayOfWeek-MS
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "MedicationStatement - Same Day Same When (INVALID)"
Description: "Invalid: Thursday appears twice with the same when code (duplicate when). Should trigger TimingOnlyOnePeriodForDayOfWeek error."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Test Medication"
* dosage[+]
  * timing.repeat
    * dayOfWeek = #thu
    * when = #NOON
    * frequency = 1
    * period = 1
    * periodUnit = #wk
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosage[+]
  * timing.repeat
    * dayOfWeek = #thu
    * when = #NOON
    * frequency = 1
    * period = 1
    * periodUnit = #wk
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"
