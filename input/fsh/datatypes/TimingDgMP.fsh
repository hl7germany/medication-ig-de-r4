Profile: TimingDgMP
Parent: TimingDE
Id: TimingDgMP
Title: "Timing dgMP"
Description: "Beschreibt ein Ereignis, das mehrfach auftreten kann. Zeitpläne werden verwendet, um festzuhalten, wann etwas geplant, erwartet oder angefordert ist. Die häufigste Anwendung ist in Dosierungsanweisungen für Medikamente. Sie werden aber auch für die Planung verschiedener Versorgungsleistungen genutzt und können zur Dokumentation von bereits erfolgten oder laufenden Aktivitäten verwendet werden."
* event 0..0
  * ^comment = "Begründung Einschränkung Kardinalität: Der Zeitpunkt des Ereignisses ist in der ersten Ausbaustufe des dgMP nicht vorgesehen, um die Komplexität zu reduzieren und die Übersichtlichkeit zu erhöhen."
* code 0..0
  * ^comment = "Begründung Einschränkung Kardinalität: Ein Timing-Code ist in der ersten Ausbaustufe des dgMP nicht vorgesehen, um die Komplexität zu reduzieren und die Übersichtlichkeit zu erhöhen. Stattdessen muss das Zeitmuster explizit strukturiert angegeben werden."
// TimingOnlyOnePeriodForDayOfWeek moved out of repeat to fix an overflow of IG Publisher while creating Excel sheets. Invariant uses %resource move didn't change any semantics
* obeys TimingOnlyOnePeriodForDayOfWeek
* repeat 1..1 MS
  * obeys TimingOnlyOneType
  * obeys TimingIntervalOnlyOneFrequency
  * obeys TimingOnlyOneWhen
  * obeys TimingOnlyWhenOrTimeOfDay
  * obeys TimingOnlyOneTimeOfDay
  * obeys TimingOnlyOneDayOfWeek
  * obeys TimingOnlyOneTimeForInterval
  * obeys TimingOnlyOneBounds
  * obeys TimingFrequencyCount
  * obeys TimingPeriodUnit
  * obeys TimingPeriodOnlyWholeNumber
  * obeys TimingBoundsDurationOnlyWholeNumber
  * obeys TimingFreqOrPeriodGtOne
  * obeys TimingVarFreqGtMin
  * obeys TimingVarPeriodGtMin
  * obeys TimingSingleDosageForTimeOfDay
  * obeys TimingSingleDosageForWhen
  * obeys TimingBoundsUnitMatchesCode
  * bounds[x] MS
  * bounds[x] only Duration or Period
    * ^comment = "Begründung Einschränkung Datentyp: Nur eine Angabe zur Dauer und Start- bzw. Enddatum sind in der aktuellen Ausbaustufe des dgMP vorgesehen, um die Komplexität zu reduzieren und die Übersichtlichkeit zu erhöhen."
  * boundsDuration MS
    * code 1..1 MS
    * code from DurationUnitsOfTimeDgMPVS (required)
    * system 1..1 MS
    * unit 1..1 MS
    * value 1..1 MS
    * comparator 0..0
  * boundsPeriod MS
    * ^short = "Start- und Endzeitpunkt der Dosieranweisung."
    * ^definition = "Beschreibt die Gültigkeit einer Dosieranweisung mit einem konkreten Start- und/oder Endzeitpunkt. Neben einem Datum kann eine Uhrzeit mit Zeitzone angegeben werden."
    * start MS
      * ^short = "Startdatum mit optionaler Uhrzeit und Zeitzone"
    * end MS
      * ^short = "Enddatum mit optionaler Uhrzeit und Zeitzone"
  * frequency 0..1 MS
  * frequencyMax MS
  * period 0..1 MS
  * periodUnit 0..1 MS
    * ^short = "min | h | d | wk | mo - Zeiteinheit (UCUM)"
  * periodUnit from PeriodUnitsOfTimeDgMPVS (required)
  * periodMax MS
  * dayOfWeek MS
  * timeOfDay MS
  * when MS
  * when from TimingWhenDgMPVS (required)

  // Restrict all elements in the repeat backbone to 0..0
  * count 0..0
    * ^comment = "Begründung Einschränkung Kardinalität: Wiederholungen sind in der ersten Ausbaustufe des dgMP nicht vorgesehen, um die Komplexität zu reduzieren und die Übersichtlichkeit zu erhöhen."
  * countMax 0..0
    * ^comment = "Begründung Einschränkung Kardinalität: Maximale Wiederholungen sind in der ersten Ausbaustufe des dgMP nicht vorgesehen, um die Komplexität zu reduzieren und die Übersichtlichkeit zu erhöhen."
  * duration 0..0
    * ^comment = "Begründung Einschränkung Kardinalität: Angaben zur Dauer einer Einzelgabe sind in der ersten Ausbaustufe des dgMP nicht vorgesehen, um die Komplexität zu reduzieren und die Übersichtlichkeit zu erhöhen."
  * durationMax 0..0
    * ^comment = "Begründung Einschränkung Kardinalität: Angaben zur maximalen Dauer einer Einzelgabe sind in der ersten Ausbaustufe desdgMP nicht vorgesehen, um die Komplexität zu reduzieren und die Übersichtlichkeit zu erhöhen."
  * durationUnit 0..0
    * ^comment = "Begründung Einschränkung Kardinalität: Angaben zur Einheit der Dauer einer Einzelgabe sind in der ersten Ausbaustufe desdgMP nicht vorgesehen, um die Komplexität zu reduzieren und die Übersichtlichkeit zu erhöhen."
  * offset 0..0
    * ^short = "Zeitversatz"
    * ^comment = "Begründung Einschränkung Kardinalität: Ein Zeitversatz ist in der ersten Ausbaustufe desdgMP nicht vorgesehen, um die Komplexität zu reduzieren und die Übersichtlichkeit zu erhöhen."

