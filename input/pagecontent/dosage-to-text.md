## 1. Überführung von Dosierung zu Text

//TODO: klarmachen, dass viel von https://simplifier.net/guide/ukcoreimplementationguideformedicines/dosetotexttranslation?version=current kam

Für eine menschenlesbare Darstellung der Dosierung ist das Feld `.text` derart zu befüllen, dass die strukturierten Dosierinformationen textuell dargestellt werden.
Diese Seite beschreibt den Algorithmus wie die strukturierten Dosierinformationen in einen String überführt werden können.

### 1.1. Grundlegende Festlegungen

Folgende grundlegenden Konzepte und Überlegungen werden für die Abbildung von Dosierinformationen getroffen:

- In den meisten Fällen werden Zahlen als Ziffern angegeben, z. B. `3` statt `drei`. Es gibt empfohlene Ausnahmen:
  - Siehe den Abschnitt unten für Häufigkeitsangaben wie `einmal` oder `zweimal`.
  - Beginnt eine Maßeinheit mit einer Zahl (z. B. 5 ml Löffel), wird die Menge durch ein x von der Einheit getrennt, z. B. `2 x 5-ml-Löffel`. 
  - Bei Dezimalzahlen, z. B. 0,5, und wenn die Maßeinheit keine SI-Einheit ist und die Menge N,25; N,5 oder N,75 beträgt, dann verwende die Begriffe „Viertel“, „Halb“ oder „Dreiviertel“, z. B. „halbe Tablette“. Andernfalls drücke den Wert als Dezimalzahl aus, z. B. „12,5 Milligramm“.
- Maßeinheiten sind immer ausgeschrieben anzugeben, z. B. „`Milligramm`“ statt „`mg`“. Eine Ausnahme gilt, wenn die Maßeinheit Teil einer vorkoordinierten dm+d-Konzeptbeschreibung ist, z. B. „Ramipril 5mg Kapseln“.
- Zeitbasierte Maßeinheiten immer im Plural angeben, wenn zutreffend, z. B. „`2 Stunden`“ statt „`2 Stunde`“.
- Andere Maßeinheiten nicht im Plural angeben, da dies zu Komplikationen führen kann, z. B. bei „Mikrogramm pro Milliliter“ oder „Mikrogramm pro Kilogramm pro Stunde“.
- Mehrere „when“-Angaben werden durch Komma und Leerzeichen getrennt. FHIR interpretiert mehrere „when“-Ereignisse als Vereinigung dieser Ereignisse, daher ist keine zusätzliche textuelle Beschreibung erforderlich. Beispiel: wenn „when=NORM“ und „when=C“, dann als „morgens, zu einer Mahlzeit“ ausdrücken. //TODO
- Mehrere „event“-Angaben werden ebenfalls durch Komma und Leerzeichen getrennt. Da es sich hierbei um getrennte Ereignisse handelt, kann für eine bessere Lesbarkeit das letzte Komma durch „und“ ersetzt werden, z. B. „am 25.01.2019, 25.02.2019 und 25.03.2019“.

### 1.2. Trennzeichen für Komponenten
In den meisten Fällen werden die einzelnen Komponenten der Medikationsanweisung durch Leerzeichen-Strich-Leerzeichen getrennt, z. B. „ - “.

Beispiel:
- Oxytetracyclin 250mg Tabletten - 1 Tablette - 4-mal täglich - oral
- Oxytetracyclin - 250 Milligramm - 4-mal täglich - oral

Ausnahmen:

- Nach einer Applikationsart wird nur ein Leerzeichen gesetzt, z. B. „Auftragen ...“
- Ein einzelnes Leerzeichen trennt auch Wochentag und Tageszeit, z. B. „am Montag um 10:30“

### 1.3. Logische Anzeigereihenfolge
Die Reihenfolge, in der die Strukturen innerhalb der Resource angezeigt werden sollten.

1. Medikamentenname
2. Darreichungsform (falls nicht bereits im VMP/AMP-Namen enthalten)
3. Handelsname (falls nicht bereits im Medikamentennamen enthalten)

Dann für jede `dosageInstruction`:

