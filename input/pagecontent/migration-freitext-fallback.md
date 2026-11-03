[Zur Migrationsübersicht](./migration-1.0.7-2.0.0.html)

Der Freitext-Fallback gilt, wenn eine strukturierte 1.0.7-Dosierungs-Liste nach der Normalisierung M02 weiterhin mindestens eine Invariante des 2.0.0-Profils verletzt. Die Fälle und ihre Invarianten stehen in der [Fallübersicht](./migration-1.0.7-2.0.0.html). Die Dosierung wird dann als reine Freitext-Dosierung abgebildet. Zahlen, Einheiten und Zeitangaben werden dabei weder korrigiert noch umgerechnet; der Freitext gibt die Quelldosierung so wieder, wie sie strukturiert angegeben war.

### Abbildung

1. **Text erzeugen:** Der Text wird immer mit der [Textgenerierung](./dosierung-textgenerierung.html) aus **allen** `Dosage`-Elementen der Quelle im Zustand nach der Normalisierung [M02](./migration-m02-exponentialnotation.html) erzeugt, mit der tatsächlich verwendeten Algorithmusversion (in dieser Beschreibung `2.0.0`). Eine vorhandene `renderedDosageInstruction` der Quellressource wird nicht übernommen, da Bestandsdaten häufig fehlerhaft sind und der Text sonst nicht zur Struktur passen muss.
2. **Dosierung ersetzen:** Die gesamte Dosierungs-Liste wird durch genau ein `Dosage`-Element ersetzt, das nur `text` mit dem Text aus Schritt 1 enthält, also ohne `timing` und ohne `doseAndRate` (`DosageStructuredOrFreeText`, `FreeTextSingleDosageOnly`).
3. **4-Schema prüfen:** Besteht der Text nur aus einem 4-Schema (zum Beispiel `1-0-1-0 Stück`), wird [M04](./migration-m04-viererschema-freitext.html) angewendet.
4. **Text-Extensions setzen:** `renderedDosageInstruction` erhält exakt den Wert von `Dosage.text`. `GeneratedDosageInstructionsMeta` gibt die Sprache und die Algorithmusversion an, mit der der Text in Schritt 1 erzeugt wurde.

### Abweichung von der Vorbedingung der Textgenerierung

Die [Textgenerierung](./dosierung-textgenerierung.html) setzt grundsätzlich eine gegen das Profil validierte Ressource voraus. Im Freitext-Fallback wird sie abweichend davon auf eine Quelle angewendet, die das 2.0.0-Profil nicht erfüllt. Diese Ausnahme gilt nur für den Freitext-Fallback der Migration. Der erzeugte Text wird nicht als strukturierte Dosierung verwendet, sondern nur als Freitext übernommen.

Bricht die Textgenerierung ab oder liefert sie keinen Text (zum Beispiel bei `Dosage`-Elementen mit unterschiedlichen Schemata), beschreibt dieser Leitfaden keine Abbildung; wie das System damit umgeht, entscheidet es selbst.

### Beispieltexte

Die Textgenerierung liefert je nach Quellstruktur zum Beispiel:

- M01, Dosis `1.2 Stück`: `täglich: je 1,2 Stück`
- M05, Behandlungsdauer `1.5 d`: `für 1,5 Tage täglich: je 1 Stück`
- M06, Periode `1.5 d`: `alle 1,5 Tage: je 1 Stück`
- M07, Frequenz 2 bei Periode `3 d`: `2 x alle 3 Tage: je 1 Stück`

### Beispiel

Quelle (1.0.7), `MedicationRequest`:

```text
dosageInstruction[0].doseAndRate.doseQuantity = 1.2 Stück
dosageInstruction[0].timing.repeat           = frequency 1, period 1, periodUnit d
renderedDosageInstruction                    = "täglich: je 1,2 Stück"
GeneratedDosageInstructionsMeta              = language de-DE, algorithmVersion <Version der Quelle>
```

Die Quellangabe `renderedDosageInstruction` wird nicht übernommen; der Text wird neu aus `dosageInstruction` erzeugt.

Ziel (2.0.0):

```text
dosageInstruction[0].text                    = "täglich: je 1,2 Stück"
renderedDosageInstruction                    = "täglich: je 1,2 Stück"
GeneratedDosageInstructionsMeta              = language de-DE, algorithmVersion 2.0.0
```

`timing` und `doseAndRate` entfallen. Der Wert `1.2` wird nicht gerundet und nicht in eine andere Einheit umgerechnet.
