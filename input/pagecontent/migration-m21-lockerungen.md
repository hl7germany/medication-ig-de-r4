# M21 – Lockerungen, Bugfixes und Constraint-Key-Änderungen

[Zur Migrationsübersicht](./migration-1.0.7-2.0.0.html)

## Zweck

M21 bündelt Änderungen, die keine zuvor gültigen Dosierungsdaten ungültig machen: Lockerungen, unveränderte Ausdrücke, Bugfixes für neue Felder und die Umbenennung eines Constraint-Keys.

## Betroffene Constraints

Die geänderten Regeln umfassen `TimingOnlyOneType`, `TimingPeriodUnit`, `TimingFrequencyCount`, `TimingVarFreqGtMin`, `TimingOnlyOneWhen`, `TimingOnlyOneTimeOfDay`, `TimingOnlyOneDayOfWeek`, `TimingOnlyOneTimeForInterval`, `TimingOnlyWhenOrTimeOfDay`, `TimingOnlyOnePeriodForDayOfWeek`, `DosageStructuredRequiresBoth` sowie die Umbenennung `DosageWarnungViererschemaInText` zu `DosageFourSlotPatternInTextWarning`. Strengere Änderungen mit eigenem M-Fall sind M13, M14 und M15.

## Migrationsregel

1. Dosierungsressourcen, die ausschließlich von einer Lockerung oder einer unveränderten Invariante betroffen sind, nicht umschreiben.
2. Bei einem Constraint-Key-Rename Validator-, Monitoring- und Testsysteme aktualisieren, die den alten Namen auswerten. Das ändert keine Dosage-Felder.
3. Bugfixes für ausschließlich neue 2.0.0-Felder erfordern keine Migration von 1.0.7-Daten.
4. Falls ein Datensatz zusätzlich einen harten Fehler aus einem anderen M-Fall enthält, diesen Fall unabhängig bearbeiten.

## Beispiel

Ein Consumer wertet bislang den Namen `DosageWarnungViererschemaInText` aus. Er wird auf `DosageFourSlotPatternInTextWarning` umgestellt; die Dosage-Ressource bleibt unverändert.

## Prüffälle

- Nur gelockerte Regel: Quellinhalt bleibt unverändert.
- Nur Constraint-Key-Rename: Tests prüfen den neuen Namen.
- Ressource mit zusätzlichem M01–M18-Fehler: die dazugehörige Datenregel wird zusätzlich angewendet.
