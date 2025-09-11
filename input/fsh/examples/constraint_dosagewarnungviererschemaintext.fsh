Instance: Warning-Dosage-Viererschema-Text-01
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Warnung: Viererschema in Dosage.text"
Description: "Beispiel, das ein Viererschema (1-1-1-1) in Dosage.text enthält, um die Warn-Invariante auszulösen."
* insert InsertMandatoryExStubs
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Amoxicillin 500mg"
* dosageInstruction[0].text = "1-1-1-1"
