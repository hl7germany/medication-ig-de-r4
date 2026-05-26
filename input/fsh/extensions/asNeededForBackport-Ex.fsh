Extension: DosageAsNeededFor
Id: extension-Dosage.asNeededFor
Title: "Dosage asNeededFor"
Description: "Indicates whether the medication is only taken based on a precondition for taking the medication."
* ^url = "http://hl7.org/fhir/5.0/StructureDefinition/extension-Dosage.asNeededFor"
* ^status = #active
* ^context[0].type = #element
* ^context[=].expression = "Dosage"
* ^extension[http://hl7.org/fhir/StructureDefinition/structuredefinition-wg].valueCode = #fhir
* extension 0..0
* value[x] only CodeableConcept
* valueCodeableConcept from http://hl7.org/fhir/ValueSet/medication-as-needed-reason (example)