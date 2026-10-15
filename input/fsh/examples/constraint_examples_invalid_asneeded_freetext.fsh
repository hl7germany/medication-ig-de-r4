// Mindestabstand und Maximalmenge an einer Freitext-Dosierung: Der Freitext
// wird unveraendert uebernommen, die Angabe koennte nie im Text erscheinen.

Instance: INV-C-MinimumIntervalOnlyPureAsNeeded-MR-04-of-04
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid Dosage"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for invalid Permutations"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * text = "Bei Kopfschmerzen 1 Stück"
  * asNeededBoolean = true
  * modifierExtension[minimumIntervalBetweenAdministrations].valueDuration = 4 $ucum#h "Stunde(n)"

Instance: INV-C-MaxDoseOnlyPureAsNeeded-MR-05-of-05
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid Dosage"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for invalid Permutations"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * text = "Bei Kopfschmerzen 1 Stück"
  * asNeededBoolean = true
  * maxDosePerPeriod.numerator = 6 $kbv-dosiereinheit#1 "Stück"
  * maxDosePerPeriod.denominator = 1 $ucum#d "Tag(e)"
