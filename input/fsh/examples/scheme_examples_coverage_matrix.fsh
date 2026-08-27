// ---------------------------------------------------------------------------
// Abdeckungsmatrix: jedes Schema mit jedem zulaessigen Querschnittsmerkmal,
// fuer alle drei Ressourcentypen. Ergaenzt die Luecken der bestehenden Beispiele.
// ---------------------------------------------------------------------------

Instance: Example-MD-Cov-uhrzeit-zeitrahmen
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Example-MD-Cov-uhrzeit-zeitrahmen"
Description: "Abdeckung: Uhrzeiten mit Anwendungsdauer."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.timeOfDay[+] = "08:00:00"
  * timing.repeat.timeOfDay[+] = "20:00:00"
  * timing.repeat.boundsDuration = 5 $ucum#d "Tag(e)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MS-Cov-uhrzeit-zeitrahmen
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Example-MS-Cov-uhrzeit-zeitrahmen"
Description: "Abdeckung: Uhrzeiten mit Anwendungsdauer."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat.timeOfDay[+] = "08:00:00"
  * timing.repeat.timeOfDay[+] = "20:00:00"
  * timing.repeat.boundsDuration = 5 $ucum#d "Tag(e)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MR-Cov-uhrzeit-doseRange
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Cov-uhrzeit-doseRange"
Description: "Abdeckung: Uhrzeiten mit variable Einzeldosis."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.timeOfDay[+] = "08:00:00"
  * timing.repeat.timeOfDay[+] = "20:00:00"
  * doseAndRate.doseRange.low = 1 $kbv-dosiereinheit#1 "Stück"
  * doseAndRate.doseRange.high = 2 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MD-Cov-uhrzeit-doseRange
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Example-MD-Cov-uhrzeit-doseRange"
Description: "Abdeckung: Uhrzeiten mit variable Einzeldosis."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.timeOfDay[+] = "08:00:00"
  * timing.repeat.timeOfDay[+] = "20:00:00"
  * doseAndRate.doseRange.low = 1 $kbv-dosiereinheit#1 "Stück"
  * doseAndRate.doseRange.high = 2 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MS-Cov-uhrzeit-doseRange
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Example-MS-Cov-uhrzeit-doseRange"
Description: "Abdeckung: Uhrzeiten mit variable Einzeldosis."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat.timeOfDay[+] = "08:00:00"
  * timing.repeat.timeOfDay[+] = "20:00:00"
  * doseAndRate.doseRange.low = 1 $kbv-dosiereinheit#1 "Stück"
  * doseAndRate.doseRange.high = 2 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MR-Cov-uhrzeit-hinweis
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Cov-uhrzeit-hinweis"
Description: "Abdeckung: Uhrzeiten mit zusaetzlichem Hinweis."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.timeOfDay[+] = "08:00:00"
  * timing.repeat.timeOfDay[+] = "20:00:00"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * patientInstruction = "Nicht zerkauen"

Instance: Example-MD-Cov-uhrzeit-hinweis
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Example-MD-Cov-uhrzeit-hinweis"
Description: "Abdeckung: Uhrzeiten mit zusaetzlichem Hinweis."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.timeOfDay[+] = "08:00:00"
  * timing.repeat.timeOfDay[+] = "20:00:00"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * patientInstruction = "Nicht zerkauen"

Instance: Example-MS-Cov-uhrzeit-hinweis
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Example-MS-Cov-uhrzeit-hinweis"
Description: "Abdeckung: Uhrzeiten mit zusaetzlichem Hinweis."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat.timeOfDay[+] = "08:00:00"
  * timing.repeat.timeOfDay[+] = "20:00:00"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * patientInstruction = "Nicht zerkauen"

