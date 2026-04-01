### Release: 1.0.4

**What's Changed**

- **Gefixte Invarianten:**
  - **DosageDE**: `DosageStructuredOrFreeTextWarning`, `DosageStructuredRequiresBoth`, `DosageDoseUnitSameCode`
  - **DosageDgMP**: `DosageStructuredOrFreeText`
  - **TimingDgMP**: `TimingOnlyOneType`, `TimingOnlyOneBounds`, `TimingOnlyOneTimeForInterval`, `TimingOnlyOnePeriodForDayOfWeek`
- **Neue Invarianten:**
  - **TimingDgMP**: `TimingNoRedundantDosageForDay`
- fix: Korrektur der FHIRPath-Ausdrücke in `DosageStructuredOrFreeTextWarning` und `DosageStructuredRequiresBoth` (`DosageDE`) — fehlende `%resource.`-Präfixe vor `ofType(MedicationDispense)` und `ofType(MedicationStatement)` ergänzt.
- fix: Korrektur der FHIRPath-Ausdrücke in `DosageDoseUnitSameCode` (`DosageDE`) — fehlende `%resource.`-Präfixe im äußeren Ausdruck ergänzt; fehlerhafte innere Pfadangaben (`%resource.dosageInstruction.*`) durch ressourcentypspezifische Ausdrücke (`%resource.ofType(MedicationRequest).dosageInstruction | ...`) ersetzt
- fix: Korrektur des FHIRPath-Ausdrucks in `DosageStructuredOrFreeText` (`DosageDgMP`) — analog zu `DosageStructuredOrFreeTextWarning`
- fix: Korrektur der FHIRPath-Ausdrücke in `TimingOnlyOneType` (`TimingDgMP`) — fehlende `%resource.`-Präfixe in allen vier Unterbedingungen (`DayOfWeek`, `Interval`, `DayOfWeek and Time/4-Schema`, `Interval and Time/4-Schema`) ergänzt
- fix: Ergänzung der Konsistenzprüfung in `TimingOnlyOneBounds` (`TimingDgMP`) — zusätzliche Bedingung, dass die Anzahl der `boundsDuration`-Einträge der Anzahl der Dosage-Instanzen entsprechen muss
- fix: Korrektur und Aktualisierung von `TimingOnlyOneTimeForInterval` (`TimingDgMP`) — Description präzisiert; redundante `MedicationRequest`/`MedicationDispense`-Bedingung entfernt.
- fix: Korrektur des FHIRPath-Ausdrucks in `TimingOnlyOnePeriodForDayOfWeek` (`TimingDgMP`) — es wurden fehlerhafte Vergleiche korrigiert, bei denen `.distinct()` (liefert Collection) direkt mit `.count()` (liefert Integer) verglichen wurde; korrekte Formulierung: `.distinct().count() = ...count()` statt `.distinct() = ...count()`
- feature: Neue Invariante `TimingNoRedundantDosageForDay` (`TimingDgMP`) — verhindert redundante dosageInstruction-Einträge beim DayOfWeek-Schema: wenn derselbe Wochentag in mehreren Dosierungen vorkommt, muss die Dosis (`doseQuantity.value`) unterschiedlich sein; andernfalls sollten die Zeitangaben in einer einzigen dosageInstruction zusammengefasst werden (z.B. Dienstag mit 1 Stück morgens und abends → eine Dosierung mit `frequency=2`)
- test: Erhöhung der Testabdeckung durch valide und invalide Beispiele für alle relevanten Medication*-Ressourcentypen (`MedicationRequest`, `MedicationDispense`, `MedicationStatement`)

---

### Release: 1.0.3

**What's Changed**

