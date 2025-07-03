Instance: MR-Unsupported-Dosage-1-Count
InstanceOf: DE_DOSAGE_DGMP_MEDICATIONREQUEST
Usage: #example
Title: "Unsupported Dosage 1 Count"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for unsupported Fields"
* subject.display = "Unsupported Dosage Count"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Unsupported Dosage Count Medication"
* dosageInstruction[+] = Unsupported-Dosage-1-Count

Instance: Unsupported-Dosage-1-Count
InstanceOf: DE_DOSAGE
Usage: #inline
Title: "Unsupported: Count"
* text = "count"
* timing.repeat.count = 5

Instance: MR-Unsupported-Dosage-2-asNeededBoolean
InstanceOf: DE_DOSAGE_DGMP_MEDICATIONREQUEST
Usage: #example
Title: "Unsupported Dosage 1 asNeededBoolean"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for unsupported Fields"
* subject.display = "Unsupported Dosage asNeededBoolean"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Unsupported Dosage asNeededBoolean Medication"
* dosageInstruction[+] = Unsupported-Dosage-2-asNeededBoolean

Instance: Unsupported-Dosage-2-asNeededBoolean
InstanceOf: DE_DOSAGE
Usage: #inline
Title: "Unsupported: asNeededBoolean"
* text = "asNeededBoolean"
* asNeededBoolean = true

Instance: MR-Unsupported-Dosage-3-asNeededCodeableConcept
InstanceOf: DE_DOSAGE_DGMP_MEDICATIONREQUEST
Usage: #example
Title: "Unsupported Dosage 1 asNeededCodeableConcept"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for unsupported Fields"
* subject.display = "Unsupported Dosage asNeededCodeableConcept"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Unsupported Dosage asNeededCodeableConcept Medication"
* dosageInstruction[+] = Unsupported-Dosage-3-asNeededCodeableConcept

Instance: Unsupported-Dosage-3-asNeededCodeableConcept
InstanceOf: DE_DOSAGE
Usage: #inline
Title: "Unsupported: asNeededCodeableConcept"
* text = "asNeededCodeableConcept"
* asNeededCodeableConcept.text = "nur wenn nötig"

Instance: MR-Unsupported-Dosage-4-Method
InstanceOf: DE_DOSAGE_DGMP_MEDICATIONREQUEST
Usage: #example
Title: "Unsupported Dosage 1 Method"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for unsupported Fields"
* subject.display = "Unsupported Dosage Method"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Unsupported Dosage Method Medication"
* dosageInstruction[+] = Unsupported-Dosage-4-Method

Instance: Unsupported-Dosage-4-Method
InstanceOf: DE_DOSAGE
Usage: #inline
Title: "Unsupported: Method"
* text = "method"
* method.text = "oral"

Instance: MR-Unsupported-Dosage-5-Route
InstanceOf: DE_DOSAGE_DGMP_MEDICATIONREQUEST
Usage: #example
Title: "Unsupported Dosage 1 Route"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for unsupported Fields"
* subject.display = "Unsupported Dosage Route"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Unsupported Dosage Route Medication"
* dosageInstruction[+] = Unsupported-Dosage-5-Route

Instance: Unsupported-Dosage-5-Route
InstanceOf: DE_DOSAGE
Usage: #inline
Title: "Unsupported: Route"
* text = "route"
* route.text = "intravenös"

Instance: MR-Unsupported-Dosage-6-Site
InstanceOf: DE_DOSAGE_DGMP_MEDICATIONREQUEST
Usage: #example
Title: "Unsupported Dosage 1 Site"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for unsupported Fields"
* subject.display = "Unsupported Dosage Site"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Unsupported Dosage Site Medication"
* dosageInstruction[+] = Unsupported-Dosage-6-Site

Instance: Unsupported-Dosage-6-Site
InstanceOf: DE_DOSAGE
Usage: #inline
Title: "Unsupported: Site"
* text = "site"
* site.text = "linker Arm"

Instance: MR-Unsupported-Dosage-7-DoseRange
InstanceOf: DE_DOSAGE_DGMP_MEDICATIONREQUEST
Usage: #example
Title: "Unsupported Dosage 1 DoseRange"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for unsupported Fields"
* subject.display = "Unsupported Dosage DoseRange"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Unsupported Dosage DoseRange Medication"
* dosageInstruction[+] = Unsupported-Dosage-7-DoseRange

Instance: Unsupported-Dosage-7-DoseRange
InstanceOf: DE_DOSAGE
Usage: #inline
Title: "Unsupported: DoseRange"
* text = "doseRange"
* doseAndRate[0].doseRange.low.value = 1
* doseAndRate[0].doseRange.low.unit = "mg"
* doseAndRate[0].doseRange.high.value = 2
* doseAndRate[0].doseRange.high.unit = "mg"

Instance: MR-Unsupported-Dosage-8-RateQuantity
InstanceOf: DE_DOSAGE_DGMP_MEDICATIONREQUEST
Usage: #example
Title: "Unsupported Dosage 1 RateQuantity"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for unsupported Fields"
* subject.display = "Unsupported Dosage RateQuantity"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Unsupported Dosage RateQuantity Medication"
* dosageInstruction[+] = Unsupported-Dosage-8-RateQuantity

