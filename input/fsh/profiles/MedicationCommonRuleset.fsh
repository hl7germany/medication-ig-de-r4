RuleSet: MedicationCommonRuleset
* ^abstract = true

* extension[renderedDosageInstruction]
  * ^short = "Dosierungsanweisung"
  * ^definition = "Diese R5 backport Extension enthält die algorithmisch generierten gerenderten Dosierungsanweisungen, die für den Patienten bestimmt sind, um eine klare und verständliche Anweisung zur Einnahme des Medikaments zu geben."
  * valueMarkdown
    * ^short = "Hinweis: In der ersten Ausbaustufe des dgMP ist nur einfacher Text (String) zulässig; Markdown wird nicht unterstützt."
    * ^definition = "Abweichend von FHIR R5 (Typ Markdown) darf in der ersten Ausbaustufe des dgMP ausschließlich Klartext ohne Markdown‑Formatierungen (z. B. Überschriften, Listen, Links) geliefert werden."

* extension[generatedDosageInstructionsMeta]
  * ^short = "Metadaten zu den generierten Dosierungsanweisungen"
  * ^definition = "Diese Extension enthält zusätzliche Metadaten zu den automatisch generierten Dosierungsanweisungen, wie z.B. Informationen zur Generierung oder zum Ursprung der Daten."