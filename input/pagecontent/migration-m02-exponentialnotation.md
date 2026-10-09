# M02 – Exponentialschreibweise

[Zur Migrationsübersicht](./migration-1.0.7-2.0.0.html)

## Anlass

`DosageDoseValueDecimalNotation` verlangt eine einfache Dezimalschreibweise mit höchstens zwei Nachkommastellen. JSON erlaubt Exponentialnotation, die dadurch im Zielprofil ungültig wird.

## Auslöser

Ein numerischer Dosiswert ist im Quellpayload mit Exponent serialisiert, zum Beispiel `5e-1` oder `50e-2`. Der gespeicherte Zahlenwert selbst muss positiv und nach den Dosisregeln zulässig sein.

## Verbindliche Migration

1. Den Zahlenwert mit Dezimalarithmetik einlesen, nicht mit binärer Gleitkommaarithmetik.
2. Den Wert in kanonischer einfacher Dezimalschreibweise serialisieren: Exponent entfernen, Nachkommastellen nur so weit wie für den exakten Wert erforderlich schreiben, keine Rundung.
3. Danach `DosageDoseQuantityAllowedFractions` und `DosageDoseValuePositive` validieren.
4. Bei gültigem Wert die strukturierte Dosierung und übrige Felder unverändert erhalten; den Text für strukturierte Dosierungen mit dem gepinnten Algorithmus neu erzeugen.
5. Verletzt der exakt normalisierte Wert einen anderen Dosis-Constraint, M01 oder M03 anwenden.

## Beispiel

Quelle:

```json
{"value": 5e-1, "unit": "Stück"}
```

Ziel:

```json
{"value": 0.5, "unit": "Stück"}
```

Der Zahlenwert ist identisch. Die Änderung ist nur die JSON-Serialisierung; eine Umwandlung von `0.51` in `0.5` wäre unzulässig.

## Prüffälle

- `5e-1` wird `0.5` und besteht beide Dosis-Constraints.
- `12e-1` wird exakt `1.2`; danach löst M01 aus.
- `0e0` wird `0`; danach löst M03 aus.
- Ein Re-Run über die normalisierte Zahl ändert den Wert nicht erneut.