Instance: Unsupported-Dosage-8-RateQuantity
InstanceOf: DE_DOSAGE
Usage: #inline
Title: "Unsupported: RateQuantity"
* text = "rateQuantity"
* doseAndRate[0].rateQuantity.value = 10
* doseAndRate[0].rateQuantity.unit = "ml/h"

Instance: MR-Unsupported-Dosage-9-RateRange
InstanceOf: DE_DOSAGE_DGMP_MEDICATIONREQUEST
Usage: #example
Title: "Unsupported Dosage 1 RateRange"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for unsupported Fields"
* subject.display = "Unsupported Dosage RateRange"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Unsupported Dosage RateRange Medication"
* dosageInstruction[+] = Unsupported-Dosage-9-RateRange

Instance: Unsupported-Dosage-9-RateRange
InstanceOf: DE_DOSAGE
Usage: #inline
Title: "Unsupported: RateRange"
* text = "rateRange"
* doseAndRate[0].rateRange.low.value = 5
* doseAndRate[0].rateRange.low.unit = "ml/h"
* doseAndRate[0].rateRange.high.value = 15
* doseAndRate[0].rateRange.high.unit = "ml/h"

Instance: MR-Unsupported-Dosage-10-RateRatio
InstanceOf: DE_DOSAGE_DGMP_MEDICATIONREQUEST
Usage: #example
Title: "Unsupported Dosage 1 RateRatio"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for unsupported Fields"
* subject.display = "Unsupported Dosage RateRatio"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Unsupported Dosage RateRatio Medication"
* dosageInstruction[+] = Unsupported-Dosage-10-RateRatio

Instance: Unsupported-Dosage-10-RateRatio
InstanceOf: DE_DOSAGE
Usage: #inline
Title: "Unsupported: RateRatio"
* text = "rateRatio"
* doseAndRate[0].rateRatio.numerator.value = 1
* doseAndRate[0].rateRatio.numerator.unit = "mg"
* doseAndRate[0].rateRatio.denominator.value = 1
* doseAndRate[0].rateRatio.denominator.unit = "h"

Instance: MR-Unsupported-Dosage-11-AdditionalInstruction
InstanceOf: DE_DOSAGE_DGMP_MEDICATIONREQUEST
Usage: #example
Title: "Unsupported Dosage 1 AdditionalInstruction"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for unsupported Fields"
* subject.display = "Unsupported Dosage AdditionalInstruction"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Unsupported Dosage AdditionalInstruction Medication"
* dosageInstruction[+] = Unsupported-Dosage-11-AdditionalInstruction

Instance: Unsupported-Dosage-11-AdditionalInstruction
InstanceOf: DE_DOSAGE
Usage: #inline
Title: "Unsupported: AdditionalInstruction"
* text = "additionalInstruction"
* additionalInstruction[0].text = "Mit Wasser einnehmen"

Instance: MR-Unsupported-Dosage-12-MaxDosePerPeriod
InstanceOf: DE_DOSAGE_DGMP_MEDICATIONREQUEST
Usage: #example
Title: "Unsupported Dosage 1 MaxDosePerPeriod"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for unsupported Fields"
* subject.display = "Unsupported Dosage MaxDosePerPeriod"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Unsupported Dosage MaxDosePerPeriod Medication"
* dosageInstruction[+] = Unsupported-Dosage-12-MaxDosePerPeriod

Instance: Unsupported-Dosage-12-MaxDosePerPeriod
InstanceOf: DE_DOSAGE
Usage: #inline
Title: "Unsupported: MaxDosePerPeriod"
* text = "maxDosePerPeriod"
* maxDosePerPeriod.numerator.value = 10
* maxDosePerPeriod.numerator.unit = "mg"
* maxDosePerPeriod.denominator.value = 24
* maxDosePerPeriod.denominator.unit = "h"

Instance: MR-Unsupported-Dosage-13-MaxDosePerAdministration
InstanceOf: DE_DOSAGE_DGMP_MEDICATIONREQUEST
Usage: #example
Title: "Unsupported Dosage 1 MaxDosePerAdministration"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for unsupported Fields"
* subject.display = "Unsupported Dosage MaxDosePerAdministration"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Unsupported Dosage MaxDosePerAdministration Medication"
* dosageInstruction[+] = Unsupported-Dosage-13-MaxDosePerAdministration

Instance: Unsupported-Dosage-13-MaxDosePerAdministration
InstanceOf: DE_DOSAGE
Usage: #inline
Title: "Unsupported: MaxDosePerAdministration"
* text = "maxDosePerAdministration"
* maxDosePerAdministration.value = 2
* maxDosePerAdministration.unit = "mg"

