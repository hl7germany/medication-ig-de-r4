Extension: GeneratedDosageInstructionsMetaEx
Id: GeneratedDosageInstructionsMeta
Title: "Generated Dosage Instructions Meta"
Description: "Diese Extension enthält die Metainformationen zur generierten textuellen Dosierungsanweisung, die auf Basis der bereitgestellten strukturierten Dosierungsinformationen erstellt wurde."
Context: MedicationRequest, MedicationDispense, MedicationStatement
* extension contains 
  language 0..1 MS and
  algorithm 0..1 MS and
  algorithmVersion 0..1 MS 
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