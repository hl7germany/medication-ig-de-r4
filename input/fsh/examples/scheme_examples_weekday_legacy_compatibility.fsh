// Positive compatibility matrix: all weekday schemas with the formerly
// mandatory, now optional frequency / 1 wk legacy fields in all resource types.

Instance: Example-MR-Weekday-Legacy
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "MedicationRequest: weekday with compatible legacy fields"
Description: "Positive compatibility example for a plain weekday schema."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Test Medication"
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek[+] = #tue
    * dayOfWeek[+] = #thu
    * frequency = 2
    * period = 1
    * periodUnit = #wk
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MD-Weekday-Legacy
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "MedicationDispense: weekday with compatible legacy fields"
Description: "Positive compatibility example for a plain weekday schema."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Test Medication"
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek[+] = #tue
    * dayOfWeek[+] = #thu
    * frequency = 2
    * period = 1
    * periodUnit = #wk
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MS-Weekday-Legacy
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "MedicationStatement: weekday with compatible legacy fields"
Description: "Positive compatibility example for a plain weekday schema."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Test Medication"
* dosage[+]
  * timing.repeat
    * dayOfWeek[+] = #tue
    * dayOfWeek[+] = #thu
    * frequency = 2
    * period = 1
    * periodUnit = #wk
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MR-Weekday-When-Legacy
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "MedicationRequest: weekday and when with compatible legacy fields"
Description: "Positive compatibility example for weekday plus when."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Test Medication"
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek[+] = #tue
    * dayOfWeek[+] = #thu
    * when[+] = #MORN
    * when[+] = #EVE
    * frequency = 4
    * period = 1
    * periodUnit = #wk
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MD-Weekday-When-Legacy
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "MedicationDispense: weekday and when with compatible legacy fields"
Description: "Positive compatibility example for weekday plus when."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Test Medication"
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek[+] = #tue
    * dayOfWeek[+] = #thu
    * when[+] = #MORN
    * when[+] = #EVE
    * frequency = 4
    * period = 1
    * periodUnit = #wk
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MS-Weekday-When-Legacy
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "MedicationStatement: weekday and when with compatible legacy fields"
Description: "Positive compatibility example for weekday plus when."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Test Medication"
* dosage[+]
  * timing.repeat
    * dayOfWeek[+] = #tue
    * dayOfWeek[+] = #thu
    * when[+] = #MORN
    * when[+] = #EVE
    * frequency = 4
    * period = 1
    * periodUnit = #wk
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MR-Weekday-TimeOfDay-Legacy
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "MedicationRequest: weekday and timeOfDay with compatible legacy fields"
Description: "Positive compatibility example for weekday plus timeOfDay."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Test Medication"
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek[+] = #tue
    * dayOfWeek[+] = #thu
    * timeOfDay[+] = "08:00:00"
    * timeOfDay[+] = "20:00:00"
    * frequency = 4
    * period = 1
    * periodUnit = #wk
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MD-Weekday-TimeOfDay-Legacy
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "MedicationDispense: weekday and timeOfDay with compatible legacy fields"
Description: "Positive compatibility example for weekday plus timeOfDay."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Test Medication"
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek[+] = #tue
    * dayOfWeek[+] = #thu
    * timeOfDay[+] = "08:00:00"
    * timeOfDay[+] = "20:00:00"
    * frequency = 4
    * period = 1
    * periodUnit = #wk
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MS-Weekday-TimeOfDay-Legacy
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "MedicationStatement: weekday and timeOfDay with compatible legacy fields"
Description: "Positive compatibility example for weekday plus timeOfDay."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Test Medication"
* dosage[+]
  * timing.repeat
    * dayOfWeek[+] = #tue
    * dayOfWeek[+] = #thu
    * timeOfDay[+] = "08:00:00"
    * timeOfDay[+] = "20:00:00"
    * frequency = 4
    * period = 1
    * periodUnit = #wk
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

// The existing positive examples already cover almost all weekday variants
// without legacy fields. These two instances close the remaining resource-type
// gaps: plain weekday for MedicationDispense and weekday + when for Statement.

Instance: Example-MD-Weekday-Without-Legacy
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "MedicationDispense: weekday without legacy fields"
Description: "Positive example showing that the compatibility fields are optional."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Test Medication"
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek[+] = #tue
    * dayOfWeek[+] = #thu
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MS-Weekday-When-Without-Legacy
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "MedicationStatement: weekday and when without legacy fields"
Description: "Positive example showing that the compatibility fields are optional."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Test Medication"
* dosage[+]
  * timing.repeat
    * dayOfWeek[+] = #tue
    * dayOfWeek[+] = #thu
    * when[+] = #MORN
    * when[+] = #EVE
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
