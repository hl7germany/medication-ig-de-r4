Instance: Invalid-Dosage-multiple-01-of-09-when
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
* dosageInstruction[+]
  * doseAndRate.doseQuantity.value = 2
  * doseAndRate.doseQuantity.unit = "Tablette"
  * timing
    * repeat
      * when[+] = #MORN
      * when[+] = #EVE

Instance: Invalid-Dosage-multiple-02-of-09-timeOfDay
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
  * doseAndRate.doseQuantity.value = 2
  * doseAndRate.doseQuantity.unit = "Tabletten"

* dosageInstruction[+]
  * timing.repeat
    * timeOfDay[+] = "08:00:00"
  * timing.repeat
    * timeOfDay[+] = "14:00:00"
  * doseAndRate.doseQuantity.value = 1
  * doseAndRate.doseQuantity.unit = "Tablette"

Instance: Invalid-Dosage-multiple-03-of-09-dayOfWeek
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
  * doseAndRate.doseQuantity.value = 1
  * doseAndRate.doseQuantity.unit = "Tablette"

* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek[+] = #mon
    * dayOfWeek[+] = #fri
  * doseAndRate.doseQuantity.value = 2
  * doseAndRate.doseQuantity.unit = "Tabletten"

Instance: Invalid-Dosage-multiple-04-of-09-dayOfWeekAndWhen
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
  * doseAndRate.doseQuantity.value = 1
  * doseAndRate.doseQuantity.unit = "Tablette"

* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek[+] = #mon
    * dayOfWeek[+] = #sat
    * when[+] = #MORN
  * doseAndRate.doseQuantity.value = 2
  * doseAndRate.doseQuantity.unit = "Tabletten"

Instance: Invalid-Dosage-multiple-05-of-09-dayOfWeekAndTimeOfDay
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
  * doseAndRate.doseQuantity.value = 1
  * doseAndRate.doseQuantity.unit = "Tablette"

* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek[+] = #mon
    * dayOfWeek[+] = #sat
    * timeOfDay[+] = "08:00:00"
  * doseAndRate.doseQuantity.value = 2
  * doseAndRate.doseQuantity.unit = "Tabletten"

Instance: Invalid-Dosage-multiple-06-of-09-Interval
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Two Interval Dosages"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung von jeden 2. Tag 1 Tablette und 3. Tag 2 Tabletten dar"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * frequency = 1
    * period = 2
    * periodUnit = #d
  * doseAndRate.doseQuantity.value = 1
  * doseAndRate.doseQuantity.unit = "Tablette"

* dosageInstruction[+]
  * timing.repeat
    * frequency = 1
    * period = 3
    * periodUnit = #d
  * doseAndRate.doseQuantity.value = 2
  * doseAndRate.doseQuantity.unit = "Tabletten"

Instance: Invalid-Dosage-multiple-07-of-09-IntervalAndSamePeriodOfDay
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Two interval Dosages same period of day"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung von Jeden 2. Tag 1 Tablette um 08:00 Uhr und 1 Tablette um 10:00 Uhr dar"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * frequency = 1
    * period = 2
    * periodUnit = #d
    * when[+] = #MORN
  * doseAndRate.doseQuantity.value = 1
  * doseAndRate.doseQuantity.unit = "Tablette"

* dosageInstruction[+]
  * timing.repeat
    * frequency = 1
    * period = 2
    * periodUnit = #d
    * when[+] = #MORN
    * when[+] = #EVE
  * doseAndRate.doseQuantity.value = 2
  * doseAndRate.doseQuantity.unit = "Tabletten"

Instance: Invalid-Dosage-multiple-08-of-09-IntervalAndSameTimeOfDay
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Two interval Dosages same time"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung von Jeden 2. Tag 1 Tablette um 08:00 Uhr und 1 Tablette um 10:00 Uhr dar"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * frequency = 1
    * period = 2
    * periodUnit = #d
    * timeOfDay[+] = "08:00:00"
  * doseAndRate.doseQuantity.value = 1
  * doseAndRate.doseQuantity.unit = "Tablette"

* dosageInstruction[+]
  * timing.repeat
    * frequency = 1
    * period = 2
    * periodUnit = #d
    * timeOfDay[+] = "08:00:00"
  * doseAndRate.doseQuantity.value = 2
  * doseAndRate.doseQuantity.unit = "Tabletten"

Instance: Invalid-Dosage-multiple-09-of-09-IntervalAndDifferentInterval
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Two interval Dosages same time"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung von Jeden 2. Tag 1 Tablette um 08:00 Uhr und 1 Tablette um 10:00 Uhr dar"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * frequency = 1
    * period = 2
    * periodUnit = #d
    * timeOfDay[+] = "08:00:00"
  * doseAndRate.doseQuantity.value = 1
  * doseAndRate.doseQuantity.unit = "Tablette"

* dosageInstruction[+]
  * timing.repeat
    * frequency = 1
    * period = 3
    * periodUnit = #d
    * timeOfDay[+] = "20:00:00"
  * doseAndRate.doseQuantity.value = 2
  * doseAndRate.doseQuantity.unit = "Tabletten"
