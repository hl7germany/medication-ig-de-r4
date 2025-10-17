| File | Consolidated Dosage Text | doseQuantity | frequency | period | periodUnit | Day<br>of<br>Week | Time<br>Of<br>Day | when | bounds[x] |
| :---: | :--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| [MedicationDispense-MD-Dosage-1020](./MedicationDispense-MD-Dosage-1020.html) | 1-0-2-0 Stück | 1 Stück | 1 | 1 | d |  |  | MORN |  |
|  |  | 2 Stück | 1 | 1 | d |  |  | EVE |  |
| [MedicationDispense-MD-Dosage-Bounds-Decimals](./MedicationDispense-MD-Dosage-Bounds-Decimals.html) | für 2 Wochen: 0,5-0-1,5-0 Stück | 0.5 Stück | 1 | 1 | d |  |  | MORN | {'system': 'http://unitsofmeasure.org', 'value': 2, 'code': 'wk', 'unit': 'Wochen'} |
|  |  | 1.5 Stück | 1 | 1 | d |  |  | EVE | {'system': 'http://unitsofmeasure.org', 'value': 2, 'code': 'wk', 'unit': 'Wochen'} |
| [MedicationDispense-MD-Dosage-DayOfWeek-Time](./MedicationDispense-MD-Dosage-DayOfWeek-Time.html) | montags 1-0-0-0 Stück; mittwochs 0-0-2-0 Stück | 1 Stück | 1 | 1 | wk | mon |  | MORN |  |
|  |  | 2 Stück | 1 | 1 | wk | wed |  | EVE |  |
| [MedicationDispense-MD-Dosage-Freetext](./MedicationDispense-MD-Dosage-Freetext.html) | Morgens und abends je 1 Kapsel nach dem Essen |  |  |  |  |  |  |  |  |
| [MedicationDispense-MD-Dosage-Interval-Time](./MedicationDispense-MD-Dosage-Interval-Time.html) | alle 2 Tage: 09:00 Uhr — je 1 Stück; 21:00 Uhr — je 2 Stück | 1 Stück | 1 | 2 | d |  | 09:00:00 |  |  |
|  |  | 2 Stück | 1 | 2 | d |  | 21:00:00 |  |  |
| [MedicationRequest-Example-MR-Bug-EmptyLists](./MedicationRequest-Example-MR-Bug-EmptyLists.html) | täglich: je 1 Stück | 1 Stück | 1 | 1 | d |  |  |  |  |
| [MedicationRequest-Example-MR-Bug-MultipleTimeOfDay-Daily](./MedicationRequest-Example-MR-Bug-MultipleTimeOfDay-Daily.html) | täglich: 08:00 Uhr, 14:00 Uhr, 22:00 Uhr — je 1 Stück | 1 Stück | 3 | 1 | d |  | 08:00:00, 14:00:00, 22:00:00 |  |  |
| [MedicationRequest-Example-MR-Bug-MultipleTimeOfDay-DayOfWeek](./MedicationRequest-Example-MR-Bug-MultipleTimeOfDay-DayOfWeek.html) | montags 09:00 Uhr, 21:00 Uhr — je 1 Stück; mittwochs 09:00 Uhr, 21:00 Uhr — je 1 Stück; freitags 09:00 Uhr, 21:00 Uhr — je 1 Stück | 1 Stück | 6 | 1 | wk | mon, wed, fri | 09:00:00, 21:00:00 |  |  |
| [MedicationRequest-Example-MR-Bug-MultipleTimeOfDay-Interval](./MedicationRequest-Example-MR-Bug-MultipleTimeOfDay-Interval.html) | alle 2 Tage: 08:00 Uhr — je 1 Stück; 20:00 Uhr — je 1 Stück | 1 Stück | 2 | 2 | d |  | 08:00:00, 20:00:00 |  |  |
| [MedicationRequest-Example-MR-Bug-MultipleWhen-DayOfWeek](./MedicationRequest-Example-MR-Bug-MultipleWhen-DayOfWeek.html) | dienstags 1-0-1-0 Stück; donnerstags 1-0-1-0 Stück | 1 Stück | 4 | 1 | wk | tue, thu |  | MORN, EVE |  |
| [MedicationRequest-Example-MR-Bug-MultipleWhen-Interval](./MedicationRequest-Example-MR-Bug-MultipleWhen-Interval.html) | alle 3 Tage: morgens — je 1 Stück; abends — je 1 Stück | 1 Stück | 2 | 3 | d |  |  | MORN, EVE |  |
| [MedicationRequest-Example-MR-Dosage-1000](./MedicationRequest-Example-MR-Dosage-1000.html) | 1-0-0-0 Stück | 1 Stück | 1 | 1 | d |  |  | MORN |  |
| [MedicationRequest-Example-MR-Dosage-1010-10-Days](./MedicationRequest-Example-MR-Dosage-1010-10-Days.html) | für 10 Wochen: 1-0-1-0 Stück | 1 Stück | 2 | 1 | d |  |  | MORN, EVE | {'system': 'http://unitsofmeasure.org', 'value': 10, 'code': 'wk', 'unit': 'Woche(n)'} |
| [MedicationRequest-Example-MR-Dosage-1010-Unsorted](./MedicationRequest-Example-MR-Dosage-1010-Unsorted.html) | 1-0-1-0 Stück | 1 Stück | 2 | 1 | d |  |  | EVE, MORN |  |
| [MedicationRequest-Example-MR-Dosage-1010](./MedicationRequest-Example-MR-Dosage-1010.html) | 1-0-1-0 Stück | 1 Stück | 2 | 1 | d |  |  | MORN, EVE |  |
| [MedicationRequest-Example-MR-Dosage-10120](./MedicationRequest-Example-MR-Dosage-10120.html) | 1-0-0,5-0 Stück | 1 Stück | 1 | 1 | d |  |  | MORN |  |
|  |  | 0.5 Stück | 1 | 1 | d |  |  | EVE |  |
| [MedicationRequest-Example-MR-Dosage-1020-Unordered](./MedicationRequest-Example-MR-Dosage-1020-Unordered.html) | 1-0-2-0 Stück | 2 Stück | 1 | 1 | d |  |  | EVE |  |
|  |  | 1 Stück | 1 | 1 | d |  |  | MORN |  |
| [MedicationRequest-Example-MR-Dosage-1020](./MedicationRequest-Example-MR-Dosage-1020.html) | 1-0-2-0 Stück | 1 Stück | 1 | 1 | d |  |  | MORN |  |
|  |  | 2 Stück | 1 | 1 | d |  |  | EVE |  |
| [MedicationRequest-Example-MR-Dosage-1111](./MedicationRequest-Example-MR-Dosage-1111.html) | 1-1-1-1 Stück | 1 Stück | 4 | 1 | d |  |  | EVE, MORN, NIGHT, NOON |  |
| [MedicationRequest-Example-MR-Dosage-1220](./MedicationRequest-Example-MR-Dosage-1220.html) | 1-2-2-0 Stück | 1 Stück | 1 | 1 | d |  |  | MORN |  |
|  |  | 2 Stück | 2 | 1 | d |  |  | NOON, EVE |  |
| [MedicationRequest-Example-MR-Dosage-Freetext](./MedicationRequest-Example-MR-Dosage-Freetext.html) | 2 Stück morgens zum Frühstück |  |  |  |  |  |  |  |  |
| [MedicationRequest-Example-MR-Dosage-UnitStueck-1020](./MedicationRequest-Example-MR-Dosage-UnitStueck-1020.html) | 1-0-2-0 Stück | 1 Stück | 1 | 1 | d |  |  | MORN |  |
|  |  | 2 Stück | 1 | 1 | d |  |  | EVE |  |
| [MedicationRequest-Example-MR-Dosage-UnitTasse-1000](./MedicationRequest-Example-MR-Dosage-UnitTasse-1000.html) | 2-0-0-0 Teelöffel | 2 Teelöffel | 1 | 1 | d |  |  | MORN |  |
| [MedicationRequest-Example-MR-Dosage-comb-dayofweek-1](./MedicationRequest-Example-MR-Dosage-comb-dayofweek-1.html) | montags 1-0-1-0 Stück; freitags 1-0-1-0 Stück | 1 Stück | 4 | 1 | wk | mon, fri |  | MORN, EVE |  |
| [MedicationRequest-Example-MR-Dosage-comb-dayofweek-2](./MedicationRequest-Example-MR-Dosage-comb-dayofweek-2.html) | montags 1-2-1-0 Stück; freitags 1-2-1-0 Stück | 1 Stück | 4 | 1 | wk | mon, fri |  | MORN, EVE |  |
|  |  | 2 Stück | 2 | 1 | wk | mon, fri |  | NOON |  |
| [MedicationRequest-Example-MR-Dosage-comb-dayofweek-3](./MedicationRequest-Example-MR-Dosage-comb-dayofweek-3.html) | für 3 Wochen: montags 1-2-0-0 Stück; freitags 1-2-0-0 Stück | 1 Stück | 2 | 1 | wk | mon, fri |  | MORN | {'system': 'http://unitsofmeasure.org', 'value': 3, 'code': 'wk', 'unit': 'Woche(n)'} |
|  |  | 2 Stück | 2 | 1 | wk | mon, fri |  | NOON | {'system': 'http://unitsofmeasure.org', 'value': 3, 'code': 'wk', 'unit': 'Woche(n)'} |
| [MedicationRequest-Example-MR-Dosage-comb-dayofweek-unsorted](./MedicationRequest-Example-MR-Dosage-comb-dayofweek-unsorted.html) | montags 1-0-1-0 Stück; donnerstags 1-0-1-0 Stück; samstags 1-0-1-0 Stück | 1 Stück | 6 | 1 | wk | sat, mon, thu |  | EVE, MORN |  |
| [MedicationRequest-Example-MR-Dosage-comb-interval-1](./MedicationRequest-Example-MR-Dosage-comb-interval-1.html) | alle 2 Tage: 08:00 Uhr — je 1 Stück; 18:00 Uhr — je 2 Stück | 1 Stück | 1 | 2 | d |  | 08:00:00 |  |  |
|  |  | 2 Stück | 1 | 2 | d |  | 18:00:00 |  |  |
| [MedicationRequest-Example-MR-Dosage-comb-interval-2](./MedicationRequest-Example-MR-Dosage-comb-interval-2.html) | 1-0-0-0 Stück | 1 Stück | 1 | 1 | d |  |  | MORN |  |
| [MedicationRequest-Example-MR-Dosage-comb-interval-3](./MedicationRequest-Example-MR-Dosage-comb-interval-3.html) | alle 2 Tage: 08:00 Uhr — je 1 Stück; 20:00 Uhr — je 2 Stück | 1 Stück | 1 | 2 | d |  | 08:00:00 |  |  |
|  |  | 2 Stück | 1 | 2 | d |  | 20:00:00 |  |  |
| [MedicationRequest-Example-MR-Dosage-comb-interval-4](./MedicationRequest-Example-MR-Dosage-comb-interval-4.html) | alle 2 Tage: 08:00 Uhr — je 1 Stück; 10:00 Uhr — je 2 Stück; 14:00 Uhr — je 2 Stück; 20:00 Uhr — je 1 Stück; 22:00 Uhr — je 2 Stück | 1 Stück | 2 | 2 | d |  | 08:00:00, 20:00:00 |  |  |
|  |  | 2 Stück | 3 | 2 | d |  | 10:00:00, 14:00:00, 22:00:00 |  |  |
| [MedicationRequest-Example-MR-Dosage-interval-2d-bound](./MedicationRequest-Example-MR-Dosage-interval-2d-bound.html) | für 6 Wochen alle 2 Tage: je 2 Stück | 2 Stück | 1 | 2 | d |  |  |  | {'system': 'http://unitsofmeasure.org', 'value': 6, 'code': 'wk', 'unit': 'Woche(n)'} |
| [MedicationRequest-Example-MR-Dosage-interval-2wk](./MedicationRequest-Example-MR-Dosage-interval-2wk.html) | alle 2 Wochen: je 1 Stück | 1 Stück | 1 | 2 | wk |  |  |  |  |
| [MedicationRequest-Example-MR-Dosage-interval-3d](./MedicationRequest-Example-MR-Dosage-interval-3d.html) | alle 3 Tage: je 1 Stück | 1 Stück | 1 | 3 | d |  |  |  |  |
| [MedicationRequest-Example-MR-Dosage-interval-4times-d](./MedicationRequest-Example-MR-Dosage-interval-4times-d.html) | 4 x täglich: je 1 Stück | 1 Stück | 4 | 1 | d |  |  |  |  |
| [MedicationRequest-Example-MR-Dosage-interval-8d](./MedicationRequest-Example-MR-Dosage-interval-8d.html) | alle 8 Tage: je 1 Stück | 1 Stück | 1 | 8 | d |  |  |  |  |
| [MedicationRequest-Example-MR-Dosage-tod-1t-8am](./MedicationRequest-Example-MR-Dosage-tod-1t-8am.html) | täglich: 08:00 Uhr — je 1 Stück | 1 Stück | 1 | 1 | d |  | 08:00:00 |  |  |
| [MedicationRequest-Example-MR-Dosage-tod-2-12am](./MedicationRequest-Example-MR-Dosage-tod-2-12am.html) | täglich: 12:00 Uhr — je 2 Stück | 2 Stück | 1 | 1 | d |  | 12:00:00 |  |  |
| [MedicationRequest-Example-MR-Dosage-tod-multi-bound](./MedicationRequest-Example-MR-Dosage-tod-multi-bound.html) | für 10 Tage täglich: 08:00 Uhr — je 2 Stück; 11:00 Uhr, 14:00 Uhr, 17:00 Uhr, 20:00 Uhr, 23:00 Uhr — je 1 Stück | 2 Stück | 1 | 1 | d |  | 08:00:00 |  | {'system': 'http://unitsofmeasure.org', 'value': 10, 'code': 'd', 'unit': 'Tag(e)'} |
|  |  | 1 Stück | 5 | 1 | d |  | 11:00:00, 14:00:00, 17:00:00, 20:00:00, 23:00:00 |  | {'system': 'http://unitsofmeasure.org', 'value': 10, 'code': 'd', 'unit': 'Tag(e)'} |
| [MedicationRequest-Example-MR-Dosage-tod-multi](./MedicationRequest-Example-MR-Dosage-tod-multi.html) | täglich: 08:00 Uhr — je 2 Stück; 11:00 Uhr, 14:00 Uhr, 17:00 Uhr, 20:00 Uhr, 23:00 Uhr — je 1 Stück | 2 Stück | 1 | 1 | d |  | 08:00:00 |  |  |
|  |  | 1 Stück | 5 | 1 | d |  | 11:00:00, 14:00:00, 17:00:00, 20:00:00, 23:00:00 |  |  |
| [MedicationRequest-Example-MR-Dosage-tod-unsorted](./MedicationRequest-Example-MR-Dosage-tod-unsorted.html) | täglich: 08:00 Uhr, 15:00 Uhr — je 1 Stück | 1 Stück | 2 | 1 | d |  | 15:00:00, 08:00:00 |  |  |
| [MedicationRequest-Example-MR-Dosage-weekday-2t-1t](./MedicationRequest-Example-MR-Dosage-weekday-2t-1t.html) | montags — je 2 Stück; donnerstags — je 1 Stück | 2 Stück | 1 | 1 | wk | mon |  |  |  |
|  |  | 1 Stück | 1 | 1 | wk | thu |  |  |  |
| [MedicationRequest-Example-MR-Dosage-weekday-2t-bound](./MedicationRequest-Example-MR-Dosage-weekday-2t-bound.html) | für 10 Wochen: montags — je 2 Stück | 2 Stück | 1 | 1 | wk | mon |  |  | {'system': 'http://unitsofmeasure.org', 'value': 10, 'code': 'wk', 'unit': 'Woche(n)'} |
| [MedicationRequest-Example-MR-Dosage-weekday-2t](./MedicationRequest-Example-MR-Dosage-weekday-2t.html) | dienstags — je 2 Stück; donnerstags — je 2 Stück | 2 Stück | 2 | 1 | wk | tue, thu |  |  |  |
| [MedicationRequest-Example-MR-Dosage-weekday-3t](./MedicationRequest-Example-MR-Dosage-weekday-3t.html) | dienstags — je 2 Stück; donnerstags — je 2 Stück; samstags — je 2 Stück | 2 Stück | 3 | 1 | wk | tue, thu, sat |  |  |  |
| [MedicationRequest-Example-MR-Dosage-weekday-unsorted](./MedicationRequest-Example-MR-Dosage-weekday-unsorted.html) | montags — je 2 Stück; dienstags — je 2 Stück; donnerstags — je 2 Stück; freitags — je 2 Stück | 2 Stück | 4 | 1 | wk | fri, tue, thu, mon |  |  |  |
| [MedicationRequest-Example-MR-DosageTr-1000](./MedicationRequest-Example-MR-DosageTr-1000.html) | 20-0-0-0 Tropfen | 20 Tropfen | 1 | 1 | d |  |  | MORN |  |
| [MedicationRequest-MR-Dosage-4schema-evening-only](./MedicationRequest-MR-Dosage-4schema-evening-only.html) | 0-0-1-0 Stück | 1 Stück | 1 | 1 | d |  |  | EVE |  |
| [MedicationRequest-MR-Dosage-4schema-ml-units](./MedicationRequest-MR-Dosage-4schema-ml-units.html) | 2-0-1-0 ml | 2 ml | 1 | 1 | d |  |  | MORN |  |
|  |  | 1 ml | 1 | 1 | d |  |  | EVE |  |
| [MedicationRequest-MR-Dosage-4schema-night-only](./MedicationRequest-MR-Dosage-4schema-night-only.html) | 0-0-0-1 Stück | 1 Stück | 1 | 1 | d |  |  | NIGHT |  |
| [MedicationRequest-MR-Dosage-4schema-noon-only](./MedicationRequest-MR-Dosage-4schema-noon-only.html) | 0-1-0-0 Stück | 1 Stück | 1 | 1 | d |  |  | NOON |  |
| [MedicationRequest-MR-Dosage-freetext-german-chars](./MedicationRequest-MR-Dosage-freetext-german-chars.html) | Nach dem Essen — 2 Stück täglich für 3 Wochen (Dosierung anpassen je nach Verträglichkeit) |  |  |  |  |  |  |  |  |
| [MedicationRequest-MR-Dosage-interval-monthly](./MedicationRequest-MR-Dosage-interval-monthly.html) | alle 2 Monate: je 1 Stück | 1 Stück | 1 | 2 | mo |  |  |  |  |
| [MedicationRequest-MR-Dosage-interval-when-3d](./MedicationRequest-MR-Dosage-interval-when-3d.html) | alle 3 Tage: morgens — je 1 Stück; abends — je 2 Stück | 1 Stück | 1 | 3 | d |  |  | MORN |  |
|  |  | 2 Stück | 1 | 3 | d |  |  | EVE |  |
| [MedicationRequest-MR-Dosage-multiple-day-time](./MedicationRequest-MR-Dosage-multiple-day-time.html) | montags 08:00 Uhr, 20:00 Uhr — je 2 Stück; dienstags 08:00 Uhr — je 1 Stück; donnerstags 08:00 Uhr — je 1 Stück; freitags 08:00 Uhr, 20:00 Uhr — je 2 Stück | 1 Stück | 2 | 1 | wk | tue, thu | 08:00:00 |  |  |
|  |  | 2 Stück | 4 | 1 | wk | mon, fri | 08:00:00, 20:00:00 |  |  |
| [MedicationRequest-MR-Dosage-single-day-time](./MedicationRequest-MR-Dosage-single-day-time.html) | montags 08:00 Uhr — je 1 Stück | 1 Stück | 1 | 1 | wk | mon | 08:00:00 |  |  |
| [MedicationRequest-MR-Dosage-tod-mixed-doses](./MedicationRequest-MR-Dosage-tod-mixed-doses.html) | täglich: 08:00 Uhr — je 1 Stück; 18:00 Uhr — je 3 Stück | 1 Stück | 1 | 1 | d |  | 08:00:00 |  |  |
|  |  | 3 Stück | 1 | 1 | d |  | 18:00:00 |  |  |
| [MedicationRequest-MR-Dosage-weekday-mixed-doses](./MedicationRequest-MR-Dosage-weekday-mixed-doses.html) | montags — je 1 Stück; dienstags — je 3 Stück | 1 Stück | 1 | 1 | wk | mon |  |  |  |
|  |  | 3 Stück | 1 | 1 | wk | tue |  |  |  |
| [MedicationRequest-Warning-Dosage-Viererschema-Text-01](./MedicationRequest-Warning-Dosage-Viererschema-Text-01.html) | 1-1-1-1 |  |  |  |  |  |  |  |  |
| [MedicationRequest-Warning-Dosage-W-DosageStructuredOrFreeTextWarning-01-of-01](./MedicationRequest-Warning-Dosage-W-DosageStructuredOrFreeTextWarning-01-of-01.html) | 1-0-1-0 |  |  |  |  |  |  |  |  |
| [MedicationRequest-Warning-Dosage-W-DosageWarnungViererschemaInText-01-of-01](./MedicationRequest-Warning-Dosage-W-DosageWarnungViererschemaInText-01-of-01.html) | 1-0-1-0 |  |  |  |  |  |  |  |  |
| [MedicationStatement-MS-Dosage-1010](./MedicationStatement-MS-Dosage-1010.html) | 1-0-1-0 Stück | 1 Stück | 2 | 1 | d |  |  | MORN, EVE |  |
| [MedicationStatement-MS-Dosage-DayOfWeek](./MedicationStatement-MS-Dosage-DayOfWeek.html) | montags — je 2 Stück; freitags — je 1 Stück | 2 Stück | 1 | 1 | wk | mon |  |  |  |
|  |  | 1 Stück | 1 | 1 | wk | fri |  |  |  |
| [MedicationStatement-MS-Dosage-Freetext](./MedicationStatement-MS-Dosage-Freetext.html) | Bei Bedarf bis zu 3 mal täglich 1 Tablette |  |  |  |  |  |  |  |  |
| [MedicationStatement-MS-Dosage-Interval](./MedicationStatement-MS-Dosage-Interval.html) | alle 3 Tage: je 1 Stück | 1 Stück | 1 | 3 | d |  |  |  |  |
| [MedicationStatement-MS-Dosage-TimeOfDay](./MedicationStatement-MS-Dosage-TimeOfDay.html) | täglich: 08:00 Uhr — je 2 Stück; 20:00 Uhr — je 1 Stück | 2 Stück | 1 | 1 | d |  | 08:00:00 |  |  |
|  |  | 1 Stück | 1 | 1 | d |  | 20:00:00 |  |  |