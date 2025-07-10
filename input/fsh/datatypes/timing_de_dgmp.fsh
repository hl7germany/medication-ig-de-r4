Profile: TimingDgMP
Parent: TimingDE
Id: TimingDgMP
Title: "Zeitmuster für Dosierungen im dgMP"
Description: "Beschreibt ein Ereignis, das mehrfach auftreten kann. Zeitpläne werden verwendet, um festzuhalten, wann etwas geplant, erwartet oder angefordert ist. Die häufigste Anwendung ist in Dosierungsanweisungen für Medikamente. Sie werden aber auch für die Planung verschiedener Versorgungsleistungen genutzt und können zur Dokumentation von bereits erfolgten oder laufenden Aktivitäten verwendet werden."
* event 0..0
* code 0..0

* repeat 1..1 MS
  * obeys timing-only-one-type
  * obeys TimingIntervalOnlyOneFrequency
  * obeys TimingOnlyOneWhen
  * obeys TimingOnlyOneTimeOfDay
  * obeys TimingOnlyOneDayOfWeek
  * obeys TimingOnlyOnePeriodForDayOfWeek
  * bounds[x] MS
  * bounds[x] only Duration
  * boundsDuration MS
  * boundsDuration.code from DurationUnitsOfTimeDgMPVS (required)

  * frequency MS
  * period MS
  * periodUnit MS
  * periodUnit from PeriodUnitsOfTimeDgMPVS (required)
  * dayOfWeek MS
  * timeOfDay MS
  * when MS
  * when from TimingWhenDgMPVS (required)

  // Restrict all elements in the repeat backbone to 0..0
  * count 0..0
  * countMax 0..0
  * duration 0..0
  * durationMax 0..0
  * durationUnit 0..0
  * frequencyMax 0..0
  * periodMax 0..0
  * offset 0..0

//TODO Invariant info auf Teile der Invariante.
Invariant: timing-only-one-type
Description: "Only one kind of Timing is allowed. Current allowed timings: 4-Scheme, TimeOfDay, DayOfWeek, Interval, DayOfWeek and Time/4-Schema, Interval and Time/4-Schema"
Expression: "
/* 4-Schema */
(%resource.ofType(MedicationRequest).dosageInstruction | ofType(MedicationDispense).dosageInstruction | ofType(MedicationStatement).dosage).all(
timing.repeat.when.exists() and
timing.repeat.frequency.empty() and
timing.repeat.period.empty() and
timing.repeat.periodUnit.empty() and
timing.repeat.timeOfDay.empty() and
timing.repeat.dayOfWeek.empty()
) or

/* TimeOfDay */
(%resource.ofType(MedicationRequest).dosageInstruction | ofType(MedicationDispense).dosageInstruction | ofType(MedicationStatement).dosage).all(
timing.repeat.timeOfDay.exists() and
timing.repeat.frequency.empty() and
timing.repeat.period.empty() and
timing.repeat.periodUnit.empty() and
timing.repeat.when.empty() and
timing.repeat.dayOfWeek.empty()
) or

/* DayOfWeek */
(%resource.ofType(MedicationRequest).dosageInstruction | ofType(MedicationDispense).dosageInstruction | ofType(MedicationStatement).dosage).all(
timing.repeat.dayOfWeek.exists() and
timing.repeat.frequency.empty() and
timing.repeat.period.empty() and
timing.repeat.periodUnit.empty() and
timing.repeat.when.empty() and
timing.repeat.timeOfDay.empty()
) or

/* Interval */
(%resource.ofType(MedicationRequest).dosageInstruction | ofType(MedicationDispense).dosageInstruction | ofType(MedicationStatement).dosage).all(
timing.repeat.frequency.exists() and
timing.repeat.period.exists() and
timing.repeat.periodUnit.exists() and
timing.repeat.when.empty() and
timing.repeat.timeOfDay.empty() and
timing.repeat.dayOfWeek.empty()
) or

/* DayOfWeek and Time/4-Schema */
(%resource.ofType(MedicationRequest).dosageInstruction | ofType(MedicationDispense).dosageInstruction | ofType(MedicationStatement).dosage).all(
timing.repeat.dayOfWeek.exists() and
timing.repeat.frequency.empty() and
timing.repeat.period.empty() and
timing.repeat.periodUnit.empty() and
  (
    (timing.repeat.timeOfDay.exists() and timing.repeat.when.empty()) or
    (timing.repeat.when.exists() and timing.repeat.timeOfDay.empty())
  )
) or

/* Interval and Time/4-Schema */
(%resource.ofType(MedicationRequest).dosageInstruction | ofType(MedicationDispense).dosageInstruction | ofType(MedicationStatement).dosage).all(
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
Expression: "
/* Detect 4-Schema */
(
  %resource.ofType(MedicationRequest).dosageInstruction
  | %resource.ofType(MedicationDispense).dosageInstruction
  | %resource.ofType(MedicationStatement).dosage
).all(
  (
    timing.repeat.when.exists() and
    timing.repeat.frequency.empty() and
    timing.repeat.period.empty() and
    timing.repeat.periodUnit.empty() and
    timing.repeat.timeOfDay.empty() and
    timing.repeat.dayOfWeek.empty()
  )
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

Invariant: TimingOnlyOneTimeOfDay
Description: "Dosages Timings must not state the same time of day across multiple dosage instances"
Expression: "
/* Detect TimeOfDay */
(
  %resource.ofType(MedicationRequest).dosageInstruction
  | %resource.ofType(MedicationDispense).dosageInstruction
  | %resource.ofType(MedicationStatement).dosage
).all(
  (
    timing.repeat.timeOfDay.exists() and
    timing.repeat.frequency.empty() and
    timing.repeat.period.empty() and
    timing.repeat.periodUnit.empty() and
    timing.repeat.when.empty() and
    timing.repeat.dayOfWeek.empty()
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
Description: "Dosages Timings must not state the same time of day across multiple dosage instances"
Expression: "
/* Detect DayOfWeek */
(
  %resource.ofType(MedicationRequest).dosageInstruction
  | %resource.ofType(MedicationDispense).dosageInstruction
  | %resource.ofType(MedicationStatement).dosage
).all(
  (
    timing.repeat.dayOfWeek.exists() and
    timing.repeat.frequency.empty() and
    timing.repeat.period.empty() and
    timing.repeat.periodUnit.empty() and
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

Invariant: TimingIntervalOnlyOneFrequency
Description: "Dosages Timings must not state the same time of day across multiple dosage instances"
Expression: "
/* Detect Interval */
(
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
Description: "Dosages Timings must not state the same time of day across multiple dosage instances"
Expression: "
/* Detect DayOfWeek and Time/4-Schema */
(
  %resource.ofType(MedicationRequest).dosageInstruction
  | %resource.ofType(MedicationDispense).dosageInstruction
  | %resource.ofType(MedicationStatement).dosage
).all(
  (
    timing.repeat.dayOfWeek.exists() and
    timing.repeat.frequency.empty() and
    timing.repeat.period.empty() and
    timing.repeat.periodUnit.empty() and
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
