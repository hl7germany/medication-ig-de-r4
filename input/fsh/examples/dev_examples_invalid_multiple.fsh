Instance: Invalid-multiple-01-of-10-when
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Two dosages with the same period of day"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for invalid Permutations"
* insert InsertMandatoryExStubs
* subject.display = "DEV Dosage"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "DEV Medication"
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * timing
    * repeat
      * when[+] = #MORN
      * frequency = 1
      * period = 1
      * periodUnit = #d
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"
  * timing
    * repeat
      * when[+] = #MORN
      * when[+] = #EVE
      * frequency = 1
      * period = 1
      * periodUnit = #d

Instance: Invalid-multiple-02-of-10-C-TimingOnlyOneTimeOfDay
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Two dosages with the same time of day"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for invalid Permutations"
* insert InsertMandatoryExStubs
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
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

* dosageInstruction[+]
  * timing.repeat
    * timeOfDay[+] = "08:00:00"
    * timeOfDay[+] = "14:00:00"
    * frequency = 2
    * period = 1
    * periodUnit = #d
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: Invalid-multiple-04-of-10-C-TimingOnlyOnePeriodForDayOfWeek
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Two dosages with the same period of day on the same day"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for invalid Permutations"
* insert InsertMandatoryExStubs
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
    * frequency = 2
    * period = 1
    * periodUnit = #d
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek[+] = #mon
    * dayOfWeek[+] = #sat
    * when[+] = #MORN
    * frequency = 1
    * period = 1
    * periodUnit = #d
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

Instance: Invalid-multiple-05-of-10-C-TimingOnlyOnePeriodForDayOfWeek
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Two dosages with the same time of day on the same day"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for invalid Permutations"
* insert InsertMandatoryExStubs
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
    * frequency = 2
    * period = 1
    * periodUnit = #d
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek[+] = #mon
    * dayOfWeek[+] = #sat
    * timeOfDay[+] = "08:00:00"
    * frequency = 1
    * period = 1
    * periodUnit = #d
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

Instance: Invalid-multiple-06-of-10-C-TimingIntervalOnlyOneFrequency
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Two Interval Dosages"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung von jeden 2. Tag 1 Stück und 3. Tag 2 Stück dar"
* insert InsertMandatoryExStubs
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

Instance: Invalid-multiple-07-of-10-C-TimingOnlyOneWhen
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Two interval Dosages same period of day"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung von Jeden 2. Tag 1 Stück um 08:00 Uhr und 1 Stück um 10:00 Uhr dar"
* insert InsertMandatoryExStubs
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
    * frequency = 2
    * period = 2
    * periodUnit = #d
    * when[+] = #MORN
    * when[+] = #EVE
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

Instance: Invalid-multiple-08-of-10-C-TimingOnlyOneTimeOfDay
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Two interval Dosages same time"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung von Jeden 2. Tag 1 Stück um 08:00 Uhr und 1 Stück um 10:00 Uhr dar"
* insert InsertMandatoryExStubs
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

Instance: Invalid-multiple-09-of-10-C-TimingOnlyOneTimeForInterval
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Two interval Dosages same time"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung von Jeden 2. Tag 1 Stück um 08:00 Uhr und 1 Stück um 10:00 Uhr dar"
* insert InsertMandatoryExStubs
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

Instance: Invalid-multiple-10-of-10-C-TimingOnlyOneBounds
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Two interval Dosages different boundsDuration"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung mit verschiedener Dauer dar"
* insert InsertMandatoryExStubs
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
    * boundsDuration = 2 $ucum#wk "Woche(n)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

* dosageInstruction[+]
  * timing.repeat
    * timeOfDay[+] = "20:00:00"
    * frequency = 1
    * period = 1
    * periodUnit = #d
    * boundsDuration = 3 $ucum#wk "Woche(n)"
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"
