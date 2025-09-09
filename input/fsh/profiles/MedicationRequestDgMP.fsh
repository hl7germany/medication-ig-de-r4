Profile: MedicationRequestDgMP
Parent: MedicationRequest
Id: MedicationRequestDgMP
Title: "Medication Request dgMP"
Description: "Dieses Profil dient ausschließlich der Validierung des Implementation Guides und ist nicht für den produktiven Einsatz gedacht. Stattdessen sollte das jeweils passende Dosage-Profil direkt in das eigene Profil eingebunden werden."
* ^abstract = true
* extension contains $medicationRequest-renderedDosageInstruction-r5 named renderedDosageInstruction 0..1 MS //TODO: 1..1??
  and GeneratedDosageInstructionsMeta named generatedDosageInstructionsMeta 0..1 MS
* dosageInstruction only DosageDgMP
  * ^short = "Angabe der Dosierinformationen strukturiert oder als Freitext"