Logical: WhenSchemeLogical
Parent: Base
Id: WhenSchemeLogical
Title: "Fachliches Informationsmodell für das Schema mit Tageszeiten-Bezug"
// Zum Anpassen der Beschreibung siehe StructureDefinition-WhenSchemeLogical-intro.md

* insert Kopf
* insert Hinweis
* insert Dosis
* insert Zeitangaben
* dosierungsdetails.zeitangaben.tageszeiten 1..* Coding "Tageszeit(en) der Anwendung, ausgedrückt als morgens | mittags | abends | zur Nacht"
* dosierungsdetails.zeitangaben.tageszeiten from http://ig.fhir.de/igs/medication/ValueSet/TimingWhenDgMP (required)
* insert Bedarf