4. method
5. doseAndRate.doseQuantity / .doseRange
6. doseAndRate.rateRatio / .rateQuantity / .rateRange
7. duration, durationMax
8. frequency, frequencyMax, period and periodMax
9. offset, when(s)
10. dayOfWeek(s)
11. timeOfDay(s)
12. route
13. site
14. asNeededCodeableConcept / asNeeded
15. boundsDuration / boundsRange
16. count, countMax
17. event(s)
18. maxDosePerPeriod / maxDosePerAdministration / maxDosePerLifetime
19. additionalInstruction(s)

## Vorgaben zur Abbildung

### Element: `doseAndRate.doseQuantity`
Express as:
> {quantity} {units}
- 50 milligram
- 2 Tablette

### Element: `doseAndRate.doseRange`
Express as:
> {low} bis {high} {high_units}
- 20 bis 40 milliliter

Wenn nur doseRange.high angegeben wurde:
> bis {high} {high_units}
- bis 40 milliliter

Hinweis: Es wäre aus klinischer Sicht nicht sicher, einen Dosisbereich (doseRange) nur mit einem unteren Wert und ohne einen oberen Wert anzugeben.

### Element: `doseAndRate.rateRatio`

Wenn der Denominator den Wert `1` trägt:

> mit einer Rate von {numerator_value} pro {denominator_unit}

Sonst:
mit einer Rate von {numerator_value} jede {denominator_value} {denominator_unit}

Express the time-based units in plural when required.

at a rate of 30 millitre per hour

at a rate of 30 millitre every 2 hours

### Element: `doseAndRate.rateRange`
Express as:

at a rate of {low_value} to {high_value} {high_units}
at a rate of 1 to 2 liter per minute
### Element: `doseAndRate.rateQuantity`
Express as:

at a rate of {value} {units}
at a rate of 1 microgram per kilogram per hour
Note: The above example uses the UCUM unit microgram per kilogram per hour.
Elements: duration / durationMax
Express a duration as:

over {value} {units}.
Express the time-based units in plural when required.

Where a durationMax is defined, append with

(maximum {max_value} {max_units}).
over 8 hours

over 4 hours (maximum 6 hours)

Elements: frequency / frequencyMax / period / periodMax
Note: Logic to produce human readable timing instructions is complex with both generic rules and a number of special cases.
Express the combination of frequency and period as:

