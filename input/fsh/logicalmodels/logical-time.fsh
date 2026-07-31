Logical: TimeSchemeLogical
Parent: Base
Id: TimeSchemeLogical
Title: "Fachliches Informationsmodell für das Schema mit Uhrzeiten-Bezug"
Description: """
Dieses Modell beschreibt die tägliche Anwendung eines Arzneimittels zu konkreten Uhrzeiten.

Im Unterschied zum Schema mit Tageszeiten-Bezug wird hier bewusst eine feste Uhrzeit und 
nicht nur ein grober Tagesabschnitt angegeben. Es eignet sich vor allem für Arzneimittel, 
bei denen der genaue Zeitpunkt wichtig ist, etwa um einen
möglichst gleichmäßigen Wirkspiegel im Körper zu erreichen. 
"""

* insert Kopf
* insert Hinweis
* insert Dosis
* insert Wiederholung
* dosierungsdetails.wiederholung.uhrzeiten 1..* time "Uhrzeit(en) der Anwendung"
* insert Bedarf
