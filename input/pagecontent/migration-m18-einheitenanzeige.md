# M18 – Anzeigeeinheit passt nicht zum UCUM-Code

[Zur Migrationsübersicht](./migration-1.0.7-2.0.0.html)

## Anlass

`TimingBoundsUnitMatchesCode` verlangt, dass `Timing.repeat.boundsDuration.unit` zum UCUM-Code in `boundsDuration.code` passt. Der Constraint ist hart im dgMP-Profil; im generischen Timing-DE-Profil gibt es eine entsprechende Warnung.

## Auslöser

`boundsDuration.code` ist vorhanden, aber `boundsDuration.unit` gehört nicht zu den im Profil für diesen Code erlaubten deutschen Anzeigen.

## Verbindliche Migration

1. `system` muss UCUM sein und `code` muss im Ziel-ValueSet enthalten sein.
2. Bei gültigem Code ausschließlich `unit` auf die kanonische deutsche Designation der festgelegten Ziel-ValueSet-Version setzen. `value`, `system` und `code` nicht ändern.
3. Die gesamte Zielressource validieren. Bei strukturierter Dosierung den gerenderten Text mit der gepinnten Renderer-Version neu erzeugen und `GeneratedDosageInstructionsMeta` aktualisieren.
4. Bei ungültigem/mehrdeutigem Code, nicht unterstützter Einheit oder fehlgeschlagener Validierung den Archiv-Fallback verwenden.

## Zuordnung

| Code | Kanonische Einheit |
|---|---|
| `d` | `Tag(e)` |
| `wk` | `Woche(n)` |
| `mo` | `Monat(e)` |
| `a` | `Jahr(e)` |

Die Invariante akzeptiert für diese Codes auch definierte Varianten wie `Tag`, `Tage`, `Woche`, `Wochen`, `Monat`, `Monate`, `Jahr` und `Jahre`. Die implementierte Zielzuordnung wird über die gepinnte ValueSet-Version bestimmt.

## Beispiel

Quelle: `value = 7`, `system = UCUM`, `code = d`, `unit = Woche`.

Ziel: `unit = Tag(e)`; `value`, `system` und `code` bleiben unverändert. Das ist eine Anzeige-Korrektur, keine Umrechnung von sieben Wochen in sieben Tage.

## Prüffälle

- `code = d`, `unit = Tag(e)`: unverändert.
- `code = d`, `unit = Woche`: nur `unit` korrigieren, sofern `d` maßgeblich ist.
- Unbekannter Code: nicht raten; Archiv-Fallback.