Invariant: TimingSingleDosageForTimeOfDay
Description: "If only timeOfDay is used and dosing is daily, the times must be modelled in a single Dosage element. Multiple Dosage elements are only allowed if every element carries a distinct dose, including its data type."
Expression: "(
  %resource.ofType(MedicationRequest).dosageInstruction
  | %resource.ofType(MedicationDispense).dosageInstruction
  | %resource.ofType(MedicationStatement).dosage
).all(
  (
    timing.repeat.dayOfWeek.empty() and
    timing.repeat.timeOfDay.exists() and
    timing.repeat.when.empty()
  )
  implies
  (
    (
      (
        %resource.ofType(MedicationRequest).dosageInstruction
        | %resource.ofType(MedicationDispense).dosageInstruction
        | %resource.ofType(MedicationStatement).dosage
      ).where(
        timing.repeat.dayOfWeek.empty() and timing.repeat.timeOfDay.exists() and timing.repeat.when.empty()
      ).count() = 1
    )
    or
    (
      (
        %resource.ofType(MedicationRequest).dosageInstruction
        | %resource.ofType(MedicationDispense).dosageInstruction
        | %resource.ofType(MedicationStatement).dosage
      ).where(
        timing.repeat.dayOfWeek.empty() and timing.repeat.timeOfDay.exists() and timing.repeat.when.empty()
      ).doseAndRate.dose.distinct().count()
      =
      (
        %resource.ofType(MedicationRequest).dosageInstruction
        | %resource.ofType(MedicationDispense).dosageInstruction
        | %resource.ofType(MedicationStatement).dosage
      ).where(
        timing.repeat.dayOfWeek.empty() and timing.repeat.timeOfDay.exists() and timing.repeat.when.empty()
      ).count()
    )
  )
)"
Severity: #error

Invariant: TimingSingleDosageForWhen
Description: "If only when is used and dosing is daily, the times of day must be modelled in a single Dosage element. Multiple Dosage elements are only allowed if every element carries a distinct dose, including its data type."
Expression: "(
  %resource.ofType(MedicationRequest).dosageInstruction
  | %resource.ofType(MedicationDispense).dosageInstruction
  | %resource.ofType(MedicationStatement).dosage
).all(
  (
    timing.repeat.dayOfWeek.empty() and
    timing.repeat.when.exists() and
    timing.repeat.timeOfDay.empty()
  )
  implies
  (
    (
      (
        %resource.ofType(MedicationRequest).dosageInstruction
        | %resource.ofType(MedicationDispense).dosageInstruction
        | %resource.ofType(MedicationStatement).dosage
      ).where(
        timing.repeat.dayOfWeek.empty() and timing.repeat.when.exists() and timing.repeat.timeOfDay.empty()
      ).count() = 1
    )
    or
    (
      (
        %resource.ofType(MedicationRequest).dosageInstruction
        | %resource.ofType(MedicationDispense).dosageInstruction
        | %resource.ofType(MedicationStatement).dosage
      ).where(
        timing.repeat.dayOfWeek.empty() and timing.repeat.when.exists() and timing.repeat.timeOfDay.empty()
      ).doseAndRate.dose.distinct().count()
      =
      (
        %resource.ofType(MedicationRequest).dosageInstruction
        | %resource.ofType(MedicationDispense).dosageInstruction
        | %resource.ofType(MedicationStatement).dosage
      ).where(
        timing.repeat.dayOfWeek.empty() and timing.repeat.when.exists() and timing.repeat.timeOfDay.empty()
      ).count()
    )
  )
)"
Severity: #error

