Instance: INV-C-TimingFrequencyCount-Request
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid Dosage: frequency does not match when"
Description: "CAVE: optional frequency must match the number of concrete when values."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * frequency = 2
    * period = 1
    * periodUnit = #wk
    * when[+] = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-TimingFrequencyCount-Dispense
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid Dosage: frequency does not match timeOfDay"
Description: "CAVE: optional frequency must match the number of concrete timeOfDay values."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * frequency = 2
    * period = 2
    * periodUnit = #d
    * timeOfDay[+] = "08:00:00"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-TimingFrequencyCount-Statement
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid Dosage: frequency does not match weekdays"
Description: "CAVE: optional frequency in a plain weekday schema must match the number of weekdays."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat
    * frequency = 1
    * dayOfWeek[+] = #tue
    * dayOfWeek[+] = #thu
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
