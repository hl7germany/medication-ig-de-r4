Profile: TimingDgMP
Parent: TimingDE
Id: TimingDgMP
Title: "Timing dgMP"
Description: "Beschreibt ein Ereignis, das mehrfach auftreten kann. Zeitpläne werden verwendet, um festzuhalten, wann etwas geplant, erwartet oder angefordert ist. Die häufigste Anwendung ist in Dosierungsanweisungen für Medikamente. Sie werden aber auch für die Planung verschiedener Versorgungsleistungen genutzt und können zur Dokumentation von bereits erfolgten oder laufenden Aktivitäten verwendet werden."
* event 0..0
  * ^comment = "Begründung Einschränkung Kardinalität: Der Zeitpunkt des Ereignisses ist in der ersten Ausbaustufe des dgMP nicht vorgesehen, um die Komplexität zu reduzieren und die Übersichtlichkeit zu erhöhen."
* code 0..0
  * ^comment = "Begründung Einschränkung Kardinalität: Ein Timing-Code ist in der ersten Ausbaustufe des dgMP nicht vorgesehen, um die Komplexität zu reduzieren und die Übersichtlichkeit zu erhöhen. Stattdessen muss das Zeitmuster explizit strukturiert angegeben werden."
* repeat 1..1 MS
  * obeys TimingOnlyOneType
  * obeys TimingIntervalOnlyOneFrequency
  * obeys TimingOnlyOneWhen
  * obeys TimingOnlyWhenOrTimeOfDay
  * obeys TimingOnlyOneTimeOfDay
  * obeys TimingOnlyOneDayOfWeek
  * obeys TimingOnlyOnePeriodForDayOfWeek
  * obeys TimingOnlyOneTimeForInterval
  * obeys TimingOnlyOneBounds
  * obeys TimingFrequencyCount
  * obeys TimingPeriodUnit
  * bounds[x] MS
  * bounds[x] only Duration
    * ^comment = "Begründung Einschränkung Datentyp: Nur eine Angabe zur Dauer ist in der ersten Ausbaustufe des dgMP vorgesehen, um die Komplexität zu reduzieren und die Übersichtlichkeit zu erhöhen."
  * boundsDuration MS
    * code 1..1 MS
    * system 1..1 MS
    * unit 1..1 MS
    * code from DurationUnitsOfTimeDgMPVS (required)
  * frequency 1..1 MS
  * period 1..1 MS
  * periodUnit 1..1 MS
  * periodUnit from PeriodUnitsOfTimeDgMPVS (required)
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
  * frequencyMax 0..0
    * ^comment = "Begründung Einschränkung Kardinalität: Eine maximale Frequenz ist in der ersten Ausbaustufe des dgMP nicht vorgesehen – es wird immer eine Frequenz explizit gesetzt, um die Komplexität zu reduzieren und die Übersichtlichkeit zu erhöhen."
  * periodMax 0..0
    * ^comment = "Begründung Einschränkung Kardinalität: Eine maximale Periodendauer ist in der ersten Ausbaustufe des dgMP nicht vorgesehen – es wird immer eine Dauer explizit gesetzt, um die Komplexität zu reduzieren und die Übersichtlichkeit zu erhöhen."
  * offset 0..0
    * ^short = "Zeitversatz"
    * ^comment = "Begründung Einschränkung Kardinalität: Ein Zeitversatz ist in der ersten Ausbaustufe desdgMP nicht vorgesehen, um die Komplexität zu reduzieren und die Übersichtlichkeit zu erhöhen."

Invariant: TimingFrequencyCount
Description: "The frequency of the timing needs to reflect the count of timeOfDay or when"
Expression: "(when.exists() and dayOfWeek.empty() implies when.count() = frequency)
and
(when.exists() and dayOfWeek.exists() implies (when.count() * dayOfWeek.count()) = frequency)
and
(timeOfDay.exists() and dayOfWeek.empty() implies timeOfDay.count() = frequency)
and
(timeOfDay.exists() and dayOfWeek.exists() implies (timeOfDay.count() * dayOfWeek.count()) = frequency)
and
(dayOfWeek.exists() and timeOfDay.empty() and when.empty() implies dayOfWeek.count() = frequency)"
Severity: #error

