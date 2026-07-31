Logical: WeekdayCombinationSchemeLogical
Parent: Base
Id: WeekdayCombinationSchemeLogical
Title: "Fachliches Informationsmodell für das Schema für Kombinationen von Wochentagen"
Description: """
Dieses Modell beschreibt eine Anwendung, deren Rhythmus sich über die Woche erstreckt: Das Arzneimittel
wird nicht täglich, sondern nur an bestimmten Wochentagen angewendet. Zusätzlich legt es fest, zu welcher
Tageszeit oder Uhrzeit die Anwendung an diesen Tagen erfolgt.

Das Modell ist damit eine Kombination des Schemas mit Wochentags-Bezug mit entweder dem Schema mit
Tageszeiten-Bezug oder dem Schema mit Uhrzeiten-Bezug.
"""

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
