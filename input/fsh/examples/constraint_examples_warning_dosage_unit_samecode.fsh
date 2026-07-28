// Warning examples for DosageDoseUnitSameCodeWarning
// Two dosage entries with different dose unit codes. Allowed as a warning in DE, error in dgMP.

Instance: Dosage-W-DosageDoseUnitSameCodeWarning-01-of-03
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

Instance: Dosage-W-DosageDoseUnitSameCodeWarning-02-of-03
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

Instance: Dosage-W-DosageDoseUnitSameCodeWarning-03-of-03
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
