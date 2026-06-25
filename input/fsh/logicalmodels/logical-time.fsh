Logical: TimeSchemeLogical
Parent: Base
Id: TimeSchemeLogical
Title: "Fachliches Informationsmodell für das Schema mit Uhrzeiten-Bezug"
Description: """
Dieses Schema beschreibt die tägliche Anwendung eines Arzneimittels zu konkreten Uhrzeiten. 
Es eignet sich insbesondere für Arzneimittel, bei denen klar definierte Zeitpunkte maßgeblich sind, etwa um einen möglichst 
konstanten Wirkspiegel zu erreichen.
"""

* insert Zeitrahmen
* insert Einzelgabe
* einzelgabe.uhrzeiten 1..* time "Uhrzeit(en) der Anwendung."
* insert Bedarfsangabe
* insert Hinweise
