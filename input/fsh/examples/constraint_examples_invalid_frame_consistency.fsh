// Invalid examples for the frame-consistency constraints in DosageDgMP.
// Die Textgenerierung liest Bedarfskennzeichen, Einnahmeanlass, Mindestabstand und
// Maximalmenge ausschließlich aus dem ersten Dosage-Element. Weichen weitere Elemente
// ab, entfiele die Angabe unbemerkt — diese Beispiele decken die Prüfung dagegen ab.
// Coverage target: Request, Dispense, Statement for each constraint

// ---------------------------------------------------------------------------
// AsNeededIdentical
// ---------------------------------------------------------------------------

Instance: INV-C-AsNeededIdentical-Request-01-of-03
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid: asNeededBoolean differs between dosages"
Description: "CAVE: Validation example - nur das erste Dosage-Element ist als Bedarfsmedikation gekennzeichnet; das zweite nicht."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * asNeededBoolean = true
  * timing.repeat.when = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosageInstruction[+]
  * timing.repeat.when = #EVE
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-AsNeededIdentical-Dispense-02-of-03
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid: asNeededBoolean differs between dosages"
Description: "CAVE: Validation example - nur das erste Dosage-Element ist als Bedarfsmedikation gekennzeichnet; das zweite nicht."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * asNeededBoolean = true
  * timing.repeat.when = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosageInstruction[+]
  * timing.repeat.when = #EVE
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-AsNeededIdentical-Statement-03-of-03
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid: asNeededBoolean differs between dosages"
Description: "CAVE: Validation example - nur das erste Dosage-Element ist als Bedarfsmedikation gekennzeichnet; das zweite nicht."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * asNeededBoolean = true
  * timing.repeat.when = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosage[+]
  * timing.repeat.when = #EVE
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

// ---------------------------------------------------------------------------
// AsNeededForIdentical
// ---------------------------------------------------------------------------

Instance: INV-C-AsNeededForIdentical-Request-01-of-03
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid: asNeededFor differs between dosages"
Description: "CAVE: Validation example - der Einnahmeanlass ist nur im ersten Dosage-Element angegeben und ginge im erzeugten Text verloren."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * asNeededBoolean = true
  * extension[asNeededFor].valueCodeableConcept.text = "Kopfschmerzen"
  * timing.repeat.when = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosageInstruction[+]
  * asNeededBoolean = true
  * timing.repeat.when = #EVE
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-AsNeededForIdentical-Dispense-02-of-03
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid: asNeededFor differs between dosages"
Description: "CAVE: Validation example - der Einnahmeanlass ist nur im ersten Dosage-Element angegeben und ginge im erzeugten Text verloren."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * asNeededBoolean = true
  * extension[asNeededFor].valueCodeableConcept.text = "Kopfschmerzen"
  * timing.repeat.when = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosageInstruction[+]
  * asNeededBoolean = true
  * timing.repeat.when = #EVE
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-AsNeededForIdentical-Statement-03-of-03
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid: asNeededFor differs between dosages"
Description: "CAVE: Validation example - der Einnahmeanlass ist nur im ersten Dosage-Element angegeben und ginge im erzeugten Text verloren."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * asNeededBoolean = true
  * extension[asNeededFor].valueCodeableConcept.text = "Kopfschmerzen"
  * timing.repeat.when = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosage[+]
  * asNeededBoolean = true
  * timing.repeat.when = #EVE
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

// ---------------------------------------------------------------------------
// MindestabstandIdentical
// ---------------------------------------------------------------------------

Instance: INV-C-MindestabstandIdentical-Request-01-of-03
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid: Mindestabstand differs between dosages"
Description: "CAVE: Validation example - der Mindestabstand zwischen Gaben ist nur im ersten Dosage-Element angegeben."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * asNeededBoolean = true
  * modifierExtension[minimumIntervalBetweenAdministrations].valueDuration = 4 $ucum#h "Stunde(n)"
  * timing.repeat.when = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosageInstruction[+]
  * asNeededBoolean = true
  * timing.repeat.when = #EVE
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-MindestabstandIdentical-Dispense-02-of-03
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid: Mindestabstand differs between dosages"
Description: "CAVE: Validation example - der Mindestabstand zwischen Gaben ist nur im ersten Dosage-Element angegeben."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * asNeededBoolean = true
  * modifierExtension[minimumIntervalBetweenAdministrations].valueDuration = 4 $ucum#h "Stunde(n)"
  * timing.repeat.when = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosageInstruction[+]
  * asNeededBoolean = true
  * timing.repeat.when = #EVE
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-MindestabstandIdentical-Statement-03-of-03
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid: Mindestabstand differs between dosages"
Description: "CAVE: Validation example - der Mindestabstand zwischen Gaben ist nur im ersten Dosage-Element angegeben."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * asNeededBoolean = true
  * modifierExtension[minimumIntervalBetweenAdministrations].valueDuration = 4 $ucum#h "Stunde(n)"
  * timing.repeat.when = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosage[+]
  * asNeededBoolean = true
  * timing.repeat.when = #EVE
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

// ---------------------------------------------------------------------------
// MindestabstandUnitMatchesCode
// ---------------------------------------------------------------------------

Instance: INV-C-MindestabstandUnitMatchesCode-Request-01-of-03
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid: Mindestabstand unit does not match code"
Description: "CAVE: Validation example - valueDuration.code ist 'h', die Anzeigeeinheit lautet aber 'Tag(e)'."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * asNeededBoolean = true
  * modifierExtension[minimumIntervalBetweenAdministrations].valueDuration = 4 $ucum#h "Tag(e)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-MindestabstandUnitMatchesCode-Dispense-02-of-03
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid: Mindestabstand unit does not match code"
Description: "CAVE: Validation example - valueDuration.code ist 'h', die Anzeigeeinheit lautet aber 'Tag(e)'."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * asNeededBoolean = true
  * modifierExtension[minimumIntervalBetweenAdministrations].valueDuration = 4 $ucum#h "Tag(e)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

