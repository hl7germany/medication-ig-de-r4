// Critical Test Cases for Medication Dosage Script
// These examples cover important edge cases that could cause script failures

// 1. Interval and Time/4-Schema with when codes instead of timeOfDay
Instance: MR-Dosage-interval-when-3d
InstanceOf: MedicationRequestDgMP
Title: "MedicationRequest Dosage Example - Interval with When Codes"
Description: "Example showing interval dosing with when codes instead of timeOfDay"
* insert InsertMandatoryExStubs
* subject.display = "Patient"
* medicationCodeableConcept.text = "Test Medication"
* status = #active
* intent = #order
* dosageInstruction[0].timing.repeat.frequency = 1
* dosageInstruction[0].timing.repeat.period = 3
* dosageInstruction[0].timing.repeat.periodUnit = #d
* dosageInstruction[0].timing.repeat.when = #MORN
* dosageInstruction[0].doseAndRate[0].doseQuantity = 1 '1' "Stück"
* dosageInstruction[1].timing.repeat.frequency = 1
* dosageInstruction[1].timing.repeat.period = 3
* dosageInstruction[1].timing.repeat.periodUnit = #d
* dosageInstruction[1].timing.repeat.when = #EVE
* dosageInstruction[1].doseAndRate[0].doseQuantity = 2 '1' "Stück"

// 2. 4-Schema single time period - night only (0-0-0-1 pattern)
Instance: MR-Dosage-4schema-night-only
InstanceOf: MedicationRequestDgMP
Title: "MedicationRequest Dosage Example - 4-Schema Night Only"
Description: "Example showing 4-Schema pattern with only night dose (0-0-0-1)"
* insert InsertMandatoryExStubs
* subject.display = "Patient"
* medicationCodeableConcept.text = "Test Medication"
* status = #active
* intent = #order
* dosageInstruction.timing.repeat.frequency = 1
* dosageInstruction.timing.repeat.period = 1
* dosageInstruction.timing.repeat.periodUnit = #d
* dosageInstruction.timing.repeat.when = #NIGHT
* dosageInstruction.doseAndRate[0].doseQuantity = 1 '1' "Stück"

// 3. 4-Schema single time period - evening only (0-0-1-0 pattern)
Instance: MR-Dosage-4schema-evening-only
InstanceOf: MedicationRequestDgMP
Title: "MedicationRequest Dosage Example - 4-Schema Evening Only"
Description: "Example showing 4-Schema pattern with only evening dose (0-0-1-0)"
* insert InsertMandatoryExStubs
* subject.display = "Patient"
* medicationCodeableConcept.text = "Test Medication"
* status = #active
* intent = #order
* dosageInstruction.timing.repeat.frequency = 1
* dosageInstruction.timing.repeat.period = 1
* dosageInstruction.timing.repeat.periodUnit = #d
* dosageInstruction.timing.repeat.when = #EVE
* dosageInstruction.doseAndRate[0].doseQuantity = 1 '1' "Stück"

// 4. 4-Schema single time period - noon only (0-1-0-0 pattern)
Instance: MR-Dosage-4schema-noon-only
InstanceOf: MedicationRequestDgMP
Title: "MedicationRequest Dosage Example - 4-Schema Noon Only"
Description: "Example showing 4-Schema pattern with only noon dose (0-1-0-0)"
* insert InsertMandatoryExStubs
* subject.display = "Patient"
* medicationCodeableConcept.text = "Test Medication"
* status = #active
* intent = #order
* dosageInstruction.timing.repeat.frequency = 1
* dosageInstruction.timing.repeat.period = 1
* dosageInstruction.timing.repeat.periodUnit = #d
* dosageInstruction.timing.repeat.when = #NOON
* dosageInstruction.doseAndRate[0].doseQuantity = 1 '1' "Stück"

// 5. FreeText with German special characters and complex text
Instance: MR-Dosage-freetext-german-chars
InstanceOf: MedicationRequestDgMP
Title: "MedicationRequest Dosage Example - FreeText German Characters"
Description: "Example showing FreeText with German special characters and complex text"
* insert InsertMandatoryExStubs
* subject.display = "Patient"
* medicationCodeableConcept.text = "Test Medication"
* status = #active
* intent = #order
* dosageInstruction.text = "Nach dem Essen — 2 Stück täglich für 3 Wochen (Dosierung anpassen je nach Verträglichkeit)"

// 6. DayOfWeek with different doses per day (mixed doses)
Instance: MR-Dosage-weekday-mixed-doses
InstanceOf: MedicationRequestDgMP
Title: "MedicationRequest Dosage Example - DayOfWeek Mixed Doses"
Description: "Example showing different doses on different days of the week"
* insert InsertMandatoryExStubs
* subject.display = "Patient"
* medicationCodeableConcept.text = "Test Medication"
* status = #active
* intent = #order
* dosageInstruction[0].timing.repeat.frequency = 1
* dosageInstruction[0].timing.repeat.period = 1
* dosageInstruction[0].timing.repeat.periodUnit = #wk
* dosageInstruction[0].timing.repeat.dayOfWeek = #mon
* dosageInstruction[0].doseAndRate[0].doseQuantity = 1 '1' "Stück"
* dosageInstruction[1].timing.repeat.frequency = 1
* dosageInstruction[1].timing.repeat.period = 1
* dosageInstruction[1].timing.repeat.periodUnit = #wk
* dosageInstruction[1].timing.repeat.dayOfWeek = #tue
* dosageInstruction[1].doseAndRate[0].doseQuantity = 3 '1' "Stück"

