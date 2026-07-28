Instance: Example-MR-Dosage-1010-PatientInstruction
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Dosage-1010-PatientInstruction"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit strukturierter Dosierung und ergänzender patientInstruction dar"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Amoxicillin 500mg"
* dosageInstruction[+]
  * timing.repeat
    * when[+] = #MORN
    * when[+] = #EVE
    * frequency = 2
    * period = 1
    * periodUnit = #d
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * patientInstruction = "Tablette nicht zerkauen. Bei Fieber über 39 Grad Arzt kontaktieren."
