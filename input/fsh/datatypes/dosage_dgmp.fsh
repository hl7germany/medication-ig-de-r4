Profile: DosageDgMP
Parent: DosageDE
Id: DosageDgMP
Title: "Dosage dgMP"
Description: "Gibt an, wie das Medikament vom Patienten im Kontext dgMP eingenommen wird/wurde oder eingenommen werden soll."
* obeys DosageStructuredOrFreeText
* obeys DosageStructuredRequiresBoth
* obeys DosageDoseUnitSameCode

* extension[generatedDosageInstructions]
  * extension[algorithm]
    * valueCoding 1..1 MS // The algorithm used to generate the text
      * ^patternCoding.system = Canonical(DosageTextAlgorithmsCS)
      * ^patternCoding.code = #GermanDosageTextGenerator
      * version 1..1 MS
* timing only TimingDgMP
* doseAndRate 0..1 // Nur eine Dosierung für eine Medikation erlauben
  * type 0..0
  * dose[x] only SimpleQuantity
  * doseQuantity
  * doseQuantity from $kbv-dosiereinheit-vs
    * system 1..1 MS
    * code 1..1 MS
    * unit 1..1 MS
  * rate[x] 0..0

// Remove unused Fields
* sequence 0..0
* additionalInstruction 0..0
* patientInstruction 0..0
* asNeeded[x] 0..0
* site 0..0
* route 0..0
* method 0..0
* maxDosePerPeriod 0..0
* maxDosePerAdministration 0..0
* maxDosePerLifetime 0..0

Invariant: DosageStructuredOrFreeText
Description: "Die Dosierungsangabe darf entweder nur als Freitext oder nur als vollständige strukturierte Information erfolgen — eine Mischung ist nicht erlaubt."
Expression: "(%resource.ofType(MedicationRequest).dosageInstruction | 
 ofType(MedicationDispense).dosageInstruction | 
 ofType(MedicationStatement).dosage).all(
  (text.exists() and timing.empty() and doseAndRate.empty()) or
  (text.empty() and (timing.exists() or doseAndRate.exists()))
)
"
Severity: #error

Invariant: DosageStructuredRequiresBoth
Description: "Wenn eine strukturierte Dosierungsangabe erfolgt, müssen sowohl timing als auch doseAndRate angegeben werden."
Expression: "(%resource.ofType(MedicationRequest).dosageInstruction | 
 ofType(MedicationDispense).dosageInstruction | 
 ofType(MedicationStatement).dosage).all(
  (timing.exists() implies doseAndRate.exists()) and
  (doseAndRate.exists() implies timing.exists())
)
"
Severity: #error

Invariant: DosageDoseUnitSameCode
Description: "Die Dosiereinheit muss über alle Dosierungen gleich sein."
Expression: "(%resource.ofType(MedicationRequest).dosageInstruction | ofType(MedicationDispense).dosageInstruction | ofType(MedicationStatement).dosage).all(
doseAndRate.exists() implies
  %resource.dosageInstruction.doseAndRate.dose.ofType(Quantity).code.distinct().count() = 1
)"
Severity: #error
