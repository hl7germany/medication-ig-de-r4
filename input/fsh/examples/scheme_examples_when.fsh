
Instance: Example-MR-Dosage-10120
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Dosage-10120"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung von 1-0-0.5-0 dar"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * when[+] = #MORN   
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

* dosageInstruction[+]
  * timing.repeat
    * when[+] = #EVE
  * doseAndRate.doseQuantity = 0.5 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MR-Dosage-1020
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Dosage-1020"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung 1-0-2-0 dar"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * when[+] = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

* dosageInstruction[+]
  * timing.repeat
    * when[+] = #EVE
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MR-Dosage-1000
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Dosage-1000"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung 1-0-0-0 dar"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * when[+] = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MR-Dosage-1111
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Dosage-1111"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung 1-0-0-0 dar"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * when[+] = #EVE
    * when[+] = #MORN
    * when[+] = #NIGHT
    * when[+] = #NOON
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MR-Dosage-1010
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Dosage-1010"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung 1-0-1-0 dar"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * when[+] = #MORN
    * when[+] = #EVE
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MR-Dosage-1010-10-Days
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Dosage-1010"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung 1-0-1-0 für 10 Wochen dar"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * when[+] = #MORN
    * when[+] = #EVE
    * boundsDuration = 10 $ucum#wk "Woche(n)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"