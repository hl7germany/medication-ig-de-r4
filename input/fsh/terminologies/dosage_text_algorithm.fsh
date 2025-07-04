CodeSystem: DosageTextAlgorithmsCS
Id: DosageTextAlgorithms
Title: "Algorithmen für Textgenerierung von Dosierungen"
Description: "This CodeSystem defines the algorithms used to generate textual dosage instructions from structured dosage information."
* #GermanDosageTextGenerator "German Dosage Text Generator" "Source: https://github.com/hl7germany/medication-ig-de-r4/blob/develop/input/content/dosage-to-text.py"

ValueSet: DosageTextAlgorithmsVS
Id: DosageTextAlgorithms
Title: "Algorithmen für Textgenerierung von Dosierungen"
Description: "This ValueSet includes the algorithms used to generate textual dosage instructions from structured dosage information."
* include codes from system DosageTextAlgorithmsCS