Invariant: TimingBoundsUnitMatchesCode
Description: "boundsDuration.unit must match the UCUM boundsDuration.code (e.g. 'Woche(n)' only with code='wk')."
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

Invariant: TimingFreqOrPeriodGtOne
Description: "If frequency and period are given together, only one of them may exceed 1 - either the frequency including frequencyMax or the period including periodMax. A statement in which both exceed 1, such as 'six times within three hours', is hard to express in language and is not needed: the same meaning can be conveyed by adapting the period, e.g. 'every 30 minutes'."
Severity: #error
Expression: "/* Detect Interval only */
(
  timeOfDay.empty() and
  when.empty() and
  dayOfWeek.empty() and
  frequency.exists() and
  period.exists()
) implies
(
  (
    (frequency > 1 or (frequencyMax.exists() and frequencyMax > 1))
    implies
    (
      period = 1 and
      (periodMax.empty() or periodMax = 1)
    )
  )
  and
  (
    (period > 1 or (periodMax.exists() and periodMax > 1))
    implies
    (
      frequency = 1 and
      (frequencyMax.empty() or frequencyMax = 1)
    )
  )
)"

Invariant: TimingVarFreqGtMin
Description: "For a variable frequency, the maximum frequency must be greater than the minimum frequency."
Expression: "frequencyMax.empty() or frequency.empty() or frequency < frequencyMax"
Severity: #error

Invariant: TimingVarPeriodGtMin
Description: "For a variable period, the maximum period must be greater than the minimum period."
Expression: "periodMax.empty() or period.empty() or period < periodMax"
Severity: #error

Invariant: TimingFrequencyCount
Description: "If frequency is given together with when, timeOfDay or dayOfWeek, its value must match the number of concrete administrations."
Expression: "(when.exists() and dayOfWeek.empty() and frequency.exists() implies when.count() = frequency)
and
(when.exists() and dayOfWeek.exists() and frequency.exists() implies (when.count() * dayOfWeek.count()) = frequency)
and
(timeOfDay.exists() and dayOfWeek.empty() and frequency.exists() implies timeOfDay.count() = frequency)
and
(timeOfDay.exists() and dayOfWeek.exists() and frequency.exists() implies (timeOfDay.count() * dayOfWeek.count()) = frequency)
and
(dayOfWeek.exists() and timeOfDay.empty() and when.empty() and frequency.exists() implies dayOfWeek.count() = frequency)"
Severity: #error

Invariant: TimingPeriodUnit
Description: "periodUnit may only be given together with period. With dayOfWeek, only the redundant weekly statement is allowed; with when or timeOfDay without dayOfWeek, days, weeks or months are allowed."
Expression: "periodUnit.empty() or (
  period.exists() and
  (
    (dayOfWeek.exists() and periodUnit = 'wk') or
    (
      dayOfWeek.empty() and
      (
        (when.empty() and timeOfDay.empty()) or
        periodUnit = 'd' or
        periodUnit = 'wk' or
        periodUnit = 'mo'
      )
    )
  )
)"
Severity: #error

Invariant: TimingPeriodOnlyWholeNumber
Description: "period and periodMax must be whole numbers; decimal values are not allowed."
Expression: "(period.exists() implies period mod 1 = 0) and (periodMax.exists() implies periodMax mod 1 = 0)"
Severity: #error

Invariant: TimingOnlyOneType
Description: "Exactly one of the supported timing schemas is allowed. With dayOfWeek, frequency and the pair period = 1 and periodUnit = wk are optional redundant legacy statements; they do not constitute an interval schema. With when or timeOfDay, frequency is optional; a non-daily period distinguishes the daily schema from a time interval combined with a time-of-day or clock-time reference. A variable frequency (frequencyMax) is reserved for the pure interval, because concrete times or weekdays already determine the number of administrations."
Expression: "/* DayOfWeek only; legacy frequency and the exact 1 wk pair are optional */
(
  %resource.ofType(MedicationRequest).dosageInstruction |
  %resource.ofType(MedicationDispense).dosageInstruction |
  %resource.ofType(MedicationStatement).dosage
).all(
  timing.repeat.dayOfWeek.exists() and
  timing.repeat.when.empty() and
  timing.repeat.timeOfDay.empty() and
  timing.repeat.frequencyMax.empty() and
  timing.repeat.periodMax.empty() and
  (
    (timing.repeat.period.empty() and timing.repeat.periodUnit.empty()) or
    (timing.repeat.period = 1 and timing.repeat.periodUnit = 'wk')
  )
) or

