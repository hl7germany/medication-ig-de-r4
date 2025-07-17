// when + timeOfDay
Instance: Invalid-Dosage-C-TimingOnlyOneType-01-of-08
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid: when + timeOfDay"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for allowed Permutations"
* subject.display = "DEV Dosage"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "DEV Medication"
* dosageInstruction[+]
  * timing.repeat
    * when[+] = #MORN
    * frequency = 1
    * period = 1
    * periodUnit = #d
* dosageInstruction[+]
  * timing.repeat
    * timeOfDay[+] = "08:00:00"
    * frequency = 1
    * period = 1
    * periodUnit = #d

// when + dayOfWeek
Instance: Invalid-Dosage-C-TimingOnlyOneType-02-of-08
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid: when + dayOfWeek"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for allowed Permutations"
* subject.display = "DEV Dosage"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "DEV Medication"
* dosageInstruction[+]
  * timing.repeat
    * when[+] = #EVE
    * frequency = 1
    * period = 1
    * periodUnit = #d
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek[+] = #mon
    * frequency = 1
    * period = 1
    * periodUnit = #d

// when + interval
Instance: Invalid-Dosage-C-TimingOnlyOneType-03-of-08
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid: when + interval"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for allowed Permutations"
* subject.display = "DEV Dosage"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "DEV Medication"
* dosageInstruction[+]
  * timing.repeat
    * when[+] = #NOON
    * frequency = 1
    * period = 1
    * periodUnit = #d
* dosageInstruction[+]
  * timing.repeat
    * frequency = 2
    * period = 1
    * periodUnit = #d

// timeOfDay + dayOfWeek
Instance: Invalid-Dosage-C-TimingOnlyOneType-04-of-08
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid: timeOfDay + dayOfWeek"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for allowed Permutations"
* subject.display = "DEV Dosage"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "DEV Medication"
* dosageInstruction[+]
  * timing.repeat
    * timeOfDay[+] = "07:00:00"
    * frequency = 1
    * period = 1
    * periodUnit = #d
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek[+] = #fri


// timeOfDay + interval
Instance: Invalid-Dosage-C-TimingOnlyOneType-05-of-08
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid: timeOfDay + interval"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for allowed Permutations"
* subject.display = "DEV Dosage"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "DEV Medication"
* dosageInstruction[+]
  * timing.repeat
    * timeOfDay[+] = "12:00:00"
    * frequency = 1
    * period = 1
    * periodUnit = #d
* dosageInstruction[+]
  * timing.repeat
    * frequency = 3
    * period = 1
    * periodUnit = #d

// dayOfWeek + interval
Instance: Invalid-Dosage-C-TimingOnlyOneType-06-of-08
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid: dayOfWeek + interval"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for allowed Permutations"
* subject.display = "DEV Dosage"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "DEV Medication"
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek[+] = #tue
* dosageInstruction[+]
  * timing.repeat
    * frequency = 2
    * period = 1
    * periodUnit = #d

// only when
Instance: Invalid-Dosage-C-TimingOnlyOneType-07-of-08
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid: only when"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for allowed Permutations"
* subject.display = "DEV Dosage"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "DEV Medication"
* dosageInstruction[+]
  * timing.repeat
    * when[+] = #MORN

// only timeOfDay
Instance: Invalid-Dosage-C-TimingOnlyOneType-08-of-08
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid: only timeOfDay"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for allowed Permutations"
* subject.display = "DEV Dosage"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "DEV Medication"
* dosageInstruction[+]
  * timing.repeat
    * timeOfDay[+] = "08:00:00"