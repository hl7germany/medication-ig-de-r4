// when + timeOfDay
Instance: INV-C-TimingOnlyWhenOrTimeOfDay-Request-01-of-01
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid (Request): when + timeOfDay"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for allowed Permutations"
* subject.display = "DEV Dosage"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "DEV Medication"
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * when[+] = #MORN
    * frequency = 1
    * period = 1
    * periodUnit = #d
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * timeOfDay[+] = "08:00:00"
    * frequency = 1
    * period = 1
    * periodUnit = #d

// when + dayOfWeek
Instance: INV-C-TimingOnlyOneType-Request-01-of-05
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid (Request): when + dayOfWeek"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for allowed Permutations"
* subject.display = "DEV Dosage"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "DEV Medication"
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * when[+] = #EVE
    * frequency = 1
    * period = 1
    * periodUnit = #d
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * dayOfWeek[+] = #mon
    * frequency = 1
    * period = 1
    * periodUnit = #wk

// when + interval
Instance: INV-C-TimingOnlyOneType-Request-02-of-05
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid (Request): when + interval"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for allowed Permutations"
* subject.display = "DEV Dosage"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "DEV Medication"
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * when[+] = #NOON
    * frequency = 1
    * period = 1
    * periodUnit = #d
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d

// timeOfDay + dayOfWeek
Instance: INV-C-TimingOnlyOneType-Request-03-of-05
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid (Request): timeOfDay + dayOfWeek"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for allowed Permutations"
* subject.display = "DEV Dosage"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "DEV Medication"
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * timeOfDay[+] = "07:00:00"
    * frequency = 1
    * period = 1
    * periodUnit = #d
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * dayOfWeek[+] = #fri
    * frequency = 1
    * period = 1
    * periodUnit = #wk


// timeOfDay + interval
Instance: INV-C-TimingOnlyOneType-Request-04-of-05
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid (Request): timeOfDay + interval"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for allowed Permutations"
* subject.display = "DEV Dosage"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "DEV Medication"
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * timeOfDay[+] = "12:00:00"
    * frequency = 1
    * period = 1
    * periodUnit = #d
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d

// dayOfWeek + interval
Instance: INV-C-TimingOnlyOneType-Request-05-of-05
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid (Request): dayOfWeek + interval"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for allowed Permutations"
* subject.display = "DEV Dosage"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "DEV Medication"
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * dayOfWeek[+] = #tue
    * frequency = 1
    * period = 1
    * periodUnit = #wk
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d

// ============================================================
// TimingOnlyWhenOrTimeOfDay — Dispense + Statement
// ============================================================

// when + timeOfDay - Dispense
Instance: INV-C-TimingOnlyWhenOrTimeOfDay-Dispense-01-of-01
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid (Dispense): when + timeOfDay"
Description: "CAVE: This MedicationDispense is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for allowed Permutations"
* subject.display = "DEV Dosage"
* status = #completed
* medicationCodeableConcept.text = "DEV Medication"
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * when[+] = #MORN
    * frequency = 1
    * period = 1
    * periodUnit = #d
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * timeOfDay[+] = "08:00:00"
    * frequency = 1
    * period = 1
    * periodUnit = #d

