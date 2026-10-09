# M07 – Frequenz und Periode größer als eins

[Zur Migrationsübersicht](./migration-1.0.7-2.0.0.html)

## Anlass

`TimingFreqOrPeriodGtOne` schränkt reine Intervallangaben ein: Frequenz und Periode dürfen nicht beide größer als eins sein. Die Invariante bezieht variable Obergrenzen ebenfalls ein.

## Auslöser

Die Regel gilt bei vorhandenem `frequency` und `period`, wenn `when`, `timeOfDay` und `dayOfWeek` leer sind und Frequenz und Periode die verbotene Kombination bilden. Variable Obergrenzen werden im Ziel ebenfalls berücksichtigt, waren in einer gültigen dgMP-Quelle 1.0.7 aber ausgeschlossen.

## Verbindliche Migration

1. Die Zahlen nicht algebraisch normalisieren. Aus `2` pro `8 h` darf nicht automatisch „alle 4 Stunden“ werden, da das FHIR-Paar allein keine gleichmäßige Verteilung belegt.
2. Die [Renderer-Allowlist und Vollständigkeitsprüfung](./migration-1.0.7-2.0.0.html) anwenden. Genau ein vollständiges reines Intervallschema mit positiver `doseQuantity` ist erforderlich. Alle gleichzeitig vorliegenden Fehler prüfen; M03 und M08–M17 sperren den Pfad.
3. Den erzeugten Text nur bei nachgewiesener Bedeutungstreue übernehmen. Die gesamte Liste durch genau ein Dosage-Element mit ausschließlich `text` ersetzen; alte Text-Extensions und Struktur-Metadaten nicht übernehmen. Das vollständige Ziel gegen 2.0.0 validieren und die Rendererherkunft im Migrationsbericht festhalten.
4. Bei Rendererfehler, Informationsverlust oder ungültigem Ziel das [Archivverfahren](./migration-freitext-fallback.html) verwenden.

## Beispiel

Quelle:

```text
frequency = 2
period = 8
periodUnit = h
doseQuantity = 1 Stück
```

Rendererziel: `2 x alle 8 Stunden: je 1 Stück`. Der Text erhält die vorhandenen Werte; er behauptet keine Gabe exakt alle vier Stunden.

## Was bleibt erhalten?

Frequenz, Periode, Einheit und Dosis bleiben im Text erhalten; die strukturierte Darstellung entfällt. Der Text übernimmt die belegte Intervallangabe, bestätigt aber keine gleichmäßige Verteilung innerhalb dieses Intervalls. Die Originalressource bleibt archiviert.

## Prüffälle

- `frequency = 1`, `period = 8 h` löst M07 nicht aus.
- `frequency = 2`, `period = 8 h` wird nicht in `1` und `4 h` umgerechnet.
- Schemata mit konkreten Uhrzeiten sind nicht reine Intervalle und werden nicht über M07 umgeschrieben.