/* Interval only (frequency + period + periodUnit, no when/timeOfDay/dayOfWeek) */
(
  %resource.ofType(MedicationRequest).dosageInstruction |
  %resource.ofType(MedicationDispense).dosageInstruction |
  %resource.ofType(MedicationStatement).dosage
).all(
  timing.repeat.frequency.exists() and
  timing.repeat.period.exists() and
  timing.repeat.periodUnit.exists() and
  timing.repeat.when.empty() and
  timing.repeat.timeOfDay.empty() and
  timing.repeat.dayOfWeek.empty()
) or

/* DayOfWeek and Time/4-Schema; legacy frequency and the exact 1 wk pair are optional */
(
  %resource.ofType(MedicationRequest).dosageInstruction | 
  %resource.ofType(MedicationDispense).dosageInstruction | 
  %resource.ofType(MedicationStatement).dosage
).all(
  timing.repeat.dayOfWeek.exists() and
  (
    (timing.repeat.timeOfDay.exists() and timing.repeat.when.empty()) or
    (timing.repeat.when.exists() and timing.repeat.timeOfDay.empty())
  ) and
  timing.repeat.frequencyMax.empty() and
  timing.repeat.periodMax.empty() and
  (
    (timing.repeat.period.empty() and timing.repeat.periodUnit.empty()) or
    (timing.repeat.period = 1 and timing.repeat.periodUnit = 'wk')
  )
) or

/* Daily When or TimeOfDay; frequency is optional, a variable frequency is not */
(
  %resource.ofType(MedicationRequest).dosageInstruction |
  %resource.ofType(MedicationDispense).dosageInstruction |
  %resource.ofType(MedicationStatement).dosage
).all(
  timing.repeat.dayOfWeek.empty() and
  (
    (timing.repeat.timeOfDay.exists() and timing.repeat.when.empty()) or
    (timing.repeat.when.exists() and timing.repeat.timeOfDay.empty())
  ) and
  timing.repeat.frequencyMax.empty() and
  timing.repeat.periodMax.empty() and
  (
    (timing.repeat.period.empty() and timing.repeat.periodUnit.empty()) or
    (timing.repeat.period = 1 and timing.repeat.periodUnit = 'd')
  )
) or

/* Non-daily interval combined with When or TimeOfDay; frequency is optional, a
   variable frequency is not */
(
  %resource.ofType(MedicationRequest).dosageInstruction |
  %resource.ofType(MedicationDispense).dosageInstruction |
  %resource.ofType(MedicationStatement).dosage
).all(
  timing.repeat.dayOfWeek.empty() and
  (
    (timing.repeat.timeOfDay.exists() and timing.repeat.when.empty()) or
    (timing.repeat.when.exists() and timing.repeat.timeOfDay.empty())
  ) and
  timing.repeat.frequencyMax.empty() and
  timing.repeat.period.exists() and
  timing.repeat.periodUnit.exists() and
  (timing.repeat.periodUnit = 'd' or timing.repeat.periodUnit = 'wk' or timing.repeat.periodUnit = 'mo') and
  (
    timing.repeat.periodUnit != 'd' or
    timing.repeat.period != 1 or
    timing.repeat.periodMax.exists()
  )
)"
Severity: #error

Invariant: TimingOnlyOneWhen
Description: "In a schema that uses only when, no part of the day may occur in more than one Dosage element of a resource."
Expression: "( /* Detect when-based schema */
  %resource.ofType(MedicationRequest).dosageInstruction
  | %resource.ofType(MedicationDispense).dosageInstruction
  | %resource.ofType(MedicationStatement).dosage
).all(
    timing.repeat.dayOfWeek.empty() and
    timing.repeat.when.exists() and
    timing.repeat.timeOfDay.empty()
  implies
  (
    (
      (%resource.ofType(MedicationRequest).exists() or %resource.ofType(MedicationDispense).exists())
      implies
      (%resource.dosageInstruction.timing.repeat.when.distinct().count() = %resource.dosageInstruction.timing.repeat.when.count())
    )
    and
    (
      %resource.ofType(MedicationStatement).exists()
      implies
      (%resource.dosage.timing.repeat.when.distinct().count() = %resource.dosage.timing.repeat.when.count())
    )
  )
)"
Severity: #error

Invariant: TimingOnlyWhenOrTimeOfDay
Description: "The Dosage elements of a resource must not mix a time of day (timeOfDay) and a part of the day (when)."
Expression: "(
  %resource.ofType(MedicationRequest).dosageInstruction
  | %resource.ofType(MedicationDispense).dosageInstruction
  | %resource.ofType(MedicationStatement).dosage
).all(
    (timing.repeat.when.exists() or 
    timing.repeat.timeOfDay.exists())
  implies
  (
    (
      (%resource.ofType(MedicationRequest).exists() or %resource.ofType(MedicationDispense).exists())
      implies
      (%resource.dosageInstruction.timing.repeat.when.exists() xor %resource.dosageInstruction.timing.repeat.timeOfDay.exists())
    )
    and
    (
      %resource.ofType(MedicationStatement).exists()
      implies
      (%resource.dosage.timing.repeat.when.exists() xor %resource.dosage.timing.repeat.timeOfDay.exists())
    )
  )
)"
Severity: #error

