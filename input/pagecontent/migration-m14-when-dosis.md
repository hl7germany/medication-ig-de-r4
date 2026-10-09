# M14 – Wiederholte `when`-Angaben mit nicht eindeutiger Dosis

[Zur Migrationsübersicht](./migration-1.0.7-2.0.0.html)

## Anlass

`TimingSingleDosageForWhen` ist das Gegenstück zur Uhrzeitenregel M13. Wenn mehrere Dosage-Elemente Tagesabschnitts-Codes wie `MORN` oder `EVE` verwenden, muss jedes Element eine eindeutige vollständige Dosis einschließlich Datentyp tragen.

## Auslöser

Mehrere betroffene Dosage-Elemente führen zum selben `when`-Tagesabschnitt und haben gleiche oder unvollständige Dosen; 2.0.0 meldet `TimingSingleDosageForWhen`.

## Verbindliche Migration

1. `when`-Angaben nicht deduplizieren und keine Elemente vereinigen.
2. Dosiswerte einschließlich Typ und Einheit vergleichen; keine Aussage aus Code oder Einheit erraten.
3. Alle ursprünglichen Dosage-Elemente vollständig und in Originalreihenfolge im Archiv-Fallback serialisieren.
4. M14 als Grund und das Validierungsergebnis protokollieren.

## Beispiel

Quelle:

```text
MORN -> 1 Stück
MORN -> 1 Stück
EVE  -> 2 Stück
```

Ziel: ein Freitext-`Dosage`-Element mit dem Archivpräfix und dem kanonischen JSON-Array aller drei Quellobjekte.

## Prüffälle

- Wiederholtes `MORN` mit gleicher Dosis wird nicht stillschweigend entfernt.
- Gleicher Zahlenwert mit verschiedenen Einheiten gilt nicht als gleiche vollständige Dosis.
- Sämtliche `when`-Codes und Dosen bleiben im Fallback erhalten.
