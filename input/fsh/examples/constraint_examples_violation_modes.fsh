// ---------------------------------------------------------------------------
// Negativbeispiele fuer bisher unbelegte Verstossarten bestehender Invarianten.
// ---------------------------------------------------------------------------

Instance: INV-min-C-MinimumIntervalUnitMatchesCode-MR
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid: Mindestabstand mit code=min und unzutreffender Anzeigeeinheit"
Description: "CAVE: Validation example - Mindestabstand mit code=min und unzutreffender Anzeigeeinheit."

* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * asNeededBoolean = true
  * modifierExtension[minimumIntervalBetweenAdministrations].valueDuration = 30 $ucum#min "Stunde(n)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-min-C-MinimumIntervalUnitMatchesCode-MD
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid: Mindestabstand mit code=min und unzutreffender Anzeigeeinheit"
Description: "CAVE: Validation example - Mindestabstand mit code=min und unzutreffender Anzeigeeinheit."

* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * asNeededBoolean = true
  * modifierExtension[minimumIntervalBetweenAdministrations].valueDuration = 30 $ucum#min "Stunde(n)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-min-C-MinimumIntervalUnitMatchesCode-MS
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid: Mindestabstand mit code=min und unzutreffender Anzeigeeinheit"
Description: "CAVE: Validation example - Mindestabstand mit code=min und unzutreffender Anzeigeeinheit."

* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * asNeededBoolean = true
  * modifierExtension[minimumIntervalBetweenAdministrations].valueDuration = 30 $ucum#min "Stunde(n)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-pmax-C-TimingPeriodOnlyWholeNumber-MR
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid: periodMax mit Nachkommastelle"
Description: "CAVE: Validation example - periodMax mit Nachkommastelle."

* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.frequency = 1
  * timing.repeat.period = 2
  * timing.repeat.periodMax = 3.5
  * timing.repeat.periodUnit = #h
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-pmax-C-TimingPeriodOnlyWholeNumber-MD
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid: periodMax mit Nachkommastelle"
Description: "CAVE: Validation example - periodMax mit Nachkommastelle."

* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.frequency = 1
  * timing.repeat.period = 2
  * timing.repeat.periodMax = 3.5
  * timing.repeat.periodUnit = #h
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-pmax-C-TimingPeriodOnlyWholeNumber-MS
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid: periodMax mit Nachkommastelle"
Description: "CAVE: Validation example - periodMax mit Nachkommastelle."

* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat.frequency = 1
  * timing.repeat.period = 2
  * timing.repeat.periodMax = 3.5
  * timing.repeat.periodUnit = #h
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-low-C-DosageDoseQuantityAllowedFractions-MR
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid: doseRange.low mit unzulaessigem Bruchteil"
Description: "CAVE: Validation example - doseRange.low mit unzulaessigem Bruchteil."

* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.when[+] = #MORN
  * doseAndRate.doseRange.low = 0.4 $kbv-dosiereinheit#1 "Stück"
  * doseAndRate.doseRange.high = 2 $kbv-dosiereinheit#1 "Stück"

Instance: INV-low-C-DosageDoseQuantityAllowedFractions-MD
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid: doseRange.low mit unzulaessigem Bruchteil"
Description: "CAVE: Validation example - doseRange.low mit unzulaessigem Bruchteil."

* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.when[+] = #MORN
  * doseAndRate.doseRange.low = 0.4 $kbv-dosiereinheit#1 "Stück"
  * doseAndRate.doseRange.high = 2 $kbv-dosiereinheit#1 "Stück"

Instance: INV-low-C-DosageDoseQuantityAllowedFractions-MS
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid: doseRange.low mit unzulaessigem Bruchteil"
Description: "CAVE: Validation example - doseRange.low mit unzulaessigem Bruchteil."

* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat.when[+] = #MORN
  * doseAndRate.doseRange.low = 0.4 $kbv-dosiereinheit#1 "Stück"
  * doseAndRate.doseRange.high = 2 $kbv-dosiereinheit#1 "Stück"

Instance: INV-high-C-DosageDoseQuantityAllowedFractions-MR
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid: doseRange.high mit unzulaessigem Bruchteil"
Description: "CAVE: Validation example - doseRange.high mit unzulaessigem Bruchteil."

* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.when[+] = #MORN
  * doseAndRate.doseRange.low = 1 $kbv-dosiereinheit#1 "Stück"
  * doseAndRate.doseRange.high = 2.4 $kbv-dosiereinheit#1 "Stück"