Instance: Example-MR-Cov-uhrzeit-bedarf
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Cov-uhrzeit-bedarf"
Description: "Abdeckung: Uhrzeiten mit Bedarfskennzeichen."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * asNeededBoolean = true
  * timing.repeat.timeOfDay[+] = "08:00:00"
  * timing.repeat.timeOfDay[+] = "20:00:00"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MD-Cov-uhrzeit-bedarf
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Example-MD-Cov-uhrzeit-bedarf"
Description: "Abdeckung: Uhrzeiten mit Bedarfskennzeichen."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * asNeededBoolean = true
  * timing.repeat.timeOfDay[+] = "08:00:00"
  * timing.repeat.timeOfDay[+] = "20:00:00"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MS-Cov-uhrzeit-bedarf
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Example-MS-Cov-uhrzeit-bedarf"
Description: "Abdeckung: Uhrzeiten mit Bedarfskennzeichen."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * asNeededBoolean = true
  * timing.repeat.timeOfDay[+] = "08:00:00"
  * timing.repeat.timeOfDay[+] = "20:00:00"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MD-Cov-wochentag-zeitrahmen
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Example-MD-Cov-wochentag-zeitrahmen"
Description: "Abdeckung: Wochentage mit Anwendungsdauer."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.dayOfWeek[+] = #mon
  * timing.repeat.dayOfWeek[+] = #fri
  * timing.repeat.boundsDuration = 5 $ucum#d "Tag(e)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MS-Cov-wochentag-zeitrahmen
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Example-MS-Cov-wochentag-zeitrahmen"
Description: "Abdeckung: Wochentage mit Anwendungsdauer."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat.dayOfWeek[+] = #mon
  * timing.repeat.dayOfWeek[+] = #fri
  * timing.repeat.boundsDuration = 5 $ucum#d "Tag(e)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MR-Cov-wochentag-doseRange
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Cov-wochentag-doseRange"
Description: "Abdeckung: Wochentage mit variable Einzeldosis."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.dayOfWeek[+] = #mon
  * timing.repeat.dayOfWeek[+] = #fri
  * doseAndRate.doseRange.low = 1 $kbv-dosiereinheit#1 "Stück"
  * doseAndRate.doseRange.high = 2 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MD-Cov-wochentag-doseRange
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Example-MD-Cov-wochentag-doseRange"
Description: "Abdeckung: Wochentage mit variable Einzeldosis."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.dayOfWeek[+] = #mon
  * timing.repeat.dayOfWeek[+] = #fri
  * doseAndRate.doseRange.low = 1 $kbv-dosiereinheit#1 "Stück"
  * doseAndRate.doseRange.high = 2 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MS-Cov-wochentag-doseRange
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Example-MS-Cov-wochentag-doseRange"
Description: "Abdeckung: Wochentage mit variable Einzeldosis."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat.dayOfWeek[+] = #mon
  * timing.repeat.dayOfWeek[+] = #fri
  * doseAndRate.doseRange.low = 1 $kbv-dosiereinheit#1 "Stück"
  * doseAndRate.doseRange.high = 2 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MR-Cov-wochentag-hinweis
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Cov-wochentag-hinweis"
Description: "Abdeckung: Wochentage mit zusaetzlichem Hinweis."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.dayOfWeek[+] = #mon
  * timing.repeat.dayOfWeek[+] = #fri
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * patientInstruction = "Nicht zerkauen"

Instance: Example-MD-Cov-wochentag-hinweis
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Example-MD-Cov-wochentag-hinweis"
Description: "Abdeckung: Wochentage mit zusaetzlichem Hinweis."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.dayOfWeek[+] = #mon
  * timing.repeat.dayOfWeek[+] = #fri
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * patientInstruction = "Nicht zerkauen"

Instance: Example-MS-Cov-wochentag-hinweis
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Example-MS-Cov-wochentag-hinweis"
Description: "Abdeckung: Wochentage mit zusaetzlichem Hinweis."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat.dayOfWeek[+] = #mon
  * timing.repeat.dayOfWeek[+] = #fri
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * patientInstruction = "Nicht zerkauen"

