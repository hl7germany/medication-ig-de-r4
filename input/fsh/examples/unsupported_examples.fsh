Instance: MR-Unsupported-Dosage-01-of-20-Count
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Unsupported Dosage 1 Count"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for unsupported Fields"
* subject.display = "Unsupported Dosage Count"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Unsupported Dosage Count Medication"
* dosageInstruction[+] = Unsupported-Dosage-1-Count

Instance: Unsupported-Dosage-1-Count
InstanceOf: DosageDE
Usage: #inline
Title: "Unsupported: Count"
* text = "count"
* timing
  * repeat
    * count = 5
    * frequency = 1
    * period = 1
    * periodUnit = #d


Instance: MR-Unsupported-Dosage-02-of-20-asNeededBoolean
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Unsupported Dosage 1 asNeededBoolean"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for unsupported Fields"
* subject.display = "Unsupported Dosage asNeededBoolean"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Unsupported Dosage asNeededBoolean Medication"
* dosageInstruction[+] = Unsupported-Dosage-2-asNeededBoolean

Instance: Unsupported-Dosage-2-asNeededBoolean
InstanceOf: DosageDE
Usage: #inline
Title: "Unsupported: asNeededBoolean"
* text = "asNeededBoolean"
* asNeededBoolean = true

Instance: MR-Unsupported-Dosage-03-of-20-asNeededCodeableConcept
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Unsupported Dosage 1 asNeededCodeableConcept"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for unsupported Fields"
* subject.display = "Unsupported Dosage asNeededCodeableConcept"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Unsupported Dosage asNeededCodeableConcept Medication"
* dosageInstruction[+] = Unsupported-Dosage-3-asNeededCodeableConcept

Instance: Unsupported-Dosage-3-asNeededCodeableConcept
InstanceOf: DosageDE
Usage: #inline
Title: "Unsupported: asNeededCodeableConcept"
* text = "asNeededCodeableConcept"
* asNeededCodeableConcept.text = "nur wenn nötig"

Instance: MR-Unsupported-Dosage-04-of-20-Method
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Unsupported Dosage 1 Method"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for unsupported Fields"
* subject.display = "Unsupported Dosage Method"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Unsupported Dosage Method Medication"
* dosageInstruction[+] = Unsupported-Dosage-4-Method

Instance: Unsupported-Dosage-4-Method
InstanceOf: DosageDE
Usage: #inline
Title: "Unsupported: Method"
* text = "method"
* method.text = "oral"

Instance: MR-Unsupported-Dosage-05-of-20-Route
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Unsupported Dosage 1 Route"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for unsupported Fields"
* subject.display = "Unsupported Dosage Route"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Unsupported Dosage Route Medication"
* dosageInstruction[+] = Unsupported-Dosage-5-Route

Instance: Unsupported-Dosage-5-Route
InstanceOf: DosageDE
Usage: #inline
Title: "Unsupported: Route"
* text = "route"
* route.text = "intravenös"

Instance: MR-Unsupported-Dosage-06-of-20-Site
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Unsupported Dosage 1 Site"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for unsupported Fields"
* subject.display = "Unsupported Dosage Site"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Unsupported Dosage Site Medication"
* dosageInstruction[+] = Unsupported-Dosage-6-Site

Instance: Unsupported-Dosage-6-Site
InstanceOf: DosageDE
Usage: #inline
Title: "Unsupported: Site"
* text = "site"
* site.text = "linker Arm"

Instance: MR-Unsupported-Dosage-07-of-20-DoseRange
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Unsupported Dosage 1 DoseRange"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for unsupported Fields"
* subject.display = "Unsupported Dosage DoseRange"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Unsupported Dosage DoseRange Medication"
* dosageInstruction[+] = Unsupported-Dosage-7-DoseRange

Instance: Unsupported-Dosage-7-DoseRange
InstanceOf: DosageDE
Usage: #inline
Title: "Unsupported: DoseRange"
* text = "doseRange"
* doseAndRate[0].doseRange.low.value = 1
* doseAndRate[0].doseRange.low.unit = "mg"
* doseAndRate[0].doseRange.high.value = 2
* doseAndRate[0].doseRange.high.unit = "mg"

