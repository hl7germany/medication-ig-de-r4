// Gemeinsame Bausteine für alle Dosierschema-Modelle.
// Werden über "* insert <Name>" in die einzelnen Logical Models eingebunden,
// damit die identischen Teile nur an einer Stelle gepflegt werden.

RuleSet: Zeitrahmen
* zeitrahmen 0..1 BackboneElement "Zeitrahmen, innerhalb dessen das Dosierschema anzuwenden ist. Wird entweder als Dauer oder über Start- und/oder Endzeitpunkt angegeben."
  * dauer[x] 0..1 Duration or Range "Dauer der Anwendung in Tagen, Wochen oder Monaten. Die Angabe kann als fester Wert (z.B. \"1 Woche\"), Bereich (z.B. \"1-2 Wochen\") oder Obergrenze (\"bis zu 2 Wochen\") erfolgen. Nicht zusammen mit Start-/Enddatum zulässig."
  * startzeitpunkt 0..1 BackboneElement "Zeitpunkt, ab dem das Dosierschema anzuwenden ist. Kann allein oder zusammen mit einem Endzeitpunkt angegeben werden."
    * startdatum 1..1 date "Datum, ab dem das Dosierschema anzuwenden ist."
    * startuhrzeit 0..1 time "Uhrzeit am Startdatum. Nur zusammen mit einem Startdatum gültig."
  * endzeitpunkt 0..1 BackboneElement "Zeitpunkt, bis zu dem das Dosierschema anzuwenden ist. Kann allein oder zusammen mit einem Startzeitpunkt angegeben werden."
    * enddatum 1..1 date "Datum, bis zu dem das Dosierschema anzuwenden ist."
    * enduhrzeit 0..1 time "Uhrzeit am Enddatum. Nur zusammen mit einem Enddatum gültig."
//* zeitrahmen obeys zr-dauer-vs-datum
//* zeitrahmen obeys zr-start-vor-ende

RuleSet: Einzelgabe
* einzelgabe 1..* BackboneElement "Eine einzelne Gabe (Anwendung) des Arzneimittels mit der zugehörigen Dosis und ihrem Zeitbezug. Bei mehreren Zeitpunkten kann die Dosis je Zeitpunkt abweichen."
  * dosis[x] 1..1 Quantity or Ratio or Range "Dosis pro Gabe. Die Angabe kann als fester Wert (z.B. \"1 Tablette\"), Bereich (z.B. \"1-2 Tabletten\") oder Obergrenze (\"bis zu 2 Tabletten\") erfolgen."
//* einzelgabe obeys eg-dosis-range

RuleSet: Bedarfsangabe
* einzelgabe.bedarfsmedikation 0..1 boolean "Kennzeichnung, dass die Anwendung ausschließlich im Falle eines konkreten Bedarfs erfolgen soll."
* einzelgabe.einnahmeanlass 0..1 string "Auslöser oder Bedingung, bei deren Auftreten das Arzneimittel im vorliegenden Schema angewandt werden soll."

RuleSet: Hinweise
* hinweise 0..1 BackboneElement "Weiterführende Hinweise, die die intendierte Anwendung des Arzneimittels präzisieren."
  * verabreichungsweg 0..1 Coding "Verabreichungsweg (Route of Administration, ROA), über den ein Therapeutikum in oder auf den Körper eines Patienten appliziert werden soll. Kodierung gemäß EDQM Standard Terms (Route of Administration)."
  * ergaenzendeHinweise 0..1 string "Ergänzende, nicht strukturiert abbildbare Anwendungshinweise im Freitext für die sichere, korrekte oder verständliche Anwendung."
