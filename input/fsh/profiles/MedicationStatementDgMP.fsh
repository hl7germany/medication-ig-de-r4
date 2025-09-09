Profile: MedicationStatementDgMP
Parent: MedicationStatement
Id: MedicationStatementDgMP
Title: "Medication Statement dgMP"
Description: "Dieses Profil dient ausschließlich der Validierung des Implementation Guides und ist nicht für den produktiven Einsatz gedacht. Stattdessen sollte das jeweils passende Dosage-Profil direkt in das eigene Profil eingebunden werden."
* ^abstract = true
* extension contains $medicationStatement-renderedDosageInstruction-r5 named renderedDosageInstruction 0..1 MS //TODO: 1..1??
  and GeneratedDosageInstructionsMeta named generatedDosageInstructionsMeta 0..1 MS
* dosage only DosageDgMP
  * ^short = "Angabe der Dosierinformationen strukturiert oder als Freitext"
  