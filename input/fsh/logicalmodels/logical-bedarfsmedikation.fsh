Logical: PRNSchemeLogical
Parent: Base
Id: PRNSchemeLogical
Title: "Fachliches Informationsmodell für das Schema Bedarfsmedikation"
Description: """
Dieses Schema beschreibt die situative Anwendung eines Arzneimittels, ausgelöst durch einen konkreten Anlass ("Bedarf"), 
etwa Schmerzen, einen erhöhten Messwert oder einen Risikokontakt. Einen im Voraus festgelegter Anwendungszeitpunkt 
besteht nicht; dadurch unterscheidet sich dieses Schema von anderen Schemata, in denen die Anwendung ebenfalls bedarfsadaptiert,
im Bedarfsfall aber zu festen Zeitpunkten erfolgt. 
"""

* insert Zeitrahmen
* einnahmeanlass 0..* string "Auslöser oder Bedingung, bei deren Auftreten das Arzneimittel angewandt werden soll."
* dosis[x] 1..1 Quantity or Ratio or Range "Dosis pro Gabe. Die Angabe kann als fester Wert (z.B. \"1 Tablette\"), Bereich (z.B. \"1-2 Tabletten\") oder Obergrenze (\"bis zu 2 Tabletten\") erfolgen."
* mindestabstand 0..1 Duration "Mindestzeit, die zwischen zwei aufeinanderfolgenden Einzelgaben einzuhalten ist. Optionale Angabe. Zulässige Einheiten: Stunde und Minute."
* maximaldosis 0..1 Quantity "Maximale Dosis des Arzneimittels, die innerhalb von 24 Stunden (1 Tag) angewandt werden darf. Die Einheit entspricht der Einheit der Einzeldosis."
* insert Hinweise
