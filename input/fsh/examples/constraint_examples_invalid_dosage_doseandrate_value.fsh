Instance: INV-C-DosageDoseQuantityAllowedFractions-Request-01-of-02
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
  * doseAndRate.doseQuantity = 1.1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-DosageDoseQuantityAllowedFractions-Request-02-of-02
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
  * doseAndRate.doseQuantity = 1.00000001 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-DosageDoseQuantityAllowedFractions-Statement-01-of-02
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
  * doseAndRate.doseQuantity = 1.1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-DosageDoseQuantityAllowedFractions-Statement-02-of-02
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
  * doseAndRate.doseQuantity = 1.00000001 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-DosageDoseQuantityAllowedFractions-Dispense-01-of-02
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
  * doseAndRate.doseQuantity = 1.1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-DosageDoseQuantityAllowedFractions-Dispense-02-of-02
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
  * doseAndRate.doseQuantity = 1.00000001 $kbv-dosiereinheit#1 "Stück"