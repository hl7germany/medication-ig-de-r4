Logical: WeekdaySchemeLogical
Parent: Base
Id: WeekdaySchemeLogical
Title: "Fachliches Informationsmodell für das Schema mit Wochentags-Bezug"
// Zum Anpassen der Beschreibung siehe StructureDefinition-WeekdaySchemeLogical-intro.md

* insert Kopf
* insert Hinweis
* insert Dosis
* insert Zeitangaben
* dosierungsdetails.zeitangaben.wochentage 1..* Coding "Wochentag(e) der Anwendung, ausgedrückt als montags | dienstags | mittwochs | donnerstags | freitags | samstags | sonntags."
* dosierungsdetails.zeitangaben.wochentage from http://hl7.org/fhir/ValueSet/days-of-week (required)
* insert Bedarf
