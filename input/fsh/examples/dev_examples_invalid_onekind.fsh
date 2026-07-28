// when + timeOfDay
Instance: INV-C-TimingOnlyWhenOrTimeOfDay-Request-01-of-02
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
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * timeOfDay[+] = "08:00:00"

Instance: INV-C-TimingOnlyWhenOrTimeOfDay-Request-02-of-02
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid (Request): dayOfWeek + timeOfDay and dayOfWeek + when"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It checks that timeOfDay and when must not be mixed when dayOfWeek is present."
* subject.display = "DEV Dosage"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "DEV Medication"
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * dayOfWeek[+] = #mon
    * timeOfDay[+] = "08:00:00"
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * dayOfWeek[+] = #mon
    * when[+] = #MORN

// when + dayOfWeek
Instance: INV-C-TimingOnlyOneType-Request-01-of-13
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
Instance: INV-C-TimingOnlyOneType-Request-02-of-13
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
Instance: INV-C-TimingOnlyOneType-Request-03-of-13
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
Instance: INV-C-TimingOnlyOneType-Request-04-of-13
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
Instance: INV-C-TimingOnlyOneType-Request-05-of-13
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

// dayOfWeek + dayOfWeek with when
Instance: INV-C-TimingOnlyOneType-Request-06-of-13
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid (Request): dayOfWeek + dayOfWeek with when"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It checks that pure dayOfWeek and dayOfWeek with when must not be mixed."
* subject.display = "DEV Dosage"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "DEV Medication"
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * dayOfWeek[+] = #mon
    * frequency = 1
    * period = 1
    * periodUnit = #wk
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * dayOfWeek[+] = #wed
    * when[+] = #MORN
    * frequency = 1
    * period = 1
    * periodUnit = #wk

// interval + interval with timeOfDay
Instance: INV-C-TimingOnlyOneType-Request-07-of-13
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid (Request): interval + interval with timeOfDay"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It checks that pure interval and interval with timeOfDay must not be mixed."
* subject.display = "DEV Dosage"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "DEV Medication"
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * frequency = 1
    * period = 2
    * periodUnit = #d
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * timeOfDay[+] = "08:00:00"
    * frequency = 1
    * period = 2
    * periodUnit = #d

// dayOfWeek with when + interval
Instance: INV-C-TimingOnlyOneType-Request-08-of-13
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid (Request): dayOfWeek with when + interval"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It checks that dayOfWeek with when and pure interval must not be mixed."
* subject.display = "DEV Dosage"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "DEV Medication"
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * dayOfWeek[+] = #fri
    * when[+] = #EVE
    * frequency = 1
    * period = 1
    * periodUnit = #wk
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * frequency = 1
    * period = 3
    * periodUnit = #d

// dayOfWeek + dayOfWeek with timeOfDay
Instance: INV-C-TimingOnlyOneType-Request-09-of-13
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid (Request): dayOfWeek + dayOfWeek with timeOfDay"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It checks that pure dayOfWeek and dayOfWeek with timeOfDay must not be mixed."
* subject.display = "DEV Dosage"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "DEV Medication"
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * dayOfWeek[+] = #mon
    * frequency = 1
    * period = 1
    * periodUnit = #wk
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * dayOfWeek[+] = #wed
    * timeOfDay[+] = "08:00:00"
    * frequency = 1
    * period = 1
    * periodUnit = #wk

// interval + interval with when
Instance: INV-C-TimingOnlyOneType-Request-10-of-13
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid (Request): interval + interval with when"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It checks that pure interval and interval with when must not be mixed."
* subject.display = "DEV Dosage"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "DEV Medication"
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * frequency = 1
    * period = 2
    * periodUnit = #d
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * when[+] = #MORN
    * frequency = 1
    * period = 2
    * periodUnit = #d

