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
  * extension[asNeededFor].valueCodeableConcept.text = "Kopfschmerzen"
  * extension[mindestabstandZwischenGaben].valueDuration = 4 $ucum#h "Stunde(n)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * maxDosePerPeriod.numerator.value = 6
  * maxDosePerPeriod.numerator.system = $kbv-dosiereinheit
  * maxDosePerPeriod.numerator.code = #1
  * maxDosePerPeriod.numerator.unit = "Stück"
  * maxDosePerPeriod.denominator.value = 24
  * maxDosePerPeriod.denominator.system = $ucum
  * maxDosePerPeriod.denominator.code = #h
  * maxDosePerPeriod.denominator.unit = "Stunde(n)"
