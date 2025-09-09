// Test cases for MedicationStatement and MedicationDispense resources
// These examples test that our dosage script works with all supported resource types

// MedicationStatement Examples

// 1. MedicationStatement with 4-Schema pattern
Instance: MS-Dosage-1010
InstanceOf: MedicationStatementDgMP
Title: "MedicationStatement Dosage Example - 4-Schema"
Description: "Example showing 4-Schema pattern in MedicationStatement"
* subject.display = "Patient"
* medicationCodeableConcept.text = "Test Medication"
* status = #active
* dosage[0].timing.repeat.frequency = 1
* dosage[0].timing.repeat.period = 1
* dosage[0].timing.repeat.periodUnit = #d
* dosage[0].timing.repeat.when = #MORN
* dosage[0].doseAndRate[0].doseQuantity = 1 '1' "Stück"
* dosage[1].timing.repeat.frequency = 1
* dosage[1].timing.repeat.period = 1
* dosage[1].timing.repeat.periodUnit = #d
* dosage[1].timing.repeat.when = #EVE
* dosage[1].doseAndRate[0].doseQuantity = 1 '1' "Stück"

// 2. MedicationStatement with FreeText
Instance: MS-Dosage-Freetext
InstanceOf: MedicationStatementDgMP
Title: "MedicationStatement Dosage Example - FreeText"
Description: "Example showing FreeText pattern in MedicationStatement"
* subject.display = "Patient"
* medicationCodeableConcept.text = "Test Medication"
* status = #active
* dosage.text = "Bei Bedarf bis zu 3 mal täglich 1 Tablette"

// 3. MedicationStatement with TimeOfDay
Instance: MS-Dosage-TimeOfDay
InstanceOf: MedicationStatementDgMP
Title: "MedicationStatement Dosage Example - TimeOfDay"
Description: "Example showing TimeOfDay pattern in MedicationStatement"
* subject.display = "Patient"
* medicationCodeableConcept.text = "Test Medication"
* status = #active
* dosage[0].timing.repeat.frequency = 1
* dosage[0].timing.repeat.period = 1
* dosage[0].timing.repeat.periodUnit = #d
* dosage[0].timing.repeat.timeOfDay = "08:00:00"
* dosage[0].doseAndRate[0].doseQuantity = 2 '1' "Stück"
* dosage[1].timing.repeat.frequency = 1
* dosage[1].timing.repeat.period = 1
* dosage[1].timing.repeat.periodUnit = #d
* dosage[1].timing.repeat.timeOfDay = "20:00:00"
* dosage[1].doseAndRate[0].doseQuantity = 1 '1' "Stück"

// 4. MedicationStatement with DayOfWeek
Instance: MS-Dosage-DayOfWeek
InstanceOf: MedicationStatementDgMP
Title: "MedicationStatement Dosage Example - DayOfWeek"
Description: "Example showing DayOfWeek pattern in MedicationStatement"
* subject.display = "Patient"
* medicationCodeableConcept.text = "Test Medication"
* status = #active
* dosage[0].timing.repeat.frequency = 1
* dosage[0].timing.repeat.period = 1
* dosage[0].timing.repeat.periodUnit = #wk
* dosage[0].timing.repeat.dayOfWeek = #mon
* dosage[0].doseAndRate[0].doseQuantity = 2 '1' "Stück"
* dosage[1].timing.repeat.frequency = 1
* dosage[1].timing.repeat.period = 1
* dosage[1].timing.repeat.periodUnit = #wk
* dosage[1].timing.repeat.dayOfWeek = #fri
* dosage[1].doseAndRate[0].doseQuantity = 1 '1' "Stück"

// 5. MedicationStatement with Interval
Instance: MS-Dosage-Interval
InstanceOf: MedicationStatementDgMP
Title: "MedicationStatement Dosage Example - Interval"
Description: "Example showing Interval pattern in MedicationStatement"
* subject.display = "Patient"
* medicationCodeableConcept.text = "Test Medication"
* status = #active
* dosage.timing.repeat.frequency = 1
* dosage.timing.repeat.period = 3
* dosage.timing.repeat.periodUnit = #d
* dosage.doseAndRate[0].doseQuantity = 1 '1' "Stück"

// MedicationDispense Examples

