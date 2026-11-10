// Examples for TimingNoDuplicateValues

// Wochentag mit doppelter Tageszeit und frequency 2
Instance: INV-C-TimingNoDuplicateValues-MR-01-of-03
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid Dosage"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for invalid Permutations"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * frequency = 2
    * dayOfWeek[+] = #mon
    * when[+] = #MORN
    * when[+] = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

// Wochentag mit doppelter Uhrzeit
Instance: INV-C-TimingNoDuplicateValues-MR-02-of-03
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid Dosage"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for invalid Permutations"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek[+] = #mon
    * timeOfDay[+] = "08:00:00"
    * timeOfDay[+] = "08:00:00"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

// doppelter Wochentag mit Tageszeit
Instance: INV-C-TimingNoDuplicateValues-MR-03-of-03
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid Dosage"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for invalid Permutations"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek[+] = #mon
    * dayOfWeek[+] = #mon
    * when[+] = #EVE
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

// Wochentag mit doppelter Tageszeit und frequency 2
Instance: INV-C-TimingNoDuplicateValues-MD-01-of-03
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid Dosage"
Description: "CAVE: This MedicationDispense is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for invalid Permutations"
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * frequency = 2
    * dayOfWeek[+] = #mon
    * when[+] = #MORN
    * when[+] = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

// Wochentag mit doppelter Uhrzeit
Instance: INV-C-TimingNoDuplicateValues-MD-02-of-03
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid Dosage"
Description: "CAVE: This MedicationDispense is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for invalid Permutations"
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek[+] = #mon
    * timeOfDay[+] = "08:00:00"
    * timeOfDay[+] = "08:00:00"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

// doppelter Wochentag mit Tageszeit
Instance: INV-C-TimingNoDuplicateValues-MD-03-of-03
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid Dosage"
Description: "CAVE: This MedicationDispense is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for invalid Permutations"
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek[+] = #mon
    * dayOfWeek[+] = #mon
    * when[+] = #EVE
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

// Wochentag mit doppelter Tageszeit und frequency 2
Instance: INV-C-TimingNoDuplicateValues-MS-01-of-03
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid Dosage"
Description: "CAVE: This MedicationStatement is for validation purposes and does NOT represent a valid dosage. It only checks for invalid Permutations"
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat
    * frequency = 2
    * dayOfWeek[+] = #mon
    * when[+] = #MORN
    * when[+] = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

// Wochentag mit doppelter Uhrzeit
Instance: INV-C-TimingNoDuplicateValues-MS-02-of-03
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid Dosage"
Description: "CAVE: This MedicationStatement is for validation purposes and does NOT represent a valid dosage. It only checks for invalid Permutations"
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat
    * dayOfWeek[+] = #mon
    * timeOfDay[+] = "08:00:00"
    * timeOfDay[+] = "08:00:00"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

// doppelter Wochentag mit Tageszeit
Instance: INV-C-TimingNoDuplicateValues-MS-03-of-03
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid Dosage"
Description: "CAVE: This MedicationStatement is for validation purposes and does NOT represent a valid dosage. It only checks for invalid Permutations"
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat
    * dayOfWeek[+] = #mon
    * dayOfWeek[+] = #mon
    * when[+] = #EVE
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
