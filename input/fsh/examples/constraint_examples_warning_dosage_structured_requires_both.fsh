// Warning examples for DosageStructuredRequiresBothWarning
// Use case: fixed administration times with a dose that is not fixed in advance
// (e.g. insulin according to a plan). Allowed as a warning in DE, error in dgMP.

Instance: W-DosageStructuredRequiresBothWarning-01-of-03
InstanceOf: MedicationRequestDE
Usage: #example
Title: "Warning (Request): timing without dose"
Description: "Warning example - fixed times without doseAndRate (Insulin nach Plan)."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Insulin human 100 I.E./ml"
* dosageInstruction[+]
  * timing.repeat
    * when[+] = #MORN
    * when[+] = #EVE
    * frequency = 2
    * period = 1
    * periodUnit = #d

Instance: W-DosageStructuredRequiresBothWarning-02-of-03
InstanceOf: MedicationDispenseDE
Usage: #example
Title: "Warning (Dispense): timing without dose"
Description: "Warning example - fixed times without doseAndRate (Insulin nach Plan)."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Insulin human 100 I.E./ml"
* dosageInstruction[+]
  * timing.repeat
    * when[+] = #MORN
    * when[+] = #EVE
    * frequency = 2
    * period = 1
    * periodUnit = #d

Instance: W-DosageStructuredRequiresBothWarning-03-of-03
InstanceOf: MedicationStatementDE
Usage: #example
Title: "Warning (Statement): timing without dose"
Description: "Warning example - fixed times without doseAndRate (Insulin nach Plan)."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Insulin human 100 I.E./ml"
* dosage[+]
  * timing.repeat
    * when[+] = #MORN
    * when[+] = #EVE
    * frequency = 2
    * period = 1
    * periodUnit = #d
