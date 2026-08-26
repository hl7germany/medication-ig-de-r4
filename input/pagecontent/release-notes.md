### Release: 2.0.0-ballot

Diese Version erweitert das dgMP-Dosiermodell erheblich: Dosierungen, die bisher
als „nicht unterstützt" geführt waren, sind jetzt strukturiert abbildbar. Der
Eintrag fasst alle Änderungen seit 1.0.5 zusammen.

**Version des Textgenerierungs-Algorithmus:** `2.0.0`. Der Algorithmus wird in
[hl7germany/dgMP-DosageTextgenerierung-Skript](https://github.com/hl7germany/dgMP-DosageTextgenerierung-Skript)
gepflegt; seine Änderungen stehen im dortigen `CHANGELOG.md`.

**Neu unterstützte Dosierangaben**

- **Variable Einzeldosis** über `doseRange` — „1 bis 2 Stück" statt eines festen Werts. Untergrenze `0` ist zulässig, Obergrenze ist Pflicht. Siehe [Variable Angaben](./schema-variable-angaben.html).
- **Variable Frequenz und Periode** über `frequencyMax` und `periodMax` — „1 bis 2 x täglich", „alle 2 bis 3 Tage". Beide Achsen gleichzeitig zu variieren ist unzulässig.
- **Bedarfsmedikation** über `asNeededBoolean`, mit **Anlass** (`asNeededFor`), **Mindestabstand zwischen zwei Gaben** und **Maximalmenge** (`maxDosePerPeriod`). Der Mindestabstand ist dabei der reinen Bedarfsdosierung vorbehalten. Siehe [Schema für Bedarfsmedikation](./schema-bedarfsmedikation.html).
- **Anwendungszeitraum** über `boundsPeriod` — Start- und/oder Enddatum, optional mit Uhrzeit und Zeitzone. Siehe [Angabe von Start- und Enddatum](./schema-start-end-datum.html).
- **Zusätzliche Instruktionen** über `patientInstruction` für Hinweise, die sich nicht strukturiert abbilden lassen. Siehe [Zusätzliche Instruktionen](./schema-zusaetzliche-instruktionen.html).
- **Kombination aus Zeitintervall und Tageszeiten- beziehungsweise Uhrzeiten-Bezug** — nicht tägliche Perioden (`d`, `wk`, `mo`) zusammen mit `when` oder `timeOfDay`. Siehe [Schema für Kombinationen von Zeitintervallen](./schema-intervall-kombination.html).
- **Rückwärtskompatibilität für redundante Legacy-Angaben:** Bei Wochentagsschemata bleiben `frequency` sowie das Paar `period = 1`, `periodUnit = wk` zulässig. Sie begründen kein Intervallschema und verändern den erzeugten Text nicht.

Damit entfallen 20 Beispiele aus der Liste nicht unterstützter Dosierkonfigurationen:
`asNeededBoolean`, `asNeededCodeableConcept`, `doseRange`, `maxDosePerPeriod` und `boundsPeriod`.

**Neue Artefakte**

- Extensions: `MinimumIntervalBetweenAdministrations`, Backport von `asNeededFor` aus R5
- ValueSet: `MindestabstandUnitsOfTimeDgMP`
- Seiten: Bedarfsmedikation, Variable Angaben, Start- und Enddatum, Zusätzliche Instruktionen

**Rückmeldungen aus dem Kommentierungsverfahren**

- **Mindestabstand nur bei reiner Bedarfsmedikation** (DAV). Beanstandet wurde der Text „alle 8 Stunden je 1 Stück, mit mindestens 6 Stunden Abstand" als widersprüchlich. Ein Rhythmus legt den Abstand zwischen zwei Gaben bereits fest; eine zweite, schwächere Untergrenze daneben lässt offen, welche Angabe gilt. Die neue Invariante `MindestabstandOnlyPureAsNeeded` lässt `modifierExtension[MinimumIntervalBetweenAdministrations]` nur noch zusammen mit `asNeededBoolean = true` und ohne `timing` zu. `VarPeriodNoMindestabstand` geht darin auf und entfällt.
- **Extension umbenannt** (KBV). Die modifierExtension trug als einzige eine deutsche Bezeichnung. Ihre kanonische URL lautet jetzt `…/StructureDefinition/MinimumIntervalBetweenAdministrations` statt `…/MindestabstandZwischenGaben`.
- **„Einnahmeanlass" durch „Anlass" ersetzt** (KBV). Der Begriff unterstellte eine orale Anwendung und passte nicht, wenn das Arzneimittel etwa auf die Haut aufgetragen wird.
- **Extensions in „Relevante Ressourcen" ergänzt** (KBV). Die Übersicht listete nur `GeneratedDosageInstructionsMeta`.
- **Mehrere Anlässe** (KBV): Es wurde nur der letzte ausgegeben. Der Fehler ist behoben, alle Anlässe erscheinen als Aufzählung. Die Verknüpfung bleibt „oder", entsprechend der ODER-Semantik von `asNeededFor`.

**Invarianten**

33 Invarianten sind neu hinzugekommen; sie sichern die oben genannten Angaben ab.
Vollständig aufgeführt sind sie unter [Übersicht der Timing- & Dosierungs-Invarianten](./dosierung-constraints.html).
Die folgenden bestehenden Regeln haben sich in ihrer Aussage geändert:

- **`TimingOnlyOneType` (`TimingDgMP`)**
  - Bei `dayOfWeek` sind `frequency` sowie das Paar `period = 1`, `periodUnit = wk` als redundante Legacy-Angaben zulässig; zuvor führten sie zu einem Fehler. Jede andere Periode ist mit `dayOfWeek` nicht kombinierbar.
  - Die Kombination aus Zeitintervall und Tageszeiten- beziehungsweise Uhrzeiten-Bezug ist als eigenes Schema erfasst.
  - Eine variable Frequenz (`frequencyMax`) bleibt der reinen Intervallangabe vorbehalten; konkrete Zeitpunkte und Wochentage legen die Zahl der Gaben bereits fest.

- **`TimingPeriodUnit` (`TimingDgMP`)**
  - `periodUnit` darf nur zusammen mit `period` angegeben werden. Bei `dayOfWeek` ist ausschließlich die redundante Wochenangabe zulässig; bei `when` oder `timeOfDay` ohne `dayOfWeek` sind Tage, Wochen oder Monate zulässig. Zuvor war dort ausschließlich `d` erlaubt, wodurch wöchentliche und monatliche Kombinationen nicht abbildbar waren.

- **`TimingSingleDosageForTimeOfDay` und `TimingSingleDosageForWhen` (`TimingDgMP`), `TimingSingleDosageForTimeOfDayWarning` und `TimingSingleDosageForWhenWarning` (`TimingDE`)**
  - Geprüft wird jetzt, ob jedes `Dosage`-Element eine eindeutige vollständige Dosis einschließlich Datentyp trägt. Zuvor genügte es, dass überhaupt zwei unterschiedliche Werte vorkamen — Ressourcen mit den Dosen 1, 1 und 2 wurden dadurch fälschlich akzeptiert.

- **`TimingVarFreqOrPeriod` (`TimingDgMP`)**
  - Die Warnung greift nur noch, wenn `frequencyMax` und `periodMax` gemeinsam belegt sind. Zuvor beanstandete sie auch eindeutige Angaben wie „2 x alle 8 Stunden".

- **`TimingFrequencyCount` (`TimingDgMP`)**
  - Beschreibung präzisiert, Ausdruck unverändert: `frequency` ist bei `when`, `timeOfDay` und `dayOfWeek` optional, muss bei Angabe aber der Anzahl der konkreten Anwendungen entsprechen.

- **`TimingOnlyOnePeriodForDayOfWeek` (`TimingDgMP`)**
  - Von `Timing.repeat` auf `Timing` verschoben, um einen Überlauf im IG Publisher bei der Erzeugung der Excel-Tabellen zu umgehen. Der Ausdruck wertet ohnehin die gesamte Ressource aus; inhaltlich ändert sich nichts.

- **`MindestabstandIdentical` (`DosageDgMP`) — entfallen**
  - Die Invariante forderte, dass der Mindestabstand über alle `Dosage`-Elemente gleich belegt ist. Sie ist nicht mehr erreichbar: Ein Mindestabstand setzt eine reine Bedarfsdosierung voraus, und dafür erlaubt `AsNeededSingleDosageOnly` genau ein `Dosage`-Element. `MaxDosePerPeriodIdentical` bleibt bestehen — eine Maximalmenge setzt kein leeres `timing` voraus.

**Entfallene Beispiele**

Gegenüber 1.0.5 entfallen 68 Beispiel-Instanzen; deren Seiten-URLs sind danach nicht mehr erreichbar. Neben den 20 Beispielen für nun unterstützte Angaben betrifft das vor allem neu gefasste Negativbeispiele zu `TimingFrequencyCount`, `TimingPeriodUnit` und `TimingOnlyOneType`: an die Stelle der durchnummerierten Reihen treten wenige Beispiele, die je einen Auslöser des Constraints isolieren. Profile, Extensions und ValueSets behalten ihre kanonischen URLs.

**Sonstiges**

- Die Spezifikation der Dosis-Textgenerierung liegt nicht mehr im IG. Die Seite [Dosis Textgenerierung](./dosierung-textgenerierung.html) verweist auf das externe Repository; der Build bezieht den Algorithmus als über Tag und Prüfsumme gepinnte Version.
- Die Seiten der Dosierschemata beschreiben jetzt durchgängig, welche `frequency`-, `period`- und `periodUnit`-Angaben optional zulässig sind und dass sie den erzeugten Text nicht verändern.

### Release: 1.0.5

**What's Changed**

- **Fix für Timing-Schema-Mischungen mit `dayOfWeek`:**
  - **TimingDgMP**: `TimingOnlyWhenOrTimeOfDay`
- **Erweiterte Negativbeispiele zur Absicherung gegen Schema-Mischung**

**Details**

- **`TimingOnlyWhenOrTimeOfDay` (`TimingDgMP`)**
  - Vom Fix betroffene Ressourcentypen: `MedicationRequest`, `MedicationDispense`, `MedicationStatement`
  - Fix: Die Einschränkung `dayOfWeek.empty()` wurde aus der Schema-Erkennung entfernt. Dadurch wird jetzt auch der Fall korrekt invalidiert, in dem innerhalb einer Ressource `dayOfWeek + timeOfDay` und `dayOfWeek + when` gemischt werden.

- **Testabdeckung für Mischformen von Dosierschemata**
  - Für `TimingOnlyWhenOrTimeOfDay` wurden Negativbeispiele für alle drei Ressourcentypen um Fälle mit gesetztem `dayOfWeek` ergänzt.
  - Für `TimingOnlyOneType` wurden zusätzliche Negativbeispiele ergänzt, um Mischungen zusammengesetzter Schemata explizit abzudecken:
    - reines `dayOfWeek` gemischt mit `dayOfWeek + when`
    - reines `dayOfWeek` gemischt mit `dayOfWeek + timeOfDay`
    - reines `Interval` gemischt mit `Interval + when`
    - reines `Interval` gemischt mit `Interval + timeOfDay`
    - `dayOfWeek + when` gemischt mit reinem `Interval`
    - `dayOfWeek + timeOfDay` gemischt mit reinem `Interval`
    - `dayOfWeek + when` gemischt mit `Interval + when`
    - `dayOfWeek + timeOfDay` gemischt mit `Interval + timeOfDay`

---

### Release: 1.0.4

**What's Changed**

- **Gefixte Invarianten:**
  - **DosageDE**: `DosageStructuredOrFreeTextWarning`, `DosageStructuredRequiresBoth`, `DosageDoseUnitSameCode`
  - **DosageDgMP**: `DosageStructuredOrFreeText`
  - **TimingDgMP**: `TimingOnlyOneType`, `TimingOnlyOneTimeForInterval`, `TimingOnlyOnePeriodForDayOfWeek`

**Details je Invariante**

- **`DosageStructuredOrFreeTextWarning` (`DosageDE`)**
  - Vom Fix betroffene Ressourcentypen: `MedicationDispense`, `MedicationStatement`
  - Fix: Fehlende `%resource.`-Präfixe vor `ofType(...)` ergänzt, damit die Regel in allen drei Ressourcentypzweigen korrekt evaluiert wird.

- **`DosageStructuredRequiresBoth` (`DosageDE`)**
  - Vom Fix betroffene Ressourcentypen: `MedicationDispense`, `MedicationStatement`
  - Fix: Fehlende `%resource.`-Präfixe vor `ofType(...)` ergänzt, damit die wechselseitige Pflicht von `timing` und `doseAndRate` korrekt geprüft wird.

- **`DosageDoseUnitSameCode` (`DosageDE`)**
  - Vom Fix betroffene Ressourcentypen: `MedicationDispense`, `MedicationStatement`
  - Fix: Ressourcentypspezifische Pfade im Ausdruck korrigiert; dadurch wird die Einheitengleichheit über alle Dosierungen je Ressource korrekt für `Quantity` und `Range` geprüft.

- **`DosageStructuredOrFreeText` (`DosageDgMP`)**
  - Vom Fix betroffene Ressourcentypen: `MedicationDispense`, `MedicationStatement`
  - Fix: Analog zu `DosageStructuredOrFreeTextWarning` wurden fehlende `%resource.`-Präfixe ergänzt, damit Mischformen aus Freitext und Struktur verlässlich erkannt werden.

- **`TimingOnlyOneType` (`TimingDgMP`)**
  - Vom Fix betroffene Ressourcentypen: `MedicationDispense`, `MedicationStatement`
  - Fix: Fehlende `%resource.`-Präfixe in den Unterbedingungen ergänzt; dadurch greifen die Typprüfungen (`DayOfWeek`, `Interval`, Kombinationsschemata) konsistent pro Ressource.

- **`TimingOnlyOneTimeForInterval` (`TimingDgMP`)**
  - Vom Fix betroffene Ressourcentypen: `MedicationStatement`
  - Fix: In der `MedicationStatement`-Prüfung wurde eine logisch redundante und inhaltlich falsche Typbedingung entfernt; dadurch wird die Konsistenz von `period`/`periodUnit` auch für `MedicationStatement` tatsächlich geprüft (zusätzlich zur Einzigartigkeitsprüfung von `timeOfDay`/`when`).

- **`TimingOnlyOnePeriodForDayOfWeek` (`TimingDgMP`)**
  - Vom Fix betroffene Ressourcentypen: `MedicationRequest`, `MedicationDispense`, `MedicationStatement`
  - Fix: Falsche Collection-vs-Integer-Vergleiche korrigiert (`distinct().count()` statt `distinct()`), damit doppelte `(dayOfWeek + when/timeOfDay)`-Kombinationen korrekt validiert werden.

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
