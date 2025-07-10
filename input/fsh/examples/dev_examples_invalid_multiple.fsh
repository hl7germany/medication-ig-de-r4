Instance: Invalid-12-Dosage-multiple-when
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Two dosages with the same period of day"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for invalid Permutations"
* subject.display = "DEV Dosage"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "DEV Medication"
* dosageInstruction[+]
  * doseAndRate.doseQuantity.value = 1
  * doseAndRate.doseQuantity.unit = "Tablette"
  * timing
    * repeat
      * when[+] = #MORN
      * frequency = 1
      * period = 1
      * periodUnit = #d
* dosageInstruction[+]
  * doseAndRate.doseQuantity.value = 2
  * doseAndRate.doseQuantity.unit = "Tablette"
  * timing
    * repeat
      * when[+] = #MORN
      * when[+] = #EVE
      * frequency = 1
      * period = 1
      * periodUnit = #d

Instance: Invalid-13-Dosage-multiple-timeOfDay
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Two dosages with the same time of day"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for invalid Permutations"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * timeOfDay[+] = "08:00:00"
    * frequency = 1
    * period = 1
    * periodUnit = #d
  * doseAndRate.doseQuantity.value = 2
  * doseAndRate.doseQuantity.unit = "Tabletten"

* dosageInstruction[+]
  * timing.repeat
    * timeOfDay[+] = "08:00:00"
    * frequency = 1
    * period = 1
    * periodUnit = #d
  * timing.repeat
    * timeOfDay[+] = "14:00:00"
    * frequency = 1
    * period = 1
    * periodUnit = #d
  * doseAndRate.doseQuantity.value = 1
  * doseAndRate.doseQuantity.unit = "Tablette"

Instance: Invalid-14-Dosage-multiple-dayOfWeek
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Two dosages with the same period of day on the same day"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for invalid Permutations"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek[+] = #mon
    * dayOfWeek[+] = #sat
    * frequency = 1
    * period = 1
    * periodUnit = #d
  * doseAndRate.doseQuantity.value = 1
  * doseAndRate.doseQuantity.unit = "Tablette"

* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek[+] = #mon
    * dayOfWeek[+] = #fri
    * frequency = 1
    * period = 1
    * periodUnit = #d
  * doseAndRate.doseQuantity.value = 2
  * doseAndRate.doseQuantity.unit = "Tabletten"

Instance: Invalid-15-Dosage-multiple-dayOfWeekAndWhen
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Two dosages with the same period of day on the same day"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for invalid Permutations"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek[+] = #mon
    * dayOfWeek[+] = #fri
    * when[+] = #MORN
    * when[+] = #EVE
    * frequency = 1
    * period = 1
    * periodUnit = #d
  * doseAndRate.doseQuantity.value = 1
  * doseAndRate.doseQuantity.unit = "Tablette"

* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek[+] = #mon
    * dayOfWeek[+] = #sat
    * when[+] = #MORN
    * frequency = 1
    * period = 1
    * periodUnit = #d
  * doseAndRate.doseQuantity.value = 2
  * doseAndRate.doseQuantity.unit = "Tabletten"

Instance: Invalid-16-Dosage-multiple-dayOfWeekAndTimeOfDay
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Two dosages with the same time of day on the same day"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for invalid Permutations"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek[+] = #mon
    * dayOfWeek[+] = #fri
    * timeOfDay[+] = "08:00:00"
    * timeOfDay[+] = "12:00:00"
    * frequency = 1
    * period = 1
    * periodUnit = #d
  * doseAndRate.doseQuantity.value = 1
  * doseAndRate.doseQuantity.unit = "Tablette"

* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek[+] = #mon
    * dayOfWeek[+] = #sat
    * timeOfDay[+] = "08:00:00"
    * frequency = 1
    * period = 1
    * periodUnit = #d
  * doseAndRate.doseQuantity.value = 2
  * doseAndRate.doseQuantity.unit = "Tabletten"