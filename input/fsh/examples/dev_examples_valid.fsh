// when + timeOfDay
Instance: Example-MR-Dosage-Invalid-One-Kind-1
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
* dosageInstruction[+]
  * timing.repeat
    * timeOfDay[+] = "08:00:00"

// when + dayOfWeek
Instance: Example-MR-Dosage-Invalid-One-Kind-2
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
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek[+] = #mon

// when + interval
Instance: Example-MR-Dosage-Invalid-One-Kind-3
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
* dosageInstruction[+]
  * timing.repeat
    * frequency = 2
    * period = 1
    * periodUnit = #d

// timeOfDay + dayOfWeek
Instance: Example-MR-Dosage-Invalid-One-Kind-4
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
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek[+] = #fri


// timeOfDay + interval
Instance: Example-MR-Dosage-Invalid-One-Kind-5
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
* dosageInstruction[+]
  * timing.repeat
    * frequency = 3
    * period = 1
    * periodUnit = #d

// dayOfWeek + interval
Instance: Example-MR-Dosage-Invalid-One-Kind-6
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
