Profile: DE_DOSAGE_DGMP
Parent: DE_DOSAGE
Id: de-dosage-dgmp
Title: "DosageDE_Dosierung"
Description: "Gibt an, wie das Medikament vom Patienten eingenommen wird/wurde oder eingenommen werden soll."
// TODO: Naming der Profile anpassen

* text 1..1

* additionalInstruction.text 1..1
* patientInstruction

* timing only TimingDE_dgmp_Zeipunkte
* doseAndRate MS
  * type 0..0
  * dose[x] only SimpleQuantity
  * doseQuantity MS
  * rateRatio 0..0
  * rateRange 0..0
  * rateQuantity 0..0

// Remove unused Fields
* sequence 0..0
* asNeededBoolean 0..0
* asNeededCodeableConcept 0..0
* site 0..0
* route 0..0
* method 0..0
* maxDosePerPeriod 0..0
* maxDosePerAdministration 0..0
* maxDosePerLifetime 0..0


