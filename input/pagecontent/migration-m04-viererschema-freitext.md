# M04 – 4-Schema im Freitext

[Zur Migrationsübersicht](./migration-1.0.7-2.0.0.html)

## Anlass

`DosageFourSlotPatternInText` verbietet in 2.0.0 einen Freitext, der vollständig einem 4-Schema entspricht, zum Beispiel `1-0-0-0`. Die Regel ist am Anfang und Ende verankert und lässt optionale Werte, Bruchteile, Teilungsverhältnisse und eine Einheit zu.

## Auslöser

Für jedes befüllte `Dosage.text` wird genau der Constraint-Ausdruck des Zielprofils verwendet:

```text
^\\s*\\d+([.,]\\d+)?(\\s*/\\s*\\d+)?(\\s*[-–]\\s*\\d+([.,]\\d+)?(\\s*/\\s*\\d+)?){3}(\\s*[A-Za-zÄÖÜäöüß().]+)?\\s*$
```

## Verbindliche Migration

Wenn der vollständige Text dem Ausdruck entspricht, MUSS die Migration exakt `täglich: ` voranstellen. Der bestehende Text einschließlich Einheiten, Leerzeichen, Dezimal- und Teilungsschreibweise sowie Bindestrichart bleibt unverändert. Werte werden nicht interpretiert und nicht in `when`, `doseQuantity` oder andere strukturierte Felder überführt.

Die Zielressource MUSS anschließend die übrigen 2.0.0-Constraints bestehen. Da der Text geändert wurde, müssen `renderedDosageInstruction` und `GeneratedDosageInstructionsMeta` auf Ressourcenebene entfernt werden, damit kein veralteter Text oder eine falsche Rendererprovenienz verbleibt. Die Originalressource bleibt unverändert archiviert.

## Beispiel

```text
Quelle:  Dosage.text = "1-0-0-0"
Ziel:    Dosage.text = "täglich: 1-0-0-0"
```

Auch ein optionaler Einheitstext bleibt erhalten:

```text
Quelle:  1-0-0-0 Stück
Ziel:    täglich: 1-0-0-0 Stück
```

## Prüffälle

- Vorher matcht der Constraint; nach dem Präfix matcht er nicht mehr.
- `1-0-0` matcht nicht, weil nur drei Slots vorhanden sind; M04 ändert den Text nicht.
- Ein Text mit weiterem Zusatz, der den vollständigen Ausdruck nicht erfüllt, wird nicht geändert.
- Ein zweiter Migrationslauf fügt kein zweites Präfix hinzu, weil der Zieltext nicht mehr matcht.
