Profile: MedicationDispenseDgMP
Parent: MedicationDispense
Id: MedicationDispenseDgMP
Title: "Medication Dispense dgMP"
Description: "Dieses Profil dient ausschließlich der Validierung des Implementation Guides und ist nicht für den produktiven Einsatz gedacht. Stattdessen sollte das jeweils passende Dosage-Profil direkt in das eigene Profil eingebunden werden."

* extension contains $medicationDispense-renderedDosageInstruction-r5 named renderedDosageInstruction 0..1 MS
  and GeneratedDosageInstructionsMeta named generatedDosageInstructionsMeta 0..1 MS
* insert MedicationCommonRuleset
* obeys ExtRequiresDosage-MD

* dosageInstruction only DosageDgMP
  * ^short = "Angabe der Dosierinformationen strukturiert oder als Freitext"

Invariant: ExtRequiresDosage-MD
Description: "If a dosage extension (GeneratedDosageInstructionsMeta or renderedDosageInstruction) is present, at least one dosageInstruction must be present."
Expression: "(
  extension.where(
    url = 'http://ig.fhir.de/igs/medication/StructureDefinition/GeneratedDosageInstructionsMeta' or
    url = 'http://hl7.org/fhir/5.0/StructureDefinition/extension-MedicationDispense.renderedDosageInstruction'
  ).exists()
) implies dosageInstruction.exists()"
Severity: #error
