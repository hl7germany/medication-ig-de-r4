Instance: Example-MR-Dosage-Bedarfsmedikation-Kopfschmerzen
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Dosage-Bedarfsmedikation-Kopfschmerzen"
Description: "Dieses Beispiel stellt eine Bedarfsmedikation mit Einnahmeanlass, Menge, Mindestabstand zwischen Gaben und Maximalgabe pro 24 Stunden dar."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * asNeededBoolean = true
  * extension[asNeededFor].valueCodeableConcept.text = "Kopfschmerzen"
  * modifierExtension[minimumIntervalBetweenAdministrations].valueDuration = 4 $ucum#h "Stunde(n)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * maxDosePerPeriod.numerator.value = 6
  * maxDosePerPeriod.numerator.system = $kbv-dosiereinheit
  * maxDosePerPeriod.numerator.code = #1
  * maxDosePerPeriod.numerator.unit = "Stück"
  * maxDosePerPeriod.denominator.value = 24
  * maxDosePerPeriod.denominator.system = $ucum
  * maxDosePerPeriod.denominator.code = #h
  * maxDosePerPeriod.denominator.unit = "Stunde(n)"

Instance: Example-MR-Dosage-Bedarfsmedikation-MehrereAnlaesse
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Dosage-Bedarfsmedikation-MehrereAnlaesse"
Description: "Bedarfsmedikation mit mehreren Einnahmeanlässen (asNeededFor 0..*). Die Anlässe sind fachlich ODER-verknüpft; im generierten Text werden sie als deutsche Aufzählung mit abschließendem \"oder\" dargestellt (z. B. \"Bei Kopfschmerzen, Fieber oder Gliederschmerzen: ...\")."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * asNeededBoolean = true
  * extension[asNeededFor][+].valueCodeableConcept.text = "Kopfschmerzen"
  * extension[asNeededFor][+].valueCodeableConcept.text = "Fieber"
  * extension[asNeededFor][+].valueCodeableConcept.text = "Gliederschmerzen"
  * modifierExtension[minimumIntervalBetweenAdministrations].valueDuration = 6 $ucum#h "Stunde(n)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * maxDosePerPeriod.numerator.value = 4
  * maxDosePerPeriod.numerator.system = $kbv-dosiereinheit
  * maxDosePerPeriod.numerator.code = #1
  * maxDosePerPeriod.numerator.unit = "Stück"
  * maxDosePerPeriod.denominator.value = 24
  * maxDosePerPeriod.denominator.system = $ucum
  * maxDosePerPeriod.denominator.code = #h
  * maxDosePerPeriod.denominator.unit = "Stunde(n)"

Instance: Example-MR-Dosage-Bedarfsmedikation-Struktur-Intervall
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Dosage-Bedarfsmedikation-Struktur-Intervall"
Description: "Strukturierte Bedarfsmedikation: ein Intervall-Dosierschema (alle 8 Stunden), das nur bei Bedarf angewendet wird. Die Bedarfsangabe kennzeichnet hier ein bestehendes strukturiertes Schema (timing ist befüllt). Weder ein Mindestabstand noch eine Maximalmenge sind hier zulaessig, weil der Rhythmus die Anwendung bereits vollstaendig festlegt."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * asNeededBoolean = true
  * extension[asNeededFor].valueCodeableConcept.text = "Kopfschmerzen"
  * timing.repeat.frequency = 1
  * timing.repeat.period = 8
  * timing.repeat.periodUnit = #h
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

// ---------------------------------------------------------------------------
// Reine Bedarfsmedikation fuer MedicationDispense und MedicationStatement.
// Dort liegt die Dosierung in dosage statt dosageInstruction; AsNeededSingleDosageOnly
// und MinimumIntervalOnlyPureAsNeeded werten die gesamte Ressource aus.
// ---------------------------------------------------------------------------

Instance: Example-MD-Dosage-Bedarfsmedikation-Kopfschmerzen
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Example-MD-Dosage-Bedarfsmedikation-Kopfschmerzen"
Description: "Reine Bedarfsmedikation mit Anlass, Mindestabstand und Maximalmenge."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * asNeededBoolean = true
  * extension[asNeededFor].valueCodeableConcept.text = "Kopfschmerzen"
  * modifierExtension[minimumIntervalBetweenAdministrations].valueDuration = 4 $ucum#h "Stunde(n)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * maxDosePerPeriod.numerator.value = 6
  * maxDosePerPeriod.numerator.system = $kbv-dosiereinheit
  * maxDosePerPeriod.numerator.code = #1
  * maxDosePerPeriod.numerator.unit = "Stück"
  * maxDosePerPeriod.denominator.value = 24
  * maxDosePerPeriod.denominator.system = $ucum
  * maxDosePerPeriod.denominator.code = #h
  * maxDosePerPeriod.denominator.unit = "Stunde(n)"

Instance: Example-MS-Dosage-Bedarfsmedikation-Kopfschmerzen
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Example-MS-Dosage-Bedarfsmedikation-Kopfschmerzen"
Description: "Reine Bedarfsmedikation mit Anlass, Mindestabstand und Maximalmenge."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * asNeededBoolean = true
  * extension[asNeededFor].valueCodeableConcept.text = "Kopfschmerzen"
  * modifierExtension[minimumIntervalBetweenAdministrations].valueDuration = 4 $ucum#h "Stunde(n)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * maxDosePerPeriod.numerator.value = 6
  * maxDosePerPeriod.numerator.system = $kbv-dosiereinheit
  * maxDosePerPeriod.numerator.code = #1
  * maxDosePerPeriod.numerator.unit = "Stück"
  * maxDosePerPeriod.denominator.value = 24
  * maxDosePerPeriod.denominator.system = $ucum
  * maxDosePerPeriod.denominator.code = #h
  * maxDosePerPeriod.denominator.unit = "Stunde(n)"

Instance: Example-MD-Dosage-Bedarfsmedikation-MehrereAnlaesse
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Example-MD-Dosage-Bedarfsmedikation-MehrereAnlaesse"
Description: "Reine Bedarfsmedikation mit mehreren Anlaessen; die Anlaesse sind fachlich ODER-verknuepft."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * asNeededBoolean = true
  * extension[asNeededFor][+].valueCodeableConcept.text = "Kopfschmerzen"
  * extension[asNeededFor][+].valueCodeableConcept.text = "Fieber"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MS-Dosage-Bedarfsmedikation-MehrereAnlaesse
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Example-MS-Dosage-Bedarfsmedikation-MehrereAnlaesse"
Description: "Reine Bedarfsmedikation mit mehreren Anlaessen; die Anlaesse sind fachlich ODER-verknuepft."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * asNeededBoolean = true
  * extension[asNeededFor][+].valueCodeableConcept.text = "Kopfschmerzen"
  * extension[asNeededFor][+].valueCodeableConcept.text = "Fieber"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MD-Dosage-Bedarfsmedikation-ohne-Anlass
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Example-MD-Dosage-Bedarfsmedikation-ohne-Anlass"
Description: "Reine Bedarfsmedikation ohne Anlass; der Text lautet generisch \"bei Bedarf\"."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * asNeededBoolean = true
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: Example-MS-Dosage-Bedarfsmedikation-ohne-Anlass
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Example-MS-Dosage-Bedarfsmedikation-ohne-Anlass"
Description: "Reine Bedarfsmedikation ohne Anlass; der Text lautet generisch \"bei Bedarf\"."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * asNeededBoolean = true
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
