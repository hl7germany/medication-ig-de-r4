Instance: INV-C-PatientInstructionIdentical-Request-01-of-02
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid: differing patientInstruction values"
Description: "CAVE: Validation example - patientInstruction differs between dosageInstruction entries."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Amoxicillin 500mg"
* dosageInstruction[+]
  * timing.repeat
    * when[+] = #MORN
    * frequency = 1
    * period = 1
    * periodUnit = #d
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * patientInstruction = "Tablette nicht zerkauen."
* dosageInstruction[+]
  * timing.repeat
    * when[+] = #EVE
    * frequency = 1
    * period = 1
    * periodUnit = #d
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"
  * patientInstruction = "Bei Fieber ueber 39 Grad Arzt kontaktieren."

Instance: INV-C-PatientInstructionIdentical-Request-02-of-02
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid: missing patientInstruction in one dosage"
Description: "CAVE: Validation example - patientInstruction exists in one dosageInstruction entry but is missing in another."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Amoxicillin 500mg"
* dosageInstruction[+]
  * timing.repeat
    * when[+] = #MORN
    * frequency = 1
    * period = 1
    * periodUnit = #d
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * patientInstruction = "Vor Gebrauch schuetteln."
* dosageInstruction[+]
  * timing.repeat
    * when[+] = #EVE
    * frequency = 1
    * period = 1
    * periodUnit = #d
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-PatientInstructionIdentical-Dispense-01-of-02
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid: differing patientInstruction values"
Description: "CAVE: Validation example - patientInstruction differs between dosageInstruction entries."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Amoxicillin 500mg"
* dosageInstruction[+]
  * timing.repeat
    * when[+] = #MORN
    * frequency = 1
    * period = 1
    * periodUnit = #d
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * patientInstruction = "Tablette nicht zerkauen."
* dosageInstruction[+]
  * timing.repeat
    * when[+] = #EVE
    * frequency = 1
    * period = 1
    * periodUnit = #d
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"
  * patientInstruction = "Bei Fieber ueber 39 Grad Arzt kontaktieren."

Instance: INV-C-PatientInstructionIdentical-Dispense-02-of-02
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid: missing patientInstruction in one dosage"
Description: "CAVE: Validation example - patientInstruction exists in one dosageInstruction entry but is missing in another."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Amoxicillin 500mg"
* dosageInstruction[+]
  * timing.repeat
    * when[+] = #MORN
    * frequency = 1
    * period = 1
    * periodUnit = #d
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * patientInstruction = "Vor Gebrauch schuetteln."
* dosageInstruction[+]
  * timing.repeat
    * when[+] = #EVE
    * frequency = 1
    * period = 1
    * periodUnit = #d
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-PatientInstructionIdentical-Statement-01-of-02
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid: differing patientInstruction values"
Description: "CAVE: Validation example - patientInstruction differs between dosage entries."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Amoxicillin 500mg"
* dosage[+]
  * timing.repeat
    * when[+] = #MORN
    * frequency = 1
    * period = 1
    * periodUnit = #d
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * patientInstruction = "Tablette nicht zerkauen."
* dosage[+]
  * timing.repeat
    * when[+] = #EVE
    * frequency = 1
    * period = 1
    * periodUnit = #d
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"
  * patientInstruction = "Bei Fieber ueber 39 Grad Arzt kontaktieren."

Instance: INV-C-PatientInstructionIdentical-Statement-02-of-02
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid: missing patientInstruction in one dosage"
Description: "CAVE: Validation example - patientInstruction exists in one dosage entry but is missing in another."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Amoxicillin 500mg"
* dosage[+]
  * timing.repeat
    * when[+] = #MORN
    * frequency = 1
    * period = 1
    * periodUnit = #d
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * patientInstruction = "Vor Gebrauch schuetteln."
* dosage[+]
  * timing.repeat
    * when[+] = #EVE
    * frequency = 1
    * period = 1
    * periodUnit = #d
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"
