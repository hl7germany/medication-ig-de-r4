# M15 – Zeitrahmen nur teilweise belegt

[Zur Migrationsübersicht](./migration-1.0.7-2.0.0.html)

## Anlass

`TimingOnlyOneBounds` verschärft die Regel für Bounds über mehrere Dosage-Elemente: Entweder tragen alle Dosage-Elemente einen Bounds-Zeitrahmen oder keines. Für vorhandene `boundsDuration`-Werte galt bereits in 1.0.7, dass die belegten Werte übereinstimmen müssen.

## Auslöser

Nur ein Teil der Dosage-Elemente einer Ressource hat `timing.repeat.boundsDuration`. Der Fall ist nicht ausgelöst, wenn alle Elemente ohne Bounds sind oder alle denselben Bounds-Wert tragen. Ein neuer `boundsPeriod`-Wert war in 1.0.7 nicht vorhanden und wird nicht aus anderen Angaben ergänzt.

## Verbindliche Migration

1. Bounds nicht auf Dosage-Elemente kopieren, die in der Quelle keinen Bounds-Wert tragen.
2. Bounds nicht aus einzelnen Elementen entfernen, da dies die ursprüngliche Gültigkeit einschränken oder erweitern könnte.
3. Die vollständige Dosage-Liste in ursprünglicher Reihenfolge im Archiv-Fallback abbilden.
4. M15 protokollieren und die Zielressource validieren.

Unterschiedliche Bounds-Werte, die bereits die 1.0.7-Regel verletzt hätten, sind ein Datenqualitätsfehler des Quellbestands und kein durch 2.0.0 neu verursachter Migrationsfall. Auch sie werden nicht automatisch vereinheitlicht.

## Beispiel

Quelle:

```text
Dosage 1: boundsDuration = 7 d
Dosage 2: boundsDuration fehlt
```

Ziel: gekennzeichnete Archiv-Freitext-Dosierung mit beiden vollständigen Dosage-Objekten. `7 d` wird nicht in das zweite Element kopiert.

## Prüffälle

- Bounds bei allen Dosages, gleicher Wert: M15 nicht ausgelöst.
- Bounds bei keinem Dosage: M15 nicht ausgelöst.
- Bounds nur bei einem von mehreren Dosages: M15 ausgelöst.
- Unterschiedliche belegte Werte werden nicht vereinheitlicht.
