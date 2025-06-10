Instance: Example-MR-Dosage-Freetext
InstanceOf: DE_DOSAGE_MEDICATIONREQUEST
Usage: #example
Title: "Example-MR-Dosage-Freetext"
Description: "Dosierung: Freetext"
* subject.display = "Freetext Dosage"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Test Medication"
* dosageInstruction[+] = Example-Dosage-Freetext

Instance: Example-MR-Dosage-DailyFourScheme
InstanceOf: DE_DOSAGE_MEDICATIONREQUEST
Usage: #example
Title: "Example-MR-Dosage-DailyFourScheme"
* subject.display = "Simple DailyFourScheme 1-0-0-0"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Test Medication"
* dosageInstruction[+] = Example-Dosage-DailyFourScheme-1-MORN

Instance: Example-MR-Dosage-DailyFourScheme-special
InstanceOf: DE_DOSAGE_MEDICATIONREQUEST
Usage: #example
Title: "Example-MR-Dosage-DailyFourScheme 1-0-0.5-1"
Description: "Dosierung: DailyFourScheme 1-0-0.5-1"
* subject.display = "DailyFourScheme 1-0-0.5-1"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Test Medication"
* dosageInstruction[+] = Example-Dosage-DailyFourScheme-1-MORN
* dosageInstruction[+] = Example-Dosage-DailyFourScheme-1-NIGHT
* dosageInstruction[+] = Example-Dosage-DailyFourScheme-05-EVE

/*
TODO
Instance: Example-MR-Dosage-DailyFourScheme-special-duration
InstanceOf: DE_DOSAGE_MEDICATIONREQUEST
Usage: #example
Title: "Example-MR-Dosage-DailyFourScheme 1-0-0.5-0"
* subject.display = "DailyFourScheme 1-0-0.5-0 for 2 Weeks and 0-0-0.5-0 for 2 more Weeks"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Test Medication"
* dosageInstruction[+] = Example-Dosage-DailyFourScheme-special-duration-1
* dosageInstruction[+] = Example-Dosage-DailyFourScheme-special-duration-2

Instance: Example-MR-Dosage-dailyDayTime
InstanceOf: DE_DOSAGE_MEDICATIONREQUEST
Usage: #example
Title: "Example-MR-Dosage-dailyDayTime"
Description: "Dosierung: dailyDayTime"
* subject.display = "Daily with Times"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Test Medication"
* dosageInstruction[+] = Example-Dosage-dailyDayTime-12
* dosageInstruction[+] = Example-Dosage-dailyDayTime-20

Instance: Example-MR-Dosage-daily
InstanceOf: DE_DOSAGE_MEDICATIONREQUEST
Usage: #example
Title: "Example-MR-Dosage-daily"
Description: "Dosierung: interval daily"
* subject.display = "Daily with Interval"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Test Medication"
* dosageInstruction = Example-Dosage-interval-daily

Instance: Example-MR-Dosage-interval-flex
InstanceOf: DE_DOSAGE_MEDICATIONREQUEST
Usage: #example
Title: "Example-MR-Dosage-interval-flex"
Description: "Dosierung: interval flex"
* subject.display = "Interval"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Test Medication"
* dosageInstruction = Example-Dosage-interval-flex

Instance: Example-MR-Dosage-weekDay
InstanceOf: DE_DOSAGE_MEDICATIONREQUEST
Usage: #example
Title: "Example-MR-Dosage-weekDay"
Description: "Dosierung: weekDay"
* subject.display = "Weekday"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Test Medication"
* dosageInstruction[+] = Example-Dosage-weekDay-mon
* dosageInstruction[+] = Example-Dosage-weekDay-thu
* dosageInstruction[+] = Example-Dosage-weekDay-sat


Instance: Example-MR-Dosage-dailyDayTime-sequence
InstanceOf: DE_DOSAGE_MEDICATIONREQUEST
Usage: #example
Title: "Example-MR-Dosage-dailyDayTime"
Description: "Dosierung: dailyDayTime"
* subject.display = "Daily with Times"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Test Medication"
* dosageInstruction[+] = Example-Dosage-dailyDayTime-12
* dosageInstruction[+] = Example-Dosage-dailyDayTime-20
* dosageInstruction[+] = Example-Dosage-dailyDayTime-15-seq1

*/