[Zur Migrationsübersicht](./migration-1.0.7-2.0.0.html)

### Anlass

`DosageDoseValueDecimalNotation` verlangt eine einfache Dezimalschreibweise mit höchstens drei Nachkommastellen. Die Prüfung verwendet `value.toString()`: Ob damit die ursprüngliche JSON-Exponentialnotation erkannt wird, hängt vom Parser beziehungsweise Validator ab. Nach gewöhnlichem JSON-Parsen sind `5e-1` und `0.5` derselbe Zahlenwert.

M02 normalisiert deshalb ausdrücklich die Quellserialisierung. Die Implementierung darf sich für ihre Erkennung nicht allein auf eine FHIRPath-Auswertung des bereits geparsten Werts verlassen.

### Auslöser

Ein numerischer Dosiswert ist im unveränderten Quellpayload mit Exponent serialisiert, zum Beispiel `5e-1` oder `50e-2`. Ein dezimalgenauer Parser muss den Original-Zahlentoken beziehungsweise seine Notation verfügbar halten. Positivität und zulässiger Bruchteil werden erst nach der exakten Normalisierung geprüft; bei Verletzungen folgen M01 beziehungsweise M03.

### Verbindliche Migration

1. Den Zahlenwert mit Dezimalarithmetik einlesen, nicht mit binärer Gleitkommaarithmetik.
2. Den Wert in einfacher Dezimalschreibweise serialisieren: Exponent entfernen, dabei die Stellenzahl der Mantisse erhalten (`5e-1` → `0.5`, `50e-2` → `0.50`), keine Rundung. FHIR betrachtet die Genauigkeit eines `decimal` einschließlich nachfolgender Nullen als Teil des Werts; die Textgenerierung gibt sie wieder (`je 0,50 Stück`). Nachfolgende Nullen zu verwerfen änderte den erzeugten Text.
3. Danach sämtliche Zielregeln für Zahlenwerte prüfen, insbesondere `DosageDoseValueDecimalNotation`, `DosageDoseQuantityAllowedFractions` und `DosageDoseValuePositive`.
4. Bei gültigem Wert die strukturierte Dosierung erhalten. Regulären Text und Text-Extensions nach dem [Ablauf und der Vollständigkeitsprüfung der Übersicht](./migration-1.0.7-2.0.0.html) erzeugen; anschließend die vollständige Zielressource validieren.
5. Verletzt der exakt normalisierte Wert einen anderen Dosis-Constraint, M01 oder M03 anwenden. Andere verbleibende Fehler ebenfalls behandeln; bei fehlendem Nachweis das [Archivverfahren](./migration-archivverfahren.html) verwenden.

### Beispiel

Quelle:

```json
{"value": 5e-1, "unit": "Stück"}
```

Ziel:

```json
{"value": 0.5, "unit": "Stück"}
```

Zahlenwert und Genauigkeit sind identisch. Die Änderung ist nur die JSON-Serialisierung; eine Umwandlung von `0.51` in `0.5` wäre ebenso unzulässig wie eine von `0.50` in `0.5`.

### Was bleibt erhalten?

Zahlenwert, Einheit und Timing bleiben unverändert; nur die Zahlenschreibweise wird normalisiert. Neu erzeugte Text-Extensions sind keine unverändert übernommenen Quelldaten. Der originale Payload einschließlich Exponentialnotation bleibt im Archiv abrufbar.

### Prüffälle

- `5e-1` wird `0.5` und besteht beide Dosis-Constraints.
- `125e-3` wird exakt `0.125` und bleibt als Achteldosis strukturiert.
- `625e-4` wird exakt `0.0625`; der Wert verletzt weiterhin die Bruchteilsregel und die Grenze von drei Nachkommastellen, ohne dass gerundet werden darf.
- `50e-2` wird `0.50`, nicht `0.5`; der Dosierungstext bleibt `je 0,50 Stück`.
- `12e-1` wird exakt `1.2`; danach löst M01 aus.
- `0e0` wird `0`; danach löst M03 aus.
- `5e-1` muss im Originalpayload erkannt werden, auch wenn der FHIRPath-Validator nach dem Parsen keinen Notationsfehler meldet.
- Ein Re-Run über die normalisierte Zahl ändert den Wert nicht erneut.
