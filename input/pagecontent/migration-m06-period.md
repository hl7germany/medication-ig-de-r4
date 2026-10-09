# M06 – Gebrochene Periode

[Zur Migrationsübersicht](./migration-1.0.7-2.0.0.html)

## Anlass

`TimingPeriodOnlyWholeNumber` verlangt ganzzahlige Werte für `Timing.repeat.period` und `periodMax`. Eine gebrochene Periode wie `1.5 d` ist strukturiert nicht mehr zulässig.

## Auslöser

M06 gilt, wenn `period` oder `periodMax` numerisch nicht ganzzahlig ist. Ein numerischer Wert `4.00` ist ganzzahlig und löst den Fall nicht aus.

## Verbindliche Migration

1. Zuerst eine mathematisch exakte Umrechnung in eine ganzzahlige Periode und eine zulässige `periodUnit` versuchen. Die Ziel-ValueSet-Einheiten sind `min`, `h`, `d`, `wk` und `mo`.
2. `mo` nicht in Tage umrechnen; die Länge eines Monats ist kalenderabhängig.
3. Wenn keine exakte strukturierte Abbildung möglich ist, den Renderer nur für genau ein vollständiges `Dosage`-Element mit unterstütztem Timing-Schema verwenden.
4. Renderertext gegen 2.0.0 validieren. Bei Fehler oder unvollständiger Ausgabe Archiv-Fallback.
5. Keine Frequenz, Periode oder Einheit runden oder weglassen.

## Beispiel

Quelle: `frequency = 1`, `period = 1.5`, `periodUnit = d`.

Eine exakte Zeitumrechnung ist möglich: `36 h` ist dieselbe Dauer wie `1.5 d`. Wenn `h` für den konkreten Kontext zulässig ist, wird strukturiert migriert. Andernfalls kann ein einzelnes vollständiges Element mit dem Renderer als `alle 1,5 Tage: je ...` in Freitext überführt werden.

## Prüffälle

- `period = 2 d` bleibt strukturiert.
- `period = 1.5 d` wird nicht zu `1 d` oder `2 d` gerundet.
- `period = 1.5 mo` wird nicht automatisch in Tage konvertiert.
- `periodMax` ist ebenfalls auf Ganzzahligkeit zu prüfen.
