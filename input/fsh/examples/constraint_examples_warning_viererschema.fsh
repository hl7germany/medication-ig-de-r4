// Warning example for DosageWarnungViererschemaInText
// Triggers the warning by providing a 4-scheme pattern in Dosage.text

Instance: Warning-Dosage-W-DosageWarnungViererschemaInText-01-of-01
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Warnung: Viererschema im Freitext"
Description: "Freitext enthält ein Viererschema (1-0-1-0); soll strukturiert modelliert werden."
* status = #active
* intent = #order
* subject.display = "Patient"
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * text = "1-0-1-0"
