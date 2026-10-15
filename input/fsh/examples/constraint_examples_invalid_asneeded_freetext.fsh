// Mindestabstand an einer Freitext-Dosierung: Der Freitext wird unveraendert
// uebernommen, die Angabe koennte nie im Text erscheinen. (Eine Maximalmenge an
// Freitext scheitert bereits an MaxDoseSameUnitAsDose; Testfall in
// tests/invariants/cases/as-needed-pure.json.)

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
