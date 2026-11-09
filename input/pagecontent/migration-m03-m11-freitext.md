[Zur Migrationsübersicht](./migration-1.0.7-2.0.0.html)

### Anlass

M03 (`DosageDoseValuePositive`) und M11 (`TimingValuesPositive`) beanstanden einen Dosiswert von null oder kleiner beziehungsweise eine Periode von null oder eine Behandlungsdauer von null oder kleiner. Bei diesen Fällen wird die Textgenerierung trotz der verletzten Zielprofil-Invariante ausgeführt. Der erzeugte Text bildet die Quelldosierung ab; die fehlerhaften strukturierten Werte werden nicht korrigiert. Vorher muss M10 erfolgreich behandelt sein. Bei mehreren unterschiedlichen `boundsDuration`-Werten oder Codes wird die Migration nach [M10](./migration-m10-einheitlicher-zeitrahmen.html) abgebrochen, bevor ein möglicherweise unvollständiger Text erzeugt wird.

### Überführung

1. **Dosierungsliste rendern:** Den Dosierungstext mit der [Textgenerierung](./dosierung-textgenerierung.html) aus allen `Dosage`-Elementen der Ressource erzeugen. Eine vorhandene `renderedDosageInstruction` der Quelle wird nicht übernommen.
2. **Struktur verwerfen:** Die gesamte Dosierungsliste durch genau ein `Dosage`-Element ersetzen, das nur `text` mit dem erzeugten Text enthält. `timing`, `doseAndRate` und die übrigen Dosierungsfelder entfallen. Die gesamte Liste wird ersetzt, weil Freitext in 2.0.0 nur in einem einzelnen `Dosage`-Element zulässig ist (`FreeTextSingleDosageOnly`).
3. **M04 erneut prüfen:** Den neu erzeugten `Dosage.text` gegen M04 prüfen. Besteht er ausschließlich aus einem 4-Schema, [M04](./migration-m04-viererschema-freitext.html) anwenden und `täglich: ` voranstellen.
4. **Text-Extensions setzen:** `renderedDosageInstruction` auf exakt den endgültigen `Dosage.text` setzen. `GeneratedDosageInstructionsMeta` muss die verwendete Sprache und Algorithmusversion enthalten.

Der in diesem Ablauf erzeugte Freitext wird nicht erneut als strukturierte Dosierung interpretiert. Insbesondere werden weder Dosis- noch Zeitwerte angepasst oder umgerechnet.

### Beispielablauf

```text
Quelle:  Dosierungsliste verletzt M03 oder M11
         -> Text aus der gesamten Liste erzeugen
         -> Liste durch ein Dosage-Element mit text ersetzen
         -> M04 auf diesen Text prüfen und ggf. "täglich: " voranstellen
Ziel:    ein Dosage-Element mit text, ohne timing und doseAndRate
         renderedDosageInstruction = derselbe endgültige Text
```