Instance: MR-Unsupported-Dosage-08-of-20-RateQuantity
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Unsupported Dosage 1 RateQuantity"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for unsupported Fields"
* subject.display = "Unsupported Dosage RateQuantity"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Unsupported Dosage RateQuantity Medication"
* dosageInstruction[+] = Unsupported-Dosage-8-RateQuantity

Instance: Unsupported-Dosage-8-RateQuantity
InstanceOf: DosageDE
Usage: #inline
Title: "Unsupported: RateQuantity"
* text = "rateQuantity"
* doseAndRate[0].rateQuantity.value = 10
* doseAndRate[0].rateQuantity.unit = "ml/h"

Instance: MR-Unsupported-Dosage-09-of-20-RateRange
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Unsupported Dosage 1 RateRange"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for unsupported Fields"
* subject.display = "Unsupported Dosage RateRange"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Unsupported Dosage RateRange Medication"
* dosageInstruction[+] = Unsupported-Dosage-9-RateRange

Instance: Unsupported-Dosage-9-RateRange
InstanceOf: DosageDE
Usage: #inline
Title: "Unsupported: RateRange"
* text = "rateRange"
* doseAndRate[0].rateRange.low.value = 5
* doseAndRate[0].rateRange.low.unit = "ml/h"
* doseAndRate[0].rateRange.high.value = 15
* doseAndRate[0].rateRange.high.unit = "ml/h"

Instance: MR-Unsupported-Dosage-10-of-20-RateRatio
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Unsupported Dosage 1 RateRatio"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for unsupported Fields"
* subject.display = "Unsupported Dosage RateRatio"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Unsupported Dosage RateRatio Medication"
* dosageInstruction[+] = Unsupported-Dosage-10-RateRatio

Instance: Unsupported-Dosage-10-RateRatio
InstanceOf: DosageDE
Usage: #inline
Title: "Unsupported: RateRatio"
* text = "rateRatio"
* doseAndRate[0].rateRatio.numerator.value = 1
* doseAndRate[0].rateRatio.numerator.unit = "mg"
* doseAndRate[0].rateRatio.denominator.value = 1
* doseAndRate[0].rateRatio.denominator.unit = "h"

Instance: MR-Unsupported-Dosage-11-of-20-AdditionalInstruction
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Unsupported Dosage 1 AdditionalInstruction"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for unsupported Fields"
* subject.display = "Unsupported Dosage AdditionalInstruction"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Unsupported Dosage AdditionalInstruction Medication"
* dosageInstruction[+] = Unsupported-Dosage-11-AdditionalInstruction

Instance: Unsupported-Dosage-11-AdditionalInstruction
InstanceOf: DosageDE
Usage: #inline
Title: "Unsupported: AdditionalInstruction"
* text = "additionalInstruction"
* additionalInstruction[0].text = "Mit Wasser einnehmen"

Instance: MR-Unsupported-Dosage-12-of-20-MaxDosePerPeriod
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Unsupported Dosage 1 MaxDosePerPeriod"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for unsupported Fields"
* subject.display = "Unsupported Dosage MaxDosePerPeriod"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Unsupported Dosage MaxDosePerPeriod Medication"
* dosageInstruction[+] = Unsupported-Dosage-12-MaxDosePerPeriod

Instance: Unsupported-Dosage-12-MaxDosePerPeriod
InstanceOf: DosageDE
Usage: #inline
Title: "Unsupported: MaxDosePerPeriod"
* text = "maxDosePerPeriod"
* maxDosePerPeriod.numerator.value = 10
* maxDosePerPeriod.numerator.unit = "mg"
* maxDosePerPeriod.denominator.value = 24
* maxDosePerPeriod.denominator.unit = "h"

Instance: MR-Unsupported-Dosage-13-of-20-MaxDosePerAdministration
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Unsupported Dosage 1 MaxDosePerAdministration"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for unsupported Fields"
* subject.display = "Unsupported Dosage MaxDosePerAdministration"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Unsupported Dosage MaxDosePerAdministration Medication"
* dosageInstruction[+] = Unsupported-Dosage-13-MaxDosePerAdministration

Instance: Unsupported-Dosage-13-MaxDosePerAdministration
InstanceOf: DosageDE
Usage: #inline
Title: "Unsupported: MaxDosePerAdministration"
* text = "maxDosePerAdministration"
* maxDosePerAdministration.value = 2
* maxDosePerAdministration.unit = "mg"