// dayOfWeek with timeOfDay + interval
Instance: INV-C-TimingOnlyOneType-Request-11-of-13
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid (Request): dayOfWeek with timeOfDay + interval"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It checks that dayOfWeek with timeOfDay and pure interval must not be mixed."
* subject.display = "DEV Dosage"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "DEV Medication"
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * dayOfWeek[+] = #fri
    * timeOfDay[+] = "08:00:00"
    * frequency = 1
    * period = 1
    * periodUnit = #wk
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * frequency = 1
    * period = 3
    * periodUnit = #d

// dayOfWeek with when + interval with when
Instance: INV-C-TimingOnlyOneType-Request-12-of-13
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid (Request): dayOfWeek with when + interval with when"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It checks that dayOfWeek with when and interval with when must not be mixed."
* subject.display = "DEV Dosage"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "DEV Medication"
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * dayOfWeek[+] = #fri
    * when[+] = #EVE
    * frequency = 1
    * period = 1
    * periodUnit = #wk
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * when[+] = #MORN
    * frequency = 1
    * period = 3
    * periodUnit = #d

// dayOfWeek with timeOfDay + interval with timeOfDay
Instance: INV-C-TimingOnlyOneType-Request-13-of-13
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid (Request): dayOfWeek with timeOfDay + interval with timeOfDay"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It checks that dayOfWeek with timeOfDay and interval with timeOfDay must not be mixed."
* subject.display = "DEV Dosage"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "DEV Medication"
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * dayOfWeek[+] = #fri
    * timeOfDay[+] = "08:00:00"
    * frequency = 1
    * period = 1
    * periodUnit = #wk
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * timeOfDay[+] = "20:00:00"
    * frequency = 1
    * period = 3
    * periodUnit = #d

// ============================================================
// TimingOnlyWhenOrTimeOfDay — Dispense + Statement
// ============================================================

// when + timeOfDay - Dispense
Instance: INV-C-TimingOnlyWhenOrTimeOfDay-Dispense-01-of-02
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
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * timeOfDay[+] = "08:00:00"

Instance: INV-C-TimingOnlyWhenOrTimeOfDay-Dispense-02-of-02
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid (Dispense): dayOfWeek + timeOfDay and dayOfWeek + when"
Description: "CAVE: This MedicationDispense is for validation purposes and does NOT represent a valid dosageInstruction. It checks that timeOfDay and when must not be mixed when dayOfWeek is present."
* subject.display = "DEV Dosage"
* status = #completed
* medicationCodeableConcept.text = "DEV Medication"
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * dayOfWeek[+] = #mon
    * timeOfDay[+] = "08:00:00"
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * dayOfWeek[+] = #mon
    * when[+] = #MORN

