Profile: TimingDE_dgmp_Zeipunkte
Parent: TimingDE_Zeipunkte
Id: timing-de-dgmp-zeipunkte
Title: "Timing DE Zeipunkte"
Description: "Beschreibt ein Ereignis, das mehrfach auftreten kann. Zeitpläne werden verwendet, um festzuhalten, wann etwas geplant, erwartet oder angefordert ist. Die häufigste Anwendung ist in Dosierungsanweisungen für Medikamente. Sie werden aber auch für die Planung verschiedener Versorgungsleistungen genutzt und können zur Dokumentation von bereits erfolgten oder laufenden Aktivitäten verwendet werden."
* event 0..0
* code 0..0

* repeat 1..1 MS
  * obeys timing-only-one-type
  * bounds[x] MS
  * bounds[x] only Duration
  * boundsDuration MS
  * boundsDuration.system = $ucum (exactly)
  * boundsDuration.code from De_Dosage_UCUM_UnitsOfTime_DgMP (required)

  * frequency MS
  * period MS
  * periodUnit MS
  * dayOfWeek MS
  * timeOfDay MS
  * when MS
  * when from TimingDE_dgmp_Zeipunkte_VS (required)

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
Description: "Only one kind of Repeat is allowed. Current allowed timings: 4-Scheme, Dailytime, Weekday, Interval, 4-Schema and Weekday, Interval and Time/4-Schema"
Expression: "
(
  (frequency.exists() and frequency = 1 and period.exists() and period = 1 and periodUnit.exists() and periodUnit = 'd' and when.exists() and timeOfDay.empty() and dayOfWeek.empty())
  or
  (timeOfDay.exists() and frequency.exists() and frequency = 1 and period.exists() and period = 1 and periodUnit.exists() and periodUnit = 'd' and when.empty() and dayOfWeek.empty())
  or
  (dayOfWeek.exists() and frequency.exists() and frequency = 1 and period.exists() and period = 1 and periodUnit.exists() and periodUnit = 'd' and when.empty() and timeOfDay.empty())
  or
  (frequency.exists() and period.exists() and periodUnit.exists() and when.empty() and timeOfDay.empty() and dayOfWeek.empty())
  or
  (frequency.exists() and frequency = 1 and period.exists() and period = 1 and periodUnit.exists() and periodUnit = 'd' and when.exists() and dayOfWeek.exists() and timeOfDay.empty())
  or
  (frequency.exists() and period.exists() and periodUnit.exists() and ((timeOfDay.exists() and when.empty())
  or (when.exists() and timeOfDay.empty())))
)
"
Severity: #error
