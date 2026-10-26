Diese Seite beschreibt, wie Dosierungen aus dem dgMP-Profilstand 1.0.7 technisch in den Profilstand 2.0.0 überführt werden. Beschrieben wird ausschließlich die Abbildung der FHIR-Strukturen. Wie ein System die Migration organisiert, ob und wie es Quelldaten aufbewahrt, protokolliert oder mit nicht überführbaren Daten umgeht, liegt beim jeweiligen System und ist nicht Gegenstand dieses Leitfadens.

**Grundsatz:** Die Überführung erhält die Aussage der Quelldosierung. Zahlenwerte werden nicht gerundet und nicht in andere Einheiten umgerechnet, fehlende Dosen, Einheiten oder Zeitangaben werden nicht ergänzt und neue 2.0.0-Felder nicht aus anderen Angaben abgeleitet. Einzige Ergänzung ist das vorangestellte `täglich: ` bei einem reinen 4-Schema im Freitext ([M04](./migration-m04-viererschema-freitext.html)). Lässt sich eine strukturierte Dosierung nicht gültig nach 2.0.0 überführen, wird sie als Freitext-Dosierung abgebildet ([Freitext-Fallback](./migration-freitext-fallback.html)).

### Geltungsbereich

| Ressourcentyp | Dosierungsfeld |
|---|---|
| `MedicationRequest` | `dosageInstruction` |
| `MedicationDispense` | `dosageInstruction` |
| `MedicationStatement` | `dosage` |

Betrachtet werden Dosierungen, die dem `DosageDgMP`-/`TimingDgMP`-Profil 1.0.7 entsprechen. Bestandsdaten, die bereits das Profil 1.0.7 verletzen, sind nicht Gegenstand der Überführung (siehe Abschnitt „Nicht Gegenstand der Überführung“).

Ressourcenelemente außerhalb der Dosierung und der Text-Extensions bleiben unverändert.

### Ablauf

Eine Dosierungs-Liste kann mehrere `Dosage`-Elemente enthalten, und jedes Element kann mehrere der unten aufgeführten Fälle aufweisen. Die Fall-IDs (M01–M15) sind nur Kennungen für die Unterschiede zwischen 1.0.7 und 2.0.0; ihre Nummern geben **keine Reihenfolge** vor. Maßgeblich ist der folgende Ablauf, der immer die gesamte Dosierungs-Liste einer Ressource betrachtet.

1. **Keine Dosierung vorhanden:** Es wird keine Dosierung ergänzt. Sind `renderedDosageInstruction` oder `GeneratedDosageInstructionsMeta` ohne Dosierung vorhanden, werden sie entfernt (M12).
2. **Reiner Freitext:** `Dosage.text` wird übernommen; besteht der Text nur aus einem 4-Schema (zum Beispiel `1-0-1-0 Stück`), wird er nach [M04](./migration-m04-viererschema-freitext.html) behandelt. Auf Ressourcenebene werden `renderedDosageInstruction` mit exakt diesem Text sowie `GeneratedDosageInstructionsMeta` gesetzt (`DosageRequiresGeneratedText`, `FreeTextMatchesRenderedText`, siehe Abschnitt „Text-Extensions“).
3. **Strukturierte Dosierung normalisieren:** In jedem `Dosage`-Element wird die Exponentialschreibweise nach [M02](./migration-m02-exponentialnotation.html) normalisiert. Weitere Änderungen an den Werten finden nicht statt.
4. **Gesamte Liste prüfen:** Erfüllt die normalisierte Dosierungs-Liste die Regeln des 2.0.0-Profils (abgesehen von den Text-Extensions, die erst in diesem Schritt gesetzt werden), bleibt sie strukturiert. Der Dosierungstext wird nach der [Textgenerierung](./dosierung-textgenerierung.html) neu erzeugt; `renderedDosageInstruction` und `GeneratedDosageInstructionsMeta` werden durch die neu erzeugten Werte ersetzt.
5. **Sonst Freitext-Fallback:** Verletzt mindestens ein `Dosage`-Element oder die Liste als Ganzes weiterhin eine Invariante des Zielprofils, wird für die **gesamte** Liste der [Freitext-Fallback](./migration-freitext-fallback.html) angewendet. Dabei spielt keine Rolle, wie viele Elemente und wie viele Fälle betroffen sind: Der Freitext wird aus allen `Dosage`-Elementen im Zustand nach Schritt 3 erzeugt.

Das Ergebnis ist eine Ressource, die dem 2.0.0-Profil entspricht. Ausgenommen sind die im Abschnitt „Nicht Gegenstand der Überführung“ genannten Daten.

### Fallübersicht

