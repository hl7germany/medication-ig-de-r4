Instance: Example-MR-Dosage-tod-1t-8am
InstanceOf: DE_DOSAGE_DGMP_MEDICATIONREQUEST
Usage: #example
Title: "Example-MR-Dosage-tod-1t-8am"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung von 1 Tablette um 08:00"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * timeOfDay[+] = "08:00:00"
    * frequency = 1
    * period = 1
    * periodUnit = #d
  * doseAndRate.doseQuantity.value = 1
  * doseAndRate.doseQuantity.unit = "Tablette"

Instance: Example-MR-Dosage-tod-2-12am
InstanceOf: DE_DOSAGE_DGMP_MEDICATIONREQUEST
Usage: #example
Title: "Example-MR-Dosage-tod-2-12am"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung von 2 Tabletten um 12:00 Uhr"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * timeOfDay[+] = "12:00:00"
    * frequency = 1
    * period = 1
    * periodUnit = #d
  * doseAndRate.doseQuantity.value = 2
  * doseAndRate.doseQuantity.unit = "Tabletten"

Instance: Example-MR-Dosage-tod-multi
InstanceOf: DE_DOSAGE_DGMP_MEDICATIONREQUEST
Usage: #example
Title: "Example-MR-Dosage-tod-multi"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung von 8 Uhr 2 Tabletten - 11 Uhr 1 Tablette - 14 Uhr 1 Tablette - 17 Uhr 1 Tablette - 20 Uhr 1 Tablette - 23 Uhr 1 Tablette dar"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * timeOfDay[+] = "08:00:00"
    * frequency = 1
    * period = 1
    * periodUnit = #d
  * doseAndRate.doseQuantity.value = 2
  * doseAndRate.doseQuantity.unit = "Tabletten"

* dosageInstruction[+]
  * timing.repeat
    * timeOfDay[+] = "11:00:00"
    * frequency = 1
    * period = 1
    * periodUnit = #d
  * timing.repeat
    * timeOfDay[+] = "14:00:00"
    * frequency = 1
    * period = 1
    * periodUnit = #d
  * timing.repeat
    * timeOfDay[+] = "17:00:00"
    * frequency = 1
    * period = 1
    * periodUnit = #d
  * timing.repeat
    * timeOfDay[+] = "20:00:00"
    * frequency = 1
    * period = 1
    * periodUnit = #d
  * timing.repeat
    * timeOfDay[+] = "23:00:00"
    * frequency = 1
    * period = 1
    * periodUnit = #d
  * doseAndRate.doseQuantity.value = 1
  * doseAndRate.doseQuantity.unit = "Tablette"

Instance: Example-MR-Dosage-tod-multi-bound
InstanceOf: DE_DOSAGE_DGMP_MEDICATIONREQUEST
Usage: #example
Title: "Example-MR-Dosage-tod-multi-bound"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung 8 Uhr 2 Tabletten - 11 Uhr 1 Tablette - 14 Uhr 1 Tablette - 17 Uhr 1 Tablette - 20 Uhr 1 Tablette - 23 Uhr 1 Tablette, für 10 Tage"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.boundsDuration.value = 10
  * timing.repeat.boundsDuration.unit = "Tage"
  * timing.repeat
    * timeOfDay[+] = "08:00:00"
    * frequency = 1
    * period = 1
    * periodUnit = #d
  * doseAndRate.doseQuantity.value = 2
  * doseAndRate.doseQuantity.unit = "Tabletten"

* dosageInstruction[+]
  * timing.repeat.boundsDuration.value = 10
  * timing.repeat.boundsDuration.unit = "Tage"
  * timing.repeat
    * timeOfDay[+] = "11:00:00"
    * frequency = 1
    * period = 1
    * periodUnit = #d
  * timing.repeat
    * timeOfDay[+] = "14:00:00"
    * frequency = 1
    * period = 1
    * periodUnit = #d
  * timing.repeat
    * timeOfDay[+] = "17:00:00"
    * frequency = 1
    * period = 1
    * periodUnit = #d
  * timing.repeat
    * timeOfDay[+] = "20:00:00"
    * frequency = 1
    * period = 1
    * periodUnit = #d
  * timing.repeat
    * timeOfDay[+] = "23:00:00"
    * frequency = 1
    * period = 1
    * periodUnit = #d
  * doseAndRate.doseQuantity.value = 1
  * doseAndRate.doseQuantity.unit = "Tablette"