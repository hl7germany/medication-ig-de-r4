Profile: MedicationRequestDgMP
Parent: MedicationRequest
Id: MedicationRequestDgMP
Title: "Medication Request dgMP"
Description: "Dieses Profil dient ausschließlich der Validierung des Implementation Guides und ist nicht für den produktiven Einsatz gedacht. Stattdessen sollte das jeweils passende Dosage-Profil direkt in das eigene Profil eingebunden werden."

* extension contains $medicationRequest-renderedDosageInstruction-r5 named renderedDosageInstruction 1..1 MS
  and GeneratedDosageInstructionsMeta named generatedDosageInstructionsMeta 1..1 MS
* insert MedicationCommonRuleset

* dosageInstruction only DosageDgMP
  * ^short = "Angabe der Dosierinformationen strukturiert oder als Freitext"