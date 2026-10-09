# M12 – Gemischte `when`- und `timeOfDay`-Schemata

[Zur Migrationsübersicht](./migration-1.0.7-2.0.0.html)

## Anlass

`TimingOnlyWhenOrTimeOfDay` verlangt für das betroffene Schema, dass entweder `when`-Codes oder konkrete `timeOfDay`-Werte verwendet werden, nicht beides über die Dosage-Elemente hinweg. Die breitere 2.0.0-Erkennung kann zuvor ungeprüfte Fälle erfassen.

## Auslöser

Mindestens ein Dosage-Element enthält `when`, während ein anderes `timeOfDay` enthält, und die Zielvalidierung meldet `TimingOnlyWhenOrTimeOfDay`.

## Verbindliche Migration

1. `when` und `timeOfDay` nicht gegeneinander austauschen. Ein ungefährer Tagesabschnitt ist nicht identisch mit einer konkreten Uhrzeit.
2. Keine der beiden Angaben löschen und keine konkrete Uhrzeit aus einem Tagesabschnitt ableiten.
3. Die vollständige Dosage-Liste in ursprünglicher Reihenfolge in den Archiv-Fallback überführen.
4. M12 protokollieren und die Zielressource validieren.

## Beispiel

Quelle:

```text
Dosage 1: when = MORN, dose = 1 Stück
Dosage 2: timeOfDay = 08:00, dose = 1 Stück
```

Ziel: beide Quellobjekte bleiben im gekennzeichneten Archivtext enthalten. Die Migration behauptet nicht, dass `MORN` genau `08:00` bedeutet.

## Prüffälle

- Getrennte Timing-Codes bleiben unverändert in der archivierten Darstellung.
- Es erfolgt kein Mapping `MORN` zu einer Uhrzeit.
- Rendererfehler oder Schema-Mischung führt nicht zum Löschen eines Timing-Felds.
