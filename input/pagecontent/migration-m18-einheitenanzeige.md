# M18 – Anzeigeeinheit passt nicht zum UCUM-Code

[Zur Migrationsübersicht](./migration-1.0.7-2.0.0.html)

## Anlass

`TimingBoundsUnitMatchesCode` verlangt, dass `Timing.repeat.boundsDuration.unit` zum UCUM-Code in `boundsDuration.code` passt. Der Constraint ist hart im dgMP-Profil; im generischen Timing-DE-Profil gibt es eine entsprechende Warnung.

## Auslöser

`boundsDuration.code` ist vorhanden, aber `boundsDuration.unit` gehört nicht zu den im Profil für diesen Code erlaubten deutschen Anzeigen.

## Verbindliche Migration

1. `system` muss UCUM sein und `code` muss im Ziel-ValueSet enthalten sein. Eine explizite, versionierte Quellkonvention muss belegen, dass der Code die maßgebliche Einheit ist und `unit` nur deren Anzeige. Bei widersprüchlichen Angaben darf die Migration nicht selbst entscheiden, welcher Wert klinisch gemeint war.
2. Nur mit diesem Nachweis ausschließlich `unit` auf die kanonische deutsche Designation der festgelegten Ziel-ValueSet-Version setzen. `value`, `system` und `code` nicht ändern. Bereits zulässige Anzeigevarianten nicht allein für eine kosmetische Vereinheitlichung ändern.
3. Die Struktur nach dem [Ablauf der Übersicht](./migration-1.0.7-2.0.0.html) prüfen, regulären Text und Text-Extensions neu erzeugen und die Vollständigkeitsprüfung durchführen. Anschließend die gesamte Zielressource einschließlich der Extensions validieren.
4. Bei fehlendem Nachweis, ungültigem/mehrdeutigem Code, Informationsverlust oder nicht behebbaren Zielverletzungen das [Archivverfahren](./migration-freitext-fallback.html) verwenden. Gleichzeitig vorliegende M-Fälle nach der Übersicht behandeln.

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

Mit belegter Quellkonvention „Code maßgeblich, unit nur Anzeige“: Ziel `unit = Tag(e)`; `value`, `system` und `code` bleiben unverändert. Die belegte Dauer von sieben Tagen wird korrekt angezeigt; es findet keine Zahlenumrechnung statt.

Ohne diesen Nachweis: nur archivieren. Die Migration darf nicht zwischen sieben Tagen und sieben Wochen entscheiden.

## Was bleibt erhalten?

Bei belegter Korrektur bleiben Zahlenwert, System, Code und Timing erhalten. Die falsche Anzeige wird ersetzt und der Text neu erzeugt. Ohne belegte maßgebliche Einheit bleibt die unveränderte Quelle im Archiv; es gibt kein freigegebenes Ziel.

## Prüffälle

- `code = d`, `unit = Tag(e)`: unverändert.
- `code = d`, `unit = Woche`: nur `unit` korrigieren, sofern `d` maßgeblich ist.
- `code = d`, `unit = Woche` ohne belegte Quellkonvention: nur archivieren.
- `code = d`, `unit = Tage`: bereits zulässige Variante; unverändert.
- Unbekannter Code: nicht raten; nur archivieren.
