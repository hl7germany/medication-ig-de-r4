# M10 – Doppelte Uhrzeiten

[Zur Migrationsübersicht](./migration-1.0.7-2.0.0.html)

## Anlass

`TimingOnlyOneTimeOfDay` verlangt, dass konkrete Uhrzeiten über die Dosage-Elemente der Ressource eindeutig sind. Die erweiterte Erkennung kann auch bisher ungeprüfte Fälle ohne vollständige Intervallfelder erfassen.

## Auslöser

Derselbe Wert in `timing.repeat.timeOfDay` kommt in mehreren Dosage-Elementen vor und der Zielvalidator meldet `TimingOnlyOneTimeOfDay`.

## Verbindliche Migration

1. Gleiche Uhrzeiten nicht automatisch entfernen oder aggregieren. Die zugehörigen Dosen oder weiteren Felder können voneinander abweichen.
2. Bei identischer Uhrzeit mit unterschiedlichen Dosen die Dosiszuordnung keinesfalls reduzieren.
3. Die vollständige Dosage-Liste in ursprünglicher Reihenfolge im Archiv-Fallback abbilden.
4. Zielressource validieren und M10 protokollieren.

## Beispiel

Quelle:

```text
08:00 -> 1 Stück
08:00 -> 2 Stück
```

Ziel: Archiv-Freitext mit beiden vollständigen Dosage-Objekten. Ein Text, der nur `08:00 -> 2 Stück` enthält, wäre verlustbehaftet.

## Prüffälle

- Doppelte Uhrzeit mit gleicher Dosis wird nicht automatisch als Duplikat gelöscht.
- Doppelte Uhrzeit mit unterschiedlicher Dosis bleibt vollständig erhalten.
- Unterschiedliche Uhrzeiten werden nicht durch M10 verändert.