// when + timeOfDay - Statement
Instance: INV-C-TimingOnlyWhenOrTimeOfDay-Statement-01-of-01
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid (Statement): when + timeOfDay"
Description: "CAVE: This MedicationStatement is for validation purposes and does NOT represent a valid dosage. It only checks for allowed Permutations"
* subject.display = "DEV Dosage"
* status = #active
* medicationCodeableConcept.text = "DEV Medication"
* dosage[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * when[+] = #MORN
    * frequency = 1
    * period = 1
    * periodUnit = #d
* dosage[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * timeOfDay[+] = "08:00:00"
    * frequency = 1
    * period = 1
    * periodUnit = #d

// ============================================================
// TimingOnlyOneType — Dispense examples (01–05 of 05)
// ============================================================

// when + dayOfWeek - Dispense
Instance: INV-C-TimingOnlyOneType-Dispense-01-of-05
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid (Dispense): when + dayOfWeek"
Description: "CAVE: This MedicationDispense is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for allowed Permutations"
* subject.display = "DEV Dosage"
* status = #completed
* medicationCodeableConcept.text = "DEV Medication"
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * when[+] = #EVE
    * frequency = 1
    * period = 1
    * periodUnit = #d
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * dayOfWeek[+] = #mon
    * frequency = 1
    * period = 1
    * periodUnit = #wk

// when + interval - Dispense
Instance: INV-C-TimingOnlyOneType-Dispense-02-of-05
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid (Dispense): when + interval"
Description: "CAVE: This MedicationDispense is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for allowed Permutations"
* subject.display = "DEV Dosage"
* status = #completed
* medicationCodeableConcept.text = "DEV Medication"
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * when[+] = #NOON
    * frequency = 1
    * period = 1
    * periodUnit = #d
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d

// timeOfDay + dayOfWeek - Dispense
Instance: INV-C-TimingOnlyOneType-Dispense-03-of-05
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid (Dispense): timeOfDay + dayOfWeek"
Description: "CAVE: This MedicationDispense is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for allowed Permutations"
* subject.display = "DEV Dosage"
* status = #completed
* medicationCodeableConcept.text = "DEV Medication"
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * timeOfDay[+] = "07:00:00"
    * frequency = 1
    * period = 1
    * periodUnit = #d
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * dayOfWeek[+] = #fri
    * frequency = 1
    * period = 1
    * periodUnit = #wk

// timeOfDay + interval - Dispense
Instance: INV-C-TimingOnlyOneType-Dispense-04-of-05
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid (Dispense): timeOfDay + interval"
Description: "CAVE: This MedicationDispense is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for allowed Permutations"
* subject.display = "DEV Dosage"
* status = #completed
* medicationCodeableConcept.text = "DEV Medication"
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * timeOfDay[+] = "12:00:00"
    * frequency = 1
    * period = 1
    * periodUnit = #d
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d

// dayOfWeek + interval - Dispense
Instance: INV-C-TimingOnlyOneType-Dispense-05-of-05
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid (Dispense): dayOfWeek + interval"
Description: "CAVE: This MedicationDispense is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for allowed Permutations"
* subject.display = "DEV Dosage"
* status = #completed
* medicationCodeableConcept.text = "DEV Medication"
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * dayOfWeek[+] = #tue
    * frequency = 1
    * period = 1
    * periodUnit = #wk
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d

// ============================================================
// TimingOnlyOneType — Statement examples (01–05 of 05)
// ============================================================

// when + dayOfWeek - Statement
Instance: INV-C-TimingOnlyOneType-Statement-01-of-05
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid (Statement): when + dayOfWeek"
Description: "CAVE: This MedicationStatement is for validation purposes and does NOT represent a valid dosage. It only checks for allowed Permutations"
* subject.display = "DEV Dosage"
* status = #active
* medicationCodeableConcept.text = "DEV Medication"
* dosage[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * when[+] = #EVE
    * frequency = 1
    * period = 1
    * periodUnit = #d
* dosage[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * dayOfWeek[+] = #mon
    * frequency = 1
    * period = 1
    * periodUnit = #wk

// when + interval - Statement
Instance: INV-C-TimingOnlyOneType-Statement-02-of-05
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid (Statement): when + interval"
Description: "CAVE: This MedicationStatement is for validation purposes and does NOT represent a valid dosage. It only checks for allowed Permutations"
* subject.display = "DEV Dosage"
* status = #active
* medicationCodeableConcept.text = "DEV Medication"
* dosage[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * when[+] = #NOON
    * frequency = 1
    * period = 1
    * periodUnit = #d
* dosage[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d

// timeOfDay + dayOfWeek - Statement
Instance: INV-C-TimingOnlyOneType-Statement-03-of-05
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid (Statement): timeOfDay + dayOfWeek"
Description: "CAVE: This MedicationStatement is for validation purposes and does NOT represent a valid dosage. It only checks for allowed Permutations"
* subject.display = "DEV Dosage"
* status = #active
* medicationCodeableConcept.text = "DEV Medication"
* dosage[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * timeOfDay[+] = "07:00:00"
    * frequency = 1
    * period = 1
    * periodUnit = #d
* dosage[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * dayOfWeek[+] = #fri
    * frequency = 1
    * period = 1
    * periodUnit = #wk

// timeOfDay + interval - Statement
Instance: INV-C-TimingOnlyOneType-Statement-04-of-05
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid (Statement): timeOfDay + interval"
Description: "CAVE: This MedicationStatement is for validation purposes and does NOT represent a valid dosage. It only checks for allowed Permutations"
* subject.display = "DEV Dosage"
* status = #active
* medicationCodeableConcept.text = "DEV Medication"
* dosage[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * timeOfDay[+] = "12:00:00"
    * frequency = 1
    * period = 1
    * periodUnit = #d
* dosage[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d

// dayOfWeek + interval - Statement
Instance: INV-C-TimingOnlyOneType-Statement-05-of-05
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid (Statement): dayOfWeek + interval"
Description: "CAVE: This MedicationStatement is for validation purposes and does NOT represent a valid dosage. It only checks for allowed Permutations"
* subject.display = "DEV Dosage"
* status = #active
* medicationCodeableConcept.text = "DEV Medication"
* dosage[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * dayOfWeek[+] = #tue
    * frequency = 1
    * period = 1
    * periodUnit = #wk
* dosage[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d
