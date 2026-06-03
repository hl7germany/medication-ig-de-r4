// Invalid examples for AsNeededForRequiresAsNeeded (error)
// Bedarfsmedikation mit asNeeded=true muss einen Einnahmeanlass in extension[asNeededFor] angeben.

Instance: INV-C-AsNeededForRequiresAsNeeded-Request-01-of-03
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid: asNeeded=true without asNeededFor"
Description: "CAVE: Validation example - asNeededBoolean is true while extension[asNeededFor] is missing."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * text = "Bei Bedarf einnehmen"
  * asNeededBoolean = true

Instance: INV-C-AsNeededForRequiresAsNeeded-Dispense-02-of-03
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid: asNeeded=true without asNeededFor"
Description: "CAVE: Validation example - asNeededBoolean is true while extension[asNeededFor] is missing."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * text = "Bei Bedarf einnehmen"
  * asNeededBoolean = true

Instance: INV-C-AsNeededForRequiresAsNeeded-Statement-03-of-03
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid: asNeeded=true without asNeededFor"
Description: "CAVE: Validation example - asNeededBoolean is true while extension[asNeededFor] is missing."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * text = "Bei Bedarf einnehmen"
  * asNeededBoolean = true
