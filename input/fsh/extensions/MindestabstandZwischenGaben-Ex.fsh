Extension: MindestabstandZwischenGabenEx
Id: MindestabstandZwischenGaben
Title: "Mindestabstand zwischen Gaben"
Description: "Gibt den Mindestabstand zwischen zwei Gaben einer Bedarfsmedikation an."
Context: Dosage
* . ^isModifier = true
* . ^isModifierReason = "Der Mindestabstand zwischen Gaben verändert die zulässige Interpretation und Anwendung der Dosierung."
* value[x] only Duration
* valueDuration 1..1 MS
  * ^short = "Mindestabstand zwischen zwei Gaben"
  * ^definition = "Zeitlicher Mindestabstand, der zwischen zwei Gaben einer Bedarfsmedikation einzuhalten ist."
