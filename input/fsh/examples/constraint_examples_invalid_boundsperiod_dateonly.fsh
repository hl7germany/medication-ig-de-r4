// Examples for TimingBoundsPeriodDateOnly constraint

Instance: INV-C-TimingBoundsPeriodDateOnly-Request-01-of-03
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid (Request): boundsPeriod.start contains a time"
Description: "boundsPeriod.start must contain a date in the format YYYY-MM-DD without a time or timezone."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d
    * boundsPeriod.start = "2026-06-05T08:30:00+02:00"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-TimingBoundsPeriodDateOnly-Dispense-02-of-03
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid (Dispense): boundsPeriod.start contains a time"
Description: "boundsPeriod.start must contain a date in the format YYYY-MM-DD without a time or timezone."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d
    * boundsPeriod.start = "2026-06-05T08:30:00+02:00"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-TimingBoundsPeriodDateOnly-Statement-03-of-03
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid (Statement): boundsPeriod.start contains a time"
Description: "boundsPeriod.start must contain a date in the format YYYY-MM-DD without a time or timezone."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d
    * boundsPeriod.start = "2026-06-05T08:30:00+02:00"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