Invariant: TimingOnlyOneTimeOfDay
Description: "In a schema that uses only timeOfDay, no time of day may occur in more than one Dosage element of a resource."
Expression: "( /* Detect TimeOfDay */
  %resource.ofType(MedicationRequest).dosageInstruction
  | %resource.ofType(MedicationDispense).dosageInstruction
  | %resource.ofType(MedicationStatement).dosage
).all(
  (
    timing.repeat.dayOfWeek.empty() and
    timing.repeat.timeOfDay.exists() and
    timing.repeat.when.empty() 
  )
  implies
  (
    (
      (%resource.ofType(MedicationRequest).exists() or %resource.ofType(MedicationDispense).exists())
      implies
      (%resource.dosageInstruction.timing.repeat.timeOfDay.distinct().count() = %resource.dosageInstruction.timing.repeat.timeOfDay.count())
    )
    and
    (
      %resource.ofType(MedicationStatement).exists()
      implies
      (%resource.dosage.timing.repeat.timeOfDay.distinct().count() = %resource.dosage.timing.repeat.timeOfDay.count())
    )
  )
)"
Severity: #error

Invariant: TimingOnlyOneDayOfWeek
Description: "In a schema that uses only dayOfWeek, no weekday may occur in more than one Dosage element of a resource."
Expression: "( /* Detect DayOfWeek */
  %resource.ofType(MedicationRequest).dosageInstruction
  | %resource.ofType(MedicationDispense).dosageInstruction
  | %resource.ofType(MedicationStatement).dosage
).all(
  (
    timing.repeat.dayOfWeek.exists() and
    timing.repeat.when.empty() and 
    timing.repeat.timeOfDay.empty()
  )
  implies
  (
    (
      (%resource.ofType(MedicationRequest).exists() or %resource.ofType(MedicationDispense).exists())
      implies
      (%resource.dosageInstruction.timing.repeat.dayOfWeek.distinct().count() = %resource.dosageInstruction.timing.repeat.dayOfWeek.count())
    )
    and
    (
      %resource.ofType(MedicationStatement).exists()
      implies
      (%resource.dosage.timing.repeat.dayOfWeek.distinct().count() = %resource.dosage.timing.repeat.dayOfWeek.count())
    )
  )
)"
Severity: #error

Invariant: TimingOnlyOneBounds
Description: "All Dosage elements of a resource must state the same bounds (Duration or Period), and either all of them carry a bounds or none."
Expression: "(
  %resource.ofType(MedicationRequest).dosageInstruction
  | %resource.ofType(MedicationDispense).dosageInstruction
  | %resource.ofType(MedicationStatement).dosage
).all(
  (
    ( /* only one different value and code are allowed*/
      (%resource.ofType(MedicationRequest).exists() or %resource.ofType(MedicationDispense).exists())
      implies
      %resource.dosageInstruction.timing.repeat.bounds.ofType(Duration).exists().not() or
      (
        (%resource.dosageInstruction.timing.repeat.bounds.ofType(Duration).value.distinct().count() = 1)
        and
        (%resource.dosageInstruction.timing.repeat.bounds.ofType(Duration).code.distinct().count() = 1)
      )
    )
    and
    (
      %resource.ofType(MedicationStatement).exists()
      implies
      %resource.dosage.timing.repeat.bounds.ofType(Duration).exists().not() or
      (
        (%resource.dosage.timing.repeat.bounds.ofType(Duration).value.distinct().count() = 1)
        and
        (%resource.dosage.timing.repeat.bounds.ofType(Duration).code.distinct().count() = 1)
      )
    )
    and
    ( /* boundsPeriod: Start und Ende müssen ebenfalls über alle Dosierungen gleich sein.
         Die Textgenerierung liest den Zeitrahmen nur aus dem ersten Dosage-Element. */
      (%resource.ofType(MedicationRequest).exists() or %resource.ofType(MedicationDispense).exists())
      implies
      %resource.dosageInstruction.timing.repeat.bounds.ofType(Period).exists().not() or
      (
        (%resource.dosageInstruction.timing.repeat.bounds.ofType(Period).start.distinct().count() <= 1)
        and
        (%resource.dosageInstruction.timing.repeat.bounds.ofType(Period).end.distinct().count() <= 1)
      )
    )
    and
    (
      %resource.ofType(MedicationStatement).exists()
      implies
      %resource.dosage.timing.repeat.bounds.ofType(Period).exists().not() or
      (
        (%resource.dosage.timing.repeat.bounds.ofType(Period).start.distinct().count() <= 1)
        and
        (%resource.dosage.timing.repeat.bounds.ofType(Period).end.distinct().count() <= 1)
      )
    )
  )
  and
  ( /* Entweder alle Dosage-Elemente tragen einen Zeitrahmen oder keines. Die
       Textgenerierung liest ihn nur aus dem ersten Element; ein Element ohne
       Zeitrahmen wuerde sonst stillschweigend als begrenzt dargestellt. */
    (
      (
        %resource.ofType(MedicationRequest).dosageInstruction |
        %resource.ofType(MedicationDispense).dosageInstruction |
        %resource.ofType(MedicationStatement).dosage
      ).timing.repeat.bounds.exists()
    )
    implies
    (
      (
        %resource.ofType(MedicationRequest).dosageInstruction |
        %resource.ofType(MedicationDispense).dosageInstruction |
        %resource.ofType(MedicationStatement).dosage
      ).all(timing.repeat.bounds.exists())
    )
  )
)"
Severity: #error