- Fix dosage dose unit same code by @patrick-werner in [#106](https://github.com/hl7germany/medication-ig-de-r4/pull/106) to also support dosageRanges
- Added guidance on backport extension usage and for defect tim-9 invariant

---

### Release: 1.0.2

**What's Changed**

- Fix: Update constraints and examples for DosageStructuredRequiresGeneratedText, maintain versioning in configuration

---

### Release: 1.0.1

**What's Changed**

- Fix dosage structured requires generated text constraint by @patrick-werner in [#104](https://github.com/hl7germany/medication-ig-de-r4/pull/104)
- Updates from Publication Feedback by @patrick-werner in [#105](https://github.com/hl7germany/medication-ig-de-r4/pull/105)

---

### Release: 1.0.0

**What's Changed**

- Add ISiK as an example case in the Implementation Guide by @f-peverali in [#39](https://github.com/hl7germany/medication-ig-de-r4/pull/39)
- Update schema-freitext.md by @f-peverali in [#70](https://github.com/hl7germany/medication-ig-de-r4/pull/70)
- fix: correct punctuation in dosage text generation documentation by @patrick-werner in [#79](https://github.com/hl7germany/medication-ig-de-r4/pull/79)
- refactor: update dosage terminology from 'Tablette' to 'Stück' in examples and descriptions by @patrick-werner in [#72](https://github.com/hl7germany/medication-ig-de-r4/pull/72)
- fix: update link in dosage text generation documentation by @patrick-werner in [#73](https://github.com/hl7germany/medication-ig-de-r4/pull/73)
- Fix der Timing Tabelle, Verbesserung des python scripts, HDB-650 by @patrick-werner in [#74](https://github.com/hl7germany/medication-ig-de-r4/pull/74)
- feat: add invariant for structured dosage instructions requiring generated text by @patrick-werner in [#75](https://github.com/hl7germany/medication-ig-de-r4/pull/75)
- fix: correct description of dosage timing bounds in TimingDgMP.fsh by @patrick-werner in [#76](https://github.com/hl7germany/medication-ig-de-r4/pull/76)
- feat: made value in duration in TimingDgMP mandatory (1..1), added MS in TimingDE.fsh by @patrick-werner in [#77](https://github.com/hl7germany/medication-ig-de-r4/pull/77)
- refactor: rename GematikDosageTextGenerator to DgMPDosageTextGenerator by @patrick-werner in [#78](https://github.com/hl7germany/medication-ig-de-r4/pull/78)
- Add note to usage of dosage text script by @florianschoffke in [#80](https://github.com/hl7germany/medication-ig-de-r4/pull/80)
- refactor: fix python indentation by @patrick-werner in [#81](https://github.com/hl7germany/medication-ig-de-r4/pull/81)
- feat: set comparator on boundsDuration to 0..0 in TimingDgMP by @patrick-werner in [#82](https://github.com/hl7germany/medication-ig-de-r4/pull/82)
- Add all 0..0 fields to deny lists in text generation script HDB-656 by @patrick-werner in [#83](https://github.com/hl7germany/medication-ig-de-r4/pull/83)
- feat: add invariant for timing bounds unit string consistency with UCUM codes by @patrick-werner in [#84](https://github.com/hl7germany/medication-ig-de-r4/pull/84)
- feat: fix TimingBoundsUnitMatchesCode invariant and add examples by @patrick-werner in [#85](https://github.com/hl7germany/medication-ig-de-r4/pull/85)
- Add Examples for DosageStructuredRequiresGeneratedText by @florianschoffke in [#86](https://github.com/hl7germany/medication-ig-de-r4/pull/86)
- fix: update dosage unit from 'Tablette' to 'Stück' for consistency across documentation by @patrick-werner in [#87](https://github.com/hl7germany/medication-ig-de-r4/pull/87)
- fix: clarify mustSupport requirements for implementation and processing of elements by @patrick-werner in [#88](https://github.com/hl7germany/medication-ig-de-r4/pull/88)
- refactor script by @florianschoffke in [#89](https://github.com/hl7germany/medication-ig-de-r4/pull/89)
- Only one dosage by @patrick-werner in [#90](https://github.com/hl7germany/medication-ig-de-r4/pull/90)
- Ig-page-for-script by @florianschoffke in [#92](https://github.com/hl7germany/medication-ig-de-r4/pull/92)
- Skript für eine zusammenfassende Evaluierung der Dosierung by @florianschoffke in [#93](https://github.com/hl7germany/medication-ig-de-r4/pull/93)
- added DosageWarnungViererschemaInText & example by @patrick-werner in [#91](https://github.com/hl7germany/medication-ig-de-r4/pull/91)
- feat: add FreeTextSingleDosageOnly invariant to enforce single dosage element in free text by @patrick-werner in [#95](https://github.com/hl7germany/medication-ig-de-r4/pull/95)
- Update ext card and script by @patrick-werner in [#94](https://github.com/hl7germany/medication-ig-de-r4/pull/94)
- Extract-script by @florianschoffke in [#96](https://github.com/hl7germany/medication-ig-de-r4/pull/96)
- Set extension cardinality and add language support by @florianschoffke in [#99](https://github.com/hl7germany/medication-ig-de-r4/pull/99)
- fix: update duration unit retrieval in medication dosage text generation by @patrick-werner in [#103](https://github.com/hl7germany/medication-ig-de-r4/pull/103)
- docs: clarify prerequisites for text generation in dosage script by @patrick-werner in [#102](https://github.com/hl7germany/medication-ig-de-r4/pull/102)
- 1.0.0 release by @patrick-werner in [#98](https://github.com/hl7germany/medication-ig-de-r4/pull/98)

---

### Release: 1.0.0-ballot

Release for the first ballot: 1.0.0-ballot
