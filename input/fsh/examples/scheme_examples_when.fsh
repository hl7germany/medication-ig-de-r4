
Instance: Example-MR-Dosage-10120
InstanceOf: DE_DOSAGE_DGMP_MEDICATIONREQUEST
Usage: #example
Title: "Example-MR-Dosage-10120"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung von 1-0-0.5-0 dar"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Medication"
* dosageInstruction[+] = Example-Dosage-When-10120-1
* dosageInstruction[+] = Example-Dosage-When-10120-2

Instance: Example-Dosage-When-10120-1
InstanceOf: DE_DOSAGE_DGMP
Usage: #inline
Title: "Dosage with when 1-0-0.5-0"
* timing.repeat
  * when[+] = #MORN
  * frequency = 1 
  * period = 1  
  * periodUnit = #d
* doseAndRate.doseQuantity.value = 1
* doseAndRate.doseQuantity.unit = "Tablette"

Instance: Example-Dosage-When-10120-2
InstanceOf: DE_DOSAGE_DGMP
Usage: #inline
Title: "Dosage with when 1-0-0.5-0"
* timing.repeat
  * when[+] = #EVE
  * frequency = 1 
  * period = 1  
  * periodUnit = #d
* doseAndRate.doseQuantity.value = 0.5
* doseAndRate.doseQuantity.unit = "Tablette"

Instance: Example-MR-Dosage-1020
InstanceOf: DE_DOSAGE_DGMP_MEDICATIONREQUEST
Usage: #example
Title: "Example-MR-Dosage-1020"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung 1-0-2-0 dar"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Medication"
* dosageInstruction[+] = Example-Dosage-When-1020-1
* dosageInstruction[+] = Example-Dosage-When-1020-2

Instance: Example-Dosage-When-1020-1
InstanceOf: DE_DOSAGE_DGMP
Usage: #inline
Title: "Dosage with when 1-0-2-0"
* timing.repeat
  * when[+] = #MORN
  * frequency = 1 
  * period = 1  
  * periodUnit = #d
* doseAndRate.doseQuantity.value = 1
* doseAndRate.doseQuantity.unit = "Tablette"

Instance: Example-Dosage-When-1020-2
InstanceOf: DE_DOSAGE_DGMP
Usage: #inline
Title: "Dosage with when 1-0-2-0"
* timing.repeat
  * when[+] = #EVE
  * frequency = 1 
  * period = 1  
  * periodUnit = #d
* doseAndRate.doseQuantity.value = 2
* doseAndRate.doseQuantity.unit = "Tabletten"

Instance: Example-MR-Dosage-1000
InstanceOf: DE_DOSAGE_DGMP_MEDICATIONREQUEST
Usage: #example
Title: "Example-MR-Dosage-1000"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung 1-0-0-0 dar"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Medication"
* dosageInstruction[+] = Example-Dosage-When-1000

Instance: Example-Dosage-When-1000
InstanceOf: DE_DOSAGE_DGMP
Usage: #inline
Title: "Dosage with when 1-0-0-0"
* timing.repeat
  * when[+] = #MORN
  * frequency = 1 
  * period = 1  
  * periodUnit = #d
* doseAndRate.doseQuantity.value = 1
* doseAndRate.doseQuantity.unit = "Tablette"

Instance: Example-MR-Dosage-1111
InstanceOf: DE_DOSAGE_DGMP_MEDICATIONREQUEST
Usage: #example
Title: "Example-MR-Dosage-1111"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung 1-0-0-0 dar"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Medication"
* dosageInstruction[+] = Example-Dosage-When-1111

Instance: Example-Dosage-When-1111
InstanceOf: DE_DOSAGE_DGMP
Usage: #inline
Title: "Dosage with when 1-1-1-1"
* timing.repeat
  * when[+] = #EVE
  * when[+] = #MORN
  * when[+] = #NIGHT
  * when[+] = #NOON
  * frequency = 1 
  * period = 1  
  * periodUnit = #d
* doseAndRate.doseQuantity.value = 1
* doseAndRate.doseQuantity.unit = "Tablette"

Instance: Example-MR-Dosage-1010
InstanceOf: DE_DOSAGE_DGMP_MEDICATIONREQUEST
Usage: #example
Title: "Example-MR-Dosage-1010"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung 1-0-1-0 dar"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Medication"
* dosageInstruction[+] = Example-Dosage-When-1010

Instance: Example-Dosage-When-1010
InstanceOf: DE_DOSAGE_DGMP
Usage: #inline
Title: "Dosage with when 1-0-1-0"
* timing.repeat
  * when[+] = #MORN
  * when[+] = #EVE
  * frequency = 1 
  * period = 1  
  * periodUnit = #d
* doseAndRate.doseQuantity.value = 1
* doseAndRate.doseQuantity.unit = "Tablette"

Instance: Example-MR-Dosage-1010-10-Days
InstanceOf: DE_DOSAGE_DGMP_MEDICATIONREQUEST
Usage: #example
Title: "Example-MR-Dosage-1010"
Description: "Dieses Beispiel stellt eine Medikationsanforderung mit einer Dosierung 1-0-1-0 dar"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Medication"
* dosageInstruction[+] = Example-Dosage-When-1010-10-Days

Instance: Example-Dosage-When-1010-10-Days
InstanceOf: DE_DOSAGE_DGMP
Usage: #inline
Title: "Dosage with when 1-0-1-0 for 10 Days"
* timing.repeat
  * when[+] = #MORN
  * frequency = 1 
  * period = 1  
  * periodUnit = #d
* timing.repeat.boundsDuration.value = 10
* timing.repeat.boundsDuration.unit = "Woche(n)"
* timing.repeat.boundsDuration.code = #wk
* timing.repeat.boundsDuration.system = "http://unitsofmeasure.org" //Triggerwarning!
* doseAndRate.doseQuantity.value = 1
* doseAndRate.doseQuantity.unit = "Tablette"