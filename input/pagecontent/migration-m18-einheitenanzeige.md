[Zur Migrationsübersicht](./migration-1.0.7-2.0.0.html)

### Anlass

`TimingBoundsUnitMatchesCode` verlangt, dass `Timing.repeat.boundsDuration.unit` zum UCUM-Code in `boundsDuration.code` passt. Der Constraint ist im dgMP-Profil ein Fehler, im generischen Timing-DE-Profil eine Warnung. Er galt bereits in 1.0.7; M18 betrifft also Bestandsdaten, die schon das Quellprofil verletzten.

### Auslöser

`boundsDuration.code` ist vorhanden, aber `boundsDuration.unit` ist keine für diesen Code zulässige Anzeige.

### Überführung

In einer FHIR-`Quantity` ist `code` die maschinenlesbare Einheit und `unit` ihre Anzeige. Die Anzeige wird deshalb aus dem Code abgeleitet:

1. Ist `code` im Ziel-ValueSet enthalten, `unit` auf die kanonische Anzeige nach der Tabelle setzen. `value`, `system` und `code` bleiben unverändert.
2. Ist `code` nicht im Ziel-ValueSet enthalten, bleibt die Angabe unverändert; die weitere Zielverletzung führt zum [Freitext-Fallback](./migration-freitext-fallback.html).

| `boundsDuration.code` | Kanonische Anzeige `unit` |
|---|---|
| `d` | `Tag(e)` |
| `wk` | `Woche(n)` |
| `mo` | `Monat(e)` |
| `a` | `Jahr(e)` |

Die Invariante akzeptiert auch die Varianten `Tag`, `Tage`, `Woche`, `Wochen`, `Monat`, `Monate`, `Jahr` und `Jahre`; diese werden nicht geändert.

### Beispiel

Quelle: `value = 7`, `system = UCUM`, `code = d`, `unit = Woche`.

Ziel: `unit = Tag(e)`; `value`, `system` und `code` bleiben unverändert. Der Dosierungstext wird anschließend neu erzeugt.

### Prüffälle

- `code = d`, `unit = Tag(e)`: unverändert.
- `code = d`, `unit = Tage`: zulässige Variante, unverändert.
- `code = d`, `unit = Woche`: `unit` wird `Tag(e)`.
