Instance: INV-C-DosageDoseQuantityAllowedFractions-MR-01-of-03
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Ungültig (Request): Dosiswert 1.1 mit unzulässigem Bruchteil"
Description: "CAVE: Validierungsbeispiel - doseQuantity.value = 1.1 ist weder ganzzahlig noch ein zulässiger Bruchteil."
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
  * doseAndRate.doseQuantity = 1.1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-DosageDoseQuantityAllowedFractions-MR-02-of-03
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Ungültig (Request): Dosiswert 1.00000001 mit unzulässigem Bruchteil"
Description: "CAVE: Validierungsbeispiel - doseQuantity.value = 1.00000001 ist weder ganzzahlig noch ein zulässiger Bruchteil."
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
  * doseAndRate.doseQuantity = 1.00000001 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-DosageDoseQuantityAllowedFractions-MR-03-of-03
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Ungültig (Request): Dosiswert 0.333 mit unzulässigem Bruchteil"
Description: "CAVE: Validierungsbeispiel - doseQuantity.value = 0.333 hat zulässig viele Nachkommastellen, ist aber kein zulässiger Bruchteil (für Drittel nur .33)."
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
  * doseAndRate.doseQuantity = 0.333 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-DosageDoseQuantityAllowedFractions-MS-01-of-03
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Ungültig (Statement): Dosiswert 1.1 mit unzulässigem Bruchteil"
Description: "CAVE: Validierungsbeispiel - doseQuantity.value = 1.1 ist weder ganzzahlig noch ein zulässiger Bruchteil."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d
    * when[+] = #MORN
  * doseAndRate.doseQuantity = 1.1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-DosageDoseQuantityAllowedFractions-MS-02-of-03
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Ungültig (Statement): Dosiswert 1.00000001 mit unzulässigem Bruchteil"
Description: "CAVE: Validierungsbeispiel - doseQuantity.value = 1.00000001 ist weder ganzzahlig noch ein zulässiger Bruchteil."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d
    * when[+] = #MORN
  * doseAndRate.doseQuantity = 1.00000001 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-DosageDoseQuantityAllowedFractions-MS-03-of-03
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Ungültig (Statement): Dosiswert 0.333 mit unzulässigem Bruchteil"
Description: "CAVE: Validierungsbeispiel - doseQuantity.value = 0.333 hat zulässig viele Nachkommastellen, ist aber kein zulässiger Bruchteil (für Drittel nur .33)."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d
    * when[+] = #MORN
  * doseAndRate.doseQuantity = 0.333 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-DosageDoseQuantityAllowedFractions-MD-01-of-03
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Ungültig (Dispense): Dosiswert 1.1 mit unzulässigem Bruchteil"
Description: "CAVE: Validierungsbeispiel - doseQuantity.value = 1.1 ist weder ganzzahlig noch ein zulässiger Bruchteil."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d
    * when[+] = #MORN
  * doseAndRate.doseQuantity = 1.1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-DosageDoseQuantityAllowedFractions-MD-02-of-03
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Ungültig (Dispense): Dosiswert 1.00000001 mit unzulässigem Bruchteil"
Description: "CAVE: Validierungsbeispiel - doseQuantity.value = 1.00000001 ist weder ganzzahlig noch ein zulässiger Bruchteil."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d
    * when[+] = #MORN
  * doseAndRate.doseQuantity = 1.00000001 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-DosageDoseQuantityAllowedFractions-MD-03-of-03
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Ungültig (Dispense): Dosiswert 0.333 mit unzulässigem Bruchteil"
Description: "CAVE: Validierungsbeispiel - doseQuantity.value = 0.333 hat zulässig viele Nachkommastellen, ist aber kein zulässiger Bruchteil (für Drittel nur .33)."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d
    * when[+] = #MORN
  * doseAndRate.doseQuantity = 0.333 $kbv-dosiereinheit#1 "Stück"