Invariant: TimingPeriodUnit
Description: "If weekdays are given the periodUnit must be week, otherwise day"
Expression: "(dayOfWeek.exists() implies periodUnit = 'wk')
and
((dayOfWeek.empty() and (when.exists() or timeOfDay.exists())) implies periodUnit = 'd')"
Severity: #error

Invariant: TimingOnlyOneType
Description: "Only one kind of Timing is allowed. Current allowed timings: 4-Scheme, TimeOfDay, DayOfWeek, Interval, DayOfWeek and Time/4-Schema, Interval and Time/4-Schema"
Expression: "/* DayOfWeek */
(
  %resource.ofType(MedicationRequest).dosageInstruction | 
  ofType(MedicationDispense).dosageInstruction | 
  ofType(MedicationStatement).dosage
).all(
  timing.repeat.dayOfWeek.exists() and
  timing.repeat.frequency.exists() and
  (timing.repeat.period.exists() and timing.repeat.period = 1) and
  (timing.repeat.periodUnit.exists()) and
  timing.repeat.when.empty() and
  timing.repeat.timeOfDay.empty()
) or

/* Interval */
(
  %resource.ofType(MedicationRequest).dosageInstruction | 
  ofType(MedicationDispense).dosageInstruction | 
  ofType(MedicationStatement).dosage
).all(
  timing.repeat.frequency.exists() and
  timing.repeat.period.exists() and
  timing.repeat.periodUnit.exists() and
  timing.repeat.when.empty() and
  timing.repeat.timeOfDay.empty() and
  timing.repeat.dayOfWeek.empty()
) or

/* DayOfWeek and Time/4-Schema */
(
  %resource.ofType(MedicationRequest).dosageInstruction | 
  ofType(MedicationDispense).dosageInstruction | 
  ofType(MedicationStatement).dosage
).all(
  timing.repeat.dayOfWeek.exists() and
  timing.repeat.frequency.exists() and
  (timing.repeat.period.exists() and timing.repeat.period = 1) and
  (timing.repeat.periodUnit.exists()) and
  (
    (timing.repeat.timeOfDay.exists() and timing.repeat.when.empty()) or
    (timing.repeat.when.exists() and timing.repeat.timeOfDay.empty())
  )
) or

/* Interval and Time/4-Schema */
(
  %resource.ofType(MedicationRequest).dosageInstruction | 
  ofType(MedicationDispense).dosageInstruction | 
  ofType(MedicationStatement).dosage
).all(
  timing.repeat.frequency.exists() and
  timing.repeat.period.exists() and
  timing.repeat.periodUnit.exists() and
  timing.repeat.dayOfWeek.empty() and
  (
    (timing.repeat.timeOfDay.exists() and timing.repeat.when.empty()) or
    (timing.repeat.when.exists() and timing.repeat.timeOfDay.empty())
  )
)
"
Severity: #error

Invariant: TimingOnlyOneWhen
Description: "Dosages Timings must not state the same period of day across multiple dosage instances"
Expression: "( /* Detect 4-Schema */
  %resource.ofType(MedicationRequest).dosageInstruction
  | %resource.ofType(MedicationDispense).dosageInstruction
  | %resource.ofType(MedicationStatement).dosage
).all(
    timing.repeat.frequency.exists() and
    timing.repeat.period.exists() and
    timing.repeat.periodUnit.exists() and
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
)
"
Severity: #error

Invariant: TimingOnlyWhenOrTimeOfDay
Description: "Dosages Timings must not state a time of day and period of day across multiple dosage instances"
Expression: "(
  %resource.ofType(MedicationRequest).dosageInstruction
  | %resource.ofType(MedicationDispense).dosageInstruction
  | %resource.ofType(MedicationStatement).dosage
).all(
    timing.repeat.frequency.exists() and
    timing.repeat.period.exists() and
    timing.repeat.periodUnit.exists() and
    timing.repeat.dayOfWeek.empty() and
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
)
"
Severity: #error

