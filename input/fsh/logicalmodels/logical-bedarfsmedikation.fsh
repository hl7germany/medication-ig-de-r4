Logical: PRNSchemeLogical
Parent: Base
Id: PRNSchemeLogical
Title: "Fachliches Informationsmodell für das Schema Bedarfsmedikation"
// Zum Anpassen der Beschreibung siehe StructureDefinition-PRNSchemeLogical-intro.md

* insert Kopf
* insert Hinweis
* insert Dosis
* dosierungsdetails.maximaldosis 0..1 Base "Höchstmenge des Arzneimittels, die innerhalb von 24 Stunden (1 Tag) angewendet werden darf."
  * wert 1..1 decimal "Zahlenwert der Höchstmenge (z.B. 6)."
  * einheit 1..1 Coding "Einheit der Höchstmenge; entspricht der Einheit der Einzeldosis (z.B. Tablette oder mg)."
* dosierungsdetails.maximaldosis.einheit from $kbv-dosiereinheit-vs (required)
* insert Zeitangaben
* dosierungsdetails.zeitangaben.mindestabstand 0..1 Base "Mindestzeit, die zwischen zwei aufeinanderfolgenden Anwendungen einzuhalten ist."
  * wert 1..1 decimal "Zahlenwert des Mindestabstands; bei einer Bereichsangabe die untere Grenze (z.B. 1)."
  * wertBis 0..1 decimal "Obere Grenze bei einer Bereichs- oder Obergrenzenangabe (z.B. 2 für „1 bis 2 Stunden“ oder „bis zu 2 Stunden“)."
  * einheit 1..1 Coding "Zeiteinheit: Stunde oder Minute."
* dosierungsdetails.anlass 0..1 string "Anlass oder Bedingung, bei deren Auftreten das Arzneimittel angewendet werden soll (z.B. „bei Schmerzen“ oder „bei Fieber über 38,5 °C“)."
