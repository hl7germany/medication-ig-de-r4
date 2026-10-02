// Examples for TimingBoundsPeriodMatchesTime and TimingBoundsPeriodNotForWhen

// TimingBoundsPeriodMatchesTime

Instance: INV-C-TimingBoundsPeriodMatchesTime-MR-01-of-02
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
    * timeOfDay[+] = "08:00:00"
    * timeOfDay[+] = "20:00:00"
    * boundsPeriod.start = "2026-06-05T09:00:00+02:00"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-TimingBoundsPeriodMatchesTime-MR-02-of-02
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
    * timeOfDay[+] = "08:00:00"
    * boundsPeriod.start = "2026-06-05"
    * boundsPeriod.end = "2026-06-12T12:00:00+02:00"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-TimingBoundsPeriodMatchesTime-MD-01-of-02
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid Dosage"
Description: "CAVE: This MedicationDispense is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for invalid Permutations"
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * timeOfDay[+] = "08:00:00"
    * timeOfDay[+] = "20:00:00"
    * boundsPeriod.start = "2026-06-05T09:00:00+02:00"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-TimingBoundsPeriodMatchesTime-MD-02-of-02
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid Dosage"
Description: "CAVE: This MedicationDispense is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for invalid Permutations"
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * timeOfDay[+] = "08:00:00"
    * boundsPeriod.start = "2026-06-05"
    * boundsPeriod.end = "2026-06-12T12:00:00+02:00"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-TimingBoundsPeriodMatchesTime-MS-01-of-02
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid Dosage"
Description: "CAVE: This MedicationStatement is for validation purposes and does NOT represent a valid dosage. It only checks for invalid Permutations"
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat
    * timeOfDay[+] = "08:00:00"
    * timeOfDay[+] = "20:00:00"
    * boundsPeriod.start = "2026-06-05T09:00:00+02:00"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-TimingBoundsPeriodMatchesTime-MS-02-of-02
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid Dosage"
Description: "CAVE: This MedicationStatement is for validation purposes and does NOT represent a valid dosage. It only checks for invalid Permutations"
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat
    * timeOfDay[+] = "08:00:00"
    * boundsPeriod.start = "2026-06-05"
    * boundsPeriod.end = "2026-06-12T12:00:00+02:00"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

// TimingBoundsPeriodNotForWhen

Instance: INV-C-TimingBoundsPeriodNotForWhen-MR-01-of-02
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
    * when[+] = #MORN
    * boundsPeriod.start = "2026-06-05T08:00:00+02:00"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-TimingBoundsPeriodNotForWhen-MR-02-of-02
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
    * when[+] = #MORN
    * boundsPeriod.start = "2026-06-05"
    * boundsPeriod.end = "2026-07-05T08:00:00+02:00"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-TimingBoundsPeriodNotForWhen-MD-01-of-02
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid Dosage"
Description: "CAVE: This MedicationDispense is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for invalid Permutations"
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * when[+] = #MORN
    * boundsPeriod.start = "2026-06-05T08:00:00+02:00"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-TimingBoundsPeriodNotForWhen-MD-02-of-02
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid Dosage"
Description: "CAVE: This MedicationDispense is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for invalid Permutations"
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * when[+] = #MORN
    * boundsPeriod.start = "2026-06-05"
    * boundsPeriod.end = "2026-07-05T08:00:00+02:00"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-TimingBoundsPeriodNotForWhen-MS-01-of-02
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid Dosage"
Description: "CAVE: This MedicationStatement is for validation purposes and does NOT represent a valid dosage. It only checks for invalid Permutations"
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat
    * when[+] = #MORN
    * boundsPeriod.start = "2026-06-05T08:00:00+02:00"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-TimingBoundsPeriodNotForWhen-MS-02-of-02
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid Dosage"
Description: "CAVE: This MedicationStatement is for validation purposes and does NOT represent a valid dosage. It only checks for invalid Permutations"
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat
    * when[+] = #MORN
    * boundsPeriod.start = "2026-06-05"
    * boundsPeriod.end = "2026-07-05T08:00:00+02:00"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