// when + timeOfDay - Statement
Instance: INV-C-TimingOnlyWhenOrTimeOfDay-Statement-01-of-02
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
* dosage[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * timeOfDay[+] = "08:00:00"

Instance: INV-C-TimingOnlyWhenOrTimeOfDay-Statement-02-of-02
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid (Statement): dayOfWeek + timeOfDay and dayOfWeek + when"
Description: "CAVE: This MedicationStatement is for validation purposes and does NOT represent a valid dosage. It checks that timeOfDay and when must not be mixed when dayOfWeek is present."
* subject.display = "DEV Dosage"
* status = #active
* medicationCodeableConcept.text = "DEV Medication"
* dosage[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * dayOfWeek[+] = #mon
    * timeOfDay[+] = "08:00:00"
* dosage[+]
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * dayOfWeek[+] = #mon
    * when[+] = #MORN

// ============================================================
// TimingOnlyOneType — Dispense examples (01–05 of 05)
// ============================================================

// when + dayOfWeek - Dispense
Instance: INV-C-TimingOnlyOneType-Dispense-01-of-13
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
Instance: INV-C-TimingOnlyOneType-Dispense-02-of-13
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
Instance: INV-C-TimingOnlyOneType-Dispense-03-of-13
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
Instance: INV-C-TimingOnlyOneType-Dispense-04-of-13
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
Instance: INV-C-TimingOnlyOneType-Dispense-05-of-13
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

// dayOfWeek + dayOfWeek with when - Dispense
Instance: INV-C-TimingOnlyOneType-Dispense-06-of-13
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid (Dispense): dayOfWeek + dayOfWeek with when"
Description: "CAVE: This MedicationDispense is for validation purposes and does NOT represent a valid dosageInstruction. It checks that pure dayOfWeek and dayOfWeek with when must not be mixed."
* subject.display = "DEV Dosage"
* status = #completed
* medicationCodeableConcept.text = "DEV Medication"
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * dayOfWeek[+] = #mon
    * frequency = 1
    * period = 1
    * periodUnit = #wk
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * dayOfWeek[+] = #wed
    * when[+] = #MORN
    * frequency = 1
    * period = 1
    * periodUnit = #wk

// interval + interval with timeOfDay - Dispense
Instance: INV-C-TimingOnlyOneType-Dispense-07-of-13
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid (Dispense): interval + interval with timeOfDay"
Description: "CAVE: This MedicationDispense is for validation purposes and does NOT represent a valid dosageInstruction. It checks that pure interval and interval with timeOfDay must not be mixed."
* subject.display = "DEV Dosage"
* status = #completed
* medicationCodeableConcept.text = "DEV Medication"
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * frequency = 1
    * period = 2
    * periodUnit = #d
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * timeOfDay[+] = "08:00:00"
    * frequency = 1
    * period = 2
    * periodUnit = #d

// dayOfWeek with when + interval - Dispense
Instance: INV-C-TimingOnlyOneType-Dispense-08-of-13
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid (Dispense): dayOfWeek with when + interval"
Description: "CAVE: This MedicationDispense is for validation purposes and does NOT represent a valid dosageInstruction. It checks that dayOfWeek with when and pure interval must not be mixed."
* subject.display = "DEV Dosage"
* status = #completed
* medicationCodeableConcept.text = "DEV Medication"
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * dayOfWeek[+] = #fri
    * when[+] = #EVE
    * frequency = 1
    * period = 1
    * periodUnit = #wk
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * frequency = 1
    * period = 3
    * periodUnit = #d

// dayOfWeek + dayOfWeek with timeOfDay - Dispense
Instance: INV-C-TimingOnlyOneType-Dispense-09-of-13
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid (Dispense): dayOfWeek + dayOfWeek with timeOfDay"
Description: "CAVE: This MedicationDispense is for validation purposes and does NOT represent a valid dosageInstruction. It checks that pure dayOfWeek and dayOfWeek with timeOfDay must not be mixed."
* subject.display = "DEV Dosage"
* status = #completed
* medicationCodeableConcept.text = "DEV Medication"
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * dayOfWeek[+] = #mon
    * frequency = 1
    * period = 1
    * periodUnit = #wk
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * dayOfWeek[+] = #wed
    * timeOfDay[+] = "08:00:00"
    * frequency = 1
    * period = 1
    * periodUnit = #wk

// interval + interval with when - Dispense
Instance: INV-C-TimingOnlyOneType-Dispense-10-of-13
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid (Dispense): interval + interval with when"
Description: "CAVE: This MedicationDispense is for validation purposes and does NOT represent a valid dosageInstruction. It checks that pure interval and interval with when must not be mixed."
* subject.display = "DEV Dosage"
* status = #completed
* medicationCodeableConcept.text = "DEV Medication"
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * frequency = 1
    * period = 2
    * periodUnit = #d
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * when[+] = #MORN
    * frequency = 1
    * period = 2
    * periodUnit = #d

// dayOfWeek with timeOfDay + interval - Dispense
Instance: INV-C-TimingOnlyOneType-Dispense-11-of-13
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid (Dispense): dayOfWeek with timeOfDay + interval"
Description: "CAVE: This MedicationDispense is for validation purposes and does NOT represent a valid dosageInstruction. It checks that dayOfWeek with timeOfDay and pure interval must not be mixed."
* subject.display = "DEV Dosage"
* status = #completed
* medicationCodeableConcept.text = "DEV Medication"
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * dayOfWeek[+] = #fri
    * timeOfDay[+] = "08:00:00"
    * frequency = 1
    * period = 1
    * periodUnit = #wk
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * frequency = 1
    * period = 3
    * periodUnit = #d

// dayOfWeek with when + interval with when - Dispense
Instance: INV-C-TimingOnlyOneType-Dispense-12-of-13
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid (Dispense): dayOfWeek with when + interval with when"
Description: "CAVE: This MedicationDispense is for validation purposes and does NOT represent a valid dosageInstruction. It checks that dayOfWeek with when and interval with when must not be mixed."
* subject.display = "DEV Dosage"
* status = #completed
* medicationCodeableConcept.text = "DEV Medication"
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * dayOfWeek[+] = #fri
    * when[+] = #EVE
    * frequency = 1
    * period = 1
    * periodUnit = #wk
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * when[+] = #MORN
    * frequency = 1
    * period = 3
    * periodUnit = #d

// dayOfWeek with timeOfDay + interval with timeOfDay - Dispense
Instance: INV-C-TimingOnlyOneType-Dispense-13-of-13
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid (Dispense): dayOfWeek with timeOfDay + interval with timeOfDay"
Description: "CAVE: This MedicationDispense is for validation purposes and does NOT represent a valid dosageInstruction. It checks that dayOfWeek with timeOfDay and interval with timeOfDay must not be mixed."
* subject.display = "DEV Dosage"
* status = #completed
* medicationCodeableConcept.text = "DEV Medication"
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * dayOfWeek[+] = #fri
    * timeOfDay[+] = "08:00:00"
    * frequency = 1
    * period = 1
    * periodUnit = #wk
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * timeOfDay[+] = "20:00:00"
    * frequency = 1
    * period = 3
    * periodUnit = #d

// ============================================================
// TimingOnlyOneType — Statement examples (01–05 of 05)
// ============================================================

// when + dayOfWeek - Statement
Instance: INV-C-TimingOnlyOneType-Statement-01-of-13
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
Instance: INV-C-TimingOnlyOneType-Statement-02-of-13
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
Instance: INV-C-TimingOnlyOneType-Statement-03-of-13
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
Instance: INV-C-TimingOnlyOneType-Statement-04-of-13
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
Instance: INV-C-TimingOnlyOneType-Statement-05-of-13
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

// dayOfWeek + dayOfWeek with when - Statement
Instance: INV-C-TimingOnlyOneType-Statement-06-of-13
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid (Statement): dayOfWeek + dayOfWeek with when"
Description: "CAVE: This MedicationStatement is for validation purposes and does NOT represent a valid dosage. It checks that pure dayOfWeek and dayOfWeek with when must not be mixed."
* subject.display = "DEV Dosage"
* status = #active
* medicationCodeableConcept.text = "DEV Medication"
* dosage[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * dayOfWeek[+] = #mon
    * frequency = 1
    * period = 1
    * periodUnit = #wk
* dosage[+]
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * dayOfWeek[+] = #wed
    * when[+] = #MORN
    * frequency = 1
    * period = 1
    * periodUnit = #wk

// interval + interval with timeOfDay - Statement
Instance: INV-C-TimingOnlyOneType-Statement-07-of-13
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid (Statement): interval + interval with timeOfDay"
Description: "CAVE: This MedicationStatement is for validation purposes and does NOT represent a valid dosage. It checks that pure interval and interval with timeOfDay must not be mixed."
* subject.display = "DEV Dosage"
* status = #active
* medicationCodeableConcept.text = "DEV Medication"
* dosage[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * frequency = 1
    * period = 2
    * periodUnit = #d
* dosage[+]
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * timeOfDay[+] = "08:00:00"
    * frequency = 1
    * period = 2
    * periodUnit = #d

// dayOfWeek with when + interval - Statement
Instance: INV-C-TimingOnlyOneType-Statement-08-of-13
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid (Statement): dayOfWeek with when + interval"
Description: "CAVE: This MedicationStatement is for validation purposes and does NOT represent a valid dosage. It checks that dayOfWeek with when and pure interval must not be mixed."
* subject.display = "DEV Dosage"
* status = #active
* medicationCodeableConcept.text = "DEV Medication"
* dosage[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * dayOfWeek[+] = #fri
    * when[+] = #EVE
    * frequency = 1
    * period = 1
    * periodUnit = #wk
* dosage[+]
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * frequency = 1
    * period = 3
    * periodUnit = #d

// dayOfWeek + dayOfWeek with timeOfDay - Statement
Instance: INV-C-TimingOnlyOneType-Statement-09-of-13
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid (Statement): dayOfWeek + dayOfWeek with timeOfDay"
Description: "CAVE: This MedicationStatement is for validation purposes and does NOT represent a valid dosage. It checks that pure dayOfWeek and dayOfWeek with timeOfDay must not be mixed."
* subject.display = "DEV Dosage"
* status = #active
* medicationCodeableConcept.text = "DEV Medication"
* dosage[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * dayOfWeek[+] = #mon
    * frequency = 1
    * period = 1
    * periodUnit = #wk
* dosage[+]
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * dayOfWeek[+] = #wed
    * timeOfDay[+] = "08:00:00"
    * frequency = 1
    * period = 1
    * periodUnit = #wk

// interval + interval with when - Statement
Instance: INV-C-TimingOnlyOneType-Statement-10-of-13
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid (Statement): interval + interval with when"
Description: "CAVE: This MedicationStatement is for validation purposes and does NOT represent a valid dosage. It checks that pure interval and interval with when must not be mixed."
* subject.display = "DEV Dosage"
* status = #active
* medicationCodeableConcept.text = "DEV Medication"
* dosage[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * frequency = 1
    * period = 2
    * periodUnit = #d
* dosage[+]
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * when[+] = #MORN
    * frequency = 1
    * period = 2
    * periodUnit = #d

// dayOfWeek with timeOfDay + interval - Statement
Instance: INV-C-TimingOnlyOneType-Statement-11-of-13
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid (Statement): dayOfWeek with timeOfDay + interval"
Description: "CAVE: This MedicationStatement is for validation purposes and does NOT represent a valid dosage. It checks that dayOfWeek with timeOfDay and pure interval must not be mixed."
* subject.display = "DEV Dosage"
* status = #active
* medicationCodeableConcept.text = "DEV Medication"
* dosage[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * dayOfWeek[+] = #fri
    * timeOfDay[+] = "08:00:00"
    * frequency = 1
    * period = 1
    * periodUnit = #wk
* dosage[+]
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * frequency = 1
    * period = 3
    * periodUnit = #d

// dayOfWeek with when + interval with when - Statement
Instance: INV-C-TimingOnlyOneType-Statement-12-of-13
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid (Statement): dayOfWeek with when + interval with when"
Description: "CAVE: This MedicationStatement is for validation purposes and does NOT represent a valid dosage. It checks that dayOfWeek with when and interval with when must not be mixed."
* subject.display = "DEV Dosage"
* status = #active
* medicationCodeableConcept.text = "DEV Medication"
* dosage[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * dayOfWeek[+] = #fri
    * when[+] = #EVE
    * frequency = 1
    * period = 1
    * periodUnit = #wk
* dosage[+]
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * when[+] = #MORN
    * frequency = 1
    * period = 3
    * periodUnit = #d

// dayOfWeek with timeOfDay + interval with timeOfDay - Statement
Instance: INV-C-TimingOnlyOneType-Statement-13-of-13
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid (Statement): dayOfWeek with timeOfDay + interval with timeOfDay"
Description: "CAVE: This MedicationStatement is for validation purposes and does NOT represent a valid dosage. It checks that dayOfWeek with timeOfDay and interval with timeOfDay must not be mixed."
* subject.display = "DEV Dosage"
* status = #active
* medicationCodeableConcept.text = "DEV Medication"
* dosage[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * dayOfWeek[+] = #fri
    * timeOfDay[+] = "08:00:00"
    * frequency = 1
    * period = 1
    * periodUnit = #wk
* dosage[+]
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * timeOfDay[+] = "20:00:00"
    * frequency = 1
    * period = 3
    * periodUnit = #d
