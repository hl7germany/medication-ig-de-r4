Logical: PRNSchemeLogical
Parent: Base
Id: PRNSchemeLogical
Title: "Fachliches Informationsmodell für das Schema Bedarfsmedikation"
Description: """
Dieses Modell beschreibt die Anwendung eines Arzneimittels nur bei Bedarf, das heißt ausgelöst durch einen
konkreten Anlass wie Schmerzen, einen erhöhten Messwert oder einen Risikokontakt. Ein im Voraus
festgelegter Anwendungszeitpunkt besteht nicht: Das Arzneimittel wird angewendet, wenn der Anlass eintritt.

Dadurch unterscheidet sich dieses Modell von anderen Schemata, bei denen die Anwendung zwar ebenfalls an
den Bedarf angepasst sein kann, im Bedarfsfall aber zu festen Zeitpunkten erfolgt.

Da kein konkreter Anwendungszeitpunkt festgelegt ist, kann festgelegt werden, welcher Mindestabstand
zwischen zwei Anwendungen einzuhalten ist und welche Höchstmenge pro Tag nicht überschritten werden darf, um 
Fehldosierungen zu vermeiden.
"""

* insert Kopf
* insert Hinweis
* insert Dosis
* insert Wiederholung
* dosierungsdetails.einnahmeanlass 0..1 string "Anlass oder Bedingung, bei deren Auftreten das Arzneimittel angewendet werden soll (z.B. „bei Schmerzen“ oder „bei Fieber über 38,5 °C“)."
* dosierungsdetails.mindestabstand 0..1 Duration "Mindestzeit, die zwischen zwei aufeinanderfolgenden Anwendungen einzuhalten ist. Möglich sind ein fester Wert (z.B. „1 Stunde“), ein Bereich (z.B. „1 bis 2 Stunden“) oder eine Obergrenze (z.B. „bis zu 2 Stunden“). Zulässige Einheiten: Stunde und Minute."
* dosierungsdetails.maximaldosis 0..1 Quantity "Höchstmenge des Arzneimittels, die innerhalb von 24 Stunden (1 Tag) angewendet werden darf. Die Einheit entspricht der Einheit der Einzeldosis."
