Extension: GeneratedDosageInstructions
Id: generated-dosage-instructions
Title: "Generated Dosage Instructions"
Description: "This extension captures the generated textual dosage instructions based on the structured dosage information provided."
Context: Dosage
* extension contains 
  text 1..1 MS and
  algorithm 1..1 MS
* extension[text]
  * valueString 1.. MS
* extension[algorithm]
  * valueCoding 1.. MS 
  * valueCoding from DosageTextAlgorithmsVS (extensible)
    * system 1.. MS
    * code 1.. MS
    * version 1.. MS

//TODO move to a separate file

CodeSystem: DosageTextAlgorithmsCS
Id: DosageTextAlgorithms
Title: "DosageTextAlgorithmsCS"
Description: "This CodeSystem defines the algorithms used to generate textual dosage instructions from structured dosage information."
* #GermanDosageTextGenerator "German Dosage Text Generator" "Source: https://github.com/hl7germany/medication-ig-de-r4/blob/develop/input/content/dosage-to-text.py"

ValueSet: DosageTextAlgorithmsVS
Id: DosageTextAlgorithms
Title: "DosageTextAlgorithmsVS"
Description: "This ValueSet includes the algorithms used to generate textual dosage instructions from structured dosage information."
* include codes from system DosageTextAlgorithmsCS