Instance: INV-C-MindestabstandUnitMatchesCode-Statement-03-of-03
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid: Mindestabstand unit does not match code"
Description: "CAVE: Validation example - valueDuration.code ist 'h', die Anzeigeeinheit lautet aber 'Tag(e)'."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * asNeededBoolean = true
  * modifierExtension[minimumIntervalBetweenAdministrations].valueDuration = 4 $ucum#h "Tag(e)"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

// ---------------------------------------------------------------------------
// MaxDosePerPeriodIdentical
// ---------------------------------------------------------------------------

Instance: INV-C-MaxDosePerPeriodIdentical-Request-01-of-03
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid: maxDosePerPeriod differs between dosages"
Description: "CAVE: Validation example - die Maximalmenge gilt für die Gesamtmenge im Bezugszeitraum, ist hier aber je Dosage-Element unterschiedlich angegeben."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * asNeededBoolean = true
  * timing.repeat.when = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * maxDosePerPeriod.numerator.value = 6
  * maxDosePerPeriod.numerator.system = $kbv-dosiereinheit
  * maxDosePerPeriod.numerator.code = #1
  * maxDosePerPeriod.numerator.unit = "Stück"
  * maxDosePerPeriod.denominator.value = 24
  * maxDosePerPeriod.denominator.system = $ucum
  * maxDosePerPeriod.denominator.code = #h
  * maxDosePerPeriod.denominator.unit = "Stunde(n)"
* dosageInstruction[+]
  * asNeededBoolean = true
  * timing.repeat.when = #EVE
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"
  * maxDosePerPeriod.numerator.value = 8
  * maxDosePerPeriod.numerator.system = $kbv-dosiereinheit
  * maxDosePerPeriod.numerator.code = #1
  * maxDosePerPeriod.numerator.unit = "Stück"
  * maxDosePerPeriod.denominator.value = 24
  * maxDosePerPeriod.denominator.system = $ucum
  * maxDosePerPeriod.denominator.code = #h
  * maxDosePerPeriod.denominator.unit = "Stunde(n)"

Instance: INV-C-MaxDosePerPeriodIdentical-Dispense-02-of-03
InstanceOf: MedicationDispenseDgMP
Usage: #example
Title: "Invalid: maxDosePerPeriod differs between dosages"
Description: "CAVE: Validation example - die Maximalmenge gilt für die Gesamtmenge im Bezugszeitraum, ist hier aber je Dosage-Element unterschiedlich angegeben."
* subject.display = "Patient"
* status = #completed
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * asNeededBoolean = true
  * timing.repeat.when = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * maxDosePerPeriod.numerator.value = 6
  * maxDosePerPeriod.numerator.system = $kbv-dosiereinheit
  * maxDosePerPeriod.numerator.code = #1
  * maxDosePerPeriod.numerator.unit = "Stück"
  * maxDosePerPeriod.denominator.value = 24
  * maxDosePerPeriod.denominator.system = $ucum
  * maxDosePerPeriod.denominator.code = #h
  * maxDosePerPeriod.denominator.unit = "Stunde(n)"
* dosageInstruction[+]
  * asNeededBoolean = true
  * timing.repeat.when = #EVE
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"
  * maxDosePerPeriod.numerator.value = 8
  * maxDosePerPeriod.numerator.system = $kbv-dosiereinheit
  * maxDosePerPeriod.numerator.code = #1
  * maxDosePerPeriod.numerator.unit = "Stück"
  * maxDosePerPeriod.denominator.value = 24
  * maxDosePerPeriod.denominator.system = $ucum
  * maxDosePerPeriod.denominator.code = #h
  * maxDosePerPeriod.denominator.unit = "Stunde(n)"

Instance: INV-C-MaxDosePerPeriodIdentical-Statement-03-of-03
InstanceOf: MedicationStatementDgMP
Usage: #example
Title: "Invalid: maxDosePerPeriod differs between dosages"
Description: "CAVE: Validation example - die Maximalmenge gilt für die Gesamtmenge im Bezugszeitraum, ist hier aber je Dosage-Element unterschiedlich angegeben."
* subject.display = "Patient"
* status = #active
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosage[+]
  * asNeededBoolean = true
  * timing.repeat.when = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
  * maxDosePerPeriod.numerator.value = 6
  * maxDosePerPeriod.numerator.system = $kbv-dosiereinheit
  * maxDosePerPeriod.numerator.code = #1
  * maxDosePerPeriod.numerator.unit = "Stück"
  * maxDosePerPeriod.denominator.value = 24
  * maxDosePerPeriod.denominator.system = $ucum
  * maxDosePerPeriod.denominator.code = #h
  * maxDosePerPeriod.denominator.unit = "Stunde(n)"
* dosage[+]
  * asNeededBoolean = true
  * timing.repeat.when = #EVE
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"
  * maxDosePerPeriod.numerator.value = 8
  * maxDosePerPeriod.numerator.system = $kbv-dosiereinheit
  * maxDosePerPeriod.numerator.code = #1
  * maxDosePerPeriod.numerator.unit = "Stück"
  * maxDosePerPeriod.denominator.value = 24
  * maxDosePerPeriod.denominator.system = $ucum
  * maxDosePerPeriod.denominator.code = #h
  * maxDosePerPeriod.denominator.unit = "Stunde(n)"
