Profile: DE_DOSAGE_DGMP
Parent: DE_DOSAGE
Id: de-dosage-dgmp
Title: "DosageDGMP_Dosierung"
Description: "Gibt an, wie das Medikament vom Patienten eingenommen wird/wurde oder eingenommen werden soll."
// TODO: Naming der Profile anpassen

* obeys DosageStructuredOrFreeText
* text // Free text dosage instructions e.g. SIG

* additionalInstruction 0..0

* patientInstruction //Patient or consumer oriented instructions

* timing only TimingDE_dgmp_Zeipunkte
* doseAndRate 0..1 MS // Nur eine Dosierung für eine Medikation erlauben
  * type 0..0 //TODO: Sollte das fixed auf "ordered" gesetzt werden oder auf 0..0 gesetzt sein? http://terminology.hl7.org/CodeSystem/dose-rate-type
  * dose[x] only SimpleQuantity
  * doseQuantity MS
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
Expression: "(text.exists() and timing.empty() and doseAndRate.empty()) or (text.empty() and timing.exists() and doseAndRate.exists())"
Severity: #error