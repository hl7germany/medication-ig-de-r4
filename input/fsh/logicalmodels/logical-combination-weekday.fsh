Logical: WeekdayCombinationSchemeLogical
Parent: Base
Id: WeekdayCombinationSchemeLogical
Title: "Fachliches Informationsmodell für das Schema für Kombinationen von Wochentagen"
// Zum Anpassen der Beschreibung siehe StructureDefinition-WeekdayCombinationSchemeLogical-intro.md

* insert Kopf
* insert Hinweis
* insert Dosis
* insert Zeitangaben
* dosierungsdetails.zeitangaben.wochentage 1..* Coding "Wochentag(e) der Anwendung, ausgedrückt als montags | dienstags | mittwochs | donnerstags | freitags | samstags | sonntags."
* dosierungsdetails.zeitangaben.wochentage from http://hl7.org/fhir/ValueSet/days-of-week (required)
* dosierungsdetails.zeitangaben.uhrzeiten 0..* time "Uhrzeit(en) der Anwendung an den ausgewählten Wochentagen. Alternativ zur Tageszeit anzugeben."
* dosierungsdetails.zeitangaben.tageszeiten 0..* Coding "Tageszeit(en) an den ausgewählten Wochentagen, ausgedrückt als morgens | mittags | abends | zur Nacht. Alternativ zur Uhrzeit anzugeben."
* dosierungsdetails.zeitangaben.tageszeiten from http://ig.fhir.de/igs/medication/ValueSet/TimingWhenDgMP (required)
* insert Bedarf
