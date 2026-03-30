Instance: Warning-Dosage-Viererschema-Text-01
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Warnung: Viererschema in Dosage.text"
Description: "Beispiel, das ein Viererschema (1-1-1-1) in Dosage.text enthält, um die Warn-Invariante auszulösen."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Amoxicillin 500mg"
* dosageInstruction[0].text = "1-1-1-1"

Instance: Warning-Dosage-Viererschema-Text-MD-01
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Warnung: Viererschema in Dosage.text"
Description: "Beispiel, das ein Viererschema (1-1-1-1) in Dosage.text enthält, um die Warn-Invariante auszulösen."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Amoxicillin 500mg"
* dosageInstruction[0].text = "1-1-1-1"

Instance: Warning-Dosage-Viererschema-Text-MS-01
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Warnung: Viererschema in Dosage.text"
Description: "Beispiel, das ein Viererschema (1-1-1-1) in Dosage.text enthält, um die Warn-Invariante auszulösen."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Amoxicillin 500mg"
* dosage[0].text = "1-1-1-1"
