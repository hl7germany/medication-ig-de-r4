Instance: Invalid-Dosage-multiple-01-of-10-when
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Two dosages with the same period of day"
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
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"
  * timing
    * repeat
      * when[+] = #MORN
      * when[+] = #EVE

Instance: Invalid-Dosage-multiple-02-of-10-timeOfDay
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
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

* dosageInstruction[+]
  * timing.repeat
    * timeOfDay[+] = "08:00:00"
  * timing.repeat
    * timeOfDay[+] = "14:00:00"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: Invalid-Dosage-multiple-03-of-10-dayOfWeek
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
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek[+] = #mon
    * dayOfWeek[+] = #fri
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

Instance: Invalid-Dosage-multiple-04-of-10-dayOfWeekAndWhen
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
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek[+] = #mon
    * dayOfWeek[+] = #sat
    * when[+] = #MORN
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

Instance: Invalid-Dosage-multiple-05-of-10-dayOfWeekAndTimeOfDay
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
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek[+] = #mon
    * dayOfWeek[+] = #sat
    * timeOfDay[+] = "08:00:00"
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

Instance: Invalid-Dosage-multiple-06-of-10-Interval
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
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

* dosageInstruction[+]
  * timing.repeat
    * frequency = 1
    * period = 3
    * periodUnit = #d
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

Instance: Invalid-Dosage-multiple-07-of-10-IntervalAndSamePeriodOfDay
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
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

* dosageInstruction[+]
  * timing.repeat
    * frequency = 1
    * period = 2
    * periodUnit = #d
    * when[+] = #MORN
    * when[+] = #EVE
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

Instance: Invalid-Dosage-multiple-08-of-10-IntervalAndSameTimeOfDay
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
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

* dosageInstruction[+]
  * timing.repeat
    * frequency = 1
    * period = 2
    * periodUnit = #d
    * timeOfDay[+] = "08:00:00"
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

Instance: Invalid-Dosage-multiple-09-of-10-IntervalAndDifInterval
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
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

* dosageInstruction[+]
  * timing.repeat
    * frequency = 1
    * period = 3
    * periodUnit = #d
    * timeOfDay[+] = "20:00:00"
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

Instance: Invalid-Dosage-multiple-10-of-10-DiffBounds
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Two interval Dosages different boundsDuration"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung mit verschiedener Dauer dar"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * timeOfDay[+] = "08:00:00"
    * boundsDuration = 2 $ucum#wk "Woche(n)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

* dosageInstruction[+]
  * timing.repeat
    * timeOfDay[+] = "20:00:00"
    * boundsDuration = 3 $ucum#wk "Woche(n)"
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"
