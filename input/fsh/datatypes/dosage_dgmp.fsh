Profile: DosageDgMP
Parent: DosageDE
Id: DosageDgMP
Title: "Dosage für dgMP"
Description: "Gibt an, wie das Medikament vom Patienten im Kontext dgMP eingenommen wird/wurde oder eingenommen werden soll."

* obeys DosageStructuredOrFreeText
* text // Free text dosage instructions e.g. SIG
  * extension[generatedDosageInstructions]
    * extension[algorithm]
      * valueCoding 1..1 MS // The algorithm used to generate the text
        * ^patternCoding.system = Canonical(DosageTextAlgorithmsCS)
        * ^patternCoding.code = #GermanDosageTextGenerator
        * version 1..1 MS

* additionalInstruction 0..0

* patientInstruction //Patient or consumer oriented instructions

* timing only TimingDgMP
* doseAndRate 0..1 // Nur eine Dosierung für eine Medikation erlauben
  * type 0..0 //TODO: Sollte das fixed auf "ordered" gesetzt werden oder auf 0..0 gesetzt sein? http://terminology.hl7.org/CodeSystem/dose-rate-type
  * dose[x] only SimpleQuantity
  * doseQuantity
  * doseQuantity from $kbv-dosiereinheit-vs
  * rate[x] 0..0

// Remove unused Fields
* sequence 0..0
* asNeeded[x] 0..0
* site 0..0
* route 0..0
* method 0..0
* maxDosePerPeriod 0..0
* maxDosePerAdministration 0..0
* maxDosePerLifetime 0..0

Invariant: DosageStructuredOrFreeText
Description: "Dosage must be either structured or free text, but not both at the same time."
Expression: "
%resource.(ofType(MedicationRequest).dosageInstruction | ofType(MedicationStatement).dosage).all(
  text.exists() and timing.empty() and doseAndRate.empty()) or (text.empty() and timing.exists() and doseAndRate.exists()
)
"
Severity: #error