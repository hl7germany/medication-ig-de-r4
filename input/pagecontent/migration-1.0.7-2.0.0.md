Diese Seite beschreibt, wie Dosierungen aus dem dgMP-Profilstand 1.0.7 technisch in den Profilstand 2.0.0 überführt werden. Beschrieben wird ausschließlich die Abbildung der FHIR-Strukturen. Wie ein System die Migration organisiert, ob und wie es Quelldaten aufbewahrt, protokolliert oder mit nicht überführbaren Daten umgeht, liegt beim jeweiligen System und ist nicht Gegenstand dieses Leitfadens.

**Grundsatz:** Die Überführung erhält die Aussage der Quelldosierung. Zahlenwerte werden nicht gerundet, fehlende Dosen, Einheiten oder Zeitangaben werden nicht ergänzt und neue 2.0.0-Felder nicht aus anderen Angaben abgeleitet. Lässt sich eine strukturierte Dosierung nicht gültig nach 2.0.0 überführen, wird sie als Freitext-Dosierung abgebildet ([Freitext-Fallback](./migration-freitext-fallback.html)).

### Geltungsbereich

| Ressourcentyp | Dosierungsfeld |
|---|---|
| `MedicationRequest` | `dosageInstruction` |
| `MedicationDispense` | `dosageInstruction` |
| `MedicationStatement` | `dosage` |

Betrachtet werden Dosierungen nach dem `DosageDgMP`-/`TimingDgMP`-Modell 1.0.7. Einige Fälle (M15–M18) betreffen Angaben, die bereits in 1.0.7 unzulässig waren; sie sind aufgeführt, damit auch solche Bestandsdaten eindeutig abgebildet werden können.

Ressourcenelemente außerhalb der Dosierung und der Text-Extensions bleiben unverändert. Eine vorhandene Profilangabe in `meta.profile` wird auf das 2.0.0-Profil gesetzt.

### Ablauf

Die Überführung betrachtet immer die gesamte Dosierungs-Liste einer Ressource.

1. **Keine Dosierung vorhanden:** Es wird keine Dosierung ergänzt. Sind `renderedDosageInstruction` oder `GeneratedDosageInstructionsMeta` ohne Dosierung vorhanden, werden sie entfernt (M23).
2. **Reiner Freitext:** `Dosage.text` wird übernommen; besteht der Text nur aus einem 4-Schema (zum Beispiel `1-0-1-0 Stück`), wird er nach [M04](./migration-m04-viererschema-freitext.html) behandelt. Auf Ressourcenebene werden `renderedDosageInstruction` mit exakt diesem Text sowie `GeneratedDosageInstructionsMeta` gesetzt (`DosageRequiresGeneratedText`, `FreeTextMatchesRenderedText`).
3. **Strukturierte Dosierung normalisieren:** Exponentialschreibweise nach [M02](./migration-m02-exponentialnotation.html) und Anzeigeeinheiten nach [M18](./migration-m18-einheitenanzeige.html) korrigieren.
4. **Strukturierte Dosierung prüfen:** Erfüllt die normalisierte Struktur das 2.0.0-Profil, bleibt sie strukturiert. Der Dosierungstext wird nach der [Textgenerierung](./dosierung-textgenerierung.html) neu erzeugt; `renderedDosageInstruction` und `GeneratedDosageInstructionsMeta` werden durch die neu erzeugten Werte ersetzt.
5. **Sonst Freitext-Fallback:** Verletzt die Struktur weiterhin eine Invariante des Zielprofils, wird die Dosierung nach dem [Freitext-Fallback](./migration-freitext-fallback.html) als Freitext abgebildet.

Das Ergebnis ist in jedem Fall eine Ressource, die dem 2.0.0-Profil entspricht.

### Fallübersicht

| Fall | Anlass | Überführung | Details |
|---|---|---|---|
| M01 | Dosisbruchteil im Ziel nicht erlaubt | Freitext-Fallback | [Freitext-Fallback](./migration-freitext-fallback.html) |
| M02 | Exponentialschreibweise im Quellpayload | Exakte Dezimalnormalisierung | [M02](./migration-m02-exponentialnotation.html) |
| M03 | Dosiswert null oder negativ | Freitext-Fallback | [Freitext-Fallback](./migration-freitext-fallback.html) |
| M04 | Freitext besteht nur aus einem 4-Schema | `täglich: ` voranstellen | [M04](./migration-m04-viererschema-freitext.html) |
| M05 | Gebrochene Behandlungsdauer | Freitext-Fallback | [Freitext-Fallback](./migration-freitext-fallback.html) |
| M06 | Gebrochene Periode | Freitext-Fallback | [Freitext-Fallback](./migration-freitext-fallback.html) |
| M07 | Frequenz und Periode beide größer als eins | Freitext-Fallback | [Freitext-Fallback](./migration-freitext-fallback.html) |
| M08–M17 | Fehlende, widersprüchliche oder mehrfache Zeit-, Dosis- oder Einheitenangaben | Freitext-Fallback | [Freitext-Fallback](./migration-freitext-fallback.html) |
| M18 | Anzeigeeinheit passt nicht zum UCUM-Code | Anzeige aus dem Code setzen | [M18](./migration-m18-einheitenanzeige.html) |
| M19–M21 | Neue Felder, Warnungen und Lockerungen | Keine Änderung | Abschnitt „Fälle ohne Datenänderung“ |
| M22 | Periode oder Behandlungsdauer null oder negativ | Freitext-Fallback | [Freitext-Fallback](./migration-freitext-fallback.html) |
| M23 | Text-Extension ohne Dosierung | Extensions entfernen | Schritt 1 des Ablaufs |

