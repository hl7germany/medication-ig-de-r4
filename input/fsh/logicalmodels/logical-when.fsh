Logical: WhenSchemeLogical
Parent: Base
Id: WhenSchemeLogical
Title: "Fachliches Informationsmodell für das Schema mit Tageszeiten-Bezug"
Description: """
Dieses Schema beschreibt die tägliche Anwendung eines Arzneimittels, ausgerichtet an den Tageszeiten "Morgen", "Mittag", "Abend" und "Nacht".
Welchen Zeitraum eine Tageszeit im Einzelfall konkret beschreibt, ergibt sich aus dem Tagesablauf der anwendenden Person oder aus 
einrichtungsinternen Konventionen.

Es ist das in Deutschland gebräuchlichste Dosierschema, wird häufig auch als "Viererschema" oder "MMAN-Schema" bezeichnet und üblicherweise
als Kette von vier Zahlen dargestellt (z.B. „1-0-2-0") dargestellt. 
"""

* insert Zeitrahmen
* insert Einzelgabe
* einzelgabe.tageszeiten 1..* Coding "Tageszeit(en) der Anwendung, ausgedrückt als morgens | mittags | abends | zur Nacht."
* einzelgabe.tageszeiten from http://ig.fhir.de/igs/medication/ValueSet/TimingWhenDgMP (required)
* insert Bedarfsangabe
* insert Hinweise
