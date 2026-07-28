Profile: MedicationStatementDgMP
Parent: MedicationStatement
Id: MedicationStatementDgMP
Title: "Medication Statement dgMP"
Description: "Dieses Profil dient ausschließlich der Validierung des Implementation Guides und ist nicht für den produktiven Einsatz gedacht. Stattdessen sollte das jeweils passende Dosage-Profil direkt in das eigene Profil eingebunden werden."

* extension contains $medicationStatement-renderedDosageInstruction-r5 named renderedDosageInstruction 0..1 MS
  and GeneratedDosageInstructionsMeta named generatedDosageInstructionsMeta 0..1 MS
* insert MedicationCommonRuleset
* obeys ExtRequiresDosage-MS-01

* dosage only DosageDgMP
  * ^short = "Angabe der Dosierinformationen strukturiert oder als Freitext"

Invariant: ExtRequiresDosage-MS-01
Description: "Wenn eine Dosierungs-Extension (GeneratedDosageInstructionsMeta oder renderedDosageInstruction) vorhanden ist, muss mindestens eine dosage vorhanden sein."
Expression: "(
  extension.where(
    url = 'http://ig.fhir.de/igs/medication/StructureDefinition/GeneratedDosageInstructionsMeta' or
    url = 'http://hl7.org/fhir/5.0/StructureDefinition/extension-MedicationStatement.renderedDosageInstruction'
  ).exists()
) implies dosage.exists()"
Severity: #error
