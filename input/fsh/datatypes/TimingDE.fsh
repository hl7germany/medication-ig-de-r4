Profile: TimingDE
Parent: Timing
Id: TimingDE
Title: "Timing DE"
Description: "Beschreibt ein Ereignis, das mehrfach auftreten kann. Zeitpläne werden verwendet, um festzuhalten, wann etwas geplant, erwartet oder angefordert ist. Die häufigste Anwendung ist in Dosierungsanweisungen für Medikamente. Sie werden aber auch für die Planung verschiedener Versorgungsleistungen genutzt und können zur Dokumentation von bereits erfolgten oder laufenden Aktivitäten verwendet werden."

* repeat MS
  * ^short = "Wann das Ereignis stattfinden soll"
  * ^definition = "Eine Menge von Regeln, die beschreiben, wann das Ereignis geplant ist."
  * obeys TimingSingleDosageForTimeOfDay
  * obeys TimingSingleDosageForWhen
  * obeys TimingBoundsUnitMatchesCode
* repeat.bounds[x] MS
  * ^short = "Länge/Bereich der Längen oder (Start- und/oder End-)Grenzen"
  * ^definition = "Entweder eine Dauer für die Länge des Zeitplans, ein Bereich möglicher Längen oder äußere Begrenzungen für Start- und/oder Endgrenzen des Zeitplans."
  * ^comment = "tbd"
* repeat.boundsDuration MS
  * ^short = "Dauer der Dosieranweisung ausgedrückt in UCUM-Einheiten"
  * ^definition = "Entweder eine Dauer für die Länge des Zeitplans, ein Bereich möglicher Längen oder äußere Begrenzungen für Start- und/oder Endgrenzen des Zeitplans."
  * system MS
  * system = $ucum (exactly)
    * ^short = "UCUM-Einheit für die Dauer"
    * ^comment = "Die UCUM-Einheit für die Dauer, z. B. d für Tag, h für Stunde, min für Minute."
  * code MS
  * unit MS
  * value MS
* repeat.frequency MS
  * ^short = "Ereignis tritt frequency-mal pro Zeitraum auf"
  * ^definition = "Die Anzahl der Wiederholungen innerhalb des angegebenen Zeitraums. Falls frequencyMax vorhanden ist, gibt dieses Element die Untergrenze des zulässigen Bereichs der Häufigkeit an."
* repeat.period MS
  * ^short = "Ereignis tritt frequency-mal pro Zeitraum auf"
  * ^definition = "Gibt die Zeitspanne an, über die die Wiederholungen stattfinden sollen; z. B. um „3-mal täglich“ auszudrücken, wäre 3 die Häufigkeit und „1 Tag“ der Zeitraum. Falls periodMax vorhanden ist, gibt dieses Element die Untergrenze des zulässigen Bereichs der Zeitspanne an."
* repeat.periodUnit MS
  * ^short = "s | min | h | d | wk | mo | a - Zeiteinheit (UCUM)"
  * ^definition = "Die Zeiteinheit für den Zeitraum, in UCUM-Einheiten."
* repeat.dayOfWeek MS
  * ^short = "mon | tue | wed | thu | fri | sat | sun"
  * ^definition = "Wenn ein oder mehrere Wochentage angegeben sind, findet die Aktion nur an den angegebenen Tagen statt."
  * ^comment = "Wenn keine Tage angegeben sind, wird angenommen, dass die Aktion an jedem Tag wie sonst angegeben stattfindet."
* repeat.timeOfDay MS
  * ^short = "Tageszeit für die Aktion"
  * ^definition = "Angegebene Tageszeit, zu der die Aktion stattfinden soll."
  * ^comment = "Wenn eine Tageszeit angegeben ist, wird angenommen, dass die Aktion jeden Tag (ggf. gefiltert durch dayOfWeek) zu den angegebenen Zeiten stattfindet."
* repeat.when MS
  * ^short = "Code für den Zeitraum des Auftretens"
  * ^definition = "Ein ungefährer Zeitraum während des Tages, der möglicherweise mit einem Ereignis des täglichen Lebens verknüpft ist und angibt, wann die Aktion stattfinden soll."
  * ^comment = "Wenn mehr als ein Ereignis angegeben ist, bezieht sich das Ereignis auf die Vereinigung der angegebenen Ereignisse."

