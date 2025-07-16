Extension: GeneratedDosageInstructionsEx
Id: GeneratedDosageInstructions
Title: "Generated Dosage Instructions"
Description: "Diese Extension enthält die automatisch generierte textuelle Dosierungsanweisung, die auf Basis der bereitgestellten strukturierten Dosierungsinformationen erstellt wurde."
Context: Dosage
* extension contains 
  text 1..1 MS and
  algorithm 0..1 MS
* extension[text]
  * valueString 1.. MS
* extension[algorithm]
  * valueCoding 1.. MS 
  * valueCoding from DosageTextAlgorithmsVS (extensible)
    * system 1.. MS
    * code 1.. MS
    * version 1.. MS