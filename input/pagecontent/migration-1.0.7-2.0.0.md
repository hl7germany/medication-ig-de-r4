Diese Seite beschreibt, wie Dosierungen aus dem dgMP-Profilstand 1.0.7 technisch in den Profilstand 2.0.0 überführt werden. Beschrieben wird ausschließlich die Abbildung der FHIR-Strukturen. Wie ein System die Migration organisiert, ob und wie es Quelldaten aufbewahrt, protokolliert oder mit nicht überführbaren Daten umgeht, liegt beim jeweiligen System und ist nicht Gegenstand dieses Leitfadens.

**Grundsatz:** Die Überführung erhält die Aussage der Quelldosierung. Zahlenwerte werden nicht gerundet und nicht in andere Einheiten umgerechnet. Neue Angaben werden nur in zwei Fällen ergänzt: Ein vorhandenes `boundsDuration` wird in die übrigen `Dosage`-Elemente kopiert ([M10](./migration-m10-einheitlicher-zeitrahmen.html)), und einem reinen 4-Schema im Freitext wird `täglich: ` vorangestellt ([M04](./migration-m04-viererschema-freitext.html)). Bei M03 und M11 wird der vorhandene Dosierungstext der Quelle als Freitext übernommen ([M03/M11](./migration-m03-m11-freitext.html)). Für andere nicht überführbare strukturierte Dosierungen gilt der [Freitext-Fallback](#freitext-fallback).

### Geltungsbereich

| Ressourcentyp | Dosierungsfeld |
|---|---|
| `MedicationRequest` | `dosageInstruction` |
| `MedicationDispense` | `dosageInstruction` |
| `MedicationStatement` | `dosage` |

Betrachtet werden Dosierungen, die dem `DosageDgMP`-/`TimingDgMP`-Profil 1.0.7 entsprechen. Bestandsdaten, die bereits das Profil 1.0.7 verletzen, sind nicht Gegenstand der Überführung (siehe Abschnitt „Nicht Gegenstand der Überführung“).

Ressourcenelemente außerhalb der Dosierung und der Text-Extensions bleiben unverändert.

### Ablauf

Eine Dosierungs-Liste kann mehrere `Dosage`-Elemente enthalten, und jedes Element kann mehrere der unten aufgeführten Fälle aufweisen. Die Fall-IDs (M01–M13) sind nur Kennungen für die Unterschiede zwischen 1.0.7 und 2.0.0; ihre Nummern geben **keine Reihenfolge** vor. Maßgeblich ist der folgende Ablauf, der immer die gesamte Dosierungs-Liste einer Ressource betrachtet.

1. **Keine Dosierung vorhanden:** Es wird keine Dosierung ergänzt. Sind `renderedDosageInstruction` oder `GeneratedDosageInstructionsMeta` ohne Dosierung vorhanden, werden sie entfernt (M12).
2. **Reiner Freitext:** Mehrere gleiche Freitext-Elemente werden zu einem zusammengefasst (M13). `Dosage.text` wird übernommen; besteht der Text nur aus einem 4-Schema (zum Beispiel `1-0-1-0 Stück`), wird er nach [M04](./migration-m04-viererschema-freitext.html) behandelt. Auf Ressourcenebene werden `renderedDosageInstruction` mit exakt diesem Text sowie `GeneratedDosageInstructionsMeta` gesetzt (`DosageRequiresGeneratedText`, `FreeTextMatchesRenderedText`, siehe Abschnitt „Text-Extensions“).
3. **Strukturierte Dosierung normalisieren:** In jedem `Dosage`-Element wird die Exponentialschreibweise nach [M02](./migration-m02-exponentialnotation.html) normalisiert. Weitere Änderungen an den Werten finden nicht statt.
4. **M10 behandeln:** Enthält nur ein Teil der Elemente ein `boundsDuration`, wird es nach [M10](./migration-m10-einheitlicher-zeitrahmen.html) in die übrigen Elemente kopiert.
5. **M03/M11 behandeln:** Verletzt mindestens ein Element der normalisierten Liste M03 oder M11, wird die gesamte Liste nach [M03/M11](./migration-m03-m11-freitext.html) durch ein Freitext-Element mit dem vorhandenen Dosierungstext ersetzt und wie in Schritt 2 weiterbehandelt.
6. **Gesamte Liste prüfen:** Erfüllt die verbleibende strukturierte Dosierungs-Liste die Regeln des 2.0.0-Profils (abgesehen von den Text-Extensions, die erst in diesem Schritt gesetzt werden), bleibt sie strukturiert. Der Dosierungstext wird nach der [Textgenerierung](./dosierung-textgenerierung.html) neu erzeugt; `renderedDosageInstruction` und `GeneratedDosageInstructionsMeta` werden durch die neu erzeugten Werte ersetzt.
7. **Sonst Freitext-Fallback:** Verletzt mindestens ein `Dosage`-Element oder die Liste als Ganzes weiterhin eine Invariante des Zielprofils, wird für die **gesamte** Liste der [Freitext-Fallback](#freitext-fallback) angewendet. M03 und M11 werden bereits in Schritt 5 behandelt.

Das Ergebnis ist eine Ressource, die dem 2.0.0-Profil entspricht. Ausgenommen sind die im Abschnitt „Nicht Gegenstand der Überführung“ genannten Daten.

### Fallübersicht

| Fall | Invariante | Anlass | Überführung | Details |
|---|---|---|---|---|
| M01 | `DosageDoseQuantityAllowedFractions`, `DosageDoseValueDecimalNotation` | Dosiswert mit einem Bruchteil außer `.125`, `.25`, `.33`, `.5`, `.66`, `.75` oder mit mehr als drei Nachkommastellen | Freitext-Fallback | [Freitext-Fallback](#freitext-fallback) |
| M02 | `DosageDoseValueDecimalNotation` | Exponentialschreibweise im Quellpayload | Exakte Dezimalnormalisierung | [M02](./migration-m02-exponentialnotation.html) |
| M03 | `DosageDoseValuePositive` | Dosiswert null oder negativ | Vorhandenen Dosierungstext als Freitext übernehmen | [M03/M11](./migration-m03-m11-freitext.html) |
| M04 | `DosageFourSlotPatternInText` | Freitext besteht nur aus einem 4-Schema | `täglich: ` voranstellen | [M04](./migration-m04-viererschema-freitext.html) |
| M05 | `TimingBoundsDurationOnlyWholeNumber` | Nicht ganzzahlige Behandlungsdauer | Freitext-Fallback | [Freitext-Fallback](#freitext-fallback) |
| M06 | `TimingPeriodOnlyWholeNumber` | Nicht ganzzahlige Periode | Freitext-Fallback | [Freitext-Fallback](#freitext-fallback) |
| M07 | `TimingFreqOrPeriodGtOne` | Reines Intervall, Frequenz und Periode beide größer als eins (zum Beispiel „2 x alle 3 Tage“) | Freitext-Fallback | [Freitext-Fallback](#freitext-fallback) |
| M08 | `TimingSingleDosageForTimeOfDay` | Uhrzeiten (ohne Wochentage) auf mehrere `Dosage`-Elemente verteilt, deren Dosen nicht paarweise verschieden sind. Neu erfasst werden teilweise gleiche Dosen (zum Beispiel `1`, `1`, `2`) und Intervall-Kombinationen mit einer Periode ungleich 1 Tag | Freitext-Fallback | [Freitext-Fallback](#freitext-fallback) |
| M09 | `TimingSingleDosageForWhen` | Wie M08, für Tagesabschnitte (`when`) | Freitext-Fallback | [Freitext-Fallback](#freitext-fallback) |
| M10 | `TimingOnlyOneBounds` | `boundsDuration` nur an einem Teil der `Dosage`-Elemente | `boundsDuration` in die übrigen Elemente kopieren | [M10](./migration-m10-einheitlicher-zeitrahmen.html) |
| M11 | `TimingValuesPositive` | Periode null oder Behandlungsdauer null oder negativ (eine negative Periode schließt bereits die R4-Basisregel `tim-5` aus) | Vorhandenen Dosierungstext als Freitext übernehmen | [M03/M11](./migration-m03-m11-freitext.html) |
| M12 | `ExtRequiresDosage-MR`, `ExtRequiresDosage-MD`, `ExtRequiresDosage-MS` | Text-Extension ohne Dosierung | Extensions entfernen | Schritt 1 des Ablaufs |
| M13 | `FreeTextSingleDosageOnly` | Mehrere `Dosage`-Elemente mit demselben Freitext | Zu einem Element zusammenfassen | Schritt 2 des Ablaufs |

Bei M01 und M05–M07 werden die Werte weder gerundet noch in andere Einheiten umgerechnet noch umgedeutet, auch wenn eine exakte Umrechnung möglich wäre (zum Beispiel eine Periode von `1.5 d` in `36 h`). „2 x alle 3 Tage“ wird also weder zu „alle 1,5 Tage“ noch zu „alle 36 Stunden“. Die Überführung erhält die Angabe der Quelle, wie sie verordnet wurde; deshalb gilt dort der Freitext-Fallback. Bei M10 wird ausschließlich ein bereits vorhandener Wert wiederholt; er wird nicht verändert.

### Freitext-Fallback

Der Freitext-Fallback gilt, wenn eine strukturierte 1.0.7-Dosierungs-Liste nach den Schritten M02 und M10 weiterhin mindestens eine Invariante des 2.0.0-Profils verletzt. M03 und M11 werden stattdessen nach dem eigenen Ablauf [M03/M11](./migration-m03-m11-freitext.html) behandelt. Die übrigen Fälle und ihre Invarianten stehen in der Fallübersicht. Die Dosierung wird dann als reine Freitext-Dosierung abgebildet. Zahlen, Einheiten und Zeitangaben werden dabei weder korrigiert noch umgerechnet; der Freitext gibt die Quelldosierung so wieder, wie sie strukturiert angegeben war.

#### Abbildung

1. **Text erzeugen:** Der Text wird immer mit der [Textgenerierung](./dosierung-textgenerierung.html) aus **allen** `Dosage`-Elementen der Quelle im Zustand nach den Schritten [M02](./migration-m02-exponentialnotation.html) und [M10](./migration-m10-einheitlicher-zeitrahmen.html) erzeugt, mit der tatsächlich verwendeten Algorithmusversion (in dieser Beschreibung `2.0.0`). Eine vorhandene `renderedDosageInstruction` der Quellressource wird nicht übernommen, da Bestandsdaten häufig fehlerhaft sind und der Text sonst nicht zur Struktur passen muss.
2. **Dosierung ersetzen:** Die gesamte Dosierungs-Liste wird durch genau ein `Dosage`-Element ersetzt, das nur `text` mit dem Text aus Schritt 1 enthält, also ohne `timing` und ohne `doseAndRate` (`DosageStructuredOrFreeText`, `FreeTextSingleDosageOnly`).
3. **4-Schema prüfen:** Besteht der Text nur aus einem 4-Schema (zum Beispiel `1-0-1-0 Stück`), wird [M04](./migration-m04-viererschema-freitext.html) angewendet.
4. **Text-Extensions setzen:** `renderedDosageInstruction` erhält exakt den Wert von `Dosage.text`. `GeneratedDosageInstructionsMeta` gibt die Sprache und die Algorithmusversion an, mit der der Text in Schritt 1 erzeugt wurde.

#### Abweichung von der Vorbedingung der Textgenerierung

Die [Textgenerierung](./dosierung-textgenerierung.html) setzt grundsätzlich eine gegen das Profil validierte Ressource voraus. Im Freitext-Fallback wird sie abweichend davon auf eine Quelle angewendet, die das 2.0.0-Profil nicht erfüllt. Diese Ausnahme gilt nur für den Freitext-Fallback der Migration. Der erzeugte Text wird nicht als strukturierte Dosierung verwendet, sondern nur als Freitext übernommen.

Bricht die Textgenerierung ab oder liefert sie keinen Text, beschreibt dieser Leitfaden keine Abbildung; wie das System damit umgeht, entscheidet es selbst.

#### Beispieltexte

Die Textgenerierung liefert je nach Quellstruktur zum Beispiel:

- M01, Dosis `1.2 Stück`: `täglich: je 1,2 Stück`
- M05, Behandlungsdauer `1.5 d`: `für 1,5 Tage täglich: je 1 Stück`
- M06, Periode `1.5 d`: `alle 1,5 Tage: je 1 Stück`
- M07, Frequenz 2 bei Periode `3 d`: `2 x alle 3 Tage: je 1 Stück`

#### Beispiel

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

### Text-Extensions

Für 2.0.0 sind `renderedDosageInstruction` und `GeneratedDosageInstructionsMeta` bei jeder Dosierung erforderlich, auch bei Freitext (`DosageRequiresGeneratedText`). Bei Freitext stimmt `renderedDosageInstruction` exakt mit `Dosage.text` überein (`FreeTextMatchesRenderedText`). Die Umstellung von `DosageStructuredRequiresGeneratedText` auf `DosageRequiresGeneratedText` ist daher nicht nur eine Umbenennung: Auch bestehende Freitext-Dosierungen erhalten beide Extensions.

`GeneratedDosageInstructionsMeta` enthält die Sprache und in `algorithmVersion` die tatsächlich verwendete Version des Algorithmus der [Textgenerierung](./dosierung-textgenerierung.html). Das gilt auch für übernommenen Freitext, da die Textgenerierung einen Freitext unverändert übernimmt. Die Beispiele dieser Migrationsbeschreibung verwenden die Algorithmusversion `2.0.0`.

### Nicht Gegenstand der Überführung

Für die folgenden Bestandsdaten beschreibt dieser Leitfaden keine Abbildung. Wie ein System mit ihnen umgeht, entscheidet es selbst.

- **Dosierungen, die bereits das Profil 1.0.7 verletzen**, zum Beispiel doppelte Tagesabschnitte oder Uhrzeiten, gemischte Tagesabschnitte und Uhrzeiten, fehlendes `timing` oder `doseAndRate`, unterschiedliche Dosis-Codes oder eine Anzeigeeinheit der Behandlungsdauer, die nicht zum UCUM-Code passt. Ihre Ungültigkeit ist keine Folge des Profilwechsels.
- **Dosisangaben ohne Zahlenwert:** `doseQuantity.value` ist in 2.0.0 Pflicht, in 1.0.7 war es optional. Ohne Zahlenwert lässt sich weder eine strukturierte Dosierung noch ein Dosierungstext bilden.
- **Dosierungen, für die die Textgenerierung im Freitext-Fallback keinen Text liefert** (siehe [Freitext-Fallback](#freitext-fallback)).

### Einheiten

Zeit- und Dosiseinheiten werden nicht umgerechnet. `value`, `system` und `code` von Dosis-, Perioden- und Dauerangaben bleiben unverändert, ebenso die Anzeige `unit`. Für `periodUnit` erlaubt das Ziel-ValueSet `min`, `h`, `d`, `wk` und `mo` (in 1.0.7 nur `d`, `wk` und `mo`), für `boundsDuration` die Codes `d`, `wk`, `mo` und `a`.
