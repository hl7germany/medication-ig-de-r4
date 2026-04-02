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

// --- MedicationDispense equivalents ---

Instance: Example-MD-Dosage-UnitStueck-1020
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Example-MD-Dosage-UnitStueck-1020"
Description: "Dieses Beispiel stellt eine Medikationsabgabe mit einer Dosierung 1-0-2-0 und kodierter Einheit 'Stück' dar"
* subject.display = "Patient"
* status = #completed
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

Instance: Example-MD-DosageTr-1000
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Example-MD-Dosage-UnitTr-1000"
Description: "Dieses Beispiel stellt eine Medikationsabgabe mit einer Dosierung 20-0-0-0 und kodierter Einheit 'Tropfen' dar"
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Iberogast"
* dosageInstruction[+]
  * timing.repeat
    * when[+] = #MORN
    * frequency = 1
    * period = 1
    * periodUnit = #d
  * doseAndRate.doseQuantity = 20 $kbv-dosiereinheit#6 "Tropfen"

Instance: Example-MD-Dosage-UnitTasse-1000
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Example-MD-Dosage-UnitTasse-1000"
Description: "Dieses Beispiel stellt eine Medikationsabgabe mit einer Dosierung 1-0-0-0 und kodierter Einheit 'Teelöffel' dar"
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen Saft"
* dosageInstruction[+]
  * timing.repeat
    * when[+] = #MORN
    * frequency = 1
    * period = 1
    * periodUnit = #d
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#7 "Teelöffel"

// --- MedicationStatement equivalents ---

Instance: Example-MS-Dosage-UnitStueck-1020
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Example-MS-Dosage-UnitStueck-1020"
Description: "Dieses Beispiel stellt eine Medikationsaussage mit einer Dosierung 1-0-2-0 und kodierter Einheit 'Stück' dar"
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d
    * when[+] = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosage[+]
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d
    * when[+] = #EVE
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MS-DosageTr-1000
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Example-MS-Dosage-UnitTr-1000"
Description: "Dieses Beispiel stellt eine Medikationsaussage mit einer Dosierung 20-0-0-0 und kodierter Einheit 'Tropfen' dar"
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Iberogast"
* dosage[+]
  * timing.repeat
    * when[+] = #MORN
    * frequency = 1
    * period = 1
    * periodUnit = #d
  * doseAndRate.doseQuantity = 20 $kbv-dosiereinheit#6 "Tropfen"

Instance: Example-MS-Dosage-UnitTasse-1000
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Example-MS-Dosage-UnitTasse-1000"
Description: "Dieses Beispiel stellt eine Medikationsaussage mit einer Dosierung 1-0-0-0 und kodierter Einheit 'Teelöffel' dar"
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen Saft"
* dosage[+]
  * timing.repeat
    * when[+] = #MORN
    * frequency = 1
    * period = 1
    * periodUnit = #d
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#7 "Teelöffel"
