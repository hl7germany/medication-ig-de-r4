Profile: MedicationRequestDgMP
Parent: MedicationRequest
Id: MedicationRequestDgMP
Title: "Medication Request dgMP"
Description: "Dieses Profil dient ausschließlich der Validierung des Implementation Guides und ist nicht für den produktiven Einsatz gedacht. Stattdessen sollte das jeweils passende Dosage-Profil direkt in das eigene Profil eingebunden werden."
* ^abstract = true
* extension contains $medicationRequest-renderedDosageInstruction-r5 named renderedDosageInstruction 0..1 MS //TODO: 1..1??
  and GeneratedDosageInstructionsMeta named generatedDosageInstructionsMeta 0..1 MS

* extension[generatedDosageInstructionsMeta]
  * ^short = "Metadaten zu den generierten Dosierungsanweisungen"
  * ^definition = "Diese Extension enthält zusätzliche Metadaten zu den automatisch generierten Dosierungsanweisungen, wie z.B. Informationen zur Generierung oder zum Ursprung der Daten."
* dosageInstruction only DosageDgMP
  * ^short = "Angabe der Dosierinformationen strukturiert oder als Freitext"