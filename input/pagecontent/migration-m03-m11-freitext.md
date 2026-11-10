[Zur Migrationsübersicht](./migration-1.0.7-2.0.0.html)

### Anlass

M03 (`DosageDoseValuePositive`) und M11 (`TimingValuesPositive`) beanstanden einen Dosiswert von null oder kleiner beziehungsweise eine Periode von null oder eine Behandlungsdauer von null oder kleiner. Für diese Dosierungen wird der vorhandene Dosierungstext der Quelle als Freitext übernommen. Die fehlerhaften strukturierten Werte werden nicht korrigiert.

### Überführung

1. **Text übernehmen:** Den Wert von `renderedDosageInstruction` der Quelle als `Dosage.text` übernehmen. In 1.0.7 ist `renderedDosageInstruction` bei strukturierten Dosierungen Pflicht (`DosageStructuredRequiresGeneratedText`).
2. **Struktur verwerfen:** Die gesamte Dosierungsliste durch genau ein `Dosage`-Element ersetzen, das nur `text` enthält. `timing`, `doseAndRate` und die übrigen Dosierungsfelder entfallen. Die gesamte Liste wird ersetzt, weil Freitext in 2.0.0 nur in einem einzelnen `Dosage`-Element zulässig ist (`FreeTextSingleDosageOnly`).
3. **Wie reinen Freitext behandeln:** Weiter mit Schritt 2 des [Ablaufs](./migration-1.0.7-2.0.0.html#ablauf): Besteht der Text nur aus einem 4-Schema, wird [M04](./migration-m04-viererschema-freitext.html) angewendet; danach werden die Text-Extensions gesetzt.

Der Text wird nicht neu erzeugt und nicht als strukturierte Dosierung interpretiert. Dosis- und Zeitwerte werden weder angepasst noch umgerechnet.

### Beispiele

Texte, die der Algorithmus 1.0.1 für solche Dosierungen erzeugt hat:

- Dosis `0`: `0-0-0-0 Stück` wird nach M04 zu `täglich: 0-0-0-0 Stück`.
- Dosis `-1`: `-1-0-0-0 Stück` bleibt unverändert, der Text ist kein reines 4-Schema.
- Periode `0`: `alle 0 Tage: je 1 Stück` bleibt unverändert.
