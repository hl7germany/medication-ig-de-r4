// Test cases for multiple timeOfDay/when entries bug
// These examples test the criticism that only the first entry in timeOfDay/when is considered

Instance: Example-MR-Bug-MultipleTimeOfDay-Interval
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Bug Test: Multiple timeOfDay with Interval"
Description: "Test case showing the bug where only first timeOfDay is processed in Interval+Time schema. Should show both 08:00 and 20:00 times."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Test Medication"
* dosageInstruction[+]
  * timing.repeat
    * timeOfDay[+] = "08:00:00"
    * timeOfDay[+] = "20:00:00"
    * frequency = 2
    * period = 2
    * periodUnit = #d
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MR-Bug-MultipleWhen-Interval
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Bug Test: Multiple when codes with Interval"
Description: "Test case showing the bug where only first when code is processed in Interval+Time schema. Should show both morning and evening."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Test Medication"
* dosageInstruction[+]
  * timing.repeat
    * when[+] = #MORN
    * when[+] = #EVE
    * frequency = 2
    * period = 3
    * periodUnit = #d
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MR-Bug-MultipleTimeOfDay-DayOfWeek
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Bug Test: Multiple timeOfDay with DayOfWeek"
Description: "Test case for multiple timeOfDay entries in DayOfWeek+Time schema. Should show both 09:00 and 21:00 times."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Test Medication"
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek[+] = #mon
    * dayOfWeek[+] = #wed
    * dayOfWeek[+] = #fri
    * timeOfDay[+] = "09:00:00"
    * timeOfDay[+] = "21:00:00"
    * frequency = 6
    * period = 1
    * periodUnit = #wk
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MR-Bug-MultipleWhen-DayOfWeek
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Bug Test: Multiple when codes with DayOfWeek"
Description: "Test case for multiple when codes in DayOfWeek+When schema. Should show both morning and evening patterns."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Test Medication"
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek[+] = #tue
    * dayOfWeek[+] = #thu
    * when[+] = #MORN
    * when[+] = #EVE
    * frequency = 4
    * period = 1
    * periodUnit = #wk
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MR-Bug-MultipleTimeOfDay-Daily
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Bug Test: Multiple timeOfDay Daily"
Description: "Test case for TimeOfDay schema with multiple times. Should show all times: 08:00, 14:00, and 22:00."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Test Medication"
* dosageInstruction[+]
  * timing.repeat
    * timeOfDay[+] = "08:00:00"
    * timeOfDay[+] = "14:00:00"
    * timeOfDay[+] = "22:00:00"
    * frequency = 3
    * period = 1
    * periodUnit = #d
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

// Edge case: Empty lists (should be treated as False, not truthy)
Instance: Example-MR-Bug-EmptyLists
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Bug Test: Empty timeOfDay/when/dayOfWeek lists"
Description: "Test case with empty arrays that might cause incorrect schema detection due to non-strict boolean logic."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Test Medication"
* dosageInstruction[+]
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
