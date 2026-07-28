// Warning example for DosageWarnungViererschemaInText
// Triggers the warning by embedding a 4-scheme pattern in Dosage.text.
// A text consisting solely of a 4-scheme is an error in dgMP, see DosageViererschemaInText.

Instance: Warning-Dosage-W-DosageWarnungViererschemaInText-01-of-03
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Warnung (Request): Viererschema im Freitext"
Description: "Freitext enthält ein eingebettetes Viererschema (1-0-1-0); soll strukturiert modelliert werden."
* status = #active
* intent = #order
* subject.display = "Patient"
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * text = "Nach dem Essen 1-0-1-0 einnehmen"

Instance: Warning-Dosage-W-DosageWarnungViererschemaInText-02-of-03
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Warnung (Dispense): Viererschema im Freitext"
Description: "Freitext enthält ein eingebettetes Viererschema (1-0-1-0); soll strukturiert modelliert werden."
* status = #completed
* subject.display = "Patient"
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * text = "Nach dem Essen 1-0-1-0 einnehmen"

Instance: Warning-Dosage-W-DosageWarnungViererschemaInText-03-of-03
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Warnung (Statement): Viererschema im Freitext"
Description: "Freitext enthält ein eingebettetes Viererschema (1-0-1-0); soll strukturiert modelliert werden."
* status = #active
* subject.display = "Patient"
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * text = "Nach dem Essen 1-0-1-0 einnehmen"
