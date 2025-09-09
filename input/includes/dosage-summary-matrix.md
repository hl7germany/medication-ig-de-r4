| File | Consolidated Dosage Text | doseQuantity | frequency | period | periodUnit | Day<br>of<br>Week | Time<br>Of<br>Day | when | bounds[x] |
| :---: | :--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| [MedicationRequest-Example-MR-Dosage-1000](./MedicationRequest-Example-MR-Dosage-1000.html) | 1-0-0-0 Stück | 1 Stück | 1 | 1 | d |  |  | MORN |  |
| [MedicationRequest-Example-MR-Dosage-1010-10-Days](./MedicationRequest-Example-MR-Dosage-1010-10-Days.html) | 1-0-1-0 Stück | 1 Stück | 2 | 1 | d |  |  | MORN, EVE | {'system': 'http://unitsofmeasure.org', 'value': 10, 'code': 'wk', 'unit': 'Woche(n)'} |
| [MedicationRequest-Example-MR-Dosage-1010-Unsorted](./MedicationRequest-Example-MR-Dosage-1010-Unsorted.html) | 1-0-1-0 Stück | 1 Stück | 2 | 1 | d |  |  | EVE, MORN |  |
| [MedicationRequest-Example-MR-Dosage-1010](./MedicationRequest-Example-MR-Dosage-1010.html) | 1-0-1-0 Stück | 1 Stück | 2 | 1 | d |  |  | MORN, EVE |  |
| [MedicationRequest-Example-MR-Dosage-10120](./MedicationRequest-Example-MR-Dosage-10120.html) | 1-0-0-0 Stück | 1 Stück | 1 | 1 | d |  |  | MORN |  |
|  |  | 0.5 Stück | 1 | 1 | d |  |  | EVE |  |
| [MedicationRequest-Example-MR-Dosage-1020](./MedicationRequest-Example-MR-Dosage-1020.html) | 1-0-2-0 Stück | 1 Stück | 1 | 1 | d |  |  | MORN |  |
|  |  | 2 Stück | 1 | 1 | d |  |  | EVE |  |
| [MedicationRequest-Example-MR-Dosage-1111](./MedicationRequest-Example-MR-Dosage-1111.html) | 1-1-1-1 Stück | 1 Stück | 4 | 1 | d |  |  | EVE, MORN, NIGHT, NOON |  |
| [MedicationRequest-Example-MR-Dosage-1220](./MedicationRequest-Example-MR-Dosage-1220.html) | 1-2-2-0 Stück | 1 Stück | 1 | 1 | d |  |  | MORN |  |
|  |  | 2 Stück | 2 | 1 | d |  |  | NOON, EVE |  |
| [MedicationRequest-Example-MR-Dosage-Freetext](./MedicationRequest-Example-MR-Dosage-Freetext.html) | Unbekanntes Dosierungsschema: Unknown |  |  |  |  |  |  |  |  |
| [MedicationRequest-Example-MR-Dosage-UnitMg-1000](./MedicationRequest-Example-MR-Dosage-UnitMg-1000.html) | 400-0-0-0 mg | 400 mg | 1 | 1 | d |  |  | MORN |  |
| [MedicationRequest-Example-MR-Dosage-UnitStueck-1020](./MedicationRequest-Example-MR-Dosage-UnitStueck-1020.html) | 1-0-2-0 Stück | 1 Stück | 1 | 1 | d |  |  | MORN |  |
|  |  | 2 Stück | 1 | 1 | d |  |  | EVE |  |
| [MedicationRequest-Example-MR-Dosage-UnitTasse-1000](./MedicationRequest-Example-MR-Dosage-UnitTasse-1000.html) | 2-0-0-0 Teelöffel | 2 Teelöffel | 1 | 1 | d |  |  | MORN |  |
| [MedicationRequest-Example-MR-Dosage-comb-dayofweek-1](./MedicationRequest-Example-MR-Dosage-comb-dayofweek-1.html) | DayOfWeek and Time/4-Schema - noch nicht implementiert | 1 Stück | 4 | 1 | wk | mon, fri |  | MORN, EVE |  |
| [MedicationRequest-Example-MR-Dosage-comb-dayofweek-2](./MedicationRequest-Example-MR-Dosage-comb-dayofweek-2.html) | DayOfWeek and Time/4-Schema - noch nicht implementiert | 1 Stück | 4 | 1 | wk | mon, fri |  | MORN, EVE |  |
|  |  | 2 Stück | 2 | 1 | wk | mon, fri |  | NOON |  |
| [MedicationRequest-Example-MR-Dosage-comb-dayofweek-3](./MedicationRequest-Example-MR-Dosage-comb-dayofweek-3.html) | DayOfWeek and Time/4-Schema - noch nicht implementiert | 1 Stück | 2 | 1 | wk | mon, fri |  | MORN | {'system': 'http://unitsofmeasure.org', 'value': 3, 'code': 'wk', 'unit': 'Woche(n)'} |
|  |  | 2 Stück | 2 | 1 | wk | mon, fri |  | NOON | {'system': 'http://unitsofmeasure.org', 'value': 3, 'code': 'wk', 'unit': 'Woche(n)'} |
| [MedicationRequest-Example-MR-Dosage-comb-dayofweek-unsorted](./MedicationRequest-Example-MR-Dosage-comb-dayofweek-unsorted.html) | DayOfWeek and Time/4-Schema - noch nicht implementiert | 1 Stück | 6 | 1 | wk | sat, mon, thu |  | EVE, MORN |  |
| [MedicationRequest-Example-MR-Dosage-comb-interval-1](./MedicationRequest-Example-MR-Dosage-comb-interval-1.html) | TimeOfDay Schema - noch nicht implementiert | 1 Stück | 1 | 2 | d |  | 08:00:00 |  |  |
|  |  | 2 Stück | 1 | 2 | d |  | 18:00:00 |  |  |
| [MedicationRequest-Example-MR-Dosage-comb-interval-2](./MedicationRequest-Example-MR-Dosage-comb-interval-2.html) | 1-0-0-0 Stück | 1 Stück | 1 | 1 | d |  |  | MORN |  |
| [MedicationRequest-Example-MR-Dosage-comb-interval-3](./MedicationRequest-Example-MR-Dosage-comb-interval-3.html) | TimeOfDay Schema - noch nicht implementiert | 1 Stück | 1 | 2 | d |  | 08:00:00 |  |  |
|  |  | 2 Stück | 1 | 2 | d |  | 20:00:00 |  |  |
| [MedicationRequest-Example-MR-Dosage-comb-interval-4](./MedicationRequest-Example-MR-Dosage-comb-interval-4.html) | TimeOfDay Schema - noch nicht implementiert | 1 Stück | 2 | 2 | d |  | 08:00:00, 20:00:00 |  |  |
|  |  | 2 Stück | 3 | 2 | d |  | 10:00:00, 14:00:00, 22:00:00 |  |  |
| [MedicationRequest-Example-MR-Dosage-interval-2d-bound](./MedicationRequest-Example-MR-Dosage-interval-2d-bound.html) | Interval Schema - noch nicht implementiert | 2 Stück | 1 | 2 | d |  |  |  | {'system': 'http://unitsofmeasure.org', 'value': 6, 'code': 'wk', 'unit': 'Woche(n)'} |
| [MedicationRequest-Example-MR-Dosage-interval-2wk](./MedicationRequest-Example-MR-Dosage-interval-2wk.html) | Interval Schema - noch nicht implementiert | 1 Stück | 1 | 2 | wk |  |  |  |  |
| [MedicationRequest-Example-MR-Dosage-interval-3d](./MedicationRequest-Example-MR-Dosage-interval-3d.html) | Interval Schema - noch nicht implementiert | 1 Stück | 1 | 3 | d |  |  |  |  |
| [MedicationRequest-Example-MR-Dosage-interval-4times-d](./MedicationRequest-Example-MR-Dosage-interval-4times-d.html) | Interval Schema - noch nicht implementiert | 1 Stück | 4 | 1 | d |  |  |  |  |
| [MedicationRequest-Example-MR-Dosage-interval-8d](./MedicationRequest-Example-MR-Dosage-interval-8d.html) | Interval Schema - noch nicht implementiert | 1 Stück | 1 | 8 | d |  |  |  |  |
| [MedicationRequest-Example-MR-Dosage-tod-1t-8am](./MedicationRequest-Example-MR-Dosage-tod-1t-8am.html) | TimeOfDay Schema - noch nicht implementiert | 1 Stück | 1 | 1 | d |  | 08:00:00 |  |  |
| [MedicationRequest-Example-MR-Dosage-tod-2-12am](./MedicationRequest-Example-MR-Dosage-tod-2-12am.html) | TimeOfDay Schema - noch nicht implementiert | 2 Stück | 1 | 1 | d |  | 12:00:00 |  |  |
| [MedicationRequest-Example-MR-Dosage-tod-multi-bound](./MedicationRequest-Example-MR-Dosage-tod-multi-bound.html) | TimeOfDay Schema - noch nicht implementiert | 2 Stück | 1 | 1 | d |  | 08:00:00 |  | {'system': 'http://unitsofmeasure.org', 'value': 10, 'code': 'd', 'unit': 'Tag(e)'} |
|  |  | 1 Stück | 5 | 1 | d |  | 11:00:00, 14:00:00, 17:00:00, 20:00:00, 23:00:00 |  | {'system': 'http://unitsofmeasure.org', 'value': 10, 'code': 'd', 'unit': 'Tag(e)'} |
| [MedicationRequest-Example-MR-Dosage-tod-multi](./MedicationRequest-Example-MR-Dosage-tod-multi.html) | TimeOfDay Schema - noch nicht implementiert | 2 Stück | 1 | 1 | d |  | 08:00:00 |  |  |
|  |  | 1 Stück | 5 | 1 | d |  | 11:00:00, 14:00:00, 17:00:00, 20:00:00, 23:00:00 |  |  |
| [MedicationRequest-Example-MR-Dosage-tod-unsorted](./MedicationRequest-Example-MR-Dosage-tod-unsorted.html) | TimeOfDay Schema - noch nicht implementiert | 1 Stück | 2 | 1 | d |  | 15:00:00, 08:00:00 |  |  |
| [MedicationRequest-Example-MR-Dosage-weekday-2t-1t](./MedicationRequest-Example-MR-Dosage-weekday-2t-1t.html) | DayOfWeek Schema - noch nicht implementiert | 2 Stück | 1 | 1 | wk | mon |  |  |  |
|  |  | 1 Stück | 1 | 1 | wk | thu |  |  |  |
| [MedicationRequest-Example-MR-Dosage-weekday-2t-bound](./MedicationRequest-Example-MR-Dosage-weekday-2t-bound.html) | DayOfWeek Schema - noch nicht implementiert | 2 Stück | 1 | 1 | wk | mon |  |  | {'system': 'http://unitsofmeasure.org', 'value': 10, 'code': 'wk', 'unit': 'Woche(n)'} |
| [MedicationRequest-Example-MR-Dosage-weekday-2t](./MedicationRequest-Example-MR-Dosage-weekday-2t.html) | DayOfWeek Schema - noch nicht implementiert | 2 Stück | 2 | 1 | wk | tue, thu |  |  |  |
| [MedicationRequest-Example-MR-Dosage-weekday-3t](./MedicationRequest-Example-MR-Dosage-weekday-3t.html) | DayOfWeek Schema - noch nicht implementiert | 2 Stück | 3 | 1 | wk | tue, thu, sat |  |  |  |
| [MedicationRequest-Example-MR-Dosage-weekday-unsorted](./MedicationRequest-Example-MR-Dosage-weekday-unsorted.html) | DayOfWeek Schema - noch nicht implementiert | 2 Stück | 4 | 1 | wk | fri, tue, thu, mon |  |  |  |
| [MedicationRequest-Invalid-C-TimingOnlyOneType-01-of-08](./MedicationRequest-Invalid-C-TimingOnlyOneType-01-of-08.html) | 0-0-1-0 Stück | 1 Stück | 1 | 1 | d |  |  | EVE |  |
|  |  | 1 Stück | 1 | 1 | wk | mon |  |  |  |
| [MedicationRequest-Invalid-C-TimingOnlyOneType-02-of-08](./MedicationRequest-Invalid-C-TimingOnlyOneType-02-of-08.html) | 0-1-0-0 Stück | 1 Stück | 1 | 1 | d |  |  | NOON |  |
|  |  | 1 Stück | 1 | 1 | d |  |  |  |  |
| [MedicationRequest-Invalid-C-TimingOnlyOneType-03-of-08](./MedicationRequest-Invalid-C-TimingOnlyOneType-03-of-08.html) | TimeOfDay Schema - noch nicht implementiert | 1 Stück | 1 | 1 | d |  | 07:00:00 |  |  |
|  |  | 1 Stück | 1 | 1 | wk | fri |  |  |  |
| [MedicationRequest-Invalid-C-TimingOnlyOneType-04-of-08](./MedicationRequest-Invalid-C-TimingOnlyOneType-04-of-08.html) | TimeOfDay Schema - noch nicht implementiert | 1 Stück | 1 | 1 | d |  | 12:00:00 |  |  |
|  |  | 1 Stück | 1 | 1 | d |  |  |  |  |
| [MedicationRequest-Invalid-C-TimingOnlyOneType-05-of-08](./MedicationRequest-Invalid-C-TimingOnlyOneType-05-of-08.html) | DayOfWeek Schema - noch nicht implementiert | 1 Stück | 1 | 1 | wk | tue |  |  |  |
|  |  | 1 Stück | 1 | 1 | d |  |  |  |  |
| [MedicationRequest-Invalid-C-TimingOnlyWhenOrTimeOfDay-01-of-01](./MedicationRequest-Invalid-C-TimingOnlyWhenOrTimeOfDay-01-of-01.html) | 1-0-0-0 Stück | 1 Stück | 1 | 1 | d |  |  | MORN |  |
|  |  | 1 Stück | 1 | 1 | d |  | 08:00:00 |  |  |
| [MedicationRequest-Invalid-Dosage-01-of-12-FreqPeriod-When](./MedicationRequest-Invalid-Dosage-01-of-12-FreqPeriod-When.html) | Unbekanntes Dosierungsschema: Unknown | 1 Stück | 1 | 1 | d |  | 08:00:00 | MORN |  |
| [MedicationRequest-Invalid-Dosage-02-of-12-FreqPeriod-ToD-DayOfWeek](./MedicationRequest-Invalid-Dosage-02-of-12-FreqPeriod-ToD-DayOfWeek.html) | DayOfWeek and Time/4-Schema - noch nicht implementiert | 1 Stück | 1 | 1 | d | mon | 08:00:00 |  |  |
| [MedicationRequest-Invalid-Dosage-03-of-12-FreqPeriod-When-DayOfWeek](./MedicationRequest-Invalid-Dosage-03-of-12-FreqPeriod-When-DayOfWeek.html) | DayOfWeek and Time/4-Schema - noch nicht implementiert | 1 Stück | 1 | 1 | d | mon |  | MORN |  |
| [MedicationRequest-Invalid-Dosage-04-of-12-FreeText-and-structured](./MedicationRequest-Invalid-Dosage-04-of-12-FreeText-and-structured.html) | 1-0-0-0 Stück | 1 Stück | 1 | 1 | d |  |  | MORN |  |
| [MedicationRequest-Invalid-Dosage-05-of-12-multiple-types](./MedicationRequest-Invalid-Dosage-05-of-12-multiple-types.html) | 0-0-0-0 |  | 1 | 1 | d |  |  | MORN |  |
|  |  |  | 1 | 1 | d |  | 08:00:00 |  |  |
| [MedicationRequest-Invalid-Dosage-06-of-12-multiple-dosagecodes](./MedicationRequest-Invalid-Dosage-06-of-12-multiple-dosagecodes.html) | 1-0-400-0 Stück | 1 Stück | 1 | 1 | d |  |  | MORN |  |
|  |  | 400 mg | 1 | 1 | d |  |  | EVE |  |
| [MedicationRequest-Invalid-Dosage-07-of-12-timing-no-dose](./MedicationRequest-Invalid-Dosage-07-of-12-timing-no-dose.html) | 0-0-0-0 |  | 1 | 1 | d |  |  | MORN |  |
| [MedicationRequest-Invalid-Dosage-09-of-12-C-TimingOnlyOneTimeForInterval](./MedicationRequest-Invalid-Dosage-09-of-12-C-TimingOnlyOneTimeForInterval.html) | 1-2-2-0 Stück | 1 Stück | 1 | 1 | d |  |  | MORN |  |
|  |  | 2 Stück | 2 | 2 | d |  |  | NOON, EVE |  |
| [MedicationRequest-Invalid-Dosage-10-of-12-When-DiffPeriodU](./MedicationRequest-Invalid-Dosage-10-of-12-When-DiffPeriodU.html) | 1-2-2-0 Stück | 1 Stück | 1 | 1 | d |  |  | MORN |  |
|  |  | 2 Stück | 2 | 1 | wk |  |  | NOON, EVE |  |
| [MedicationRequest-Invalid-Dosage-11-of-12-C-TimingOnlyOneWhen](./MedicationRequest-Invalid-Dosage-11-of-12-C-TimingOnlyOneWhen.html) | 2-0-2-0 Stück | 1 Stück | 1 | 1 | d |  |  | MORN |  |
|  |  | 2 Stück | 1 | 1 | d |  |  | MORN, EVE |  |
| [MedicationRequest-Invalid-Dosage-12-of-12-C-TimingOnlyOneDayOfWeek](./MedicationRequest-Invalid-Dosage-12-of-12-C-TimingOnlyOneDayOfWeek.html) | DayOfWeek Schema - noch nicht implementiert | 1 Stück | 1 | 1 | wk | mon |  |  |  |
|  |  | 2 Stück | 1 | 1 | wk | mon |  |  |  |
| [MedicationRequest-Invalid-Dosage-C-DosageStructuredRequiresGeneratedText-01-of-01](./MedicationRequest-Invalid-Dosage-C-DosageStructuredRequiresGeneratedText-01-of-01.html) | 1-0-0-0 Stück | 1 Stück | 1 | 1 | d |  |  | MORN |  |
| [MedicationRequest-Invalid-Dosage-C-TimingBoundsUnitMatchesCode-02-of-02](./MedicationRequest-Invalid-Dosage-C-TimingBoundsUnitMatchesCode-02-of-02.html) | Interval Schema - noch nicht implementiert | 1 Stück | 1 | 2 | d |  |  |  | {'system': 'http://unitsofmeasure.org', 'value': 3, 'code': 'wk', 'unit': 'Tag(e)'} |
| [MedicationRequest-Invalid-Dosage-C-TimingFrequencyCount-01-of-05](./MedicationRequest-Invalid-Dosage-C-TimingFrequencyCount-01-of-05.html) | 1-0-0-0 Stück | 1 Stück | 2 | 1 | d |  |  | MORN |  |
| [MedicationRequest-Invalid-Dosage-C-TimingFrequencyCount-02-of-05](./MedicationRequest-Invalid-Dosage-C-TimingFrequencyCount-02-of-05.html) | TimeOfDay Schema - noch nicht implementiert | 1 Stück | 2 | 1 | d |  | 08:00:00 |  |  |
| [MedicationRequest-Invalid-Dosage-C-TimingFrequencyCount-03-of-05](./MedicationRequest-Invalid-Dosage-C-TimingFrequencyCount-03-of-05.html) | DayOfWeek Schema - noch nicht implementiert | 2 Stück | 3 | 1 | wk | tue, thu |  |  |  |
| [MedicationRequest-Invalid-Dosage-C-TimingFrequencyCount-04-of-05](./MedicationRequest-Invalid-Dosage-C-TimingFrequencyCount-04-of-05.html) | TimeOfDay Schema - noch nicht implementiert | 1 Stück | 3 | 2 | d |  | 08:00:00, 20:00:00 |  |  |
|  |  | 2 Stück | 2 | 2 | d |  | 10:00:00, 14:00:00, 22:00:00 |  |  |
| [MedicationRequest-Invalid-Dosage-C-TimingFrequencyCount-05-of-05](./MedicationRequest-Invalid-Dosage-C-TimingFrequencyCount-05-of-05.html) | DayOfWeek and Time/4-Schema - noch nicht implementiert | 1 Stück | 3 | 1 | wk | mon, fri |  | MORN | {'system': 'http://unitsofmeasure.org', 'value': 3, 'code': 'wk', 'unit': 'Woche(n)'} |
| [MedicationRequest-Invalid-Dosage-C-TimingPeriodUnit-01-of-05](./MedicationRequest-Invalid-Dosage-C-TimingPeriodUnit-01-of-05.html) | Interval and Time/4-Schema - noch nicht implementiert | 1 Stück | 1 | 1 | wk |  |  | MORN |  |
| [MedicationRequest-Invalid-Dosage-C-TimingPeriodUnit-02-of-05](./MedicationRequest-Invalid-Dosage-C-TimingPeriodUnit-02-of-05.html) | TimeOfDay Schema - noch nicht implementiert | 1 Stück | 1 | 1 | wk |  | 08:00:00 |  |  |
| [MedicationRequest-Invalid-Dosage-C-TimingPeriodUnit-03-of-05](./MedicationRequest-Invalid-Dosage-C-TimingPeriodUnit-03-of-05.html) | DayOfWeek Schema - noch nicht implementiert | 2 Stück | 1 | 1 | d | tue |  |  |  |
| [MedicationRequest-Invalid-Dosage-C-TimingPeriodUnit-04-of-05](./MedicationRequest-Invalid-Dosage-C-TimingPeriodUnit-04-of-05.html) | DayOfWeek and Time/4-Schema - noch nicht implementiert | 1 Stück | 2 | 1 | d | mon, fri |  | MORN | {'system': 'http://unitsofmeasure.org', 'value': 3, 'code': 'wk', 'unit': 'Woche(n)'} |
| [MedicationRequest-Invalid-Dosage-C-TimingPeriodUnit-05-of-05](./MedicationRequest-Invalid-Dosage-C-TimingPeriodUnit-05-of-05.html) | DayOfWeek and Time/4-Schema - noch nicht implementiert | 1 Stück | 2 | 1 | wk | mon, fri |  | MORN | {'system': 'http://unitsofmeasure.org', 'value': 3, 'code': 'wk', 'unit': 'Woche(n)'} |
|  |  | 2 Stück | 2 | 1 | d | mon, fri |  | NOON | {'system': 'http://unitsofmeasure.org', 'value': 3, 'code': 'wk', 'unit': 'Woche(n)'} |
| [MedicationRequest-Invalid-multiple-01-of-10-when](./MedicationRequest-Invalid-multiple-01-of-10-when.html) | 2-0-2-0 Stück | 1 Stück | 1 | 1 | d |  |  | MORN |  |
|  |  | 2 Stück | 1 | 1 | d |  |  | MORN, EVE |  |
| [MedicationRequest-Invalid-multiple-02-of-10-C-TimingOnlyOneTimeOfDay](./MedicationRequest-Invalid-multiple-02-of-10-C-TimingOnlyOneTimeOfDay.html) | TimeOfDay Schema - noch nicht implementiert | 2 Stück | 1 | 1 | d |  | 08:00:00 |  |  |
|  |  | 1 Stück | 2 | 1 | d |  | 08:00:00, 14:00:00 |  |  |
| [MedicationRequest-Invalid-multiple-04-of-10-C-TimingOnlyOnePeriodForDayOfWeek](./MedicationRequest-Invalid-multiple-04-of-10-C-TimingOnlyOnePeriodForDayOfWeek.html) | DayOfWeek and Time/4-Schema - noch nicht implementiert | 1 Stück | 2 | 1 | d | mon, fri |  | MORN, EVE |  |
|  |  | 2 Stück | 1 | 1 | d | mon, sat |  | MORN |  |
| [MedicationRequest-Invalid-multiple-05-of-10-C-TimingOnlyOnePeriodForDayOfWeek](./MedicationRequest-Invalid-multiple-05-of-10-C-TimingOnlyOnePeriodForDayOfWeek.html) | DayOfWeek and Time/4-Schema - noch nicht implementiert | 1 Stück | 2 | 1 | d | mon, fri | 08:00:00, 12:00:00 |  |  |
|  |  | 2 Stück | 1 | 1 | d | mon, sat | 08:00:00 |  |  |
| [MedicationRequest-Invalid-multiple-06-of-10-C-TimingIntervalOnlyOneFrequency](./MedicationRequest-Invalid-multiple-06-of-10-C-TimingIntervalOnlyOneFrequency.html) | Interval Schema - noch nicht implementiert | 1 Stück | 1 | 2 | d |  |  |  |  |
|  |  | 2 Stück | 1 | 3 | d |  |  |  |  |
| [MedicationRequest-Invalid-multiple-07-of-10-C-TimingOnlyOneWhen](./MedicationRequest-Invalid-multiple-07-of-10-C-TimingOnlyOneWhen.html) | Interval and Time/4-Schema - noch nicht implementiert | 1 Stück | 1 | 2 | d |  |  | MORN |  |
|  |  | 2 Stück | 2 | 2 | d |  |  | MORN, EVE |  |
| [MedicationRequest-Invalid-multiple-08-of-10-C-TimingOnlyOneTimeOfDay](./MedicationRequest-Invalid-multiple-08-of-10-C-TimingOnlyOneTimeOfDay.html) | TimeOfDay Schema - noch nicht implementiert | 1 Stück | 1 | 2 | d |  | 08:00:00 |  |  |
|  |  | 2 Stück | 1 | 2 | d |  | 08:00:00 |  |  |
| [MedicationRequest-Invalid-multiple-09-of-10-C-TimingOnlyOneTimeForInterval](./MedicationRequest-Invalid-multiple-09-of-10-C-TimingOnlyOneTimeForInterval.html) | TimeOfDay Schema - noch nicht implementiert | 1 Stück | 1 | 2 | d |  | 08:00:00 |  |  |
|  |  | 2 Stück | 1 | 3 | d |  | 20:00:00 |  |  |
| [MedicationRequest-Invalid-multiple-10-of-10-C-TimingOnlyOneBounds](./MedicationRequest-Invalid-multiple-10-of-10-C-TimingOnlyOneBounds.html) | TimeOfDay Schema - noch nicht implementiert | 1 Stück | 1 | 1 | d |  | 08:00:00 |  | {'system': 'http://unitsofmeasure.org', 'value': 2, 'code': 'wk', 'unit': 'Woche(n)'} |
|  |  | 2 Stück | 1 | 1 | d |  | 20:00:00 |  | {'system': 'http://unitsofmeasure.org', 'value': 3, 'code': 'wk', 'unit': 'Woche(n)'} |
| [MedicationRequest-MR-Unsupported-Dosage-01-of-20-Count](./MedicationRequest-MR-Unsupported-Dosage-01-of-20-Count.html) | Interval Schema - noch nicht implementiert |  | 1 | 1 | d |  |  |  |  |
| [MedicationRequest-MR-Unsupported-Dosage-02-of-20-asNeededBoolean](./MedicationRequest-MR-Unsupported-Dosage-02-of-20-asNeededBoolean.html) | Unbekanntes Dosierungsschema: Unknown |  |  |  |  |  |  |  |  |
| [MedicationRequest-MR-Unsupported-Dosage-03-of-20-asNeededCodeableConcept](./MedicationRequest-MR-Unsupported-Dosage-03-of-20-asNeededCodeableConcept.html) | Unbekanntes Dosierungsschema: Unknown |  |  |  |  |  |  |  |  |
| [MedicationRequest-MR-Unsupported-Dosage-04-of-20-Method](./MedicationRequest-MR-Unsupported-Dosage-04-of-20-Method.html) | Unbekanntes Dosierungsschema: Unknown |  |  |  |  |  |  |  |  |
| [MedicationRequest-MR-Unsupported-Dosage-05-of-20-Route](./MedicationRequest-MR-Unsupported-Dosage-05-of-20-Route.html) | Unbekanntes Dosierungsschema: Unknown |  |  |  |  |  |  |  |  |
| [MedicationRequest-MR-Unsupported-Dosage-06-of-20-Site](./MedicationRequest-MR-Unsupported-Dosage-06-of-20-Site.html) | Unbekanntes Dosierungsschema: Unknown |  |  |  |  |  |  |  |  |
| [MedicationRequest-MR-Unsupported-Dosage-07-of-20-DoseRange](./MedicationRequest-MR-Unsupported-Dosage-07-of-20-DoseRange.html) | Unbekanntes Dosierungsschema: Unknown |  |  |  |  |  |  |  |  |
| [MedicationRequest-MR-Unsupported-Dosage-08-of-20-RateQuantity](./MedicationRequest-MR-Unsupported-Dosage-08-of-20-RateQuantity.html) | Unbekanntes Dosierungsschema: Unknown |  |  |  |  |  |  |  |  |
| [MedicationRequest-MR-Unsupported-Dosage-09-of-20-RateRange](./MedicationRequest-MR-Unsupported-Dosage-09-of-20-RateRange.html) | Unbekanntes Dosierungsschema: Unknown |  |  |  |  |  |  |  |  |
| [MedicationRequest-MR-Unsupported-Dosage-10-of-20-RateRatio](./MedicationRequest-MR-Unsupported-Dosage-10-of-20-RateRatio.html) | Unbekanntes Dosierungsschema: Unknown |  |  |  |  |  |  |  |  |
| [MedicationRequest-MR-Unsupported-Dosage-11-of-20-AdditionalInstruction](./MedicationRequest-MR-Unsupported-Dosage-11-of-20-AdditionalInstruction.html) | Unbekanntes Dosierungsschema: Unknown |  |  |  |  |  |  |  |  |
| [MedicationRequest-MR-Unsupported-Dosage-12-of-20-MaxDosePerPeriod](./MedicationRequest-MR-Unsupported-Dosage-12-of-20-MaxDosePerPeriod.html) | Unbekanntes Dosierungsschema: Unknown |  |  |  |  |  |  |  |  |
| [MedicationRequest-MR-Unsupported-Dosage-13-of-20-MaxDosePerAdministration](./MedicationRequest-MR-Unsupported-Dosage-13-of-20-MaxDosePerAdministration.html) | Unbekanntes Dosierungsschema: Unknown |  |  |  |  |  |  |  |  |
| [MedicationRequest-MR-Unsupported-Dosage-14-of-20-MaxDosePerLifetime](./MedicationRequest-MR-Unsupported-Dosage-14-of-20-MaxDosePerLifetime.html) | Unbekanntes Dosierungsschema: Unknown |  |  |  |  |  |  |  |  |
| [MedicationRequest-MR-Unsupported-Dosage-15-of-20-Count](./MedicationRequest-MR-Unsupported-Dosage-15-of-20-Count.html) | Interval Schema - noch nicht implementiert |  | 1 | 1 | d |  |  |  |  |
| [MedicationRequest-MR-Unsupported-Dosage-16-of-20-CountMax](./MedicationRequest-MR-Unsupported-Dosage-16-of-20-CountMax.html) | Interval Schema - noch nicht implementiert |  | 1 | 1 | d |  |  |  |  |
| [MedicationRequest-MR-Unsupported-Dosage-17-of-20-BoundsPeriod](./MedicationRequest-MR-Unsupported-Dosage-17-of-20-BoundsPeriod.html) | Interval Schema - noch nicht implementiert |  | 1 | 1 | d |  |  |  |  |
| [MedicationRequest-MR-Unsupported-Dosage-18-of-20-BoundsRange](./MedicationRequest-MR-Unsupported-Dosage-18-of-20-BoundsRange.html) | Interval Schema - noch nicht implementiert |  | 1 | 1 | d |  |  |  |  |
| [MedicationRequest-MR-Unsupported-Dosage-19-of-20-Offset](./MedicationRequest-MR-Unsupported-Dosage-19-of-20-Offset.html) | Interval Schema - noch nicht implementiert |  | 1 | 1 | d |  |  |  |  |
| [MedicationRequest-MR-Unsupported-Dosage-20-of-20-Event](./MedicationRequest-MR-Unsupported-Dosage-20-of-20-Event.html) | Unbekanntes Dosierungsschema: Unknown |  | 1 | 1 | d |  | 08:00:00 | MORN | {'value': 3, 'code': 'wk', 'system': 'http://unitsofmeasure.org', 'unit': 'Woche(n)'} |
| [MedicationRequest-Valid-Dosage-C-TimingBoundsUnitMatchesCode-01-of-02](./MedicationRequest-Valid-Dosage-C-TimingBoundsUnitMatchesCode-01-of-02.html) | Interval Schema - noch nicht implementiert | 1 Stück | 1 | 2 | d |  |  |  | {'system': 'http://unitsofmeasure.org', 'value': 3, 'code': 'wk', 'unit': 'Woche(n)'} |