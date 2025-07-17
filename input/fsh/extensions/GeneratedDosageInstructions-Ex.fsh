Extension: GeneratedDosageInstructionsEx
Id: GeneratedDosageInstructions
Title: "Generated Dosage Instructions"
Description: "Diese Extension enthält die automatisch generierte textuelle Dosierungsanweisung, die auf Basis der bereitgestellten strukturierten Dosierungsinformationen erstellt wurde."
Context: Dosage
* extension contains 
  text 1..1 MS and
  language 0..1 MS and
  algorithm 0..1 MS and
  algorithmVersion 0..1 MS 
* extension[text]
  * valueString 1.. MS
* extension[language]
  * valueCode 1.. MS
  * valueCode from $all-languages-vs
* extension[algorithm]
  * valueCoding 1.. MS 
  * valueCoding from DosageTextAlgorithmVS (extensible)
    * system 1.. MS
    * code 1.. MS
    * version 1.. MS
* extension[algorithmVersion]
  * valueString 1.. MS