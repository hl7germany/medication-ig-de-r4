# M11 – Doppelte Wochentage

[Zur Migrationsübersicht](./migration-1.0.7-2.0.0.html)

## Anlass

`TimingOnlyOneDayOfWeek` verlangt eindeutige Werte in `timing.repeat.dayOfWeek` über die Dosage-Elemente einer Ressource. Die 2.0.0-Schemaerkennung deckt mehr Timing-Kombinationen als 1.0.7 ab.

## Auslöser

Ein Wochentag wie `mon` oder `wed` steht mehrfach in den betroffenen Dosage-Elementen und die Zielvalidierung meldet `TimingOnlyOneDayOfWeek`.

## Verbindliche Migration

1. Wochentage nicht entfernen oder zusammenführen. Dieselben Tage können mit unterschiedlichen Dosen, Zeiträumen oder Zusatzangaben verbunden sein.
2. `frequency` nicht aus der Anzahl unterschiedlicher Wochentage neu berechnen, da dies eine fachliche Interpretation wäre.
3. Die vollständigen Dosage-Objekte im Archiv-Fallback erhalten.
4. M11 und Validierungsergebnis protokollieren.

## Beispiel

Quelle: Ein Dosage-Element enthält `mon`, ein weiteres ebenfalls `mon`, aber mit anderer Dosis oder anderem Zeitrahmen.

Ziel: eine reine Text-Dosierung mit dem vollständigen kanonischen JSON-Array beider Dosage-Objekte.

## Prüffälle

- Doppelte Wochentage führen zum Fallback, nicht zur Deduplizierung.
- Wochentage mit unterschiedlichen Dosen bleiben getrennt erhalten.
- Frequenz und Zeitraum werden nicht abgeleitet oder neu berechnet.