Invariant: TimingOnlyOneTimeOfDay
Description: "Dosages Timings must not state the same time of day across multiple dosage instances"
Expression: "( /* Detect TimeOfDay */
  %resource.ofType(MedicationRequest).dosageInstruction
  | %resource.ofType(MedicationDispense).dosageInstruction
  | %resource.ofType(MedicationStatement).dosage
).all(
  (
    timing.repeat.frequency.exists() and
    timing.repeat.period.exists() and
    timing.repeat.periodUnit.exists() and
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
Description: "Dosages Timings must not state the same day across multiple dosage instances"
Expression: "( /* Detect DayOfWeek */
  %resource.ofType(MedicationRequest).dosageInstruction
  | %resource.ofType(MedicationDispense).dosageInstruction
  | %resource.ofType(MedicationStatement).dosage
).all(
  (
    timing.repeat.frequency.exists() and
    timing.repeat.period.exists() and
    timing.repeat.periodUnit.exists() and
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
Description: "Dosages Timings must state the same bounds duration across multiple dosage instances"
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
  )
)"
Severity: #error

Invariant: TimingIntervalOnlyOneFrequency
Description: "If a dosage is defined by a pure interval, then only one dosage is allowed in the resource."
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
)
"
Severity: #error


Invariant: TimingOnlyOnePeriodForDayOfWeek
Description: "For schedules using only dayOfWeek with either timeOfDay or when, each (day + period of day/time) combination must be unique across all dosage instructions."
Expression: "( /* Detect DayOfWeek and Time/4-Schema */
  %resource.ofType(MedicationRequest).dosageInstruction
  | %resource.ofType(MedicationDispense).dosageInstruction
  | %resource.ofType(MedicationStatement).dosage
).all(
  (
    timing.repeat.dayOfWeek.exists() and
    timing.repeat.frequency.exists() and
    timing.repeat.period.exists() and
    timing.repeat.periodUnit.exists() and
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
        ((
          %resource.dosageInstruction.timing.repeat.dayOfWeek
          .where($this = 'mon')
          .where(%resource.dosageInstruction.timing.repeat.dayOfWeek.where($this = 'mon').count() > 1)
          .distinct()
        ) implies 
        (
          (%resource.dosageInstruction.timing.repeat.where('mon' in dayOfWeek).when.distinct().count() = %resource.dosageInstruction.timing.repeat.where('mon' in dayOfWeek).when.count()) and
          (%resource.dosageInstruction.timing.repeat.where('mon' in dayOfWeek).timeOfDay.distinct().count() = %resource.dosageInstruction.timing.repeat.where('mon' in dayOfWeek).timeOfDay.count())
        )) and
        
        /* if tue occurs multiple times */
        ((
          %resource.dosageInstruction.timing.repeat.dayOfWeek
          .where($this = 'tue')
          .where(%resource.dosageInstruction.timing.repeat.dayOfWeek.where($this = 'tue').count() > 1)
          .distinct()
        ) implies 
        (
          (%resource.dosageInstruction.timing.repeat.where('tue' in dayOfWeek).when.distinct().count() = %resource.dosageInstruction.timing.repeat.where('tue' in dayOfWeek).when.count()) and
          (%resource.dosageInstruction.timing.repeat.where('tue' in dayOfWeek).timeOfDay.distinct().count() = %resource.dosageInstruction.timing.repeat.where('tue' in dayOfWeek).timeOfDay.count())
        )) and
        /* if wed occurs multiple times */
        ((
          %resource.dosageInstruction.timing.repeat.dayOfWeek
          .where($this = 'wed')
          .where(%resource.dosageInstruction.timing.repeat.dayOfWeek.where($this = 'wed').count() > 1)
          .distinct()
        ) implies 
        (
          (%resource.dosageInstruction.timing.repeat.where('wed' in dayOfWeek).when.distinct().count() = %resource.dosageInstruction.timing.repeat.where('wed' in dayOfWeek).when.count()) and
          (%resource.dosageInstruction.timing.repeat.where('wed' in dayOfWeek).timeOfDay.distinct().count() = %resource.dosageInstruction.timing.repeat.where('wed' in dayOfWeek).timeOfDay.count())
        )) and
        /* if thu occurs multiple times */
        ((
          %resource.dosageInstruction.timing.repeat.dayOfWeek
          .where($this = 'thu')
          .where(%resource.dosageInstruction.timing.repeat.dayOfWeek.where($this = 'thu').count() > 1)
          .distinct()
        ) implies 
        (
          (%resource.dosageInstruction.timing.repeat.where('thu' in dayOfWeek).when.distinct().count() = %resource.dosageInstruction.timing.repeat.where('thu' in dayOfWeek).when.count()) and
          (%resource.dosageInstruction.timing.repeat.where('thu' in dayOfWeek).timeOfDay.distinct().count() = %resource.dosageInstruction.timing.repeat.where('thu' in dayOfWeek).timeOfDay.count())
        )) and
        /* if fri occurs multiple times */
        ((
          %resource.dosageInstruction.timing.repeat.dayOfWeek
          .where($this = 'fri')
          .where(%resource.dosageInstruction.timing.repeat.dayOfWeek.where($this = 'fri').count() > 1)
          .distinct()
        ) implies 
        (
          (%resource.dosageInstruction.timing.repeat.where('fri' in dayOfWeek).when.distinct().count() = %resource.dosageInstruction.timing.repeat.where('fri' in dayOfWeek).when.count()) and
          (%resource.dosageInstruction.timing.repeat.where('fri' in dayOfWeek).timeOfDay.distinct().count() = %resource.dosageInstruction.timing.repeat.where('fri' in dayOfWeek).timeOfDay.count())
        )) and
        /* if sat occurs multiple times */
        ((
          %resource.dosageInstruction.timing.repeat.dayOfWeek
          .where($this = 'sat')
          .where(%resource.dosageInstruction.timing.repeat.dayOfWeek.where($this = 'sat').count() > 1)
          .distinct()
        ) implies 
        (
          (%resource.dosageInstruction.timing.repeat.where('sat' in dayOfWeek).when.distinct().count() = %resource.dosageInstruction.timing.repeat.where('sat' in dayOfWeek).when.count()) and
          (%resource.dosageInstruction.timing.repeat.where('sat' in dayOfWeek).timeOfDay.distinct().count() = %resource.dosageInstruction.timing.repeat.where('sat' in dayOfWeek).timeOfDay.count())
        )) and
        
        /* if sun occurs multiple times */
        ((
          %resource.dosageInstruction.timing.repeat.dayOfWeek
          .where($this = 'sun')
          .where(%resource.dosageInstruction.timing.repeat.dayOfWeek.where($this = 'sun').count() > 1)
          .distinct()
        ) implies 
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
        ((
          %resource.dosage.timing.repeat.dayOfWeek
          .where($this = 'mon')
          .where(%resource.dosage.timing.repeat.dayOfWeek.where($this = 'mon').count() > 1)
          .distinct()
        ) implies 
        (
          (%resource.dosage.timing.repeat.where('mon' in dayOfWeek).when.distinct().count() = %resource.dosage.timing.repeat.where('mon' in dayOfWeek).when.count()) and
          (%resource.dosage.timing.repeat.where('mon' in dayOfWeek).timeOfDay.distinct().count() = %resource.dosage.timing.repeat.where('mon' in dayOfWeek).timeOfDay.count())
        )) and
        
        /* if tue occurs multiple times */
        ((
          %resource.dosage.timing.repeat.dayOfWeek
          .where($this = 'tue')
          .where(%resource.dosage.timing.repeat.dayOfWeek.where($this = 'tue').count() > 1)
          .distinct()
        ) implies 
        (
          (%resource.dosage.timing.repeat.where('tue' in dayOfWeek).when.distinct().count() = %resource.dosage.timing.repeat.where('tue' in dayOfWeek).when.count()) and
          (%resource.dosage.timing.repeat.where('tue' in dayOfWeek).timeOfDay.distinct().count() = %resource.dosage.timing.repeat.where('tue' in dayOfWeek).timeOfDay.count())
        )) and
        /* if wed occurs multiple times */
        ((
          %resource.dosage.timing.repeat.dayOfWeek
          .where($this = 'wed')
          .where(%resource.dosage.timing.repeat.dayOfWeek.where($this = 'wed').count() > 1)
          .distinct()
        ) implies 
        (
          (%resource.dosage.timing.repeat.where('wed' in dayOfWeek).when.distinct().count() = %resource.dosage.timing.repeat.where('wed' in dayOfWeek).when.count()) and
          (%resource.dosage.timing.repeat.where('wed' in dayOfWeek).timeOfDay.distinct().count() = %resource.dosage.timing.repeat.where('wed' in dayOfWeek).timeOfDay.count())
        )) and
        /* if thu occurs multiple times */
        ((
          %resource.dosage.timing.repeat.dayOfWeek
          .where($this = 'thu')
          .where(%resource.dosage.timing.repeat.dayOfWeek.where($this = 'thu').count() > 1)
          .distinct()
        ) implies 
        (
          (%resource.dosage.timing.repeat.where('thu' in dayOfWeek).when.distinct().count() = %resource.dosage.timing.repeat.where('thu' in dayOfWeek).when.count()) and
          (%resource.dosage.timing.repeat.where('thu' in dayOfWeek).timeOfDay.distinct().count() = %resource.dosage.timing.repeat.where('thu' in dayOfWeek).timeOfDay.count())
        )) and
        /* if fri occurs multiple times */
        ((
          %resource.dosage.timing.repeat.dayOfWeek
          .where($this = 'fri')
          .where(%resource.dosage.timing.repeat.dayOfWeek.where($this = 'fri').count() > 1)
          .distinct()
        ) implies 
        (
          (%resource.dosage.timing.repeat.where('fri' in dayOfWeek).when.distinct().count() = %resource.dosage.timing.repeat.where('fri' in dayOfWeek).when.count()) and
          (%resource.dosage.timing.repeat.where('fri' in dayOfWeek).timeOfDay.distinct().count() = %resource.dosage.timing.repeat.where('fri' in dayOfWeek).timeOfDay.count())
        )) and
        /* if sat occurs multiple times */
        ((
          %resource.dosage.timing.repeat.dayOfWeek
          .where($this = 'sat')
          .where(%resource.dosage.timing.repeat.dayOfWeek.where($this = 'sat').count() > 1)
          .distinct()
        ) implies 
        (
          (%resource.dosage.timing.repeat.where('sat' in dayOfWeek).when.distinct().count() = %resource.dosage.timing.repeat.where('sat' in dayOfWeek).when.count()) and
          (%resource.dosage.timing.repeat.where('sat' in dayOfWeek).timeOfDay.distinct().count() = %resource.dosage.timing.repeat.where('sat' in dayOfWeek).timeOfDay.count())
        )) and
        
        /* if sun occurs multiple times */
        ((
          %resource.dosage.timing.repeat.dayOfWeek
          .where($this = 'sun')
          .where(%resource.dosage.timing.repeat.dayOfWeek.where($this = 'sun').count() > 1)
          .distinct()
        ) implies 
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
Description: "Dosage Interval Timings must not state the same time of day across multiple dosage instances"
Expression: "/* Detect Interval and Time/4-Schema */
(
  %resource.ofType(MedicationRequest).dosageInstruction
  | %resource.ofType(MedicationDispense).dosageInstruction
  | %resource.ofType(MedicationStatement).dosage
)
.all(
  (
    timing.repeat.frequency.exists() and
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
        %resource.ofType(MedicationRequest).exists()
        or %resource.ofType(MedicationDispense).exists()
      )
      implies
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
)
"
Severity: #error