Invariant: TimingSingleDosageForTimeOfDay
Description: "Wenn nur timeOfDay verwendet wird und täglich dosiert wird, ist die Angabe in einem einzigen Dosage-Element zu modellieren. Mehrere Dosage-Elemente sind nur zulässig, wenn sich die Dosis (Wert) unterscheidet."
Expression: "(
  %resource.ofType(MedicationRequest).dosageInstruction
  | %resource.ofType(MedicationDispense).dosageInstruction
  | %resource.ofType(MedicationStatement).dosage
).all(
  (
    timing.repeat.dayOfWeek.empty() and
    timing.repeat.timeOfDay.exists() and
    timing.repeat.when.empty() and
    (timing.repeat.period.exists() and timing.repeat.period = 1) and
    (timing.repeat.periodUnit.exists() and timing.repeat.periodUnit = 'd')
  )
  implies
  (
    (
      (
        %resource.ofType(MedicationRequest).dosageInstruction
        | %resource.ofType(MedicationDispense).dosageInstruction
        | %resource.ofType(MedicationStatement).dosage
      ).where(
        timing.repeat.dayOfWeek.empty() and timing.repeat.timeOfDay.exists() and timing.repeat.when.empty() and (timing.repeat.period.exists() and timing.repeat.period = 1) and (timing.repeat.periodUnit.exists() and timing.repeat.periodUnit = 'd')
      ).count() = 1
    )
    or
    (
      (
        %resource.ofType(MedicationRequest).dosageInstruction
        | %resource.ofType(MedicationDispense).dosageInstruction
        | %resource.ofType(MedicationStatement).dosage
      ).where(
        timing.repeat.dayOfWeek.empty() and timing.repeat.timeOfDay.exists() and timing.repeat.when.empty() and (timing.repeat.period.exists() and timing.repeat.period = 1) and (timing.repeat.periodUnit.exists() and timing.repeat.periodUnit = 'd')
      ).doseAndRate.dose.ofType(Quantity).value.distinct().count() > 1
    )
  )
)
"
Severity: #error

Invariant: TimingSingleDosageForWhen
Description: "Wenn nur when verwendet wird und täglich dosiert wird, ist die Angabe in einem einzigen Dosage-Element zu modellieren. Mehrere Dosage-Elemente sind nur zulässig, wenn sich die Dosis (Wert) unterscheidet."
Expression: "(
  %resource.ofType(MedicationRequest).dosageInstruction
  | %resource.ofType(MedicationDispense).dosageInstruction
  | %resource.ofType(MedicationStatement).dosage
).all(
  (
    timing.repeat.dayOfWeek.empty() and
    timing.repeat.when.exists() and
    timing.repeat.timeOfDay.empty() and
    (timing.repeat.period.exists() and timing.repeat.period = 1) and
    (timing.repeat.periodUnit.exists() and timing.repeat.periodUnit = 'd')
  )
  implies
  (
    (
      (
        %resource.ofType(MedicationRequest).dosageInstruction
        | %resource.ofType(MedicationDispense).dosageInstruction
        | %resource.ofType(MedicationStatement).dosage
      ).where(
        timing.repeat.dayOfWeek.empty() and timing.repeat.when.exists() and timing.repeat.timeOfDay.empty() and (timing.repeat.period.exists() and timing.repeat.period = 1) and (timing.repeat.periodUnit.exists() and timing.repeat.periodUnit = 'd')
      ).count() = 1
    )
    or
    (
      (
        %resource.ofType(MedicationRequest).dosageInstruction
        | %resource.ofType(MedicationDispense).dosageInstruction
        | %resource.ofType(MedicationStatement).dosage
      ).where(
        timing.repeat.dayOfWeek.empty() and timing.repeat.when.exists() and timing.repeat.timeOfDay.empty() and (timing.repeat.period.exists() and timing.repeat.period = 1) and (timing.repeat.periodUnit.exists() and timing.repeat.periodUnit = 'd')
      ).doseAndRate.dose.ofType(Quantity).value.distinct().count() > 1
    )
  )
)
"
Severity: #error

Invariant: TimingBoundsUnitMatchesCode
Description: "boundsDuration.unit muss zur UCUM boundsDuration.code passen (z. B. 'Woche(n)' nur mit code='wk')."
Expression: "bounds.ofType(Duration).exists().not() or (
  (
    bounds.ofType(Duration).code = 'd'
    implies 
    (
      bounds.ofType(Duration).unit = 'Tag(e)' or
      bounds.ofType(Duration).unit = 'Tag' or
      bounds.ofType(Duration).unit = 'Tage'
    )
  ) and (
    bounds.ofType(Duration).code = 'wk'
    implies 
    (
      bounds.ofType(Duration).unit = 'Woche(n)' or
      bounds.ofType(Duration).unit = 'Woche' or
      bounds.ofType(Duration).unit = 'Wochen'
    )
  ) and (
    bounds.ofType(Duration).code = 'mo'
    implies 
    (
      bounds.ofType(Duration).unit = 'Monat(e)' or
      bounds.ofType(Duration).unit = 'Monat' or
      bounds.ofType(Duration).unit = 'Monate'
    )
  ) and (
    bounds.ofType(Duration).code = 'a'
    implies 
    (
      bounds.ofType(Duration).unit = 'Jahr(e)' or
      bounds.ofType(Duration).unit = 'Jahr' or
      bounds.ofType(Duration).unit = 'Jahre'
    )
  )
)"
Severity: #error