Mehrere Fälle können gleichzeitig vorliegen. Bleibt nach M02 und M18 irgendeine Zielverletzung bestehen, gilt für die gesamte Dosierungs-Liste der Freitext-Fallback.

### Text-Extensions

Für 2.0.0 sind `renderedDosageInstruction` und `GeneratedDosageInstructionsMeta` bei jeder Dosierung erforderlich, auch bei Freitext (`DosageRequiresGeneratedText`). Bei Freitext stimmt `renderedDosageInstruction` exakt mit `Dosage.text` überein (`FreeTextMatchesRenderedText`). `GeneratedDosageInstructionsMeta` enthält die Sprache und die Version des Algorithmus, mit dem der Text erzeugt beziehungsweise übernommen wurde. Die Umstellung von `DosageStructuredRequiresGeneratedText` auf `DosageRequiresGeneratedText` ist daher nicht nur eine Umbenennung: Auch bestehende Freitext-Dosierungen erhalten beide Extensions.

### Fälle ohne Datenänderung (M19–M21)

| Fall | Betroffene Constraints | Verhalten |
|---|---|---|
| M19 – Neue 2.0.0-Felder | `AsNeededForIdentical`, `AsNeededForRequiresAsNeeded`, `AsNeededIdentical`, `AsNeededSingleDosageOnly`, `DosageLimitsPositive`, `DoseRangeHighRequiredWhenLowPresent`, `DoseRangeLowAndHighSameUnit`, `DoseRangeNoVarPeriod`, `MaxDoseNotBelowDose`, `MaxDoseOnlyPureAsNeeded`, `MaxDosePerPeriodOnly24hOr1d`, `MaxDoseSameUnitAsDose`, `MinimumIntervalOnlyPureAsNeeded`, `MinimumIntervalUnitMatchesCode`, `PatientInstructionIdentical`, `TimingBoundsPeriodMatchesTime`, `TimingBoundsPeriodNotForWhen`, `TimingVarFreqGtMin`, `TimingVarPeriodGtMin`, `dos-1` | Die Regeln betreffen Elemente, die in 1.0.7 nicht strukturiert vorhanden waren (zum Beispiel `doseRange`, `asNeededBoolean`, `maxDosePerPeriod`, `periodMax`, `boundsPeriod`, `patientInstruction`). Diese Felder werden bei der Überführung nicht befüllt. |
| M20 – Warnungen | `DosageDoseUnitSameCodeWarning`, `DosageDoseValuePositiveWarning`, `DosageFourSlotPatternInTextWarning`, `DosageLimitsPositiveWarning`, `DosageStructuredRequiresBothWarning`, `AsNeededForRequiresAsNeededWarning`, `TimingBoundsUnitMatchesCodeWarning`, `TimingFreqOrPeriodGtOneWarning`, `TimingSingleDosageForTimeOfDayWarning`, `TimingSingleDosageForWhenWarning`, `TimingValuesPositiveWarning` | Eine Warnung löst keine Änderung aus. Ist dieselbe Bedingung im dgMP-Profil ein Fehler, gilt der zugehörige Fall (M03, M04, M07, M13, M14, M16, M17, M18 oder M22). |
| M21 – Lockerungen, unveränderte Regeln, Umbenennung | `TimingOnlyOneType`, `TimingPeriodUnit`, `TimingFrequencyCount`, `DosageStructuredRequiresBoth`, `TimingOnlyOnePeriodForDayOfWeek`, `DosageWarnungViererschemaInText` → `DosageFourSlotPatternInTextWarning` | Für in 1.0.7 gültige Dosierungen ergibt sich daraus keine Änderung der Dosierungsdaten. |

### Einheiten

Zeit- und Dosiseinheiten werden nicht umgerechnet. `value`, `system` und `code` von Dosis-, Perioden- und Dauerangaben bleiben unverändert; geändert wird allenfalls die Anzeige `unit` nach M18. Für `periodUnit` erlaubt das Ziel-ValueSet `min`, `h`, `d`, `wk` und `mo`, für `boundsDuration` die Codes `d`, `wk`, `mo` und `a`.
