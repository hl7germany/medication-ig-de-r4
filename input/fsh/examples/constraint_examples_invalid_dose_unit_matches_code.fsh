// Examples for DosageDoseUnitMatchesCode: the dose unit must be exactly the display
// of its code from KBV_CS_SFHIR_BMP_DOSIEREINHEIT.

Instance: INV-C-DosageDoseUnitMatchesCode-Request-01-of-06
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid (Request): dose unit does not match the code"
Description: "doseQuantity.code '1' (Stück) with unit 'Tablette'"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.when = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Tablette"

Instance: INV-C-DosageDoseUnitMatchesCode-Dispense-02-of-06
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid (Dispense): dose unit does not match the code"
Description: "doseQuantity.code '1' (Stück) with unit 'Tablette'"
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.when = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Tablette"

Instance: INV-C-DosageDoseUnitMatchesCode-Statement-03-of-06
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid (Statement): dose unit does not match the code"
Description: "doseQuantity.code '1' (Stück) with unit 'Tablette'"
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat.when = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Tablette"

Instance: INV-C-DosageDoseUnitMatchesCode-Request-04-of-06
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid (Request): dose range unit does not match the code"
Description: "doseRange.low/high.code 's' (ml) with unit 'Milliliter'"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.when = #MORN
  * doseAndRate.doseRange.low = 1 $kbv-dosiereinheit#s "Milliliter"
  * doseAndRate.doseRange.high = 2 $kbv-dosiereinheit#s "Milliliter"

Instance: INV-C-DosageDoseUnitMatchesCode-Dispense-05-of-06
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid (Dispense): dose range unit does not match the code"
Description: "doseRange.low/high.code 's' (ml) with unit 'Milliliter'"
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.when = #MORN
  * doseAndRate.doseRange.low = 1 $kbv-dosiereinheit#s "Milliliter"
  * doseAndRate.doseRange.high = 2 $kbv-dosiereinheit#s "Milliliter"

Instance: INV-C-DosageDoseUnitMatchesCode-Statement-06-of-06
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid (Statement): dose range unit does not match the code"
Description: "doseRange.low/high.code 's' (ml) with unit 'Milliliter'"
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat.when = #MORN
  * doseAndRate.doseRange.low = 1 $kbv-dosiereinheit#s "Milliliter"
  * doseAndRate.doseRange.high = 2 $kbv-dosiereinheit#s "Milliliter"
