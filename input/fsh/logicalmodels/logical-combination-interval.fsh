Logical: IntervalCombinationSchemeLogical
Parent: Base
Id: IntervalCombinationSchemeLogical
Title: "Fachliches Informationsmodell für das Schema für Kombinationen von Zeitintervallen"
Description: """
Dieses Schema beschreibt eine Anwendung in regelmäßigen Abständen, die zusätzlich tageszeitlich oder uhrzeitlich verankert ist. 
Das Intervall setzt sich aus der Frequenz (wie oft) und der Periode (je welchem Zeitraum) zusammen; die Periode beträgt dabei 
mindestens einen Tag. Die ergänzenden Tageszeiten oder Uhrzeiten konkretisieren somit, wann die Anwendung an den vom
Intervall betroffenen Tagen erfolgen sollte. 
Das Schema stellt damit eine Kombination des Schemas für wiederkehrende Intervalle mit entweder
dem Schema mit Tageszeiten-Bezug oder dem Schema mit Uhrzeiten-Bezug dar.
"""

* insert Zeitrahmen
* insert Einzelgabe
* einzelgabe.frequenz[x] 1..1 positiveInt or Range "Häufigkeit: wie oft je Periode eine Dosis anzuwenden ist. Die Angabe kann als fester Wert (z.B. \"1\"), Bereich (z.B. \"1-2\") oder Obergrenze (\"bis zu 2\") erfolgen. Nur ganze Zahlen sind zulässig."
* einzelgabe.periode[x] 1..1 Duration or Range "Zeitraum, auf den sich die Häufigkeit bezieht. Die Angabe kann als fester Wert (z.B. \"1 Woche\"), Bereich (z.B. \"1-2 Wochen\") oder Obergrenze (\"bis zu 2 Wochen\") erfolgen. Mögliche Einheiten: Tag, Woche und Monat. Nur ganze Zahlen sind zulässig."
* einzelgabe.konkretisierung 0..1 BackboneElement "Konkretisierung des Zeitpunkts der Anwendung an den vom Intervall betroffenen Tagen, ausgedrückt entweder in Tageszeiten oder in Uhrzeiten."
  * tageszeit 0..* Coding "Tageszeit(en) an den vom Intervall betroffenen Tagen, ausgedrückt als morgens | mittags | abends | zur Nacht."
  * uhrzeit 0..* time "Uhrzeit(en) der Anwendung an den vom Intervall betroffenen Tagen."
* einzelgabe.konkretisierung.tageszeit from http://ig.fhir.de/igs/medication/ValueSet/TimingWhenDgMP (required)
* insert Bedarfsangabe
* insert Hinweise
