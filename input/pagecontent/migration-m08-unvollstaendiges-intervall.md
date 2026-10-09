# M08 – Unvollständige oder widersprüchliche Intervallangabe

[Zur Migrationsübersicht](./migration-1.0.7-2.0.0.html)

## Anlass

`TimingOnlyOneTimeForInterval` erkennt Timing-Schemata in 2.0.0 auch dann, wenn `frequency`, `period` oder `periodUnit` fehlen. Dadurch können bisher ungeprüfte Kombinationen mit widersprüchlichen Zeit- oder Periodenangaben ungültig werden.

## Auslöser

Der 2.0.0-Validator meldet `TimingOnlyOneTimeForInterval` für ein zuvor gespeichertes Timing-Schema, dessen Erkennung in 1.0.7 noch vollständige Intervallfelder voraussetzte.

## Verbindliche Migration

1. Fehlende Intervallwerte nicht aus anderen Dosage-Elementen, aus Text oder aus einer vermuteten Standardfrequenz ergänzen.
2. Keine Zeit- oder Periodenangabe auswählen und keine widersprüchlichen Angaben löschen.
3. Die vollständige Ressourcen-Dosage-Liste im kanonischen Archiv-Fallback der Übersichtsseite abbilden.
4. Zielressource validieren und die Fall-ID M08 protokollieren.

## Beispiel

Quelle: Zwei Dosage-Elemente enthalten Zeit-/Intervallangaben, aber keines enthält eine vollständige Kombination aus `frequency`, `period` und `periodUnit`. Es ist nicht eindeutig, welches Timing maßgeblich ist.

Ziel: eine einzelne reine Freitext-Dosierung mit dem gekennzeichneten JSON-Array aller ursprünglichen Dosage-Elemente. Kein Zeitwert wird ergänzt.

## Prüffälle

- Fehlende Intervallfelder werden nicht ergänzt.
- Bei widersprüchlichen Zeitangaben wird kein Element bevorzugt.
- Die kanonische Serialisierung enthält jedes Dosage-Element in ursprünglicher Listenreihenfolge.