// 7. TimeOfDay with mixed doses at different times
Instance: MR-Dosage-tod-mixed-doses
InstanceOf: MedicationRequestDgMP
Title: "MedicationRequest Dosage Example - TimeOfDay Mixed Doses"
Description: "Example showing different doses at different times of day"
* insert InsertMandatoryExStubs
* subject.display = "Patient"
* medicationCodeableConcept.text = "Test Medication"
* status = #active
* intent = #order
* dosageInstruction[0].timing.repeat.frequency = 1
* dosageInstruction[0].timing.repeat.period = 1
* dosageInstruction[0].timing.repeat.periodUnit = #d
* dosageInstruction[0].timing.repeat.timeOfDay = "08:00:00"
* dosageInstruction[0].doseAndRate[0].doseQuantity = 1 '1' "Stück"
* dosageInstruction[1].timing.repeat.frequency = 1
* dosageInstruction[1].timing.repeat.period = 1
* dosageInstruction[1].timing.repeat.periodUnit = #d
* dosageInstruction[1].timing.repeat.timeOfDay = "18:00:00"
* dosageInstruction[1].doseAndRate[0].doseQuantity = 3 '1' "Stück"

// 8. 4-Schema with different units (ml instead of Stück)
Instance: MR-Dosage-4schema-ml-units
InstanceOf: MedicationRequestDgMP
Title: "MedicationRequest Dosage Example - 4-Schema with ml Units"
Description: "Example showing 4-Schema pattern with ml units instead of Stück"
* insert InsertMandatoryExStubs
* subject.display = "Patient"
* medicationCodeableConcept.text = "Test Medication"
* status = #active
* intent = #order
* dosageInstruction[0].timing.repeat.frequency = 1
* dosageInstruction[0].timing.repeat.period = 1
* dosageInstruction[0].timing.repeat.periodUnit = #d
* dosageInstruction[0].timing.repeat.when = #MORN
* dosageInstruction[0].doseAndRate[0].doseQuantity = 2 'mL' "ml"
* dosageInstruction[1].timing.repeat.frequency = 1
* dosageInstruction[1].timing.repeat.period = 1
* dosageInstruction[1].timing.repeat.periodUnit = #d
* dosageInstruction[1].timing.repeat.when = #EVE
* dosageInstruction[1].doseAndRate[0].doseQuantity = 1 'mL' "ml"

// 9. DayOfWeek and Time/4-Schema with single day + timeOfDay
Instance: MR-Dosage-single-day-time
InstanceOf: MedicationRequestDgMP
Title: "MedicationRequest Dosage Example - Single Day with TimeOfDay"
Description: "Example showing minimal dayOfWeek + timeOfDay combination"
* insert InsertMandatoryExStubs
* subject.display = "Patient"
* medicationCodeableConcept.text = "Test Medication"
* status = #active
* intent = #order
* dosageInstruction.timing.repeat.frequency = 1
* dosageInstruction.timing.repeat.period = 1
* dosageInstruction.timing.repeat.periodUnit = #wk
* dosageInstruction.timing.repeat.dayOfWeek = #mon
* dosageInstruction.timing.repeat.timeOfDay = "08:00:00"
* dosageInstruction.doseAndRate[0].doseQuantity = 1 '1' "Stück"

Instance: MR-Dosage-multiple-day-time
InstanceOf: MedicationRequestDgMP
Title: "MedicationRequest Dosage Example - Multiple Days with TimeOfDay"
Description: "Example showing multiple dayOfWeek + timeOfDay combination"
* insert InsertMandatoryExStubs
* subject.display = "Patient"
* medicationCodeableConcept.text = "Test Medication"
* status = #active
* intent = #order
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek[+] = #tue
    * dayOfWeek[+] = #thu
    * timeOfDay[+] = "08:00:00"
    * frequency = 2
    * period = 1
    * periodUnit = #wk
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek[+] = #mon
    * dayOfWeek[+] = #fri
    * timeOfDay[+] = "08:00:00"
    * timeOfDay[+] = "20:00:00"
    * frequency = 4
    * period = 1
    * periodUnit = #wk
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

// 10. Interval with monthly period unit
Instance: MR-Dosage-interval-monthly
InstanceOf: MedicationRequestDgMP
Title: "MedicationRequest Dosage Example - Monthly Interval"
Description: "Example showing interval dosing with monthly period"
* insert InsertMandatoryExStubs
* subject.display = "Patient"
* medicationCodeableConcept.text = "Test Medication"
* status = #active
* intent = #order
* dosageInstruction.timing.repeat.frequency = 1
* dosageInstruction.timing.repeat.period = 2
* dosageInstruction.timing.repeat.periodUnit = #mo
* dosageInstruction.doseAndRate[0].doseQuantity = 1 '1' "Stück"
