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
* text = "Dosierung mit when"
* timing.repeat.when[+] = #MORN

Instance: Example-Dosage-TimeOfDay
InstanceOf: DE_DOSAGE_DGMP
Usage: #inline
Title: "Dosage with timeOfDay"
* text = "Dosierung mit timeOfDay"
* timing.repeat.timeOfDay[+] = "08:00:00"

Instance: Example-Dosage-DayOfWeek
InstanceOf: DE_DOSAGE_DGMP
Usage: #inline
Title: "Dosage with dayOfWeek"
* text = "Dosierung mit dayOfWeek"
* timing.repeat.dayOfWeek[+] = #mon

Instance: Example-Dosage-FreqPeriod
InstanceOf: DE_DOSAGE_DGMP
Usage: #inline
Title: "Dosage with frequency/period/periodUnit"
* text = "Dosierung mit frequency/period/periodUnit"
* timing.repeat.frequency = 2
* timing.repeat.period = 1
* timing.repeat.periodUnit = #d

Instance: Example-Dosage-When-DayOfWeek
InstanceOf: DE_DOSAGE_DGMP
Usage: #inline
Title: "Dosage with when and dayOfWeek"
* text = "Dosierung mit when und dayOfWeek"
* timing.repeat.when[+] = #EVE
* timing.repeat.dayOfWeek[+] = #fri

Instance: Example-Dosage-FreqPeriod-TimeOfDay
InstanceOf: DE_DOSAGE_DGMP
Usage: #inline
Title: "Dosage with freq/period/periodUnit and timeOfDay"
* text = "Dosierung mit freq/period/periodUnit und timeOfDay"
* timing.repeat.frequency = 1
* timing.repeat.period = 1
* timing.repeat.periodUnit = #d
* timing.repeat.timeOfDay[+] = "20:00:00"

Instance: Example-Dosage-FreqPeriod-DayOfWeek
InstanceOf: DE_DOSAGE_DGMP
Usage: #inline
Title: "Dosierung mit freq/period/periodUnit und dayOfWeek"
* text = "Dosierung mit freq/period/periodUnit und dayOfWeek"
* timing.repeat.frequency = 1
* timing.repeat.period = 1
* timing.repeat.periodUnit = #wk
* timing.repeat.dayOfWeek[+] = #sat
