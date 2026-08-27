// B4 — Bedarfsmedikation kombiniert mit 4-Schema
// Erwarteter generierter Text: "Bei Bedarf: 1-0-2-0 Stück"
Instance: Example-MR-Dosage-asneeded-b4-4schema
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Dosage-asneeded-b4-4schema"
Description: "Bedarfsmedikation (asNeededBoolean=true) mit 4-Schema: morgens 1 Stück, abends 2 Stück – kein maxDosePerPeriod."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * asNeededBoolean = true
  * timing.repeat
    * when[+] = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosageInstruction[+]
  * asNeededBoolean = true
  * timing.repeat
    * when[+] = #EVE
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

// B5 — Bedarfsmedikation kombiniert mit Uhrzeiten-Schema und maxDosePerPeriod (Nenner 1 d)
// Erwarteter generierter Text:
// "Bei Bedarf: täglich 08:00 Uhr — je 1 Stück, 20:00 Uhr — je 2 Stück — nicht mehr als 6 Stück pro Tag"
Instance: Example-MR-Dosage-asneeded-b5-timeofday-maxdose-1d
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Dosage-asneeded-b5-timeofday-maxdose-1d"
Description: "Bedarfsmedikation (asNeededBoolean=true) mit Uhrzeiten-Schema (08:00 Uhr 1 Stück, 20:00 Uhr 2 Stück) und maxDosePerPeriod mit Nenner 1 d (pro Tag)."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * asNeededBoolean = true
  * timing.repeat
    * timeOfDay[+] = "08:00:00"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * maxDosePerPeriod.numerator.value = 6
  * maxDosePerPeriod.numerator.system = $kbv-dosiereinheit
  * maxDosePerPeriod.numerator.code = #1
  * maxDosePerPeriod.numerator.unit = "Stück"
  * maxDosePerPeriod.denominator.value = 1
  * maxDosePerPeriod.denominator.system = $ucum
  * maxDosePerPeriod.denominator.code = #d
  * maxDosePerPeriod.denominator.unit = "Tag(e)"
* dosageInstruction[+]
  * asNeededBoolean = true
  * timing.repeat
    * timeOfDay[+] = "20:00:00"
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"
  * maxDosePerPeriod.numerator.value = 6
  * maxDosePerPeriod.numerator.system = $kbv-dosiereinheit
  * maxDosePerPeriod.numerator.code = #1
  * maxDosePerPeriod.numerator.unit = "Stück"
  * maxDosePerPeriod.denominator.value = 1
  * maxDosePerPeriod.denominator.system = $ucum
  * maxDosePerPeriod.denominator.code = #d
  * maxDosePerPeriod.denominator.unit = "Tag(e)"

// B7 — Reine Bedarfsdosierung mit maxDosePerPeriod Nenner 1 d
// Erwarteter generierter Text: "Bei Bedarf: je 1 Stück — nicht mehr als 6 Stück pro Tag"
Instance: Example-MR-Dosage-asneeded-b7-maxdose-1d
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Dosage-asneeded-b7-maxdose-1d"
Description: "Reine Bedarfsdosierung (asNeededBoolean=true, kein timing) mit maxDosePerPeriod: Nenner 1 d statt 24 h – zeigt die 'pro Tag'-Formulierung."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * asNeededBoolean = true
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * maxDosePerPeriod.numerator.value = 6
  * maxDosePerPeriod.numerator.system = $kbv-dosiereinheit
  * maxDosePerPeriod.numerator.code = #1
  * maxDosePerPeriod.numerator.unit = "Stück"
  * maxDosePerPeriod.denominator.value = 1
  * maxDosePerPeriod.denominator.system = $ucum
  * maxDosePerPeriod.denominator.code = #d
  * maxDosePerPeriod.denominator.unit = "Tag(e)"
