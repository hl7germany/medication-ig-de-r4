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
* insert Wiederholung
* dosierungsdetails.wiederholung.haeufigkeit 1..1 Base "Häufigkeit der Anwendung: wie oft je Zeitraum eine Dosis angewendet wird (z.B. „jeden zweiten Tag“)."
  * anzahl[x] 1..1 positiveInt or Range "Wie oft je Periode eine Dosis angewendet wird. Möglich sind ein fester Wert (z.B. „1“), ein Bereich (z.B. „1 bis 2“) oder eine Obergrenze (z.B. „bis zu 2“). Nur ganze Zahlen sind zulässig."
  * periode[x] 1..1 Duration or Range "Zeitraum, auf den sich die Anzahl bezieht. Möglich sind ein fester Wert (z.B. „1 Woche“), ein Bereich (z.B. „1 bis 2 Wochen“) oder eine Obergrenze (z.B. „bis zu 2 Wochen“). Mögliche Einheiten: Tag, Woche und Monat. Nur ganze Zahlen sind zulässig."
* dosierungsdetails.wiederholung.uhrzeiten 0..* time "Uhrzeit(en) der Anwendung an den vom Intervall betroffenen Tagen. Alternativ zur Tageszeit anzugeben."
* dosierungsdetails.wiederholung.tageszeiten 0..* Coding "Tageszeit(en) an den vom Intervall betroffenen Tagen, ausgedrückt als morgens | mittags | abends | zur Nacht. Alternativ zur Uhrzeit anzugeben."
* dosierungsdetails.wiederholung.tageszeiten from http://ig.fhir.de/igs/medication/ValueSet/TimingWhenDgMP (required)
* insert Bedarf
