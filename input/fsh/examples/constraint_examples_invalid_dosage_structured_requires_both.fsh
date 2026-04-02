// Invalid examples for DosageStructuredRequiresBoth (error)
// timing without doseAndRate, and doseAndRate without timing

Instance: INV-C-DosageStructuredRequiresBoth-Request-01-of-02
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid: timing without dose"
Description: "CAVE: Validation example - timing exists but doseAndRate missing."
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

Instance: INV-C-DosageStructuredRequiresBoth-Request-02-of-02
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid: dose without timing"
Description: "CAVE: Validation example - doseAndRate exists but timing missing."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-DosageStructuredRequiresBoth-Dispense-01-of-02
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid: timing without dose"
Description: "CAVE: Validation example - timing exists but doseAndRate missing."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d
    * when[+] = #MORN

Instance: INV-C-DosageStructuredRequiresBoth-Statement-01-of-02
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid: timing without dose"
Description: "CAVE: Validation example - timing exists but doseAndRate missing."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d
    * when[+] = #MORN

Instance: INV-C-DosageStructuredRequiresBoth-Dispense-02-of-02
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid: dose without timing"
Description: "CAVE: Validation example - doseAndRate exists but timing missing."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-DosageStructuredRequiresBoth-Statement-02-of-02
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid: dose without timing"
Description: "CAVE: Validation example - doseAndRate exists but timing missing."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
