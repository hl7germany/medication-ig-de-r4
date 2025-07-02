Instance: Example-MR-Dosage-Valid
InstanceOf: DE_DOSAGE_DGMP_MEDICATIONREQUEST
Usage: #example
Title: "Example-MR-Dosage-DEV"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for allowed Permutations"
* subject.display = "DEV Dosage"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "DEV Medication"
* dosageInstruction[+] = Example-Dosage-When
* dosageInstruction[+] = Example-Dosage-TimeOfDay
* dosageInstruction[+] = Example-Dosage-DayOfWeek
* dosageInstruction[+] = Example-Dosage-FreqPeriod
* dosageInstruction[+] = Example-Dosage-When-DayOfWeek
* dosageInstruction[+] = Example-Dosage-FreqPeriod-TimeOfDay
* dosageInstruction[+] = Example-Dosage-FreqPeriod-DayOfWeek

Instance: Example-Dosage-When
InstanceOf: DE_DOSAGE_DGMP
Usage: #inline
Title: "Dosage with when"
* timing.repeat
  * when[+] = #MORN
  * frequency = 1
  * period = 1
  * periodUnit = #d

Instance: Example-Dosage-TimeOfDay
InstanceOf: DE_DOSAGE_DGMP
Usage: #inline
Title: "Dosage with timeOfDay"
* timing.repeat
  * timeOfDay[+] = "08:00:00"
  * frequency = 1
  * period = 1
  * periodUnit = #d
* doseAndRate.doseQuantity.value = 1
* doseAndRate.doseQuantity.unit = "Tablette"

Instance: Example-Dosage-DayOfWeek
InstanceOf: DE_DOSAGE_DGMP
Usage: #inline
Title: "Dosage with dayOfWeek"
* timing.repeat
  * dayOfWeek[+] = #mon
  * frequency = 1
  * period = 1
  * periodUnit = #d
* doseAndRate.doseQuantity.value = 1
* doseAndRate.doseQuantity.unit = "Tablette"

Instance: Example-Dosage-FreqPeriod
InstanceOf: DE_DOSAGE_DGMP
Usage: #inline
Title: "Dosage with frequency/period/periodUnit"
* timing.repeat.frequency = 2
* timing.repeat.period = 1
* timing.repeat.periodUnit = #d
* doseAndRate.doseQuantity.value = 1
* doseAndRate.doseQuantity.unit = "Tablette"

Instance: Example-Dosage-When-DayOfWeek
InstanceOf: DE_DOSAGE_DGMP
Usage: #inline
Title: "Dosage with when and dayOfWeek"
* timing.repeat
  * when[+] = #EVE
  * dayOfWeek[+] = #fri
  * frequency = 1
  * period = 1
  * periodUnit = #d
* doseAndRate.doseQuantity.value = 1
* doseAndRate.doseQuantity.unit = "Tablette"

Instance: Example-Dosage-FreqPeriod-TimeOfDay
InstanceOf: DE_DOSAGE_DGMP
Usage: #inline
Title: "Dosage with freq/period/periodUnit and timeOfDay"
* timing.repeat
  * frequency = 1
  * period = 1
  * periodUnit = #d
  * timeOfDay[+] = "20:00:00"
* doseAndRate.doseQuantity.value = 1
* doseAndRate.doseQuantity.unit = "Tablette"

Instance: Example-Dosage-FreqPeriod-DayOfWeek
InstanceOf: DE_DOSAGE_DGMP
Usage: #inline
Title: "Dosierung mit freq/period/periodUnit und dayOfWeek"
* timing.repeat
  * frequency = 1
  * period = 1
  * periodUnit = #wk
  * dayOfWeek[+] = #sat
* doseAndRate.doseQuantity.value = 1
* doseAndRate.doseQuantity.unit = "Tablette"