Instance: INV-high-C-DosageDoseQuantityAllowedFractions-MD
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid: doseRange.high mit unzulaessigem Bruchteil"
Description: "CAVE: Validation example - doseRange.high mit unzulaessigem Bruchteil."

* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.when[+] = #MORN
  * doseAndRate.doseRange.low = 1 $kbv-dosiereinheit#1 "Stück"
  * doseAndRate.doseRange.high = 2.4 $kbv-dosiereinheit#1 "Stück"

Instance: INV-high-C-DosageDoseQuantityAllowedFractions-MS
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid: doseRange.high mit unzulaessigem Bruchteil"
Description: "CAVE: Validation example - doseRange.high mit unzulaessigem Bruchteil."

* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat.when[+] = #MORN
  * doseAndRate.doseRange.low = 1 $kbv-dosiereinheit#1 "Stück"
  * doseAndRate.doseRange.high = 2.4 $kbv-dosiereinheit#1 "Stück"

Instance: INV-noan-C-MinimumIntervalOnlyPureAsNeeded-MR
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid: Mindestabstand ohne Bedarfskennzeichen"
Description: "CAVE: Validation example - Mindestabstand ohne Bedarfskennzeichen."

* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * modifierExtension[minimumIntervalBetweenAdministrations].valueDuration = 4 $ucum#h "Stunde(n)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-noan-C-MinimumIntervalOnlyPureAsNeeded-MD
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid: Mindestabstand ohne Bedarfskennzeichen"
Description: "CAVE: Validation example - Mindestabstand ohne Bedarfskennzeichen."

* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * modifierExtension[minimumIntervalBetweenAdministrations].valueDuration = 4 $ucum#h "Stunde(n)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-noan-C-MinimumIntervalOnlyPureAsNeeded-MS
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid: Mindestabstand ohne Bedarfskennzeichen"
Description: "CAVE: Validation example - Mindestabstand ohne Bedarfskennzeichen."

* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * modifierExtension[minimumIntervalBetweenAdministrations].valueDuration = 4 $ucum#h "Stunde(n)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-wk-C-MaxDosePerPeriodOnly24hOr1d-MR
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid: Maximalmenge mit Bezugszeitraum 1 wk"
Description: "CAVE: Validation example - Maximalmenge mit Bezugszeitraum 1 wk."

* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * asNeededBoolean = true
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * maxDosePerPeriod.numerator.value = 4
  * maxDosePerPeriod.numerator.system = $kbv-dosiereinheit
  * maxDosePerPeriod.numerator.code = #1
  * maxDosePerPeriod.numerator.unit = "Stück"
  * maxDosePerPeriod.denominator.value = 1
  * maxDosePerPeriod.denominator.system = $ucum
  * maxDosePerPeriod.denominator.code = #wk
  * maxDosePerPeriod.denominator.unit = "Woche(n)"

Instance: INV-wk-C-MaxDosePerPeriodOnly24hOr1d-MD
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid: Maximalmenge mit Bezugszeitraum 1 wk"
Description: "CAVE: Validation example - Maximalmenge mit Bezugszeitraum 1 wk."

* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * asNeededBoolean = true
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * maxDosePerPeriod.numerator.value = 4
  * maxDosePerPeriod.numerator.system = $kbv-dosiereinheit
  * maxDosePerPeriod.numerator.code = #1
  * maxDosePerPeriod.numerator.unit = "Stück"
  * maxDosePerPeriod.denominator.value = 1
  * maxDosePerPeriod.denominator.system = $ucum
  * maxDosePerPeriod.denominator.code = #wk
  * maxDosePerPeriod.denominator.unit = "Woche(n)"

Instance: INV-wk-C-MaxDosePerPeriodOnly24hOr1d-MS
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid: Maximalmenge mit Bezugszeitraum 1 wk"
Description: "CAVE: Validation example - Maximalmenge mit Bezugszeitraum 1 wk."

* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * asNeededBoolean = true
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * maxDosePerPeriod.numerator.value = 4
  * maxDosePerPeriod.numerator.system = $kbv-dosiereinheit
  * maxDosePerPeriod.numerator.code = #1
  * maxDosePerPeriod.numerator.unit = "Stück"
  * maxDosePerPeriod.denominator.value = 1
  * maxDosePerPeriod.denominator.system = $ucum
  * maxDosePerPeriod.denominator.code = #wk
  * maxDosePerPeriod.denominator.unit = "Woche(n)"

