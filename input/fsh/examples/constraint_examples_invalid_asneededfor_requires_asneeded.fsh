// Invalid examples for AsNeededForRequiresAsNeeded (error)
// Ein Einnahmeanlass (extension[asNeededFor]) darf nur bei asNeededBoolean=true angegeben werden.
// Hier ist asNeededFor gesetzt, asNeededBoolean fehlt jedoch -> Verstoß.

Instance: INV-C-AsNeededForRequiresAsNeeded-Request-01-of-03
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid: asNeededFor without asNeeded=true"
Description: "CAVE: Validation example - extension[asNeededFor] is present while asNeededBoolean is not true."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * text = "Bei Bedarf einnehmen"
  * extension[asNeededFor].valueCodeableConcept.text = "Kopfschmerzen"

Instance: INV-C-AsNeededForRequiresAsNeeded-Dispense-02-of-03
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid: asNeededFor without asNeeded=true"
Description: "CAVE: Validation example - extension[asNeededFor] is present while asNeededBoolean is not true."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * text = "Bei Bedarf einnehmen"
  * extension[asNeededFor].valueCodeableConcept.text = "Kopfschmerzen"

Instance: INV-C-AsNeededForRequiresAsNeeded-Statement-03-of-03
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid: asNeededFor without asNeeded=true"
Description: "CAVE: Validation example - extension[asNeededFor] is present while asNeededBoolean is not true."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * text = "Bei Bedarf einnehmen"
  * extension[asNeededFor].valueCodeableConcept.text = "Kopfschmerzen"
