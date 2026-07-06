Profile: MedicationDispenseDE
Parent: MedicationDispense
Id: MedicationDispenseDE
Title: "Medication Dispense DE"
Description: "Dieses Profil dient ausschließlich der Validierung des Implementation Guides auf DosageDE-Ebene (u. a. der Warnungs-Beispiele, die im dgMP-Profil als Fehler modelliert sind) und ist nicht für den produktiven Einsatz gedacht. Stattdessen sollte das jeweils passende Dosage-Profil direkt in das eigene Profil eingebunden werden."

* extension contains $medicationDispense-renderedDosageInstruction-r5 named renderedDosageInstruction 0..1 MS
  and GeneratedDosageInstructionsMeta named generatedDosageInstructionsMeta 0..1 MS
* insert MedicationCommonRuleset

* dosageInstruction only DosageDE
  * ^short = "Angabe der Dosierinformationen strukturiert oder als Freitext"