Invariant: TimingIntervalOnlyOneFrequency
Description: "If a dosage is defined by a pure interval, only one Dosage element is allowed in the resource."
Expression: "( /* Detect Interval */
  %resource.ofType(MedicationRequest).dosageInstruction
  | %resource.ofType(MedicationDispense).dosageInstruction
  | %resource.ofType(MedicationStatement).dosage
)
.all(
  (
    timing.repeat.frequency.exists()
    and timing.repeat.period.exists()
    and timing.repeat.periodUnit.exists()
    and timing.repeat.when.empty()
    and timing.repeat.timeOfDay.empty()
    and timing.repeat.dayOfWeek.empty()
  )
  /* Only One Dosage allowed for Interval */
  implies
  (
    (
      (
        %resource.ofType(MedicationRequest).exists()
        or %resource.ofType(MedicationDispense).exists()
      )
      implies (
        %resource.dosageInstruction.count() = 1
      )
    )
    and
    (
      %resource.ofType(MedicationStatement).exists()
      implies
      %resource.dosage.count() = 1
    )
  )
)"
Severity: #error


Invariant: TimingOnlyOnePeriodForDayOfWeek
Description: "In a schema that combines dayOfWeek with either timeOfDay or when, each combination of weekday and time must be unique across all Dosage elements of a resource."
Expression: "( /* Detect DayOfWeek and Time/4-Schema */
  %resource.ofType(MedicationRequest).dosageInstruction
  | %resource.ofType(MedicationDispense).dosageInstruction
  | %resource.ofType(MedicationStatement).dosage
).all(
  (
    timing.repeat.dayOfWeek.exists() and
      (
        (timing.repeat.timeOfDay.exists() and timing.repeat.when.empty()) or
        (timing.repeat.when.exists() and timing.repeat.timeOfDay.empty())
      )
  )
  implies
  (
    (
      (%resource.ofType(MedicationRequest).exists() or %resource.ofType(MedicationDispense).exists())
      implies
      (
        /* For each day of week */
        /* if Mon occurs multiple times */
        ((%resource.dosageInstruction.timing.repeat.dayOfWeek.where($this = 'mon').count() > 1) implies 
        (
          (%resource.dosageInstruction.timing.repeat.where('mon' in dayOfWeek).when.distinct().count() = %resource.dosageInstruction.timing.repeat.where('mon' in dayOfWeek).when.count()) and
          (%resource.dosageInstruction.timing.repeat.where('mon' in dayOfWeek).timeOfDay.distinct().count() = %resource.dosageInstruction.timing.repeat.where('mon' in dayOfWeek).timeOfDay.count())
        )) and
        
        /* if tue occurs multiple times */
        ((%resource.dosageInstruction.timing.repeat.dayOfWeek.where($this = 'tue').count() > 1) implies 
        (
          (%resource.dosageInstruction.timing.repeat.where('tue' in dayOfWeek).when.distinct().count() = %resource.dosageInstruction.timing.repeat.where('tue' in dayOfWeek).when.count()) and
          (%resource.dosageInstruction.timing.repeat.where('tue' in dayOfWeek).timeOfDay.distinct().count() = %resource.dosageInstruction.timing.repeat.where('tue' in dayOfWeek).timeOfDay.count())
        )) and
        /* if wed occurs multiple times */
        ((%resource.dosageInstruction.timing.repeat.dayOfWeek.where($this = 'wed').count() > 1) implies 
        (
          (%resource.dosageInstruction.timing.repeat.where('wed' in dayOfWeek).when.distinct().count() = %resource.dosageInstruction.timing.repeat.where('wed' in dayOfWeek).when.count()) and
          (%resource.dosageInstruction.timing.repeat.where('wed' in dayOfWeek).timeOfDay.distinct().count() = %resource.dosageInstruction.timing.repeat.where('wed' in dayOfWeek).timeOfDay.count())
        )) and
        /* if thu occurs multiple times */
        ((%resource.dosageInstruction.timing.repeat.dayOfWeek.where($this = 'thu').count() > 1) implies 
        (
          (%resource.dosageInstruction.timing.repeat.where('thu' in dayOfWeek).when.distinct().count() = %resource.dosageInstruction.timing.repeat.where('thu' in dayOfWeek).when.count()) and
          (%resource.dosageInstruction.timing.repeat.where('thu' in dayOfWeek).timeOfDay.distinct().count() = %resource.dosageInstruction.timing.repeat.where('thu' in dayOfWeek).timeOfDay.count())
        )) and
        /* if fri occurs multiple times */
        ((%resource.dosageInstruction.timing.repeat.dayOfWeek.where($this = 'fri').count() > 1) implies 
        (
          (%resource.dosageInstruction.timing.repeat.where('fri' in dayOfWeek).when.distinct().count() = %resource.dosageInstruction.timing.repeat.where('fri' in dayOfWeek).when.count()) and
          (%resource.dosageInstruction.timing.repeat.where('fri' in dayOfWeek).timeOfDay.distinct().count() = %resource.dosageInstruction.timing.repeat.where('fri' in dayOfWeek).timeOfDay.count())
        )) and
        /* if sat occurs multiple times */
        ((%resource.dosageInstruction.timing.repeat.dayOfWeek.where($this = 'sat').count() > 1) implies 
        (
          (%resource.dosageInstruction.timing.repeat.where('sat' in dayOfWeek).when.distinct().count() = %resource.dosageInstruction.timing.repeat.where('sat' in dayOfWeek).when.count()) and
          (%resource.dosageInstruction.timing.repeat.where('sat' in dayOfWeek).timeOfDay.distinct().count() = %resource.dosageInstruction.timing.repeat.where('sat' in dayOfWeek).timeOfDay.count())
        )) and
        
        /* if sun occurs multiple times */
        ((%resource.dosageInstruction.timing.repeat.dayOfWeek.where($this = 'sun').count() > 1) implies 
        (
          (%resource.dosageInstruction.timing.repeat.where('sun' in dayOfWeek).when.distinct().count() = %resource.dosageInstruction.timing.repeat.where('sun' in dayOfWeek).when.count()) and
          (%resource.dosageInstruction.timing.repeat.where('sun' in dayOfWeek).timeOfDay.distinct().count() = %resource.dosageInstruction.timing.repeat.where('sun' in dayOfWeek).timeOfDay.count())
        ))
      )
    )
    and
    (
      %resource.ofType(MedicationStatement).exists()
      implies
      (
        /* For each day of week */
        /* if Mon occurs multiple times */
        ((%resource.dosage.timing.repeat.dayOfWeek.where($this = 'mon').count() > 1) implies 
        (
          (%resource.dosage.timing.repeat.where('mon' in dayOfWeek).when.distinct().count() = %resource.dosage.timing.repeat.where('mon' in dayOfWeek).when.count()) and
          (%resource.dosage.timing.repeat.where('mon' in dayOfWeek).timeOfDay.distinct().count() = %resource.dosage.timing.repeat.where('mon' in dayOfWeek).timeOfDay.count())
        )) and
        
        /* if tue occurs multiple times */
        ((%resource.dosage.timing.repeat.dayOfWeek.where($this = 'tue').count() > 1) implies 
        (
          (%resource.dosage.timing.repeat.where('tue' in dayOfWeek).when.distinct().count() = %resource.dosage.timing.repeat.where('tue' in dayOfWeek).when.count()) and
          (%resource.dosage.timing.repeat.where('tue' in dayOfWeek).timeOfDay.distinct().count() = %resource.dosage.timing.repeat.where('tue' in dayOfWeek).timeOfDay.count())
        )) and
        /* if wed occurs multiple times */
        ((%resource.dosage.timing.repeat.dayOfWeek.where($this = 'wed').count() > 1) implies 
        (
          (%resource.dosage.timing.repeat.where('wed' in dayOfWeek).when.distinct().count() = %resource.dosage.timing.repeat.where('wed' in dayOfWeek).when.count()) and
          (%resource.dosage.timing.repeat.where('wed' in dayOfWeek).timeOfDay.distinct().count() = %resource.dosage.timing.repeat.where('wed' in dayOfWeek).timeOfDay.count())
        )) and
        /* if thu occurs multiple times */
        ((%resource.dosage.timing.repeat.dayOfWeek.where($this = 'thu').count() > 1) implies 
        (
          (%resource.dosage.timing.repeat.where('thu' in dayOfWeek).when.distinct().count() = %resource.dosage.timing.repeat.where('thu' in dayOfWeek).when.count()) and
          (%resource.dosage.timing.repeat.where('thu' in dayOfWeek).timeOfDay.distinct().count() = %resource.dosage.timing.repeat.where('thu' in dayOfWeek).timeOfDay.count())
        )) and
        /* if fri occurs multiple times */
        ((%resource.dosage.timing.repeat.dayOfWeek.where($this = 'fri').count() > 1) implies 
        (
          (%resource.dosage.timing.repeat.where('fri' in dayOfWeek).when.distinct().count() = %resource.dosage.timing.repeat.where('fri' in dayOfWeek).when.count()) and
          (%resource.dosage.timing.repeat.where('fri' in dayOfWeek).timeOfDay.distinct().count() = %resource.dosage.timing.repeat.where('fri' in dayOfWeek).timeOfDay.count())
        )) and
        /* if sat occurs multiple times */
        ((%resource.dosage.timing.repeat.dayOfWeek.where($this = 'sat').count() > 1) implies 
        (
          (%resource.dosage.timing.repeat.where('sat' in dayOfWeek).when.distinct().count() = %resource.dosage.timing.repeat.where('sat' in dayOfWeek).when.count()) and
          (%resource.dosage.timing.repeat.where('sat' in dayOfWeek).timeOfDay.distinct().count() = %resource.dosage.timing.repeat.where('sat' in dayOfWeek).timeOfDay.count())
        )) and
        
        /* if sun occurs multiple times */
        ((%resource.dosage.timing.repeat.dayOfWeek.where($this = 'sun').count() > 1) implies 
        (
          (%resource.dosage.timing.repeat.where('sun' in dayOfWeek).when.distinct().count() = %resource.dosage.timing.repeat.where('sun' in dayOfWeek).when.count()) and
          (%resource.dosage.timing.repeat.where('sun' in dayOfWeek).timeOfDay.distinct().count() = %resource.dosage.timing.repeat.where('sun' in dayOfWeek).timeOfDay.count())
        ))
      )
    )
  )
)"