Instance: Example-MR-Cov-wochentag-bedarf
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Cov-wochentag-bedarf"
Description: "Abdeckung: Wochentage mit Bedarfskennzeichen."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * asNeededBoolean = true
  * timing.repeat.dayOfWeek[+] = #mon
  * timing.repeat.dayOfWeek[+] = #fri
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MD-Cov-wochentag-bedarf
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Example-MD-Cov-wochentag-bedarf"
Description: "Abdeckung: Wochentage mit Bedarfskennzeichen."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * asNeededBoolean = true
  * timing.repeat.dayOfWeek[+] = #mon
  * timing.repeat.dayOfWeek[+] = #fri
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MS-Cov-wochentag-bedarf
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Example-MS-Cov-wochentag-bedarf"
Description: "Abdeckung: Wochentage mit Bedarfskennzeichen."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * asNeededBoolean = true
  * timing.repeat.dayOfWeek[+] = #mon
  * timing.repeat.dayOfWeek[+] = #fri
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MD-Cov-wochentagzeit-zeitrahmen
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Example-MD-Cov-wochentagzeit-zeitrahmen"
Description: "Abdeckung: Wochentag und Tagesabschnitte mit Anwendungsdauer."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.dayOfWeek[+] = #mon
  * timing.repeat.when[+] = #MORN
  * timing.repeat.when[+] = #EVE
  * timing.repeat.boundsDuration = 5 $ucum#d "Tag(e)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MS-Cov-wochentagzeit-zeitrahmen
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Example-MS-Cov-wochentagzeit-zeitrahmen"
Description: "Abdeckung: Wochentag und Tagesabschnitte mit Anwendungsdauer."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat.dayOfWeek[+] = #mon
  * timing.repeat.when[+] = #MORN
  * timing.repeat.when[+] = #EVE
  * timing.repeat.boundsDuration = 5 $ucum#d "Tag(e)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MD-Cov-wochentagzeit-doseRange
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Example-MD-Cov-wochentagzeit-doseRange"
Description: "Abdeckung: Wochentag und Tagesabschnitte mit variable Einzeldosis."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.dayOfWeek[+] = #mon
  * timing.repeat.when[+] = #MORN
  * timing.repeat.when[+] = #EVE
  * doseAndRate.doseRange.low = 1 $kbv-dosiereinheit#1 "Stück"
  * doseAndRate.doseRange.high = 2 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MS-Cov-wochentagzeit-doseRange
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Example-MS-Cov-wochentagzeit-doseRange"
Description: "Abdeckung: Wochentag und Tagesabschnitte mit variable Einzeldosis."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat.dayOfWeek[+] = #mon
  * timing.repeat.when[+] = #MORN
  * timing.repeat.when[+] = #EVE
  * doseAndRate.doseRange.low = 1 $kbv-dosiereinheit#1 "Stück"
  * doseAndRate.doseRange.high = 2 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MR-Cov-wochentagzeit-hinweis
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Cov-wochentagzeit-hinweis"
Description: "Abdeckung: Wochentag und Tagesabschnitte mit zusaetzlichem Hinweis."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.dayOfWeek[+] = #mon
  * timing.repeat.when[+] = #MORN
  * timing.repeat.when[+] = #EVE
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * patientInstruction = "Nicht zerkauen"

Instance: Example-MD-Cov-wochentagzeit-hinweis
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Example-MD-Cov-wochentagzeit-hinweis"
Description: "Abdeckung: Wochentag und Tagesabschnitte mit zusaetzlichem Hinweis."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.dayOfWeek[+] = #mon
  * timing.repeat.when[+] = #MORN
  * timing.repeat.when[+] = #EVE
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * patientInstruction = "Nicht zerkauen"

Instance: Example-MS-Cov-wochentagzeit-hinweis
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Example-MS-Cov-wochentagzeit-hinweis"
Description: "Abdeckung: Wochentag und Tagesabschnitte mit zusaetzlichem Hinweis."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat.dayOfWeek[+] = #mon
  * timing.repeat.when[+] = #MORN
  * timing.repeat.when[+] = #EVE
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * patientInstruction = "Nicht zerkauen"

Instance: Example-MR-Cov-wochentagzeit-bedarf
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Cov-wochentagzeit-bedarf"
Description: "Abdeckung: Wochentag und Tagesabschnitte mit Bedarfskennzeichen."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * asNeededBoolean = true
  * timing.repeat.dayOfWeek[+] = #mon
  * timing.repeat.when[+] = #MORN
  * timing.repeat.when[+] = #EVE
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MD-Cov-wochentagzeit-bedarf
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Example-MD-Cov-wochentagzeit-bedarf"
Description: "Abdeckung: Wochentag und Tagesabschnitte mit Bedarfskennzeichen."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * asNeededBoolean = true
  * timing.repeat.dayOfWeek[+] = #mon
  * timing.repeat.when[+] = #MORN
  * timing.repeat.when[+] = #EVE
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MS-Cov-wochentagzeit-bedarf
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Example-MS-Cov-wochentagzeit-bedarf"
Description: "Abdeckung: Wochentag und Tagesabschnitte mit Bedarfskennzeichen."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * asNeededBoolean = true
  * timing.repeat.dayOfWeek[+] = #mon
  * timing.repeat.when[+] = #MORN
  * timing.repeat.when[+] = #EVE
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MD-Cov-intervall-zeitrahmen
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Example-MD-Cov-intervall-zeitrahmen"
Description: "Abdeckung: Intervall mit Anwendungsdauer."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.frequency = 1
  * timing.repeat.period = 8
  * timing.repeat.periodUnit = #h
  * timing.repeat.boundsDuration = 5 $ucum#d "Tag(e)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MS-Cov-intervall-zeitrahmen
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Example-MS-Cov-intervall-zeitrahmen"
Description: "Abdeckung: Intervall mit Anwendungsdauer."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat.frequency = 1
  * timing.repeat.period = 8
  * timing.repeat.periodUnit = #h
  * timing.repeat.boundsDuration = 5 $ucum#d "Tag(e)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MD-Cov-intervall-doseRange
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Example-MD-Cov-intervall-doseRange"
Description: "Abdeckung: Intervall mit variable Einzeldosis."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.frequency = 1
  * timing.repeat.period = 8
  * timing.repeat.periodUnit = #h
  * doseAndRate.doseRange.low = 1 $kbv-dosiereinheit#1 "Stück"
  * doseAndRate.doseRange.high = 2 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MS-Cov-intervall-doseRange
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Example-MS-Cov-intervall-doseRange"
Description: "Abdeckung: Intervall mit variable Einzeldosis."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat.frequency = 1
  * timing.repeat.period = 8
  * timing.repeat.periodUnit = #h
  * doseAndRate.doseRange.low = 1 $kbv-dosiereinheit#1 "Stück"
  * doseAndRate.doseRange.high = 2 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MR-Cov-intervall-hinweis
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Cov-intervall-hinweis"
Description: "Abdeckung: Intervall mit zusaetzlichem Hinweis."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.frequency = 1
  * timing.repeat.period = 8
  * timing.repeat.periodUnit = #h
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * patientInstruction = "Nicht zerkauen"

