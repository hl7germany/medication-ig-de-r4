// Warning examples for DosageDoseUnitSameCodeWarning
// Two dosage entries with different dose unit codes. Allowed as a warning in DE, error in dgMP.

Instance: W-DosageDoseUnitSameCodeWarning-01-of-03
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

Instance: W-DosageDoseUnitSameCodeWarning-Range-01-of-03
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

Instance: W-DosageDoseUnitSameCodeWarning-Range-02-of-03
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

Instance: W-DosageDoseUnitSameCodeWarning-Range-03-of-03
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

Instance: W-DosageDoseUnitSameCodeWarning-RangeBounds-01-of-03
InstanceOf: MedicationRequestDE
Usage: #example
Title: "Warning (Request): different doseRange bound codes"
Description: "Warning example - a single doseRange uses mg in low and g in high, yielding two distinct dose codes."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Testmedikation"
* dosageInstruction[+]
  * timing.repeat.when[+] = #MORN
  * doseAndRate.doseRange
    * low = 1 $ucum#mg "mg"
    * high = 2 $ucum#g "g"

Instance: W-DosageDoseUnitSameCodeWarning-RangeBounds-02-of-03
InstanceOf: MedicationDispenseDE
Usage: #example
Title: "Warning (Dispense): different doseRange bound codes"
Description: "Warning example - a single doseRange uses mg in low and g in high, yielding two distinct dose codes."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Testmedikation"
* dosageInstruction[+]
  * timing.repeat.when[+] = #MORN
  * doseAndRate.doseRange
    * low = 1 $ucum#mg "mg"
    * high = 2 $ucum#g "g"

Instance: W-DosageDoseUnitSameCodeWarning-RangeBounds-03-of-03
InstanceOf: MedicationStatementDE
Usage: #example
Title: "Warning (Statement): different doseRange bound codes"
Description: "Warning example - a single doseRange uses mg in low and g in high, yielding two distinct dose codes."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Testmedikation"
* dosage[+]
  * timing.repeat.when[+] = #MORN
  * doseAndRate.doseRange
    * low = 1 $ucum#mg "mg"
    * high = 2 $ucum#g "g"

Instance: W-DosageDoseUnitSameCodeWarning-NoCode-01-of-03
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

Instance: W-DosageDoseUnitSameCodeWarning-NoCode-02-of-03
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

Instance: W-DosageDoseUnitSameCodeWarning-NoCode-03-of-03
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

Instance: W-DosageDoseUnitSameCodeWarning-02-of-03
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

Instance: W-DosageDoseUnitSameCodeWarning-03-of-03
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
