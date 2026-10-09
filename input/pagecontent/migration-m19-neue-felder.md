# M19 – Neue 2.0.0-Felder ohne 1.0.7-Quelle

[Zur Migrationsübersicht](./migration-1.0.7-2.0.0.html)

## Zweck

M19 dokumentiert Felder und Constraints, die in 2.0.0 neu sind und für gültige 1.0.7-Quellen keinen Transformationsbedarf erzeugen. Diese Seite verlangt ausdrücklich keine Datenänderung.

## Betroffene neue Felder

Unter anderem sind dies `asNeededBoolean`, `asNeededFor`, `doseRange`, `frequencyMax`, `periodMax`, `maxDosePerPeriod`, `patientInstruction`, `MinimumIntervalBetweenAdministrations` und `boundsPeriod`. Dazu gehören Constraints wie `AsNeededForIdentical`, `AsNeededIdentical`, `AsNeededSingleDosageOnly`, `DoseRangeHighRequiredWhenLowPresent`, `DoseRangeLowAndHighSameUnit`, `MaxDoseOnlyPureAsNeeded`, `MaxDosePerPeriodOnly24hOr1d`, `MinimumIntervalUnitMatchesCode`, `PatientInstructionIdentical`, `TimingVarFreqGtMin` und `TimingVarPeriodGtMin`.

## Migrationsregel

Diese Felder DÜRFEN nicht aus unstrukturiertem Text, anderen Feldern oder einer angenommenen Standarddosierung ergänzt werden. Sie bleiben unbelegt, sofern keine unabhängige, verlässliche Quelle diese Information ausdrücklich enthält und eine separate Mappingregel dafür festgelegt wurde.

Vorhandene 1.0.7-Felder werden unabhängig davon gegen sämtliche anwendbaren 2.0.0-Regeln geprüft. M19 ist kein Freibrief, andere Validierungsfehler zu ignorieren.

## Beispiel

Quelle: keine Bedarfsangabe.

Ziel: `asNeededBoolean` und `asNeededFor` bleiben leer. Aus einem Text wie „bei Bedarf“ darf kein strukturierter Anlasscode erfunden werden.

## Prüffälle

- Kein Quellwert: Ziel-Feld bleibt leer.
- Unabhängige strukturierte Quelle mit dokumentiertem Mapping: nur über die separate, versionierte Regel ergänzen.
- Eine Verletzung eines alten Feld-Constraints wird nicht durch M19 übersprungen.
