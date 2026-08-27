Profile: MedicationRequestDE
Parent: MedicationRequest
Id: MedicationRequestDE
Title: "Medication Request DE"
Description: "Dieses Profil dient ausschließlich der Validierung des Implementation Guides auf DosageDE-Ebene (u. a. der Warnungs-Beispiele, die im dgMP-Profil als Fehler modelliert sind) und ist nicht für den produktiven Einsatz gedacht. Stattdessen sollte das jeweils passende Dosage-Profil direkt in das eigene Profil eingebunden werden."

* extension contains $medicationRequest-renderedDosageInstruction-r5 named renderedDosageInstruction 0..1 MS
  and GeneratedDosageInstructionsMeta named generatedDosageInstructionsMeta 0..1 MS
* insert MedicationCommonRuleset

* dosageInstruction only DosageDE
  * ^short = "Angabe der Dosierinformationen strukturiert oder als Freitext"
