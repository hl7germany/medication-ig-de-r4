Instance: Example-MR-Dosage-1000-startdate
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Dosage-1000-startdate"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einem Startdatum dar."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * boundsPeriod
      * start = "2026-06-05"
    * when[+] = #MORN
    * frequency = 1
    * period = 1
    * periodUnit = #d
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MR-Dosage-1000-enddate
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Dosage-1000-enddate"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einem Enddatum dar."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * boundsPeriod
      * end = "2026-07-05"
    * when[+] = #MORN
    * frequency = 1
    * period = 1
    * periodUnit = #d
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MR-Dosage-1000-startandenddate
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Dosage-1000-startandenddate"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einem Start- und Enddatum dar."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * boundsPeriod
      * start = "2026-06-05"
      * end = "2026-07-05"
    * when[+] = #MORN
    * frequency = 1
    * period = 1
    * periodUnit = #d
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
