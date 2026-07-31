// Gemeinsame Bausteine für alle Dosierschema-Modelle.
//
// Alle Modelle teilen denselben Aufbau und dieselbe feste Reihenfolge der Elemente:
//   renderedDosageInstruction, danach dosierungsdetails mit der Reihenfolge
//   hinweis -> dosis -> wiederholung -> bedarfsmedikation (-> ergänzende Angaben).
// Die Bausteine werden über "* insert <Name>" in die einzelnen Modelle eingebunden,
// damit alle Schemata dieselbe Struktur teilen und identische Teile nur an einer
// Stelle gepflegt werden.

RuleSet: Kopf
* generierterText 0..1 string "Vollständige Dosierungsangabe als für Menschen lesbarer Text, generiert gemäß Dosis Textgenerierung"
* dosierungsdetails 1..* BackboneElement "Strukturierte Angaben zur Dosierung"

RuleSet: Hinweis
* dosierungsdetails.hinweis 0..1 string "Ergänzender Anwendungshinweis im Freitext, der sich nicht strukturiert abbilden lässt, aber für die sichere, korrekte oder verständliche Anwendung wichtig ist (z.B. „mit ausreichend Wasser einnehmen“ oder „nicht auf nüchternen Magen“)."

RuleSet: Dosis
* dosierungsdetails.dosis[x] 1..1 Quantity or Ratio or Range "Menge des Arzneimittels je Anwendung. Möglich sind ein fester Wert (z.B. „1 Tablette“), ein Bereich (z.B. „1 bis 2 Tabletten“) oder eine Obergrenze (z.B. „bis zu 2 Tabletten“)."

RuleSet: Wiederholung
* dosierungsdetails.wiederholung 0..1 BackboneElement "Angaben dazu, wann und in welchem Rhythmus die Dosierung angewendet wird. Hierzu gehören der Zeitraum der Gültigkeit sowie, je nach Schema, Häufigkeit, Wochentage, Uhrzeiten oder Tageszeiten."
  * zeitrahmen 0..1 BackboneElement "Zeitraum, für den die Dosieranweisung gilt. Er legt fest, ab wann, bis wann oder für wie lange angewendet werden soll, entweder über eine Dauer (z.B. „für eine Woche“) oder über ein Start- und/oder Enddatum."
    * dauer[x] 0..1 Duration or Range "Dauer der Anwendung in Tagen, Wochen oder Monaten. Möglich sind ein fester Wert (z.B. „1 Woche“), ein Bereich (z.B. „1 bis 2 Wochen“) oder eine Obergrenze (z.B. „bis zu 2 Wochen“). Nicht gleichzeitig mit Start- oder Enddatum zulässig."
    * startzeitpunkt 0..1 BackboneElement "Zeitpunkt, ab dem die Dosierangabe gilt. Kann allein oder gemeinsam mit einem Endzeitpunkt angegeben werden."
      * startdatum 1..1 date "Datum, ab dem die Anwendung beginnen soll."
      * startuhrzeit 0..1 time "Uhrzeit am Startdatum, falls der Beginn auf die Uhrzeit genau festgelegt werden soll. Nur zusammen mit einem Startdatum zulässig."
    * endzeitpunkt 0..1 BackboneElement "Zeitpunkt, bis zu dem die Dosierangabe gilt. Kann allein oder gemeinsam mit einem Startzeitpunkt angegeben werden."
      * enddatum 1..1 date "Datum, bis zu dem die Anwendung fortgeführt werden soll."
      * enduhrzeit 0..1 time "Uhrzeit am Enddatum, falls das Ende auf die Uhrzeit genau festgelegt werden soll. Nur zusammen mit einem Enddatum zulässig."

RuleSet: Bedarf
* dosierungsdetails.bedarfsmedikation 0..1 boolean "Kennzeichen, dass die Anwendung nur bei tatsächlichem Bedarf erfolgen soll."
* dosierungsdetails.einnahmeanlass 0..1 string "Anlass oder Bedingung, bei der das Arzneimittel im Bedarfsfall angewendet werden soll (z.B. „bei Schmerzen“ oder „bei Fieber über 38,5 °C“)."
