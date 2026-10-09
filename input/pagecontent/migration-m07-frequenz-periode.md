# M07 – Frequenz und Periode größer als eins

[Zur Migrationsübersicht](./migration-1.0.7-2.0.0.html)

## Anlass

`TimingFreqOrPeriodGtOne` schränkt reine Intervallangaben ein: Frequenz und Periode dürfen nicht beide größer als eins sein. Die Invariante bezieht variable Obergrenzen ebenfalls ein.

## Auslöser

Die Regel gilt, wenn `when`, `timeOfDay` und `dayOfWeek` leer sind und sowohl `frequency` (oder `frequencyMax`) als auch `period` (oder `periodMax`) die verbotene Kombination bilden.

## Verbindliche Migration

1. Die Zahlen nicht algebraisch normalisieren. Aus `2` pro `8 h` darf nicht automatisch „alle 4 Stunden“ werden, da das FHIR-Paar allein keine gleichmäßige Verteilung belegt.
2. Den gepinnten Renderer nur bei genau einem vollständigen reinen Intervallschema mit `doseAndRate` ausführen.
3. Den erzeugten Text vollständig und unverändert übernehmen, wenn er nichtleer ist und alle 2.0.0-Textinvarianten besteht.
4. Bei Rendererfehler oder nicht abgebildeten Feldern den Archiv-Fallback verwenden.

## Beispiel

Quelle:

```text
frequency = 2
period = 8
periodUnit = h
doseQuantity = 1 Stück
```

Rendererziel: `2 x alle 8 Stunden: je 1 Stück`. Der Text erhält die vorhandenen Werte; er behauptet keine Gabe exakt alle vier Stunden.

## Prüffälle

- `frequency = 1`, `period = 8 h` löst M07 nicht aus.
- `frequency = 2`, `period = 8 h` wird nicht in `1` und `4 h` umgerechnet.
- Schemata mit konkreten Uhrzeiten sind nicht reine Intervalle und werden nicht über M07 umgeschrieben.