// 6. MedicationDispense with 4-Schema pattern
Instance: MD-Dosage-1020
InstanceOf: MedicationDispenseDgMP
Title: "MedicationDispense Dosage Example - 4-Schema"
Description: "Example showing 4-Schema pattern in MedicationDispense"
* subject.display = "Patient"
* medicationCodeableConcept.text = "Test Medication"
* status = #completed
* dosageInstruction[0].timing.repeat.frequency = 1
* dosageInstruction[0].timing.repeat.period = 1
* dosageInstruction[0].timing.repeat.periodUnit = #d
* dosageInstruction[0].timing.repeat.when = #MORN
* dosageInstruction[0].doseAndRate[0].doseQuantity = 1 '1' "Stück"
* dosageInstruction[1].timing.repeat.frequency = 1
* dosageInstruction[1].timing.repeat.period = 1
* dosageInstruction[1].timing.repeat.periodUnit = #d
* dosageInstruction[1].timing.repeat.when = #EVE
* dosageInstruction[1].doseAndRate[0].doseQuantity = 2 '1' "Stück"

// 7. MedicationDispense with FreeText
Instance: MD-Dosage-Freetext
InstanceOf: MedicationDispenseDgMP
Title: "MedicationDispense Dosage Example - FreeText"
Description: "Example showing FreeText pattern in MedicationDispense"
* subject.display = "Patient"
* medicationCodeableConcept.text = "Test Medication"
* status = #completed
* dosageInstruction.text = "Morgens und abends je 1 Kapsel nach dem Essen"

// 8. MedicationDispense with Interval and Time
Instance: MD-Dosage-Interval-Time
InstanceOf: MedicationDispenseDgMP
Title: "MedicationDispense Dosage Example - Interval and Time"
Description: "Example showing Interval and Time pattern in MedicationDispense"
* subject.display = "Patient"
* medicationCodeableConcept.text = "Test Medication"
* status = #completed
* dosageInstruction[0].timing.repeat.frequency = 1
* dosageInstruction[0].timing.repeat.period = 2
* dosageInstruction[0].timing.repeat.periodUnit = #d
* dosageInstruction[0].timing.repeat.timeOfDay = "09:00:00"
* dosageInstruction[0].doseAndRate[0].doseQuantity = 1 '1' "Stück"
* dosageInstruction[1].timing.repeat.frequency = 1
* dosageInstruction[1].timing.repeat.period = 2
* dosageInstruction[1].timing.repeat.periodUnit = #d
* dosageInstruction[1].timing.repeat.timeOfDay = "21:00:00"
* dosageInstruction[1].doseAndRate[0].doseQuantity = 2 '1' "Stück"

// 9. MedicationDispense with DayOfWeek and Time
Instance: MD-Dosage-DayOfWeek-Time
InstanceOf: MedicationDispenseDgMP
Title: "MedicationDispense Dosage Example - DayOfWeek and Time"
Description: "Example showing DayOfWeek and Time pattern in MedicationDispense"
* subject.display = "Patient"
* medicationCodeableConcept.text = "Test Medication"
* status = #completed
* dosageInstruction[0].timing.repeat.frequency = 1
* dosageInstruction[0].timing.repeat.period = 1
* dosageInstruction[0].timing.repeat.periodUnit = #wk
* dosageInstruction[0].timing.repeat.dayOfWeek = #mon
* dosageInstruction[0].timing.repeat.when = #MORN
* dosageInstruction[0].doseAndRate[0].doseQuantity = 1 '1' "Stück"
* dosageInstruction[1].timing.repeat.frequency = 1
* dosageInstruction[1].timing.repeat.period = 1
* dosageInstruction[1].timing.repeat.periodUnit = #wk
* dosageInstruction[1].timing.repeat.dayOfWeek = #wed
* dosageInstruction[1].timing.repeat.when = #EVE
* dosageInstruction[1].doseAndRate[0].doseQuantity = 2 '1' "Stück"

// 10. MedicationDispense with bounds and decimals
Instance: MD-Dosage-Bounds-Decimals
InstanceOf: MedicationDispenseDgMP
Title: "MedicationDispense Dosage Example - Bounds and Decimals"
Description: "Example showing bounds and decimal doses in MedicationDispense"
* subject.display = "Patient"
* medicationCodeableConcept.text = "Test Medication"
* status = #completed
* dosageInstruction[0].timing.repeat.frequency = 1
* dosageInstruction[0].timing.repeat.period = 1
* dosageInstruction[0].timing.repeat.periodUnit = #d
* dosageInstruction[0].timing.repeat.when = #MORN
* dosageInstruction[0].timing.repeat.boundsDuration = 2 'wk' "weeks"
* dosageInstruction[0].doseAndRate[0].doseQuantity = 0.5 '1' "Stück"
* dosageInstruction[1].timing.repeat.frequency = 1
* dosageInstruction[1].timing.repeat.period = 1
* dosageInstruction[1].timing.repeat.periodUnit = #d
* dosageInstruction[1].timing.repeat.when = #EVE
* dosageInstruction[1].timing.repeat.boundsDuration = 2 'wk' "weeks"
* dosageInstruction[1].doseAndRate[0].doseQuantity = 1.5 '1' "Stück"
