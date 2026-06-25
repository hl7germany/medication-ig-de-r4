Logical: WeekdaySchemeLogical
Parent: Base
Id: WeekdaySchemeLogical
Title: "Fachliches Informationsmodell für das Schema mit Wochentags-Bezug"
Description: """
Dieses Schema beschreibt eine Anwendung, deren Rhythmus sich über die Woche erstreckt: Das Arzneimittel wird nicht täglich, sondern an bestimmten Wochentagen angewandt. Zu welcher Tages- oder Uhrzeit die Anwendung an diesen Tagen erfolgt, ist nicht Gegenstand dieses Schemas.

"""

* insert Zeitrahmen
* insert Einzelgabe
* einzelgabe.wochentage 1..* Coding "Wochentag(e) der Anwendung, ausgedrückt als montags | dienstags | mittwochs | donnerstags | freitags | samstags | sonntags."
* einzelgabe.wochentage from http://hl7.org/fhir/ValueSet/days-of-week (required)
* insert Bedarfsangabe
* insert Hinweise
