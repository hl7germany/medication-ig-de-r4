// Negative matrix: a variable frequency (frequencyMax) is reserved for pure
// interval schemas. Together with concrete when/timeOfDay values the number of
// administrations is already fixed, so frequencyMax contradicts it and would be
// dropped without trace by the text generation. No period is given, so
// TimingVarFreqOrPeriod does not apply and TimingOnlyOneType is isolated.

Instance: INV-VarFreq-C-TimingOnlyOneType-MR
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid MedicationRequest: variable frequency together with when"
Description: "CAVE: frequencyMax cannot be combined with concrete when values."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Test Medication"
* dosageInstruction[+]
  * timing.repeat
    * when = #MORN
    * frequency = 1
    * frequencyMax = 3
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-VarFreq-C-TimingOnlyOneType-MD
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid MedicationDispense: variable frequency together with timeOfDay"
Description: "CAVE: frequencyMax cannot be combined with concrete timeOfDay values."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Test Medication"
* dosageInstruction[+]
  * timing.repeat
    * timeOfDay = "08:00:00"
    * frequency = 1
    * frequencyMax = 3
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-VarFreq-C-TimingOnlyOneType-MS
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid MedicationStatement: variable frequency together with an interval combination"
Description: "CAVE: frequencyMax cannot be combined with concrete when values, not even within a non-daily interval combination."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Test Medication"
* dosage[+]
  * timing.repeat
    * when = #MORN
    * frequency = 1
    * frequencyMax = 3
    * period = 2
    * periodUnit = #d
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