Instance: MR-Unsupported-Dosage-14-MaxDosePerLifetime
InstanceOf: DE_DOSAGE_DGMP_MEDICATIONREQUEST
Usage: #example
Title: "Unsupported Dosage 1 MaxDosePerLifetime"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for unsupported Fields"
* subject.display = "Unsupported Dosage MaxDosePerLifetime"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Unsupported Dosage MaxDosePerLifetime Medication"
* dosageInstruction[+] = Unsupported-Dosage-14-MaxDosePerLifetime

Instance: Unsupported-Dosage-14-MaxDosePerLifetime
InstanceOf: DE_DOSAGE
Usage: #inline
Title: "Unsupported: MaxDosePerLifetime"
* text = "maxDosePerLifetime"
* maxDosePerLifetime.value = 100
* maxDosePerLifetime.unit = "mg"

Instance: MR-Unsupported-Dosage-15-Count
InstanceOf: DE_DOSAGE_DGMP_MEDICATIONREQUEST
Usage: #example
Title: "Unsupported Dosage 1 Count"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for unsupported Fields"
* subject.display = "Unsupported Dosage Count"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Unsupported Dosage Count Medication"
* dosageInstruction[+] = Unsupported-Dosage-15-Count

Instance: Unsupported-Dosage-15-Count
InstanceOf: DE_DOSAGE
Usage: #inline
Title: "Unsupported: Count"
* text = "count"
* timing.repeat.count = 5

Instance: MR-Unsupported-Dosage-16-CountMax
InstanceOf: DE_DOSAGE_DGMP_MEDICATIONREQUEST
Usage: #example
Title: "Unsupported Dosage 1 CountMax"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for unsupported Fields"
* subject.display = "Unsupported Dosage CountMax"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Unsupported Dosage CountMax Medication"
* dosageInstruction[+] = Unsupported-Dosage-16-CountMax

Instance: Unsupported-Dosage-16-CountMax
InstanceOf: DE_DOSAGE
Usage: #inline
Title: "Unsupported: CountMax"
* text = "countMax"
* timing.repeat.countMax = 10

Instance: MR-Unsupported-Dosage-17-BoundsPeriod
InstanceOf: DE_DOSAGE_DGMP_MEDICATIONREQUEST
Usage: #example
Title: "Unsupported Dosage 1 BoundsPeriod"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for unsupported Fields"
* subject.display = "Unsupported Dosage BoundsPeriod"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Unsupported Dosage BoundsPeriod Medication"
* dosageInstruction[+] = Unsupported-Dosage-17-BoundsPeriod

Instance: Unsupported-Dosage-17-BoundsPeriod
InstanceOf: DE_DOSAGE
Usage: #inline
Title: "Unsupported: BoundsPeriod"
* text = "boundsPeriod"
* timing.repeat.boundsPeriod.start = "2023-01-01"
* timing.repeat.boundsPeriod.end = "2023-01-31"

Instance: MR-Unsupported-Dosage-18-BoundsRange
InstanceOf: DE_DOSAGE_DGMP_MEDICATIONREQUEST
Usage: #example
Title: "Unsupported Dosage 1 BoundsRange"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for unsupported Fields"
* subject.display = "Unsupported Dosage BoundsRange"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Unsupported Dosage BoundsRange Medication"
* dosageInstruction[+] = Unsupported-Dosage-18-BoundsRange

Instance: Unsupported-Dosage-18-BoundsRange
InstanceOf: DE_DOSAGE
Usage: #inline
Title: "Unsupported: BoundsRange"
* text = "boundsRange"
* timing.repeat.boundsRange.low.value = 1
* timing.repeat.boundsRange.low.unit = "d"
* timing.repeat.boundsRange.high.value = 10
* timing.repeat.boundsRange.high.unit = "d"

Instance: MR-Unsupported-Dosage-19-Offset
InstanceOf: DE_DOSAGE_DGMP_MEDICATIONREQUEST
Usage: #example
Title: "Unsupported Dosage 1 Offset"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for unsupported Fields"
* subject.display = "Unsupported Dosage Offset"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Unsupported Dosage Offset Medication"
* dosageInstruction[+] = Unsupported-Dosage-19-Offset

Instance: Unsupported-Dosage-19-Offset
InstanceOf: DE_DOSAGE
Usage: #inline
Title: "Unsupported: Offset"
* text = "offset"
* timing.repeat.offset = 30

Instance: MR-Unsupported-Dosage-20-Event
InstanceOf: DE_DOSAGE_DGMP_MEDICATIONREQUEST
Usage: #example
Title: "Unsupported Dosage 1 Event"
Description: "CAVE: This MedicationRequest is for validation purposes and does NOT represent a valid dosageInstruction. It only checks for unsupported Fields"
* subject.display = "Unsupported Dosage Event"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Unsupported Dosage Event Medication"
* dosageInstruction[+] = Unsupported-Dosage-20-Event

Instance: Unsupported-Dosage-20-Event
InstanceOf: DE_DOSAGE
Usage: #inline
Title: "Unsupported: Event"
* text = "event"
* timing.event[0] = "2023-06-01T08:00:00+01:00"
* timing.repeat.boundsDuration.value = 3
* timing.repeat.boundsDuration.unit = "Woche(n)"