Instance: Example-MD-Cov-intervall-hinweis
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Example-MD-Cov-intervall-hinweis"
Description: "Abdeckung: Intervall mit zusaetzlichem Hinweis."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.frequency = 1
  * timing.repeat.period = 8
  * timing.repeat.periodUnit = #h
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * patientInstruction = "Nicht zerkauen"

Instance: Example-MS-Cov-intervall-hinweis
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Example-MS-Cov-intervall-hinweis"
Description: "Abdeckung: Intervall mit zusaetzlichem Hinweis."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat.frequency = 1
  * timing.repeat.period = 8
  * timing.repeat.periodUnit = #h
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * patientInstruction = "Nicht zerkauen"

Instance: Example-MD-Cov-intervall-bedarf
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Example-MD-Cov-intervall-bedarf"
Description: "Abdeckung: Intervall mit Bedarfskennzeichen."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * asNeededBoolean = true
  * timing.repeat.frequency = 1
  * timing.repeat.period = 8
  * timing.repeat.periodUnit = #h
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MS-Cov-intervall-bedarf
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Example-MS-Cov-intervall-bedarf"
Description: "Abdeckung: Intervall mit Bedarfskennzeichen."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * asNeededBoolean = true
  * timing.repeat.frequency = 1
  * timing.repeat.period = 8
  * timing.repeat.periodUnit = #h
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MR-Cov-intervallzeit-zeitrahmen
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Cov-intervallzeit-zeitrahmen"
Description: "Abdeckung: Intervall mit Tagesabschnitt mit Anwendungsdauer."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.period = 2
  * timing.repeat.periodUnit = #d
  * timing.repeat.when[+] = #MORN
  * timing.repeat.boundsDuration = 5 $ucum#d "Tag(e)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MD-Cov-intervallzeit-zeitrahmen
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Example-MD-Cov-intervallzeit-zeitrahmen"
Description: "Abdeckung: Intervall mit Tagesabschnitt mit Anwendungsdauer."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.period = 2
  * timing.repeat.periodUnit = #d
  * timing.repeat.when[+] = #MORN
  * timing.repeat.boundsDuration = 5 $ucum#d "Tag(e)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MS-Cov-intervallzeit-zeitrahmen
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Example-MS-Cov-intervallzeit-zeitrahmen"
Description: "Abdeckung: Intervall mit Tagesabschnitt mit Anwendungsdauer."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat.period = 2
  * timing.repeat.periodUnit = #d
  * timing.repeat.when[+] = #MORN
  * timing.repeat.boundsDuration = 5 $ucum#d "Tag(e)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MR-Cov-intervallzeit-doseRange
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Cov-intervallzeit-doseRange"
Description: "Abdeckung: Intervall mit Tagesabschnitt mit variable Einzeldosis."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.period = 2
  * timing.repeat.periodUnit = #d
  * timing.repeat.when[+] = #MORN
  * doseAndRate.doseRange.low = 1 $kbv-dosiereinheit#1 "Stück"
  * doseAndRate.doseRange.high = 2 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MD-Cov-intervallzeit-doseRange
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Example-MD-Cov-intervallzeit-doseRange"
Description: "Abdeckung: Intervall mit Tagesabschnitt mit variable Einzeldosis."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.period = 2
  * timing.repeat.periodUnit = #d
  * timing.repeat.when[+] = #MORN
  * doseAndRate.doseRange.low = 1 $kbv-dosiereinheit#1 "Stück"
  * doseAndRate.doseRange.high = 2 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MS-Cov-intervallzeit-doseRange
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Example-MS-Cov-intervallzeit-doseRange"
Description: "Abdeckung: Intervall mit Tagesabschnitt mit variable Einzeldosis."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat.period = 2
  * timing.repeat.periodUnit = #d
  * timing.repeat.when[+] = #MORN
  * doseAndRate.doseRange.low = 1 $kbv-dosiereinheit#1 "Stück"
  * doseAndRate.doseRange.high = 2 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MR-Cov-intervallzeit-hinweis
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Cov-intervallzeit-hinweis"
Description: "Abdeckung: Intervall mit Tagesabschnitt mit zusaetzlichem Hinweis."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.period = 2
  * timing.repeat.periodUnit = #d
  * timing.repeat.when[+] = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * patientInstruction = "Nicht zerkauen"

