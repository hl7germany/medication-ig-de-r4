Logical: WeekdayCombinationSchemeLogical
Parent: Base
Id: WeekdayCombinationSchemeLogical
Title: "Fachliches Informationsmodell für das Schema für Kombinationen von Wochentagen"
Description: """
Dieses Schema beschreibt eine Anwendung, deren Rhythmus sich über die Woche erstreckt: Das Arzneimittel wird nicht täglich, 
sondern an bestimmten Wochentagen angewandt. Außerdem definiert es, zu welchen Tageszeiten oder Uhrzeiten die Anwendung 
an den betreffenden Wochentagen erfolgen soll. Es stellt damit eine Kombination des Schemas mit Wochentags-Bezug mit entweder
dem Schema mit Tageszeiten-Bezug oder dem Schema mit Uhrzeiten-Bezug dar.
"""

* insert Zeitrahmen
* insert Einzelgabe
* einzelgabe.wochentage 1..* Coding "Wochentag(e) der Anwendung, ausgedrückt als montags | dienstags | mittwochs | donnerstags | freitags | samstags | sonntags."
* einzelgabe.wochentage from http://hl7.org/fhir/ValueSet/days-of-week (required)
* einzelgabe.konkretisierung 0..1 BackboneElement "Konkretisierung des Zeitpunkts der Anwendung an den gewählten Wochentagen, ausgedrückt entweder in Tageszeiten oder in Uhrzeiten."
  * tageszeit 0..* Coding "Tageszeit(en) an den ausgewählten Wochentagen, ausgedrückt als morgens | mittags | abends | zur Nacht."
  * uhrzeit 0..* time "Uhrzeit(en) der Anwendung an den ausgewählten Wochentagen."
* einzelgabe.konkretisierung.tageszeit from http://ig.fhir.de/igs/medication/ValueSet/TimingWhenDgMP (required)
* insert Bedarfsangabe
* insert Hinweise