Instance: MR-Unsupported-Dosage-14-of-20-MaxDosePerLifetime
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Unsupported Dosage 1 MaxDosePerLifetime"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for unsupported Fields"
* subject.display = "Unsupported Dosage MaxDosePerLifetime"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Unsupported Dosage MaxDosePerLifetime Medication"
* dosageInstruction[+] = Unsupported-Dosage-14-MaxDosePerLifetime

Instance: Unsupported-Dosage-14-MaxDosePerLifetime
InstanceOf: DosageDE
Usage: #inline
Title: "Unsupported: MaxDosePerLifetime"
* text = "maxDosePerLifetime"
* maxDosePerLifetime.value = 100
* maxDosePerLifetime.unit = "mg"

Instance: MR-Unsupported-Dosage-15-of-20-Count
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Unsupported Dosage 1 Count"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for unsupported Fields"
* subject.display = "Unsupported Dosage Count"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Unsupported Dosage Count Medication"
* dosageInstruction[+] = Unsupported-Dosage-15-Count

Instance: Unsupported-Dosage-15-Count
InstanceOf: DosageDE
Usage: #inline
Title: "Unsupported: Count"
* text = "count"
* timing
  * repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d
    * count = 5

Instance: MR-Unsupported-Dosage-16-of-20-CountMax
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Unsupported Dosage 1 CountMax"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for unsupported Fields"
* subject.display = "Unsupported Dosage CountMax"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Unsupported Dosage CountMax Medication"
* dosageInstruction[+] = Unsupported-Dosage-16-CountMax

Instance: Unsupported-Dosage-16-CountMax
InstanceOf: DosageDE
Usage: #inline
Title: "Unsupported: CountMax"
* timing
  * repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d
    * countMax = 10

Instance: MR-Unsupported-Dosage-17-of-20-BoundsPeriod
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Unsupported Dosage 1 BoundsPeriod"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for unsupported Fields"
* subject.display = "Unsupported Dosage BoundsPeriod"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Unsupported Dosage BoundsPeriod Medication"
* dosageInstruction[+] = Unsupported-Dosage-17-BoundsPeriod

Instance: Unsupported-Dosage-17-BoundsPeriod
InstanceOf: DosageDE
Usage: #inline
Title: "Unsupported: BoundsPeriod"
* text = "boundsPeriod"
* timing
  * repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d
    * boundsPeriod.start = "2023-01-01"
    * boundsPeriod.end = "2023-01-31"

Instance: MR-Unsupported-Dosage-18-of-20-BoundsRange
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Unsupported Dosage 1 BoundsRange"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for unsupported Fields"
* subject.display = "Unsupported Dosage BoundsRange"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Unsupported Dosage BoundsRange Medication"
* dosageInstruction[+] = Unsupported-Dosage-18-BoundsRange

Instance: Unsupported-Dosage-18-BoundsRange
InstanceOf: DosageDE
Usage: #inline
Title: "Unsupported: BoundsRange"
* text = "boundsRange"
* timing
  * repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d
    * boundsRange.low.value = 1
    * boundsRange.low.unit = "d"
    * boundsRange.high.value = 10
    * boundsRange.high.unit = "d"

Instance: MR-Unsupported-Dosage-19-of-20-Offset
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Unsupported Dosage 1 Offset"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for unsupported Fields"
* subject.display = "Unsupported Dosage Offset"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Unsupported Dosage Offset Medication"
* dosageInstruction[+] = Unsupported-Dosage-19-Offset

Instance: Unsupported-Dosage-19-Offset
InstanceOf: DosageDE
Usage: #inline
Title: "Unsupported: Offset"
* timing
  * repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d
    * offset = 30

Instance: MR-Unsupported-Dosage-20-of-20-Event
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Unsupported Dosage 1 Event"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for unsupported Fields"
* subject.display = "Unsupported Dosage Event"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Unsupported Dosage Event Medication"
* dosageInstruction[+] = Unsupported-Dosage-20-Event

Instance: Unsupported-Dosage-20-Event
InstanceOf: DosageDE
Usage: #inline
Title: "Unsupported: Event"
* timing
  * event[0] = "2023-06-01T08:00:00+01:00"
  * repeat
    * when[+] = #MORN
    * timeOfDay[+] = "08:00:00"
    * frequency = 1
    * period = 1
    * periodUnit = #d
    * boundsDuration = 3 $ucum#wk "Woche(n)"
