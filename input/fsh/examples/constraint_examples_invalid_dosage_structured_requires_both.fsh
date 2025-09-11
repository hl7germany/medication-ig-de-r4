// Invalid examples for DosageStructuredRequiresBoth (error)
// timing without doseAndRate, and doseAndRate without timing

Instance: Invalid-Dosage-C-DosageStructuredRequiresBoth-01-of-02
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid: timing without dose"
Description: "CAVE: Validation example - timing exists but doseAndRate missing."
* insert InsertMandatoryExStubs
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

Instance: Invalid-Dosage-C-DosageStructuredRequiresBoth-02-of-02
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid: dose without timing"
Description: "CAVE: Validation example - doseAndRate exists but timing missing."
* insert InsertMandatoryExStubs
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
