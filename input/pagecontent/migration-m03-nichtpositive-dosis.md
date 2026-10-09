# M03 – Dosiswert null oder negativ

[Zur Migrationsübersicht](./migration-1.0.7-2.0.0.html)

## Anlass

`DosageDoseValuePositive` verlangt für `doseQuantity.value` einen Wert größer null. Ein Null- oder Negativwert, der in 1.0.7 zulässig gespeichert werden konnte, ist im 2.0.0-dgMP-Profil nicht als strukturierte Einzeldosis erlaubt.

## Auslöser

Der Fall liegt vor, wenn `doseQuantity.value <= 0` ist. `doseRange.low.value = 0` ist ein anderer, neu hinzugefügter Fall und nicht aus 1.0.7 abzuleiten.

## Verbindliche Migration

1. Den Zahlenwert nicht ändern, entfernen oder als „keine Gabe“ interpretieren.
2. Den Standardrenderer nicht aufrufen; er weist solche Werte zurück.
3. Die vollständige ursprüngliche Dosage-Liste als eine einzelne reine Freitext-Dosierung im gekennzeichneten Archivformat der Übersicht abbilden.
4. `renderedDosageInstruction` und `GeneratedDosageInstructionsMeta` aus der Zielressource entfernen, falls sie einen anderen Text oder eine unzutreffende Algorithmusprovenienz enthalten.
5. Die Quelle unverändert archivieren und den Zielstatus als Archiv-Fallback ausweisen. Der Fallback darf nicht als aktive, fachlich bestätigte Einnahmeanweisung dargestellt werden.

## Beispiel

Quelle:

```json
{"doseAndRate":[{"doseQuantity":{"value":0,"unit":"Stück"}}]}
```

Ziel: einzelnes `Dosage`-Element, ausschließlich `text`, mit dem Archivpräfix und der kanonischen vollständigen Serialisierung der Original-Dosage-Liste. Der Wert `0` wird weder in eine positive Dosis umgewandelt noch als klinischer Stoppbefehl umgedeutet.

## Prüffälle

- `value = 0` verwendet M03.
- `value = -1` verwendet M03.
- `doseRange.low.value = 0` wird nicht durch diese Regel verändert.
- Kein Ziel darf den Fallbacktext als geprüfte Verordnung oder Ausführungsanweisung kennzeichnen.