| Fall | Invariante | Anlass | Überführung | Details |
|---|---|---|---|---|
| M01 | `DosageDoseQuantityAllowedFractions`, `DosageDoseValueDecimalNotation` | Dosiswert mit einem Bruchteil außer `.25`, `.33`, `.5`, `.66`, `.75` oder mit mehr als zwei Nachkommastellen | Freitext-Fallback | [Freitext-Fallback](./migration-freitext-fallback.html) |
| M02 | `DosageDoseValueDecimalNotation` | Exponentialschreibweise im Quellpayload | Exakte Dezimalnormalisierung | [M02](./migration-m02-exponentialnotation.html) |
| M03 | `DosageDoseValuePositive` | Dosiswert null oder negativ | Freitext-Fallback | [Freitext-Fallback](./migration-freitext-fallback.html) |
| M04 | `DosageFourSlotPatternInText` | Freitext besteht nur aus einem 4-Schema | `täglich: ` voranstellen | [M04](./migration-m04-viererschema-freitext.html) |
| M05 | `TimingBoundsDurationOnlyWholeNumber` | Nicht ganzzahlige Behandlungsdauer | Freitext-Fallback | [Freitext-Fallback](./migration-freitext-fallback.html) |
| M06 | `TimingPeriodOnlyWholeNumber` | Nicht ganzzahlige Periode | Freitext-Fallback | [Freitext-Fallback](./migration-freitext-fallback.html) |
| M07 | `TimingFreqOrPeriodGtOne` | Reines Intervall, Frequenz und Periode beide größer als eins (zum Beispiel „2 x alle 3 Tage“) | Freitext-Fallback | [Freitext-Fallback](./migration-freitext-fallback.html) |
| M08 | `TimingSingleDosageForTimeOfDay` | Uhrzeiten (ohne Wochentage) auf mehrere `Dosage`-Elemente verteilt, deren Dosen nicht paarweise verschieden sind. Neu erfasst werden teilweise gleiche Dosen (zum Beispiel `1`, `1`, `2`) und Intervall-Kombinationen mit einer Periode ungleich 1 Tag | Freitext-Fallback | [Freitext-Fallback](./migration-freitext-fallback.html) |
| M09 | `TimingSingleDosageForWhen` | Wie M08, für Tagesabschnitte (`when`) | Freitext-Fallback | [Freitext-Fallback](./migration-freitext-fallback.html) |
| M10 | `TimingOnlyOneBounds` | Behandlungsdauer nur an einem Teil der `Dosage`-Elemente | Freitext-Fallback | [Freitext-Fallback](./migration-freitext-fallback.html) |
| M11 | `TimingValuesPositive` | Periode null oder Behandlungsdauer null oder negativ (eine negative Periode schließt bereits die R4-Basisregel `tim-5` aus) | Freitext-Fallback | [Freitext-Fallback](./migration-freitext-fallback.html) |
| M12 | `ExtRequiresDosage-MR`, `ExtRequiresDosage-MD`, `ExtRequiresDosage-MS` | Text-Extension ohne Dosierung | Extensions entfernen | Schritt 1 des Ablaufs |
| M13–M15 | siehe unten | Neue Felder, Warnungen und Lockerungen | Keine Änderung | Abschnitt „Fälle ohne Datenänderung“ |

Bei M01 und M05–M07 werden die Werte weder gerundet noch in andere Einheiten umgerechnet noch umgedeutet, auch wenn eine exakte Umrechnung möglich wäre (zum Beispiel eine Periode von `1.5 d` in `36 h`). „2 x alle 3 Tage“ wird also weder zu „alle 1,5 Tage“ noch zu „alle 36 Stunden“. Die Überführung erhält die Angabe der Quelle, wie sie verordnet wurde; deshalb gilt dort der Freitext-Fallback. Strukturiert überführt wird nur, was sich ohne Änderung der Werte normalisieren lässt (M02).

### Text-Extensions

Für 2.0.0 sind `renderedDosageInstruction` und `GeneratedDosageInstructionsMeta` bei jeder Dosierung erforderlich, auch bei Freitext (`DosageRequiresGeneratedText`). Bei Freitext stimmt `renderedDosageInstruction` exakt mit `Dosage.text` überein (`FreeTextMatchesRenderedText`). Die Umstellung von `DosageStructuredRequiresGeneratedText` auf `DosageRequiresGeneratedText` ist daher nicht nur eine Umbenennung: Auch bestehende Freitext-Dosierungen erhalten beide Extensions.

`GeneratedDosageInstructionsMeta` enthält die Sprache und in `algorithmVersion` die tatsächlich verwendete Version des Algorithmus der [Textgenerierung](./dosierung-textgenerierung.html). Das gilt auch für übernommenen Freitext, da die Textgenerierung einen Freitext unverändert übernimmt. Die Beispiele dieser Migrationsbeschreibung verwenden die Algorithmusversion `2.0.0`.

### Fälle ohne Datenänderung (M13–M15)