Instance: INV-diff-C-AsNeededIdentical-MR
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid: asNeededBoolean weicht zwischen den Dosage-Elementen ab"
Description: "CAVE: Validation example - asNeededBoolean weicht zwischen den Dosage-Elementen ab."

* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * asNeededBoolean = true
  * timing.repeat.when[+] = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosageInstruction[+]
  * asNeededBoolean = false
  * timing.repeat.when[+] = #EVE
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

Instance: INV-diff-C-AsNeededIdentical-MD
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid: asNeededBoolean weicht zwischen den Dosage-Elementen ab"
Description: "CAVE: Validation example - asNeededBoolean weicht zwischen den Dosage-Elementen ab."

* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * asNeededBoolean = true
  * timing.repeat.when[+] = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosageInstruction[+]
  * asNeededBoolean = false
  * timing.repeat.when[+] = #EVE
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

Instance: INV-diff-C-AsNeededIdentical-MS
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid: asNeededBoolean weicht zwischen den Dosage-Elementen ab"
Description: "CAVE: Validation example - asNeededBoolean weicht zwischen den Dosage-Elementen ab."

* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * asNeededBoolean = true
  * timing.repeat.when[+] = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosage[+]
  * asNeededBoolean = false
  * timing.repeat.when[+] = #EVE
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

Instance: INV-diff-C-AsNeededForIdentical-MR
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid: asNeededFor weicht zwischen den Dosage-Elementen ab"
Description: "CAVE: Validation example - asNeededFor weicht zwischen den Dosage-Elementen ab."

* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * asNeededBoolean = true
  * extension[asNeededFor].valueCodeableConcept.text = "Kopfschmerzen"
  * timing.repeat.when[+] = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosageInstruction[+]
  * asNeededBoolean = true
  * extension[asNeededFor].valueCodeableConcept.text = "Fieber"
  * timing.repeat.when[+] = #EVE
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

Instance: INV-diff-C-AsNeededForIdentical-MD
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid: asNeededFor weicht zwischen den Dosage-Elementen ab"
Description: "CAVE: Validation example - asNeededFor weicht zwischen den Dosage-Elementen ab."

* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * asNeededBoolean = true
  * extension[asNeededFor].valueCodeableConcept.text = "Kopfschmerzen"
  * timing.repeat.when[+] = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosageInstruction[+]
  * asNeededBoolean = true
  * extension[asNeededFor].valueCodeableConcept.text = "Fieber"
  * timing.repeat.when[+] = #EVE
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

Instance: INV-diff-C-AsNeededForIdentical-MS
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid: asNeededFor weicht zwischen den Dosage-Elementen ab"
Description: "CAVE: Validation example - asNeededFor weicht zwischen den Dosage-Elementen ab."

* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * asNeededBoolean = true
  * extension[asNeededFor].valueCodeableConcept.text = "Kopfschmerzen"
  * timing.repeat.when[+] = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosage[+]
  * asNeededBoolean = true
  * extension[asNeededFor].valueCodeableConcept.text = "Fieber"
  * timing.repeat.when[+] = #EVE
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

Instance: INV-miss-C-TimingOnlyOneBounds-MR
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid: Zeitrahmen nur in einem der Dosage-Elemente"
Description: "CAVE: Validation example - Zeitrahmen nur in einem der Dosage-Elemente."

* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.boundsDuration = 5 $ucum#d "Tag(e)"
  * timing.repeat.when[+] = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosageInstruction[+]
  * timing.repeat.when[+] = #EVE
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

Instance: INV-miss-C-TimingOnlyOneBounds-MD
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid: Zeitrahmen nur in einem der Dosage-Elemente"
Description: "CAVE: Validation example - Zeitrahmen nur in einem der Dosage-Elemente."

* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat.boundsDuration = 5 $ucum#d "Tag(e)"
  * timing.repeat.when[+] = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosageInstruction[+]
  * timing.repeat.when[+] = #EVE
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

Instance: INV-miss-C-TimingOnlyOneBounds-MS
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid: Zeitrahmen nur in einem der Dosage-Elemente"
Description: "CAVE: Validation example - Zeitrahmen nur in einem der Dosage-Elemente."

* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * timing.repeat.boundsDuration = 5 $ucum#d "Tag(e)"
  * timing.repeat.when[+] = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosage[+]
  * timing.repeat.when[+] = #EVE
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"
