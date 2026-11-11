// Invalid examples for DosageDoseUnitSameCode (error)
// Two dosageInstructions with different dose units

Instance: INV-C-DosageDoseUnitSameCode-Request-01-of-02
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
    * when[+] = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosageInstruction[+]
  * timing.repeat
    * when[+] = #EVE
  * doseAndRate.doseQuantity = 500 $kbv-dosiereinheit#v "mg"

Instance: INV-C-DosageDoseUnitSameCode-Request-02-of-02
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid (Request): mixed Quantity and Range dose units"
Description: "CAVE: Validation example - doseQuantity uses code 1, doseRange.low and doseRange.high use code 6. The Range bounds agree with each other, but not with the Quantity."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Testmedikation"
* dosageInstruction[+]
  * timing.repeat.when[+] = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosageInstruction[+]
  * timing.repeat.when[+] = #EVE
  * doseAndRate.doseRange
    * low = 1 $kbv-dosiereinheit#6 "Tropfen"
    * high = 2 $kbv-dosiereinheit#6 "Tropfen"

Instance: INV-C-DosageDoseUnitSameCode-Statement-02-of-02
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid (Statement): mixed Quantity and Range dose units"
Description: "CAVE: Validation example - doseQuantity uses code 1, doseRange.low and doseRange.high use code 6. The Range bounds agree with each other, but not with the Quantity."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Testmedikation"
* dosage[+]
  * timing.repeat.when[+] = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosage[+]
  * timing.repeat.when[+] = #EVE
  * doseAndRate.doseRange
    * low = 1 $kbv-dosiereinheit#6 "Tropfen"
    * high = 2 $kbv-dosiereinheit#6 "Tropfen"

Instance: INV-C-DosageDoseUnitSameCode-Dispense-02-of-02
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid (Dispense): mixed Quantity and Range dose units"
Description: "CAVE: Validation example - doseQuantity uses code 1, doseRange.low and doseRange.high use code 6. The Range bounds agree with each other, but not with the Quantity."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Testmedikation"
* dosageInstruction[+]
  * timing.repeat.when[+] = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosageInstruction[+]
  * timing.repeat.when[+] = #EVE
  * doseAndRate.doseRange
    * low = 1 $kbv-dosiereinheit#6 "Tropfen"
    * high = 2 $kbv-dosiereinheit#6 "Tropfen"

Instance: INV-C-DosageDoseUnitSameCode-Statement-01-of-02
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid: mixed dose units"
Description: "CAVE: Validation example - two dosage entries use different dose unit codes."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat
    * when[+] = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosage[+]
  * timing.repeat
    * when[+] = #EVE
  * doseAndRate.doseQuantity = 500 $kbv-dosiereinheit#v "mg"

Instance: INV-C-DosageDoseUnitSameCode-Dispense-01-of-02
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid: mixed dose units"
Description: "CAVE: Validation example - two dosageInstruction entries use different dose unit codes."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * when[+] = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosageInstruction[+]
  * timing.repeat
    * when[+] = #EVE
  * doseAndRate.doseQuantity = 500 $kbv-dosiereinheit#v "mg"