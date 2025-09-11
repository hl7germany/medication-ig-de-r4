Extension: GeneratedDosageInstructionsMetaEx
Id: GeneratedDosageInstructionsMeta
Title: "Generated Dosage Instructions Meta"
Description: "Diese Extension enthält die Metainformationen zur generierten textuellen Dosierungsanweisung, die auf Basis der bereitgestellten strukturierten Dosierungsinformationen erstellt wurde."
Context: MedicationRequest, MedicationDispense, MedicationStatement
* extension contains 
  language 1..1 MS and
  algorithmVersion 1..1 MS 
* extension[language]
  * ^short = "Sprache der generierten Dosierungsanweisung"
  * valueCode 1.. MS
  * valueCode from $all-languages-vs
* extension[algorithmVersion]
  * ^short = "Version des Algorithmus zur Generierung der Dosierungsanweisung (Version der zugrundeliegenden Python Referenzimplementierung)"
  * valueString 1.. MS