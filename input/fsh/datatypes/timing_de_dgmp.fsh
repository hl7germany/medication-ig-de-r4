Profile: TimingDgMP
Parent: TimingDE
Id: TimingDgMP
Title: "Zeitmuster für Dosierungen im dgMP"
Description: "Beschreibt ein Ereignis, das mehrfach auftreten kann. Zeitpläne werden verwendet, um festzuhalten, wann etwas geplant, erwartet oder angefordert ist. Die häufigste Anwendung ist in Dosierungsanweisungen für Medikamente. Sie werden aber auch für die Planung verschiedener Versorgungsleistungen genutzt und können zur Dokumentation von bereits erfolgten oder laufenden Aktivitäten verwendet werden."
* event 0..0
* code 0..0

* repeat 1..1 MS
  * obeys timing-only-one-type
  * bounds[x] MS
  * bounds[x] only Duration
  * boundsDuration MS
  * boundsDuration.system = $ucum (exactly)
  * boundsDuration.code from DosageUnitsOfTimeDgMP (required)

  * frequency MS
  * period MS
  * periodUnit MS
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

Invariant: timing-only-one-type
Description: "Only one kind of Timing is allowed. Current allowed timings: 4-Scheme, TimeOfDay, DayOfWeek, Interval, DayOfWeek and Time/4-Schema, Interval and Time/4-Schema"
Expression: "
/* 4-Schema */
%resource.(ofType(MedicationRequest).dosageInstruction | ofType(MedicationStatement).dosage).all(
timing.repeat.frequency.exists() and timing.repeat.frequency = 1 and
timing.repeat.period.exists() and timing.repeat.period = 1 and
timing.repeat.periodUnit.exists() and timing.repeat.periodUnit = 'd' and
timing.repeat.when.exists() and
timing.repeat.timeOfDay.empty() and
timing.repeat.dayOfWeek.empty()
) or

/* TimeOfDay */
%resource.(ofType(MedicationRequest).dosageInstruction | ofType(MedicationStatement).dosage).all(
timing.repeat.timeOfDay.exists() and
timing.repeat.frequency.exists() and timing.repeat.frequency = 1 and
timing.repeat.period.exists() and timing.repeat.period = 1 and
timing.repeat.periodUnit.exists() and timing.repeat.periodUnit = 'd' and
timing.repeat.when.empty() and
timing.repeat.dayOfWeek.empty()
) or

/* DayOfWeek */
%resource.(ofType(MedicationRequest).dosageInstruction | ofType(MedicationStatement).dosage).all(
timing.repeat.dayOfWeek.exists() and
timing.repeat.frequency.exists() and timing.repeat.frequency = 1 and
timing.repeat.period.exists() and timing.repeat.period = 1 and
timing.repeat.periodUnit.exists() and timing.repeat.periodUnit = 'd' and
timing.repeat.when.empty() and
timing.repeat.timeOfDay.empty()
) or

/* Interval */
%resource.(ofType(MedicationRequest).dosageInstruction | ofType(MedicationStatement).dosage).all(
timing.repeat.frequency.exists() and
timing.repeat.period.exists() and
timing.repeat.periodUnit.exists() and
timing.repeat.when.empty() and
timing.repeat.timeOfDay.empty() and
timing.repeat.dayOfWeek.empty()
) or

/* DayOfWeek and Time/4-Schema */
%resource.(ofType(MedicationRequest).dosageInstruction | ofType(MedicationStatement).dosage).all(
timing.repeat.dayOfWeek.exists() and
timing.repeat.frequency.exists() and timing.repeat.frequency = 1 and
timing.repeat.period.exists() and timing.repeat.period = 1 and
timing.repeat.periodUnit.exists() and timing.repeat.periodUnit = 'd' and
  (
    (timing.repeat.timeOfDay.exists() and timing.repeat.when.empty()) or
    (timing.repeat.when.exists() and timing.repeat.timeOfDay.empty())
  )
) or

/* Interval and Time/4-Schema */
%resource.(ofType(MedicationRequest).dosageInstruction | ofType(MedicationStatement).dosage).all(
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