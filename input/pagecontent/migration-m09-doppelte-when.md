# M09 – Doppelte `when`-Werte

[Zur Migrationsübersicht](./migration-1.0.7-2.0.0.html)

## Anlass

`TimingOnlyOneWhen` verlangt, dass Tagesabschnitts-Codes wie `MORN`, `NOON`, `EVE` und `NIGHT` über die Dosage-Elemente einer Ressource eindeutig sind. 2.0.0 prüft das Schema auch ohne vollständige Intervallfelder.

## Auslöser

Mindestens zwei Dosage-Elemente enthalten denselben `timing.repeat.when`-Code und die 2.0.0-Validierung meldet `TimingOnlyOneWhen`.

## Verbindliche Migration

1. Codes nicht deduplizieren und Dosage-Elemente nicht zusammenführen. Gleiche Tagesabschnitte können verschiedene Dosen, Zusatzinstruktionen oder weitere Timing-Angaben tragen.
2. Den Renderer nicht auf doppelte `when`-Werte anwenden; die geprüfte Implementierung weist doppelte Codes zurück.
3. Alle Dosage-Elemente in Reihenfolge und vollständig im kanonischen Archiv-Fallback serialisieren.
4. M09 und das Validatorergebnis im Migrationsprotokoll festhalten.

## Beispiel

Quelle:

```text
Dosage 1: when = MORN, dose = 1 Stück
Dosage 2: when = MORN, dose = 2 Stück
```

Ziel: ein Freitext-`Dosage`-Element mit gekennzeichnetem JSON-Array beider Quellobjekte. Keine der Dosen wird gelöscht oder bevorzugt.

## Prüffälle

- Wiederholter Code innerhalb verschiedener Dosage-Elemente löst M09 aus.
- Ähnliche, aber unterschiedliche Codes werden nicht als Duplikate behandelt.
- Die Ausgabe enthält beide ursprünglichen Objekte und ihre Reihenfolge.
