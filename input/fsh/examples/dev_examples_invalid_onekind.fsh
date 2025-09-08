// when + timeOfDay
Instance: Invalid-C-TimingOnlyWhenOrTimeOfDay-01-of-01
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid: when + timeOfDay"
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
Instance: Invalid-C-TimingOnlyOneType-01-of-08
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid: when + dayOfWeek"
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
Instance: Invalid-C-TimingOnlyOneType-02-of-08
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid: when + interval"
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
Instance: Invalid-C-TimingOnlyOneType-03-of-08
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid: timeOfDay + dayOfWeek"
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
Instance: Invalid-C-TimingOnlyOneType-04-of-08
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid: timeOfDay + interval"
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
Instance: Invalid-C-TimingOnlyOneType-05-of-08
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid: dayOfWeek + interval"
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