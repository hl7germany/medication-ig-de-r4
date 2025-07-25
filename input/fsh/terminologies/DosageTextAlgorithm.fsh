CodeSystem: DosageTextAlgorithmCS
Id: DosageTextAlgorithm
Title: "Dosage Text Algorithm CodeSystem"
Description: "Dieses CodeSystem legt die Algorithmen fest, mit denen aus strukturierten Dosierungsangaben automatisch Dosierungsanweisungen in Textform erzeugt werden."
* #GematikDosageTextGenerator "Gematik Dosage Text Generator" "Source: https://github.com/hl7germany/medication-ig-de-r4/blob/main/input/content/dosage-to-text.py"

ValueSet: DosageTextAlgorithmVS
Id: DosageTextAlgorithm
Title: "Dosage Text Algorithm ValueSet"
Description: "Dieses ValueSet legt die Algorithmen fest, mit denen aus strukturierten Dosierungsangaben automatisch Dosierungsanweisungen in Textform erzeugt werden."
* include codes from system DosageTextAlgorithmCS