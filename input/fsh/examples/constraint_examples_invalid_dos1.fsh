// Invalid examples for dos-1 (error)
// AsNeededFor can only be set if AsNeeded is empty or true

Instance: INV-C-dos-1-Request-01-of-03
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid: dos-1 (asNeededFor with asNeeded=false)"
Description: "CAVE: Validation example - asNeededFor is populated while asNeededBoolean is false."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * text = "Bei Bedarf einnehmen"
  * asNeededBoolean = false
  * extension[asNeededFor].valueCodeableConcept.text = "Kopfschmerzen"

Instance: INV-C-dos-1-Dispense-02-of-03
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid: dos-1 (asNeededFor with asNeeded=false)"
Description: "CAVE: Validation example - asNeededFor is populated while asNeededBoolean is false."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * text = "Bei Bedarf einnehmen"
  * asNeededBoolean = false
  * extension[asNeededFor].valueCodeableConcept.text = "Kopfschmerzen"

Instance: INV-C-dos-1-Statement-03-of-03
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid: dos-1 (asNeededFor with asNeeded=false)"
Description: "CAVE: Validation example - asNeededFor is populated while asNeededBoolean is false."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * text = "Bei Bedarf einnehmen"
  * asNeededBoolean = false
  * extension[asNeededFor].valueCodeableConcept.text = "Kopfschmerzen"
