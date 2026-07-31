Logical: WeekdaySchemeLogical
Parent: Base
Id: WeekdaySchemeLogical
Title: "Fachliches Informationsmodell für das Schema mit Wochentags-Bezug"
Description: """
Dieses Modell beschreibt eine Anwendung, deren Rhythmus sich über die Woche erstreckt: Das Arzneimittel
wird nicht täglich, sondern nur an bestimmten Wochentagen angewendet.

Zu welcher Tages- oder Uhrzeit die Anwendung an diesen Tagen erfolgt, ist nicht Gegenstand dieses
Modells. Soll zusätzlich die Tageszeit oder Uhrzeit festgelegt werden, ist das Schema für Kombinationen
von Wochentagen zu verwenden.
"""

* insert Kopf
* insert Hinweis
* insert Dosis
* insert Zeitangaben
* dosierungsdetails.zeitangaben.wochentage 1..* Coding "Wochentag(e) der Anwendung, ausgedrückt als montags | dienstags | mittwochs | donnerstags | freitags | samstags | sonntags."
* dosierungsdetails.zeitangaben.wochentage from http://hl7.org/fhir/ValueSet/days-of-week (required)
* insert Bedarf