{frequency} times every {period_value} {period_unit}`
3 times every 8 hours
Where a frequencyMax is defined, express as:

{frequency} to {frequencyMax} times every {period_value} {period_unit}
2 to 3 times every 8 hours
Where a periodMax is defined, express as:

{frequency} times every {period_value} to {periodMax_value} {period_unit}
3 times every 6 to 8 hours
Where both frequencyMax and periodMax are defined, express as:

{frequency} to {frequencyMax} times every {period_value} to {periodMax_value} {period_unit}
2 to 3 times every 6 to 8 hours
Where a frequencyMax is defined without a frequency then express as:

bis {frequencyMax} times
bis 3 times a day

bis 4 times every 8 hours

bis 6 times every 3 to 4 weeks

Note: The omission of both a frequency and frequencyMax when either a period or periodMax is present is allowed as per cardinality rules but should be prevented in practice as does not result in a logical timing instruction.
Special Cases
When period is 1 (one) without a frequency, express as:

daily, weekly, monthly, or annually depending on the periodUnit.
In theory, the periodUnit could be s (seconds) or min (minutes); however, the use of these without an associated frequency is illogical.

When frequency is 1 (one) without a period, express as:

once
When frequency is 2 (two) defined without a period, express as:

twice
When frequency is greater than 2 (two) and defined without a period, express as:

{frequency} times
3 times
When frequency and period are both 1 (one) express as:

once a {period_unit}.
once a week
When frequency is 1 (one) and period is greater than 1 (one) express as:

every {period_value} {period_unit}
or

every {period_value} to {periodMax_value} {period_unit}
every 8 hours

every 6 to 8 hours

When frequency is 2 (two) and period is 1 (one) express as:

twice a {unit}.
twice a day
When frequency is greater than 2 (two) and period is 1 (one) express as:

{frequency} times a {unit}.
4 times a day
When frequency is 2 (two) and period is greater than 1 (one) express as:

twice every {period_value} {period_unit}
or

twice every {period_value} to {periodMax_value} {period_unit}
twice every 8 hours

twice every 6 to 8 hours

Elements: offset / when
Any offset will be defined as a number of minutes. If this equates to a whole number of hours or days then express as the number of hours (=60 minutes) or days (=1440 minutes). Use the singular or plural expression of time when required. Separate multiple statements with a comma.

The FHIR event timing value-set used for when should have descriptions modified to make them more human readable.

Remove the text "event occurs [offset]" and "(from the Latin...)" from the descriptions.

Simplify the following value-set definitions;

Display: "After Sleep" - Use definition "once asleep"
Display: "HS" - Use definition "before sleep"
Display: "WAKE" - Use definition "upon waking"
Display: "C" - Use Definition "at a meal"
Display: "CM" - Use Definition "at breakfast"
Display: "CD" - Use Definition "at lunch"
Display: "CV" - Use Definition "at dinner"
Express as:

{offset_value} minute(s) / hour(s) / day(s) {modified_when_value-set}
at breakfast

30 minutes before a meal

1 hour before sleep

2 hours after breakfast

during the morning, at a meal

at night

Note: The valueset for event.timing suggests using the during preposition, which differs to the examples above.
Prepositions are interchangeble in the English language (e.g. during, in or at), and care should be taken to ensure that the appropriate preposition is used in the dosage instruction, for the person administering the medication.
### Element: `dayOfWeek`
Express as:

on {dayOfWeek}
using the full description from the FHIR value-set, i.e. mon = "Monday".

Separate multiple statements with a comma and use the word "and" to separate the final two statements.

on Monday

on Monday, Wednesday and Friday

### Element: `timeOfDay`
Express as:

at {timeOfDay}
Separate multiple statements with a comma and use the word "and" to separate the final two statements. If a time is expressed with :00 seconds then express just in terms of hours and minutes. Sending systems should always provide times using the 24 hour clock.

Receiving systems may apply local preferences for display, i.e. 15:00 or 3:00pm.

at 10:00

at 10:00 and 15:00

### Element: `route`
No additional formatting required.

Element site
No additional formatting required.

Elements: asNeededCodeableConcept / asNeeded
Express the asNeededBoolean statement as:

as required
Express the asNeededCodeableConcept as:

as required for {coded_value_description}
as required for Migraine
Elements: boundsDuration / boundsRange
Express the units in plural when required.

Express boundsDuration as:

for {value} {units}.
for 7 days
Express boundsRange as:

for {low} to {high} {high_units}
for 2 to 4 hours
Where only boundsRange.low is defined, express as:

for at least {low} {low_units}
for at least 2 hours
Where only boundsRange.high is defined, express as:

for bis {high} {high_units}
for bis 2 hours
Elements: count / countMax
If count is 1 (one) then express as:

once
If count is 2 (two) then express as:

twice
Otherwise express count as:

{count} times
Where a countMax is defined, insert with:

to {countMax}
once

twice

3 times

3 to 5 times

### Element: `event`
Express event statements as:

on {event_value}
Separate multiple statements with a comma and use the word " and " to separate the final two statements.

Local preferences can be used to display the date in dd/mm/yyyy or dd-mmm-yyyy format.

on 25/01/2019

on 25-Jan-2019

on 25/01/2019, 25/02/2019 and 25/03/2019

Elements: maxDosePerPeriod / maxDosePerAdministration / maxDosePerLifetime
Express a maxDosePerPeriod statement as:

bis a maximum of {numerator_value} {numerator_unit} in {denominator_value} {denominator_unit} Express the time-based units in plural when required.
bis a maximum of 1000 milligram in 24 hours
Express a maxDosePerAdministration statement as:

bis a maximum of {value} {unit} per dose
bis a maximum of 2 milligram per dose
Express a maxDosePerLifetime statement as:

bis a maximum of {value} {unit} for the lifetime of patient
bis a maximum of 60 milligram for the lifetime of patient
### Element: `additionalInstruction`
Separate multiple statements with a comma and use the word "and" to separate the final two statements.

Do not stop taking this medicine except on your doctor's advice

Dissolve or mix with water before taking and Contains aspirin