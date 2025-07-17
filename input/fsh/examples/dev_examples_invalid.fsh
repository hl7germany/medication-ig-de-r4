Instance: Invalid-Dosage-01-of-13-FrequencyOnly
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid Dosage"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for invalid Permutations"
* subject.display = "DEV Dosage"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "DEV Medication"
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing
    * repeat.frequency = 1

Instance: Invalid-Dosage-02-of-13-FreqPeriod
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid Dosage"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for invalid Permutations"
* subject.display = "DEV Dosage"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "DEV Medication"
* dosageInstruction[+]
  * timing.repeat.frequency = 1
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: Invalid-Dosage-03-of-13-When-TimeOfDay
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid Dosage"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for invalid Permutations"
* subject.display = "DEV Dosage"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "DEV Medication"
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing
    * repeat
      * when[+] = #MORN
      * timeOfDay[+] = "08:00:00"

Instance: Invalid-Dosage-04-of-13-TimeOfDay-DayOfWeek
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid Dosage"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for invalid Permutations"
* subject.display = "DEV Dosage"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "DEV Medication"
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing
    * repeat
      * dayOfWeek[+] = #mon
      * timeOfDay[+] = "08:00:00"

Instance: Invalid-Dosage-05-of-13-When-TimeOfDay-DayOfWeek
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid Dosage"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for invalid Permutations"
* subject.display = "DEV Dosage"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "DEV Medication"
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing
    * repeat
      * when[+] = #MORN
      * timeOfDay[+] = "08:00:00"
      * dayOfWeek[+] = #mon   

Instance: Invalid-Dosage-06-of-13-FreqPeriod-When
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid Dosage"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for invalid Permutations"
* subject.display = "DEV Dosage"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "DEV Medication"
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d
    * when[+] = #MORN
    * timeOfDay[+] = "08:00:00"

Instance: Invalid-Dosage-07-of-13-FreqPeriod-ToD-DayOfWeek
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid Dosage"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for invalid Permutations"
* subject.display = "DEV Dosage"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "DEV Medication"
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat.frequency = 1
  * timing.repeat
    * period = 1
    * periodUnit = #d
    * timeOfDay[+] = "08:00:00"
    * dayOfWeek[+] = #mon

Instance: Invalid-Dosage-08-of-13-FreqPeriod-When-DayOfWeek
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid Dosage"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for invalid Permutations"
* subject.display = "DEV Dosage"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "DEV Medication"
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d
    * when[+] = #MORN
    * dayOfWeek[+] = #mon

Instance: Invalid-Dosage-09-of-13-FreeText-and-structured
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid Dosage"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for invalid Permutations"
* subject.display = "DEV Dosage"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "DEV Medication"
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * text = "Einmal am Tag um 20:00"
  * timing.repeat
    * when[+] = #MORN
    * frequency = 1
    * period = 1
    * periodUnit = #d

Instance: Invalid-Dosage-10-of-13-multiple-types
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid Dosage"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for invalid Permutations"
* subject.display = "DEV Dosage"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "DEV Medication"
* dosageInstruction[+]
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d
    * when[+] = #MORN
* dosageInstruction[+]
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d
    * timeOfDay[+] = "08:00:00"

Instance: Invalid-Dosage-11-of-13-multiple-dosagecodes
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid Dosage"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for invalid Permutations"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * when[+] = #MORN
    * frequency = 1
    * period = 1
    * periodUnit = #d
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

* dosageInstruction[+]
  * timing.repeat
    * when[+] = #EVE
    * frequency = 1
    * period = 1
    * periodUnit = #d
  * doseAndRate.doseQuantity = 400 $kbv-dosiereinheit#v "mg"

Instance: Invalid-Dosage-12-of-13-timing-no-dose
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid Dosage"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for invalid Permutations"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * when[+] = #MORN
    * frequency = 1
    * period = 1
    * periodUnit = #d

Instance: Invalid-Dosage-13-of-13-When-DayOfWeek
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid Dosage"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for invalid Permutations"
* subject.display = "DEV Dosage"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "DEV Medication"
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing
    * repeat
      * dayOfWeek[+] = #mon
      * when[+] = #MORN