| Fall | Betroffene Constraints | Verhalten |
|---|---|---|
| M13 – Neue 2.0.0-Felder | `AsNeededForIdentical`, `AsNeededForRequiresAsNeeded`, `AsNeededIdentical`, `AsNeededSingleDosageOnly`, `DosageLimitsPositive`, `DoseRangeHighRequiredWhenLowPresent`, `DoseRangeLowAndHighSameUnit`, `DoseRangeNoVarPeriod`, `MaxDoseNotBelowDose`, `MaxDoseOnlyPureAsNeeded`, `MaxDosePerPeriodOnly24hOr1d`, `MaxDoseSameUnitAsDose`, `MinimumIntervalOnlyPureAsNeeded`, `MinimumIntervalUnitMatchesCode`, `PatientInstructionIdentical`, `TimingBoundsPeriodFullDate`, `TimingBoundsPeriodMatchesTime`, `TimingBoundsPeriodNotForWhen`, `TimingVarFreqGtMin`, `TimingVarPeriodGtMin`, `dos-1` | Die Regeln betreffen Elemente, die in 1.0.7 nicht strukturiert vorhanden waren (zum Beispiel `doseRange`, `asNeededBoolean`, `maxDosePerPeriod`, `periodMax`, `boundsPeriod`, `patientInstruction`). Diese Felder werden bei der Überführung nicht befüllt. |
| M14 – Warnungen | `AsNeededForRequiresAsNeededWarning`, `DosageDoseUnitSameCodeWarning`, `DosageDoseValuePositiveWarning`, `DosageFourSlotPatternInTextWarning`, `DosageLimitsPositiveWarning`, `DosageStructuredRequiresBothWarning`, `TimingBoundsUnitMatchesCodeWarning`, `TimingFreqOrPeriodGtOneWarning`, `TimingSingleDosageForTimeOfDayWarning`, `TimingSingleDosageForWhenWarning`, `TimingValuesPositiveWarning` | Eine Warnung löst keine Änderung aus. Ist dieselbe Bedingung im dgMP-Profil ein Fehler, gilt der zugehörige Fall (M03, M04, M07, M08, M09 oder M11). Galt der Fehler bereits in 1.0.7, betrifft er keine 1.0.7-konformen Daten. |
| M15 – Lockerungen, für 1.0.7-konforme Daten unveränderte Regeln, Umbenennung | `TimingOnlyOneType`, `TimingPeriodUnit`, `TimingFrequencyCount`, `DosageStructuredRequiresBoth`, `DosageStructuredOrFreeText`, `FreeTextSingleDosageOnly`, `DosageDoseUnitSameCode`, `TimingBoundsUnitMatchesCode`, `TimingIntervalOnlyOneFrequency`, `TimingOnlyOnePeriodForDayOfWeek`, `TimingOnlyOneWhen`, `TimingOnlyOneTimeOfDay`, `TimingOnlyOneDayOfWeek`, `TimingOnlyWhenOrTimeOfDay`, `TimingOnlyOneTimeForInterval`; Umbenennung `DosageWarnungViererschemaInText` → `DosageFourSlotPatternInTextWarning` | Für in 1.0.7 gültige Dosierungen ergibt sich daraus keine Änderung der Dosierungsdaten. Bei `TimingOnlyOneWhen`, `TimingOnlyOneTimeOfDay`, `TimingOnlyOneDayOfWeek`, `TimingOnlyWhenOrTimeOfDay` und `TimingOnlyOneTimeForInterval` ist zwar die Vorbedingung `frequency`/`period`/`periodUnit` entfallen; diese Felder waren in 1.0.7 jedoch Pflicht. |

### Nicht Gegenstand der Überführung

Für die folgenden Bestandsdaten beschreibt dieser Leitfaden keine Abbildung. Wie ein System mit ihnen umgeht, entscheidet es selbst.

- **Dosierungen, die bereits das Profil 1.0.7 verletzen**, zum Beispiel doppelte Tagesabschnitte oder Uhrzeiten, gemischte Tagesabschnitte und Uhrzeiten, fehlendes `timing` oder `doseAndRate`, unterschiedliche Dosis-Codes oder eine Anzeigeeinheit der Behandlungsdauer, die nicht zum UCUM-Code passt. Ihre Ungültigkeit ist keine Folge des Profilwechsels.
- **Dosisangaben ohne Zahlenwert:** `doseQuantity.value` ist in 2.0.0 Pflicht, in 1.0.7 war es optional. Ohne Zahlenwert lässt sich weder eine strukturierte Dosierung noch ein Dosierungstext bilden.
- **Dosierungen, für die die Textgenerierung im Freitext-Fallback keinen Text liefert** (siehe [Freitext-Fallback](./migration-freitext-fallback.html)).

### Einheiten

Zeit- und Dosiseinheiten werden nicht umgerechnet. `value`, `system` und `code` von Dosis-, Perioden- und Dauerangaben bleiben unverändert, ebenso die Anzeige `unit`. Für `periodUnit` erlaubt das Ziel-ValueSet `min`, `h`, `d`, `wk` und `mo` (in 1.0.7 nur `d`, `wk` und `mo`), für `boundsDuration` die Codes `d`, `wk`, `mo` und `a`.
