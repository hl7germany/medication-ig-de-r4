Instance: Example-MR-Dosage-Bedarfsmedikation-Kopfschmerzen
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Dosage-Bedarfsmedikation-Kopfschmerzen"
Description: "Dieses Beispiel stellt eine Bedarfsmedikation mit Einnahmeanlass, Menge und Maximalgabe pro 6 Stunden dar."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * extension[asNeededFor].valueCodeableConcept.text = "Kopfschmerzen"
  * timing.repeat.frequency = 1
  * timing.repeat.period = 6
  * timing.repeat.periodUnit = #h
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * maxDosePerPeriod.numerator.value = 1
  * maxDosePerPeriod.numerator.system = $kbv-dosiereinheit
  * maxDosePerPeriod.numerator.code = #1
  * maxDosePerPeriod.numerator.unit = "Stück"
  * maxDosePerPeriod.denominator.value = 6
  * maxDosePerPeriod.denominator.system = $ucum
  * maxDosePerPeriod.denominator.code = #h
  * maxDosePerPeriod.denominator.unit = "Stunde(n)"