Instance: Example-MD-Cov-intervallzeit-hinweis
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Example-MD-Cov-intervallzeit-hinweis"
Description: "Abdeckung: Intervall mit Tagesabschnitt mit zusaetzlichem Hinweis."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.period = 2
  * timing.repeat.periodUnit = #d
  * timing.repeat.when[+] = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * patientInstruction = "Nicht zerkauen"

Instance: Example-MS-Cov-intervallzeit-hinweis
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Example-MS-Cov-intervallzeit-hinweis"
Description: "Abdeckung: Intervall mit Tagesabschnitt mit zusaetzlichem Hinweis."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat.period = 2
  * timing.repeat.periodUnit = #d
  * timing.repeat.when[+] = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * patientInstruction = "Nicht zerkauen"

Instance: Example-MR-Cov-intervallzeit-bedarf
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Cov-intervallzeit-bedarf"
Description: "Abdeckung: Intervall mit Tagesabschnitt mit Bedarfskennzeichen."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * asNeededBoolean = true
  * timing.repeat.period = 2
  * timing.repeat.periodUnit = #d
  * timing.repeat.when[+] = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MD-Cov-intervallzeit-bedarf
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Example-MD-Cov-intervallzeit-bedarf"
Description: "Abdeckung: Intervall mit Tagesabschnitt mit Bedarfskennzeichen."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * asNeededBoolean = true
  * timing.repeat.period = 2
  * timing.repeat.periodUnit = #d
  * timing.repeat.when[+] = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MS-Cov-intervallzeit-bedarf
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Example-MS-Cov-intervallzeit-bedarf"
Description: "Abdeckung: Intervall mit Tagesabschnitt mit Bedarfskennzeichen."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * asNeededBoolean = true
  * timing.repeat.period = 2
  * timing.repeat.periodUnit = #d
  * timing.repeat.when[+] = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MR-Cov-bedarf-doseRange
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Cov-bedarf-doseRange"
Description: "Abdeckung: reine Bedarfsmedikation mit variable Einzeldosis."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * asNeededBoolean = true
  * doseAndRate.doseRange.low = 1 $kbv-dosiereinheit#1 "Stück"
  * doseAndRate.doseRange.high = 2 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MD-Cov-bedarf-doseRange
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Example-MD-Cov-bedarf-doseRange"
Description: "Abdeckung: reine Bedarfsmedikation mit variable Einzeldosis."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * asNeededBoolean = true
  * doseAndRate.doseRange.low = 1 $kbv-dosiereinheit#1 "Stück"
  * doseAndRate.doseRange.high = 2 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MS-Cov-bedarf-doseRange
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Example-MS-Cov-bedarf-doseRange"
Description: "Abdeckung: reine Bedarfsmedikation mit variable Einzeldosis."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * asNeededBoolean = true
  * doseAndRate.doseRange.low = 1 $kbv-dosiereinheit#1 "Stück"
  * doseAndRate.doseRange.high = 2 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MR-Cov-bedarf-hinweis
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Cov-bedarf-hinweis"
Description: "Abdeckung: reine Bedarfsmedikation mit zusaetzlichem Hinweis."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * asNeededBoolean = true
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * patientInstruction = "Nicht zerkauen"

Instance: Example-MD-Cov-bedarf-hinweis
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Example-MD-Cov-bedarf-hinweis"
Description: "Abdeckung: reine Bedarfsmedikation mit zusaetzlichem Hinweis."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * asNeededBoolean = true
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * patientInstruction = "Nicht zerkauen"

Instance: Example-MS-Cov-bedarf-hinweis
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Example-MS-Cov-bedarf-hinweis"
Description: "Abdeckung: reine Bedarfsmedikation mit zusaetzlichem Hinweis."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * asNeededBoolean = true
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * patientInstruction = "Nicht zerkauen"
