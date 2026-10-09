# M16 – Nur `timing` oder nur `doseAndRate`

[Zur Migrationsübersicht](./migration-1.0.7-2.0.0.html)

## Anlass

`DosageStructuredRequiresBoth` ist im 2.0.0-dgMP-Profil ein Fehler: Eine strukturierte Dosierung braucht grundsätzlich `timing` und `doseAndRate`. 1.0.7 konnte strukturierte Dosages mit nur einem der beiden Bestandteile zulassen.

## Auslöser

Ein Dosage-Element enthält `timing` ohne `doseAndRate` oder `doseAndRate` ohne `timing`, ohne die neue Ausnahme für reine Bedarfsmedikation.

## Verbindliche Migration

1. Fehlende Dosis- oder Timing-Felder nicht erfinden und nicht aus einem anderen Dosage-Element kopieren.
2. Der gepinnte Renderer ist für unvollständige strukturierte Dosages nicht freigegeben.
3. Die gesamte Dosage-Liste als gekennzeichneten Archiv-Fallback in ein einziges reines Freitext-Element migrieren.
4. Die fehlenden strukturierten Bestandteile im Fallback sichtbar erhalten; der Text gilt ausdrücklich nicht als fachlich bestätigte Einnahmeanweisung.
5. M16 und das Zielvalidierungsergebnis protokollieren.

## Beispiel

Quelle:

```json
{"timing":{"repeat":{"frequency":1,"period":1,"periodUnit":"d"}}}
```

`doseAndRate` fehlt. Die Migration erzeugt keine angenommene Dosis, sondern serialisiert das vollständige Dosage-Objekt im Archiv-Fallback.

## Prüffälle

- `timing` vorhanden, `doseAndRate` fehlt: Fallback.
- `doseAndRate` vorhanden, `timing` fehlt und kein reiner Bedarf: Fallback.
- `timing` und `doseAndRate` vorhanden: M16 nicht ausgelöst.
- Keine erfundenen Standarddosen oder Standardfrequenzen.
