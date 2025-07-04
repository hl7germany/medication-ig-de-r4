Extension: GeneratedDosageInstructionsEx
Id: GeneratedDosageInstructions
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