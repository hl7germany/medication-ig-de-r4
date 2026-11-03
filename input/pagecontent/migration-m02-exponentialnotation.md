[Zur Migrationsübersicht](./migration-1.0.7-2.0.0.html)

### Anlass

`DosageDoseValueDecimalNotation` verlangt eine einfache Dezimalschreibweise mit höchstens zwei Nachkommastellen. Die Prüfung verwendet `value.toString()`. Ob dabei eine JSON-Exponentialnotation erkannt wird, hängt vom Parser ab: Nach gewöhnlichem JSON-Parsen sind `5e-1` und `0.5` derselbe Zahlenwert. M02 betrifft deshalb die Serialisierung im Quellpayload, nicht nur den geparsten Wert.

### Auslöser

Ein Dosiswert ist im Quellpayload mit Exponent serialisiert, zum Beispiel `5e-1` oder `50e-2`.

### Überführung

1. Den Wert dezimalgenau einlesen, ohne binäre Gleitkommaarithmetik.
2. Den Wert ohne Exponent serialisieren und dabei die Stellenzahl der Mantisse erhalten: `5e-1` → `0.5`, `50e-2` → `0.50`. Es wird nicht gerundet. FHIR behandelt die Genauigkeit eines `decimal` einschließlich nachfolgender Nullen als Teil des Werts, und die Textgenerierung gibt sie wieder (`je 0,50 Stück`).
3. Mit dem normalisierten Wert weiter nach dem [Ablauf der Übersicht](./migration-1.0.7-2.0.0.html) verfahren. Verletzt der Wert danach einen anderen Dosis-Constraint (zum Beispiel M01 oder M03), gilt der [Freitext-Fallback](./migration-freitext-fallback.html).

### Beispiel

Quelle:

```json
{"value": 5e-1, "unit": "Stück"}
```

Ziel:

```json
{"value": 0.5, "unit": "Stück"}
```

### Prüffälle

- `5e-1` wird `0.5` und bleibt strukturiert.
- `50e-2` wird `0.50`, nicht `0.5`.
- `12e-1` wird `1.2`; danach gilt M01.
- `0e0` wird `0`; danach gilt M03.
