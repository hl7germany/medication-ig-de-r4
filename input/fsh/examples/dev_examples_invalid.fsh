Instance: Example-MR-Dosage-Invalid-1-Dosage-FrequencyOnly
InstanceOf: DE_DOSAGE_DGMP_MEDICATIONREQUEST
Usage: #example
Title: "Example-MR-Dosage-DEV"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for invalid Permutations"
* subject.display = "DEV Dosage"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "DEV Medication"
* dosageInstruction[+] = Invalid-Dosage-FrequencyOnly

Instance: Invalid-Dosage-FrequencyOnly
InstanceOf: DE_DOSAGE_DGMP
Usage: #inline
Title: "Invalid: frequency only"
* timing.repeat.frequency = 1

Instance: Example-MR-Dosage-Invalid-2-Dosage-FreqPeriod
InstanceOf: DE_DOSAGE_DGMP_MEDICATIONREQUEST
Usage: #example
Title: "Example-MR-Dosage-DEV"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for invalid Permutations"
* subject.display = "DEV Dosage"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "DEV Medication"
* dosageInstruction[+] = Invalid-Dosage-FreqPeriod

Instance: Invalid-Dosage-FreqPeriod
InstanceOf: DE_DOSAGE_DGMP
Usage: #inline
Title: "Invalid: frequency only"
* timing.repeat.frequency = 1

Instance: Example-MR-Dosage-Invalid-3-Dosage-When-TimeOfDay
InstanceOf: DE_DOSAGE_DGMP_MEDICATIONREQUEST
Usage: #example
Title: "Example-MR-Dosage-DEV"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for invalid Permutations"
* subject.display = "DEV Dosage"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "DEV Medication"
* dosageInstruction[+] = Invalid-Dosage-When-TimeOfDay

Instance: Invalid-Dosage-When-TimeOfDay
InstanceOf: DE_DOSAGE_DGMP
Usage: #inline
Title: "Invalid: when and timeOfDay"
* timing.repeat.when[+] = #MORN
* timing.repeat.timeOfDay[+] = "08:00:00"

Instance: Example-MR-Dosage-Invalid-4-Dosage-TimeOfDay-DayOfWeek
InstanceOf: DE_DOSAGE_DGMP_MEDICATIONREQUEST
Usage: #example
Title: "Example-MR-Dosage-DEV"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for invalid Permutations"
* subject.display = "DEV Dosage"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "DEV Medication"
* dosageInstruction[+] = Invalid-Dosage-TimeOfDay-DayOfWeek

Instance: Invalid-Dosage-TimeOfDay-DayOfWeek
InstanceOf: DE_DOSAGE_DGMP
Usage: #inline
Title: "Invalid: timeOfDay and dayOfWeek"
* timing.repeat.timeOfDay[+] = "08:00:00"
* timing.repeat.dayOfWeek[+] = #mon

Instance: Example-MR-Dosage-Invalid-5-Dosage-When-TimeOfDay-DayOfWeek
InstanceOf: DE_DOSAGE_DGMP_MEDICATIONREQUEST
Usage: #example
Title: "Example-MR-Dosage-DEV"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for invalid Permutations"
* subject.display = "DEV Dosage"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "DEV Medication"
* dosageInstruction[+] = Invalid-Dosage-When-TimeOfDay-DayOfWeek

Instance: Invalid-Dosage-When-TimeOfDay-DayOfWeek
InstanceOf: DE_DOSAGE_DGMP
Usage: #inline
Title: "Invalid: when, timeOfDay, and dayOfWeek"
* timing.repeat.when[+] = #MORN
* timing.repeat.timeOfDay[+] = "08:00:00"
* timing.repeat.dayOfWeek[+] = #mon

Instance: Example-MR-Dosage-Invalid-6-Dosage-FreqPeriod-When
InstanceOf: DE_DOSAGE_DGMP_MEDICATIONREQUEST
Usage: #example
Title: "Example-MR-Dosage-DEV"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for invalid Permutations"
* subject.display = "DEV Dosage"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "DEV Medication"
* dosageInstruction[+] = Invalid-Dosage-FreqPeriod-When

Instance: Invalid-Dosage-FreqPeriod-When
InstanceOf: DE_DOSAGE_DGMP
Usage: #inline
Title: "Invalid: freq/period/periodUnit and when"
* timing.repeat.frequency = 1
* timing.repeat.period = 1
* timing.repeat.periodUnit = #d
* timing.repeat.when[+] = #MORN

