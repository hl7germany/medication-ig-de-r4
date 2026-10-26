[Zur Migrationsübersicht](./migration-1.0.7-2.0.0.html)

### Anlass

`DosageFourSlotPatternInText` verbietet in 2.0.0 einen Freitext, der ausschließlich aus einem 4-Schema besteht, zum Beispiel `1-0-1-0` oder `1-0-1-0 Stück`. Ein 4-Schema innerhalb eines weiteren Textes, etwa in der Form `täglich: 1-0-1-0 Stück`, löst nur die Warnung `DosageFourSlotPatternInTextWarning` aus.

### Auslöser

`Dosage.text` erfüllt den regulären Ausdruck aus `DosageFourSlotPatternInText`. Er steht hier ohne das String-Escaping des FHIRPath-Ausdrucks:

```text
^\s*\d+([.,]\d+)?(\s*/\s*\d+)?(\s*[-–]\s*\d+([.,]\d+)?(\s*/\s*\d+)?){3}(\s*[A-Za-zÄÖÜäöüß().]+)?\s*$
```

M04 gilt für bestehende Freitext-Dosierungen ebenso wie für einen Text, der im [Freitext-Fallback](./migration-freitext-fallback.html) entsteht.

### Überführung

1. Dem Text ohne führende und nachfolgende Leerzeichen `täglich: ` voranstellen. Der übrige Text bleibt unverändert.
2. `renderedDosageInstruction` auf exakt denselben Text setzen und `GeneratedDosageInstructionsMeta` angeben (siehe [Text-Extensions](./migration-1.0.7-2.0.0.html)).

Der Text wird nicht in eine strukturierte Dosierung umgewandelt.

Das Voranstellen von `täglich: ` ist die einzige Ergänzung, die die Überführung vornimmt. Sie löst den Konflikt mit `DosageFourSlotPatternInText` und entspricht der Form, in der die Textgenerierung 2.0.0 ein strukturiertes 4-Schema ausgibt (zum Beispiel `täglich: 1-0-1-0 Stück`).

### Beispiel

```text
Quelle:  Dosage.text = "1-0-1-0 Stück"
Ziel:    Dosage.text = "täglich: 1-0-1-0 Stück"
         renderedDosageInstruction = "täglich: 1-0-1-0 Stück"
```

### Prüffälle

- `1-0-1-0` wird `täglich: 1-0-1-0`.
- `1/2-0-0-1 Stück` wird `täglich: 1/2-0-0-1 Stück`.
- `1-0-0` hat nur drei Slots und bleibt unverändert.
- `morgens 1-0-0-0` erfüllt den Ausdruck nicht und bleibt unverändert.
