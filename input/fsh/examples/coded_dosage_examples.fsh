Instance: Example-MR-Dosage-UnitStueck-1020
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Dosage-UnitStueck-1020"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung 1-0-2-0 und kodierter Einheit 'Stück' dar"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d
    * when[+] = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosageInstruction[+]
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d
    * when[+] = #EVE
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MR-DosageTr-1000
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Dosage-UnitTr-1000"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung 20-0-0-0 und kodierter Einheit 'Tropfen' dar"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Iberogast"
* dosageInstruction[+]
  * timing.repeat
    * when[+] = #MORN
    * frequency = 1
    * period = 1
    * periodUnit = #d
  * doseAndRate.doseQuantity = 20 $kbv-dosiereinheit#6 "Tropfen"

Instance: Example-MR-Dosage-UnitTasse-1000
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Dosage-UnitTasse-1000"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung 1-0-0-0 und kodierter Einheit 'Stück' dar"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen Saft"
* dosageInstruction[+]
  * timing.repeat
    * when[+] = #MORN
    * frequency = 1
    * period = 1
    * periodUnit = #d
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#7 "Teelöffel"