Instance: Example-MR-Dosage-Invalid-7-Dosage-FreqPeriod-ToD-DayOfWeek
InstanceOf: DE_DOSAGE_DGMP_MEDICATIONREQUEST
Usage: #example
Title: "Example-MR-Dosage-DEV"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for invalid Permutations"
* subject.display = "DEV Dosage"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "DEV Medication"
* dosageInstruction[+] = Invalid-Dosage-FreqPeriod-TimeOfDay-DayOfWeek

Instance: Invalid-Dosage-FreqPeriod-TimeOfDay-DayOfWeek
InstanceOf: DE_DOSAGE_DGMP
Usage: #inline
Title: "Invalid: freq/period/periodUnit, timeOfDay, and dayOfWeek"
* timing.repeat.frequency = 1
* timing.repeat.period = 1
* timing.repeat.periodUnit = #d
* timing.repeat.timeOfDay[+] = "08:00:00"
* timing.repeat.dayOfWeek[+] = #mon

Instance: Example-MR-Dosage-Invalid-8-Dosage-FreqPeriod-When-DayOfWeek
InstanceOf: DE_DOSAGE_DGMP_MEDICATIONREQUEST
Usage: #example
Title: "Example-MR-Dosage-DEV"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for invalid Permutations"
* subject.display = "DEV Dosage"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "DEV Medication"
* dosageInstruction[+] = Invalid-Dosage-FreqPeriod-When-DayOfWeek

Instance: Invalid-Dosage-FreqPeriod-When-DayOfWeek
InstanceOf: DE_DOSAGE_DGMP
Usage: #inline
Title: "Invalid: freq/period/periodUnit, when, and dayOfWeek"
* timing.repeat.frequency = 1
* timing.repeat.period = 1
* timing.repeat.periodUnit = #d
* timing.repeat.when[+] = #MORN
* timing.repeat.dayOfWeek[+] = #mon

Instance: Example-MR-Dosage-Invalid-9-Dosage-Freq-TimeOfDay-When
InstanceOf: DE_DOSAGE_DGMP_MEDICATIONREQUEST
Usage: #example
Title: "Example-MR-Dosage-DEV"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for invalid Permutations"
* subject.display = "DEV Dosage"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "DEV Medication"
* dosageInstruction[+] = Invalid-Dosage-Freq-TimeOfDay-When

Instance: Invalid-Dosage-Freq-TimeOfDay-When
InstanceOf: DE_DOSAGE_DGMP
Usage: #inline
Title: "Invalid: frequency, timeOfDay, and when"
* timing.repeat.frequency = 1
* timing.repeat.timeOfDay[+] = "08:00:00"
* timing.repeat.when[+] = #MORN

Instance: Example-MR-Dosage-Invalid-10-Dosage-FreeText-and-structured
InstanceOf: DE_DOSAGE_DGMP_MEDICATIONREQUEST
Usage: #example
Title: "Example-MR-Dosage-DEV"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for invalid Permutations"
* subject.display = "DEV Dosage"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "DEV Medication"
* dosageInstruction[+] = Invalid-Dosage-FreeText-and-structured

Instance: Invalid-Dosage-FreeText-and-structured
InstanceOf: DE_DOSAGE_DGMP
Usage: #inline
Title: "Invalid: when and structured"
* text = "Einmal am Tag um 20:00"
* timing.repeat.when[+] = #MORN

Instance: Example-MR-Dosage-Invalid-11-Dosage-multiple-types
InstanceOf: DE_DOSAGE_DGMP_MEDICATIONREQUEST
Usage: #example
Title: "Example-MR-Dosage-DEV"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for invalid Permutations"
* subject.display = "DEV Dosage"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "DEV Medication"
* dosageInstruction[+] = Invalid-Dosage-multiple-types-1
* dosageInstruction[+] = Invalid-Dosage-multiple-types-2

Instance: Invalid-Dosage-multiple-types-1
InstanceOf: DE_DOSAGE_DGMP
Usage: #inline
Title: "Invalid: when and structured"
* timing.repeat.frequency = 1
* timing.repeat.period = 1
* timing.repeat.periodUnit = #d
* timing.repeat.when[+] = #MORN

Instance: Invalid-Dosage-multiple-types-2
InstanceOf: DE_DOSAGE_DGMP
Usage: #inline
Title: "Invalid: when and structured"
* timing.repeat.frequency = 1
* timing.repeat.period = 1
* timing.repeat.periodUnit = #d
* timing.repeat.timeOfDay[+] = "08:00:00"

