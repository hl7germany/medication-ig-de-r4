Logical: IntervalSchemeLogical
Parent: Base
Id: IntervalSchemeLogical
Title: "Fachliches Informationsmodell für das Schema für wiederkehrende Intervalle"
// Zum Anpassen der Beschreibung siehe StructureDefinition-IntervalSchemeLogical-intro.md

* insert Kopf
* insert Hinweis
* insert Dosis
* insert Zeitangaben
* dosierungsdetails.zeitangaben.haeufigkeit 1..1 Base "Häufigkeit der Anwendung: wie oft je Zeitraum eine Dosis angewendet wird (z.B. „dreimal täglich“)."
  * frequenz 1..1 Base "Wie oft je Periode eine Dosis angewendet wird."
    * wert 1..1 positiveInt "Anzahl; bei einer Bereichsangabe die untere Grenze (z.B. 1). Nur ganze Zahlen."
    * wertBis 0..1 positiveInt "Obere Grenze bei einer Bereichs- oder Obergrenzenangabe (z.B. 2 für „1 bis 2“ oder „bis zu 2“). Nur ganze Zahlen."
  * periode 1..1 Base "Zeitraum, auf den sich die Frequenz bezieht."
    * wert 1..1 decimal "Zahlenwert des Zeitraums; bei einer Bereichsangabe die untere Grenze (z.B. 1)."
    * wertBis 0..1 decimal "Obere Grenze bei einer Bereichsangabe (z.B. 2 für „1 bis 2 Tage“)."
    * einheit 1..1 Coding "Zeiteinheit: Minute, Stunde, Tag, Woche oder Monat."
* insert Bedarf
