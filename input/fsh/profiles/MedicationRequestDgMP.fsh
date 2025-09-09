Profile: MedicationRequestDgMP
Parent: MedicationRequest
Id: MedicationRequestDgMP
Title: "Medication Request dgMP"
Description: "Dieses Profil dient ausschließlich der Validierung des Implementation Guides und ist nicht für den produktiven Einsatz gedacht. Stattdessen sollte das jeweils passende Dosage-Profil direkt in das eigene Profil eingebunden werden."
* ^abstract = true
* extension contains $medicationRequest-renderedDosageInstruction-r5 named renderedDosageInstruction 0..1 MS
  and GeneratedDosageInstructionsMeta named generatedDosageInstructionsMeta 0..1 MS

* extension[renderedDosageInstruction]
  * ^short = "Dosierungsanweisung"
  * ^definition = "Diese R5‑Backport‑Extension enthält die gerenderten Dosierungsanweisungen für den Patienten, um eine klare und verständliche Einnahmeanweisung bereitzustellen."
  * valueMarkdown
    * ^short = "Hinweis: In der ersten Ausbaustufe des dgMP ist nur einfacher Text (String) zulässig; Markdown wird nicht unterstützt."
    * ^definition = "Abweichend von FHIR R5 (Typ Markdown) darf in der ersten Ausbaustufe des dgMP ausschließlich Klartext ohne Markdown‑Formatierungen (z. B. Überschriften, Listen, Links) geliefert werden."

* extension[generatedDosageInstructionsMeta]
  * ^short = "Metadaten zu den generierten Dosierungsanweisungen"
  * ^definition = "Diese Extension enthält zusätzliche Metadaten zu den automatisch generierten Dosierungsanweisungen, wie z.B. Informationen zur Generierung oder zum Ursprung der Daten."
* dosageInstruction only DosageDgMP
  * ^short = "Angabe der Dosierinformationen strukturiert oder als Freitext"