Severity: #error

Invariant: TimingOnlyOneTimeForInterval
Description: "In a schema that combines an interval with timeOfDay or when, all Dosage elements of a resource must use the same period and periodUnit, and each timeOfDay or when value must be unique across them."
Expression: "/* Detect Interval and Time/4-Schema */
(
  %resource.ofType(MedicationRequest).dosageInstruction
  | %resource.ofType(MedicationDispense).dosageInstruction
  | %resource.ofType(MedicationStatement).dosage
)
.all(
  (
    timing.repeat.period.exists() and
    timing.repeat.periodUnit.exists() and
    timing.repeat.dayOfWeek.empty() and
    (
      (timing.repeat.timeOfDay.exists() and timing.repeat.when.empty()) or
      (timing.repeat.when.exists() and timing.repeat.timeOfDay.empty())
    )
  )
  implies
  (
    (
      %resource.ofType(MedicationRequest).exists()
      or %resource.ofType(MedicationDispense).exists()
    )
    implies
    (
      %resource.dosageInstruction.timing.repeat.period.distinct().count() = 1
      and %resource.dosageInstruction.timing.repeat.periodUnit.distinct().count() = 1
    )
    and
    (
      (%resource.dosageInstruction.timing.repeat.timeOfDay.distinct().count() = %resource.dosageInstruction.timing.repeat.timeOfDay.count())
      and
      (%resource.dosageInstruction.timing.repeat.when.distinct().count() = %resource.dosageInstruction.timing.repeat.when.count())
    )
  )
  and
  (
    %resource.ofType(MedicationStatement).exists()
    implies
    (
      (
        %resource.dosage.timing.repeat.period.distinct().count() = 1
        and %resource.dosage.timing.repeat.periodUnit.distinct().count() = 1
      )
      and
      (
        (%resource.dosage.timing.repeat.timeOfDay.distinct().count() = %resource.dosage.timing.repeat.timeOfDay.count())
        and
        (%resource.dosage.timing.repeat.when.distinct().count() = %resource.dosage.timing.repeat.when.count())
      )
    )
  )
)"
Severity: #error

Invariant: TimingBoundsDurationOnlyWholeNumber
Description: "boundsDuration.value must be a whole number; decimal values are not allowed."
Expression: "bounds.ofType(Duration).value.empty() or bounds.ofType(Duration).value mod 1 = 0"
Severity: #error
