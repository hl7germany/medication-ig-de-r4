// Warning examples for DosageDoseUnitSameCodeWarning
// Two dosage entries with different dose unit codes. Allowed as a warning in DE, error in dgMP.

Instance: W-DosageDoseUnitSameCodeWarning-01-of-09
InstanceOf: MedicationRequestDE
Usage: #example
Title: "Warning (Request): mixed dose units"
Description: "Warning example - two dosageInstructions use different dose unit codes."
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
  * doseAndRate.doseQuantity = 500 $kbv-dosiereinheit#mg "mg"

Instance: W-DosageDoseUnitSameCodeWarning-07-of-09
InstanceOf: MedicationRequestDE
Usage: #example
Title: "Warning (Request): mixed Quantity and Range dose units"
Description: "Warning example - doseQuantity uses code 1, doseRange.low and doseRange.high use code 6."
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

Instance: W-DosageDoseUnitSameCodeWarning-08-of-09
InstanceOf: MedicationDispenseDE
Usage: #example
Title: "Warning (Dispense): mixed Quantity and Range dose units"
Description: "Warning example - doseQuantity uses code 1, doseRange.low and doseRange.high use code 6."
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

Instance: W-DosageDoseUnitSameCodeWarning-09-of-09
InstanceOf: MedicationStatementDE
Usage: #example
Title: "Warning (Statement): mixed Quantity and Range dose units"
Description: "Warning example - doseQuantity uses code 1, doseRange.low and doseRange.high use code 6."
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

Instance: W-DosageDoseUnitSameCodeWarning-04-of-09
InstanceOf: MedicationRequestDE
Usage: #example
Title: "Warning (Request): dose without code"
Description: "Warning example - doseAndRate is present, but doseQuantity has no code. Zero distinct dose codes do not satisfy the rule."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Testmedikation"
* dosageInstruction[+]
  * timing.repeat.when[+] = #MORN
  * doseAndRate.doseQuantity
    * value = 1
    * unit = "Stück"

Instance: W-DosageDoseUnitSameCodeWarning-05-of-09
InstanceOf: MedicationDispenseDE
Usage: #example
Title: "Warning (Dispense): dose without code"
Description: "Warning example - doseAndRate is present, but doseQuantity has no code. Zero distinct dose codes do not satisfy the rule."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Testmedikation"
* dosageInstruction[+]
  * timing.repeat.when[+] = #MORN
  * doseAndRate.doseQuantity
    * value = 1
    * unit = "Stück"

Instance: W-DosageDoseUnitSameCodeWarning-06-of-09
InstanceOf: MedicationStatementDE
Usage: #example
Title: "Warning (Statement): dose without code"
Description: "Warning example - doseAndRate is present, but doseQuantity has no code. Zero distinct dose codes do not satisfy the rule."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Testmedikation"
* dosage[+]
  * timing.repeat.when[+] = #MORN
  * doseAndRate.doseQuantity
    * value = 1
    * unit = "Stück"

Instance: W-DosageDoseUnitSameCodeWarning-02-of-09
InstanceOf: MedicationDispenseDE
Usage: #example
Title: "Warning (Dispense): mixed dose units"
Description: "Warning example - two dosageInstruction entries use different dose unit codes."
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
  * doseAndRate.doseQuantity = 500 $kbv-dosiereinheit#mg "mg"

Instance: W-DosageDoseUnitSameCodeWarning-03-of-09
InstanceOf: MedicationStatementDE
Usage: #example
Title: "Warning (Statement): mixed dose units"
Description: "Warning example - two dosage entries use different dose unit codes."
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
  * doseAndRate.doseQuantity = 500 $kbv-dosiereinheit#mg "mg"
