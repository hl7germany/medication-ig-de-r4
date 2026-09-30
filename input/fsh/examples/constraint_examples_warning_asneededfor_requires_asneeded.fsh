// Warning examples for AsNeededForRequiresAsNeededWarning
// Ein Anlass (extension[asNeededFor]) ohne asNeeded ist in DE zulässig (dos-1, wie FHIR R5),
// soll aber zusammen mit asNeededBoolean = true angegeben werden. Fehler in dgMP.

Instance: W-AsNeededForRequiresAsNeededWarning-MR-01-of-03
InstanceOf: MedicationRequestDE
Usage: #example
Title: "Warning (Request): asNeededFor without asNeeded"
Description: "Warning example - extension[asNeededFor] is present while asNeeded is missing."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * text = "Bei Bedarf einnehmen"
  * extension[asNeededFor].valueCodeableConcept.text = "Kopfschmerzen"

Instance: W-AsNeededForRequiresAsNeededWarning-MD-02-of-03
InstanceOf: MedicationDispenseDE
Usage: #example
Title: "Warning (Dispense): asNeededFor without asNeeded"
Description: "Warning example - extension[asNeededFor] is present while asNeeded is missing."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * text = "Bei Bedarf einnehmen"
  * extension[asNeededFor].valueCodeableConcept.text = "Kopfschmerzen"

Instance: W-AsNeededForRequiresAsNeededWarning-MS-03-of-03
InstanceOf: MedicationStatementDE
Usage: #example
Title: "Warning (Statement): asNeededFor without asNeeded"
Description: "Warning example - extension[asNeededFor] is present while asNeeded is missing."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * text = "Bei Bedarf einnehmen"
  * extension[asNeededFor].valueCodeableConcept.text = "Kopfschmerzen"
