### Release: 2.0.0

**Version des Textgenerierungs-Algorithmus:** `2.0.0`

**What's Changed**

- **Spezifikation der Dosis-Textgenerierung ausgelagert:** Algorithmenbeschreibung, Referenzimplementierung und Versionsverlauf liegen jetzt in [hl7germany/dgMP-DosageTextgenerierung-Skript](https://github.com/hl7germany/dgMP-DosageTextgenerierung-Skript). Die Seite [Dosis Textgenerierung](./dosierung-textgenerierung.html) verweist nur noch dorthin.
- **Neue Invarianten:**
  - **DosageDgMP**: `DosageDoseValuePositive`
  - **DosageDE**: `DosageDoseValuePositiveWarning`
- **Geänderte Invarianten:**
  - **TimingDgMP**: `TimingOnlyOneType`, `TimingPeriodUnit`, `TimingFrequencyCount`, `TimingVarFreqOrPeriod`, `TimingSingleDosageForTimeOfDay`, `TimingSingleDosageForWhen`, `TimingOnlyOnePeriodForDayOfWeek`
  - **TimingDE**: `TimingSingleDosageForTimeOfDayWarning`, `TimingSingleDosageForWhenWarning`
- **Rückwärtskompatibilität für redundante Legacy-Angaben** bei Wochentags- und Zeitpunktschemata
- **Nicht tägliche Perioden im [Schema für Kombinationen von Zeitintervallen](./schema-intervall-kombination.html)**
- **Geändertes Ausgabeverhalten der Textgenerierung:** jeder erzeugte Text ist durchgehend kleingeschrieben; nicht numerische Dosiswerte werden abgewiesen
- **Erweiterte Beispielabdeckung** für Legacy-Angaben, Kombinationsschemata, Bedarfsdosierungen und `doseRange`-Varianten
- **Entfallene und umbenannte Beispiele:** 31 Instanzen, dadurch entfallen deren Seiten-URLs
- **Überarbeitete Seiten der Dosierschemata** zu Wochentagen, Tageszeiten, Uhrzeiten und Kombinationen
- **Der Textgenerierungs-Algorithmus wird als gepinnte Version aus dem externen Repository bezogen**

**Details**

- **Textgenerierung: durchgehende Kleinschreibung**
  - Betroffen: alle generierten Dosierungstexte außer Freitext
  - Änderung: Die Groß-/Kleinschreibung war zuvor an vier Stellen verteilt. `boundsPeriod` erzeugte `Ab dem`, `Vom` und `Bis zum` großgeschrieben, während `boundsDuration` im selben Baustein `für 7 Tage` klein schreibt, und ein Abschlussschritt schrieb bei Bedarfsmedikation das erste Zeichen groß. Jetzt gibt es keine Ausnahme mehr: der erzeugte Text ist ein Fragment, die Schreibweise am Satzanfang entscheidet das anzeigende System. Ein als Freitext angegebener `Dosage.text` wird weiterhin unverändert durchgereicht.
  - Auswirkung: 51 der bisher veröffentlichten Beispieltexte ändern sich, insbesondere die Bedarfsdosierungen (`Bei Bedarf: …` wird zu `bei Bedarf: …`). Systeme, die den Text unverändert anzeigen, sollten die Großschreibung am Satzanfang selbst setzen.

- **Textgenerierung: nicht numerische Dosiswerte**
  - Betroffen: `doseQuantity.value`, `doseRange.low.value`, `doseRange.high.value`
  - Änderung: Zahlen und numerische Strings werden geprüft, alles andere wird mit `<Feld> muss numerisch sein.` abgewiesen. Zuvor konnte ein nicht numerischer Wert unverändert in den Dosierungstext gelangen.

- **`DosageDoseValuePositive` (`DosageDgMP`) — neu**
  - Betroffene Ressourcentypen: `MedicationRequest`, `MedicationDispense`, `MedicationStatement`
  - Regel: `doseQuantity.value` und `doseRange.high.value` müssen größer als `0` sein. Ausschließlich für `doseRange.low.value` ist zusätzlich der Wert `0` zulässig.
  - Begründung: Eine negative Dosis beschreibt keine verabreichbare Arzneimittelmenge. Dasselbe gilt für `0` als Einzeldosis oder als Obergrenze — daraus entstünde eine Anweisung, nach der nichts anzuwenden ist. Benötigt wird `0` nur als Untergrenze einer variablen Dosis („0 bis 2 Tabletten“).

- **`DosageDoseValuePositiveWarning` (`DosageDE`) — neu**
  - Betroffene Ressourcentypen: `MedicationRequest`, `MedicationDispense`, `MedicationStatement`
  - Regel: Identisch zu `DosageDoseValuePositive`, im generischen DE-Profil jedoch als Warnung.

- **`TimingOnlyOneType` (`TimingDgMP`)**
  - Betroffene Ressourcentypen: `MedicationRequest`, `MedicationDispense`, `MedicationStatement`
  - Änderung 1: Bei `dayOfWeek` sind `frequency` sowie das Paar `period = 1` und `periodUnit = wk` als redundante Legacy-Angaben zulässig. Sie begründen kein Intervallschema und werden im generierten Text nicht ausgegeben. Zuvor führten sie zu einem Fehler.
  - Änderung 2: Die [Kombination aus Zeitintervall und Tageszeiten- beziehungsweise Uhrzeiten-Bezug](./schema-intervall-kombination.html) ist als eigenes Schema erfasst. Eine nicht tägliche Periode (`d`, `wk` oder `mo`) zusammen mit `when` oder `timeOfDay` ist damit ausdrücklich zulässig; die Abgrenzung zum täglichen Schema erfolgt über `period`, `periodUnit` und `periodMax`.
  - Änderung 3: Eine variable Frequenz (`frequencyMax`) bleibt der reinen Intervallangabe vorbehalten. Konkrete Zeitpunkte in `when` oder `timeOfDay` sowie Wochentage in `dayOfWeek` legen die Zahl der Gaben bereits abschließend fest; ein zusätzliches `frequencyMax` widerspräche dieser Aufzählung und entfiele in der Textgenerierung ersatzlos.

- **`TimingPeriodUnit` (`TimingDgMP`)**
  - Betroffene Ressourcentypen: `MedicationRequest`, `MedicationDispense`, `MedicationStatement`
  - Änderung: `periodUnit` darf nur zusammen mit `period` angegeben werden. Bei `dayOfWeek` ist ausschließlich die redundante Wochenangabe zulässig, bei `when` oder `timeOfDay` ohne `dayOfWeek` sind Tage, Wochen oder Monate zulässig. Reine Intervalle verwenden weiterhin die vollständige gebundene Wertemenge. Zuvor war bei `when` oder `timeOfDay` ohne `dayOfWeek` ausschließlich `d` erlaubt, wodurch wöchentliche und monatliche Kombinationen mit Zeitintervall nicht abbildbar waren; außerdem konnte `periodUnit` ohne `period` stehen.

- **`TimingFrequencyCount` (`TimingDgMP`)**
  - Betroffene Ressourcentypen: `MedicationRequest`, `MedicationDispense`, `MedicationStatement`
  - Änderung: Nur die Beschreibung wurde präzisiert; der Ausdruck ist unverändert. `frequency` ist bei `when`, `timeOfDay` und `dayOfWeek` optional, muss bei Angabe aber der Anzahl der konkreten Anwendungen entsprechen — bei einer Kombination aus Wochentagen und Zeitpunkten dem Produkt beider Anzahlen.

- **`TimingVarFreqOrPeriod` (`TimingDgMP`)**
  - Betroffene Ressourcentypen: `MedicationRequest`, `MedicationDispense`, `MedicationStatement`
  - Fix: Die Warnung greift nur noch, wenn `frequencyMax` und `periodMax` gemeinsam belegt sind. Zuvor verlangte der Ausdruck bei `frequency > 1` zwingend `period = 1` und beanstandete damit auch eindeutige Angaben wie „2 x alle 8 Stunden“. Der Ausdruck entspricht jetzt der bereits unter [Variable Angaben](./schema-variable-angaben.html) dokumentierten Regel.

- **`TimingSingleDosageForTimeOfDay` und `TimingSingleDosageForWhen` (`TimingDgMP`)**
  - Betroffene Ressourcentypen: `MedicationRequest`, `MedicationDispense`, `MedicationStatement`
  - Fix: Statt zu prüfen, ob es überhaupt mehr als einen Dosiswert gibt, wird jetzt verglichen, ob die Anzahl unterschiedlicher Dosen der Anzahl der Dosage-Elemente entspricht. Zuvor wurden Ressourcen mit den Dosen 1, 1 und 2 fälschlich akzeptiert, weil bereits zwei unterschiedliche Werte vorlagen. Zusätzlich wird die vollständige Dosis einschließlich ihres Datentyps verglichen, nicht mehr nur der numerische Wert einer `Quantity`.

- **`TimingSingleDosageForTimeOfDayWarning` und `TimingSingleDosageForWhenWarning` (`TimingDE`)**
  - Betroffene Ressourcentypen: `MedicationRequest`, `MedicationDispense`, `MedicationStatement`
  - Fix: Analog zu den dgMP-Invarianten, im generischen DE-Profil als Warnung.

- **`TimingOnlyOnePeriodForDayOfWeek` (`TimingDgMP`)**
  - Betroffene Ressourcentypen: `MedicationRequest`, `MedicationDispense`, `MedicationStatement`
  - Änderung: Die Invariante ist von `Timing.repeat` auf das `Timing`-Element verschoben, um einen Überlauf im IG Publisher bei der Erzeugung der Excel-Tabellen zu umgehen. Der Ausdruck wertet ohnehin über `%resource` die gesamte Ressource aus; inhaltlich ändert sich nichts.

- **Entfallene und umbenannte Beispiele**
  - `Example-MR-Dosage-comb-interval-5` ist entfallen. Das Beispiel zeigte dasselbe Schema wie `Example-MR-Dosage-comb-interval-4`, einmal mit und einmal ohne redundante `frequency`; die Aussage steht jetzt im Fließtext von [Schema für Kombinationen von Zeitintervallen](./schema-intervall-kombination.html).
  - Die Negativbeispiele zu `TimingFrequencyCount` und `TimingPeriodUnit` sind neu gefasst. An die Stelle der durchnummerierten Reihen `…-01-of-05` bis `…-05-of-05` treten wenige Beispiele, die je einen Auslöser des Constraints isolieren — bei `TimingFrequencyCount` etwa je einen für `when`, `timeOfDay` und `dayOfWeek`. Damit entfallen 30 bisherige Instanz-URLs.
  - Die Negativbeispiele zu `TimingOnlyOneType` für eine variable Frequenz heißen jetzt `INV-VarFreq-C-TimingOnlyOneType-*`.
  - Alle betroffenen Instanzen sind Beispiele; Profile, Extensions und ValueSets behalten ihre kanonischen URLs. Verweise auf die genannten Beispielseiten laufen nach dem Release ins Leere.

- **Überarbeitete Seiten der Dosierschemata**
  - Die Seiten zu Tageszeiten, Uhrzeiten, Wochentagen und beiden Kombinationsschemata beschreiben jetzt, welche `frequency`-, `period`- und `periodUnit`-Angaben optional zulässig sind und dass sie den erzeugten Text nicht verändern.
  - Der Begriff „äußeres Intervall" ist durchgängig ersetzt. Das Schema heißt so, wie es im Menü steht: Kombination aus Zeitintervall und Tageszeiten- beziehungsweise Uhrzeiten-Bezug. „Äußer-" bleibt `bounds[x]` vorbehalten, wo FHIR es für die äußeren Grenzen des Zeitplans verwendet.

- **Bezug des Textgenerierungs-Algorithmus**
  - Der Algorithmus liegt nicht mehr im IG-Repository, sondern wird beim Build aus [hl7germany/dgMP-DosageTextgenerierung-Skript](https://github.com/hl7germany/dgMP-DosageTextgenerierung-Skript) geladen. `scripts/dosage-algorithm.lock` nennt Tag und SHA-256; weicht die geladene Datei ab, bricht der Build ab.
  - Damit ist die in `algorithmVersion` protokollierte Version nachweislich diejenige, mit der die Texte erzeugt wurden. Für die Nutzung des IG ändert sich nichts; die Angabe betrifft, wie der IG selbst gebaut wird.

- **Erweiterte Beispielabdeckung**
  - Wochentagsschemata mit und ohne redundante Legacy-Angaben, die denselben Dosierungstext erzeugen
  - Kombination aus Wochentag und `doseRange`, Tagesabschnitt mit variabler Dosis
  - Bedarfsdosierungen mit Viererschema, Uhrzeit und Maximaldosis
  - Intervallangaben mit `doseRange` ohne Untergrenze, wöchentlichem Rhythmus und fester Frequenz größer als 1
  - Negativbeispiele für teilweise identische Dosen, für Wochentage mit echtem Intervall und für variable Frequenz zusammen mit konkreten Zeitpunkten

---

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
