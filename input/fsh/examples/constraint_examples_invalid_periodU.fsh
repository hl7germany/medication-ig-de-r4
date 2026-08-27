Instance: INV-C-TimingPeriodUnit-Request
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid Dosage: hourly interval in a weekday schema"
Description: "CAVE: a weekday schema cannot be combined with an hourly interval."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek[+] = #tue
    * frequency = 1
    * period = 3
    * periodUnit = #h
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-TimingPeriodUnit-Dispense
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid Dosage: hourly interval with weekday and timeOfDay"
Description: "CAVE: weekday plus timeOfDay cannot be combined with an hourly interval."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek[+] = #thu
    * frequency = 1
    * period = 3
    * periodUnit = #h
    * timeOfDay[+] = "08:00:00"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-TimingPeriodUnit-Statement
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid Dosage: minute interval with weekday and when"
Description: "CAVE: weekday plus when cannot be combined with a minute interval."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat
    * dayOfWeek[+] = #fri
    * frequency = 1
    * period = 30
    * periodUnit = #min
    * when[+] = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-TimingPeriodUnit-MR-01-of-02
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid MedicationRequest: weekday and when plus hourly interval"
Description: "CAVE: dayOfWeek and when cannot be combined with an hourly interval."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Test Medication"
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek = #tue
    * when = #MORN
    * frequency = 1
    * period = 3
    * periodUnit = #h
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-TimingPeriodUnit-MR-02-of-02
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid MedicationRequest: weekday and timeOfDay plus hourly interval"
Description: "CAVE: dayOfWeek and timeOfDay cannot be combined with an hourly interval."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Test Medication"
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek = #tue
    * timeOfDay = "08:00:00"
    * frequency = 1
    * period = 3
    * periodUnit = #h
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-TimingPeriodUnit-MD-01-of-02
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid MedicationDispense: weekday plus hourly interval"
Description: "CAVE: a plain weekday schema cannot be combined with an hourly interval."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Test Medication"
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek = #tue
    * frequency = 1
    * period = 3
    * periodUnit = #h
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-TimingPeriodUnit-MD-02-of-02
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid MedicationDispense: weekday and when plus hourly interval"
Description: "CAVE: dayOfWeek and when cannot be combined with an hourly interval."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Test Medication"
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek = #tue
    * when = #MORN
    * frequency = 1
    * period = 3
    * periodUnit = #h
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-TimingPeriodUnit-MS-01-of-02
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid MedicationStatement: weekday plus hourly interval"
Description: "CAVE: a plain weekday schema cannot be combined with an hourly interval."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Test Medication"
* dosage[+]
  * timing.repeat
    * dayOfWeek = #tue
    * frequency = 1
    * period = 3
    * periodUnit = #h
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-TimingPeriodUnit-MS-02-of-02
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid MedicationStatement: weekday and timeOfDay plus hourly interval"
Description: "CAVE: dayOfWeek and timeOfDay cannot be combined with an hourly interval."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Test Medication"
* dosage[+]
  * timing.repeat
    * dayOfWeek = #tue
    * timeOfDay = "08:00:00"
    * frequency = 1
    * period = 3
    * periodUnit = #h
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
