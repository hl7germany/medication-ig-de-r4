# M13 – Wiederholte Tageszeiten mit nicht eindeutiger Dosis

[Zur Migrationsübersicht](./migration-1.0.7-2.0.0.html)

## Anlass

`TimingSingleDosageForTimeOfDay` erlaubt bei mehreren Dosage-Elementen mit konkreten Uhrzeiten nur dann mehrere Elemente, wenn jedes Element eine eindeutige vollständige Dosis einschließlich Datentyp trägt. Die strengere 2.0.0-Regel schließt Fälle wie `1, 1, 2` aus.

## Auslöser

Mehrere passende Dosage-Elemente enthalten gleiche vollständige Dosiswerte oder unvollständige Dosisangaben und die Zielvalidierung meldet `TimingSingleDosageForTimeOfDay`.

## Verbindliche Migration

1. Dosiswerte nicht nach nur ihrem numerischen Anteil vergleichen; Datentyp, Wert und Einheit sind Teil der Dosis.
2. Dosage-Elemente nicht zusammenführen und Zeit-Dosis-Zuordnungen nicht verändern.
3. Die gesamte Liste im Archiv-Fallback abbilden. Der geprüfte Renderer darf nur verwendet werden, wenn jedes konkrete Zeit-Dosis-Paar eindeutig und vollständig ausgegeben wird; für diesen Fehlerfall ist der Fallback festgelegt.
4. M13 und Validierungsergebnis protokollieren.

## Beispiel

Quelle:

```text
08:00 -> 1 Stück
12:00 -> 1 Stück
20:00 -> 2 Stück
```

Die Dosis `1 Stück` kommt mehrfach vor. Ziel ist das vollständige Archiv-JSON aller drei Dosage-Elemente; die Migration löscht keinen Zeitpunkt.

## Prüffälle

- Dosen `1 Stück`, `1 Stück`, `2 Stück` lösen den Fall aus.
- `1 Stück` und `1 mg` sind nicht dieselbe vollständige Dosis.
- Jeder Quellzeitpunkt bleibt im Fallback vorhanden.
