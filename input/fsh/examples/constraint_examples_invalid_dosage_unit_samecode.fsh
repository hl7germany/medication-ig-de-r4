// Invalid examples for DosageDoseUnitSameCode (error)
// Two dosageInstructions with different dose units

Instance: INV-C-DosageDoseUnitSameCode-Request-01-of-01
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid: mixed dose units"
Description: "CAVE: Validation example - two dosageInstructions use different dose unit codes."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d
    * when[+] = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosageInstruction[+]
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d
    * when[+] = #EVE
  * doseAndRate.doseQuantity = 500 $kbv-dosiereinheit#mg "mg"

Instance: INV-C-DosageDoseUnitSameCode-Statement-01-of-01
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid: mixed dose units"
Description: "CAVE: Validation example - two dosage entries use different dose unit codes."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d
    * when[+] = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosage[+]
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d
    * when[+] = #EVE
  * doseAndRate.doseQuantity = 500 $kbv-dosiereinheit#mg "mg"

Instance: INV-C-DosageDoseUnitSameCode-Dispense-01-of-01
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid: mixed dose units"
Description: "CAVE: Validation example - two dosageInstruction entries use different dose unit codes."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d
    * when[+] = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosageInstruction[+]
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d
    * when[+] = #EVE
  * doseAndRate.doseQuantity = 500 $kbv-dosiereinheit#mg "mg"