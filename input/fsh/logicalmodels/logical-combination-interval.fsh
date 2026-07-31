Logical: IntervalCombinationSchemeLogical
Parent: Base
Id: IntervalCombinationSchemeLogical
Title: "Fachliches Informationsmodell für das Schema für Kombinationen von Zeitintervallen"
Description: """
Dieses Modell beschreibt eine Anwendung in regelmäßigen Abständen, die zusätzlich an Tageszeiten oder
eine Uhrzeiten gebunden ist. 

Die Häufigkeit ergibt sich aus drei Angaben: Die Frequenz (wie oft) und die Periode (je welchem Zeitraum; mindestens ein Tag) 
beschreiben, an welchen Tagen das Arzneimittel anzuwenden ist. Die ergänzende Tageszeit oder Uhrzeit legt fest, wann an den vom
Intervall betroffenen Tagen das Arzneimittel angewendet werden soll.

Das Modell ist damit eine Kombination des Schemas für wiederkehrende Intervalle mit entweder dem Schema
mit Tageszeiten-Bezug oder dem Schema mit Uhrzeiten-Bezug.
"""

* insert Kopf
* insert Hinweis
* insert Dosis
* insert Zeitangaben
* dosierungsdetails.zeitangaben.haeufigkeit 1..1 Base "Häufigkeit der Anwendung: wie oft je Zeitraum eine Dosis angewendet wird (z.B. „jeden zweiten Tag“)."
  * anzahl 1..1 Base "Wie oft je Periode eine Dosis angewendet wird."
    * wert 1..1 positiveInt "Anzahl; bei einer Bereichsangabe die untere Grenze (z.B. 1). Nur ganze Zahlen."
    * wertBis 0..1 positiveInt "Obere Grenze bei einer Bereichs- oder Obergrenzenangabe (z.B. 2 für „1 bis 2“ oder „bis zu 2“). Nur ganze Zahlen."
  * periode 1..1 Base "Zeitraum, auf den sich die Anzahl bezieht."
    * wert 1..1 decimal "Zahlenwert des Zeitraums; bei einer Bereichsangabe die untere Grenze (z.B. 1)."
    * wertBis 0..1 decimal "Obere Grenze bei einer Bereichsangabe (z.B. 2 für „1 bis 2 Wochen“)."
    * einheit 1..1 Coding "Zeiteinheit: Tag, Woche oder Monat."
* dosierungsdetails.zeitangaben.haeufigkeit.periode.einheit from PeriodUnitsOfTimeDgMPVS (required)
* dosierungsdetails.zeitangaben.uhrzeiten 0..* time "Uhrzeit(en) der Anwendung an den vom Intervall betroffenen Tagen. Alternativ zur Tageszeit anzugeben."
* dosierungsdetails.zeitangaben.tageszeiten 0..* Coding "Tageszeit(en) an den vom Intervall betroffenen Tagen, ausgedrückt als morgens | mittags | abends | zur Nacht. Alternativ zur Uhrzeit anzugeben."
* dosierungsdetails.zeitangaben.tageszeiten from http://ig.fhir.de/igs/medication/ValueSet/TimingWhenDgMP (required)
* insert Bedarf
