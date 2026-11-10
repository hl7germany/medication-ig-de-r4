Diese Seite beschreibt, wie Dosierungen aus dem dgMP-Profilstand 1.0.7 technisch in den Profilstand 2.0.0 überführt werden. Beschrieben wird ausschließlich die Abbildung der FHIR-Strukturen. Wie ein System die Migration organisiert, ob und wie es Quelldaten aufbewahrt, protokolliert oder mit nicht überführbaren Daten umgeht, liegt beim jeweiligen System und ist nicht Gegenstand dieses Leitfadens.

**Grundsatz:** Die Überführung erhält die Aussage der Quelldosierung. Zahlenwerte werden nicht gerundet und nicht in andere Einheiten umgerechnet. Neue Angaben werden nur in zwei Fällen ergänzt: Ein vorhandenes `boundsDuration` wird in die übrigen `Dosage`-Elemente kopiert ([M10](#m10)), und einem reinen 4-Schema im Freitext wird `täglich: ` vorangestellt ([M04](#m04)). Doppelte Werte innerhalb eines `Dosage`-Elements werden zusammengeführt und `frequency` wird an die verbleibenden Werte angepasst ([M14](#m14)). Bei M03 und M11 wird der vorhandene Dosierungstext der Quelle als Freitext übernommen ([M03/M11](#m03-m11)). Für andere nicht überführbare strukturierte Dosierungen gilt der [Freitext-Fallback](#freitext-fallback).

### Geltungsbereich

| Ressourcentyp | Dosierungsfeld |
|---|---|
| `MedicationRequest` | `dosageInstruction` |
| `MedicationDispense` | `dosageInstruction` |
| `MedicationStatement` | `dosage` |

Betrachtet werden Dosierungen, die dem `DosageDgMP`-/`TimingDgMP`-Profil 1.0.7 entsprechen. Bestandsdaten, die bereits das Profil 1.0.7 verletzen, sind nicht Gegenstand der Überführung (siehe Abschnitt „Nicht Gegenstand der Überführung“).

Ressourcenelemente außerhalb der Dosierung und der Text-Extensions bleiben unverändert.

### Ablauf

Eine Dosierungs-Liste kann mehrere `Dosage`-Elemente enthalten, und jedes Element kann mehrere der unten aufgeführten Fälle aufweisen. Die Fall-IDs (M01–M14) sind nur Kennungen für die Unterschiede zwischen 1.0.7 und 2.0.0; ihre Nummern geben **keine Reihenfolge** vor. Maßgeblich ist der folgende Ablauf, der immer die gesamte Dosierungs-Liste einer Ressource betrachtet.

1. **Keine Dosierung vorhanden:** Es wird keine Dosierung ergänzt. Sind `renderedDosageInstruction` oder `GeneratedDosageInstructionsMeta` ohne Dosierung vorhanden, werden sie entfernt (M12).
2. **Reiner Freitext:** Mehrere gleiche Freitext-Elemente werden zu einem zusammengefasst (M13). `Dosage.text` wird übernommen; besteht der Text nur aus einem 4-Schema (zum Beispiel `1-0-1-0 Stück`), wird er nach [M04](#m04) behandelt. Auf Ressourcenebene werden `renderedDosageInstruction` mit exakt diesem Text sowie `GeneratedDosageInstructionsMeta` gesetzt (`DosageRequiresGeneratedText`, `FreeTextMatchesRenderedText`, siehe Abschnitt „Text-Extensions“).
3. **Strukturierte Dosierung normalisieren:** In jedem `Dosage`-Element wird die Exponentialschreibweise nach [M02](#m02) normalisiert, und doppelte Werte werden nach [M14](#m14) zusammengeführt. Weitere Änderungen an den Werten finden nicht statt.
4. **M10 behandeln:** Enthält nur ein Teil der Elemente ein `boundsDuration`, wird es nach [M10](#m10) in die übrigen Elemente kopiert.
5. **M03/M11 behandeln:** Verletzt mindestens ein Element der normalisierten Liste M03 oder M11, wird die gesamte Liste nach [M03/M11](#m03-m11) durch ein Freitext-Element mit dem vorhandenen Dosierungstext ersetzt und wie in Schritt 2 weiterbehandelt.
6. **Gesamte Liste prüfen:** Erfüllt die verbleibende strukturierte Dosierungs-Liste die Regeln des 2.0.0-Profils (abgesehen von den Text-Extensions, die erst in diesem Schritt gesetzt werden), bleibt sie strukturiert. Der Dosierungstext wird nach der [Textgenerierung](./dosierung-textgenerierung.html) neu erzeugt; `renderedDosageInstruction` und `GeneratedDosageInstructionsMeta` werden durch die neu erzeugten Werte ersetzt.
7. **Sonst Freitext-Fallback:** Verletzt mindestens ein `Dosage`-Element oder die Liste als Ganzes weiterhin eine Invariante des Zielprofils, wird für die **gesamte** Liste der [Freitext-Fallback](#freitext-fallback) angewendet. M03 und M11 werden bereits in Schritt 5 behandelt.

Das Ergebnis ist eine Ressource, die dem 2.0.0-Profil entspricht. Ausgenommen sind die im Abschnitt „Nicht Gegenstand der Überführung“ genannten Daten.

### Fallübersicht

| Fall | Invariante | Anlass | Überführung | Details |
|---|---|---|---|---|
| M01 | `DosageDoseQuantityAllowedFractions`, `DosageDoseValueDecimalNotation` | Dosiswert mit einem Bruchteil außer `.125`, `.25`, `.33`, `.5`, `.66`, `.75` oder mit mehr als drei Nachkommastellen | Freitext-Fallback | [Freitext-Fallback](#freitext-fallback) |
| M02 | `DosageDoseValueDecimalNotation` | Exponentialschreibweise im Quellpayload | Exakte Dezimalnormalisierung | [M02](#m02) |
| M03 | `DosageDoseValuePositive` | Dosiswert null oder negativ | Vorhandenen Dosierungstext als Freitext übernehmen | [M03/M11](#m03-m11) |
| M04 | `DosageFourSlotPatternInText` | Freitext besteht nur aus einem 4-Schema | `täglich: ` voranstellen | [M04](#m04) |
| M05 | `TimingBoundsDurationOnlyWholeNumber` | Nicht ganzzahlige Behandlungsdauer | Freitext-Fallback | [Freitext-Fallback](#freitext-fallback) |
| M06 | `TimingPeriodOnlyWholeNumber` | Nicht ganzzahlige Periode | Freitext-Fallback | [Freitext-Fallback](#freitext-fallback) |
| M07 | `TimingFreqOrPeriodGtOne` | Reines Intervall, Frequenz und Periode beide größer als eins (zum Beispiel „2 x alle 3 Tage“) | Freitext-Fallback | [Freitext-Fallback](#freitext-fallback) |
| M08 | `TimingSingleDosageForTimeOfDay` | Uhrzeiten (ohne Wochentage) auf mehrere `Dosage`-Elemente verteilt, deren Dosen nicht paarweise verschieden sind. Neu erfasst werden teilweise gleiche Dosen (zum Beispiel `1`, `1`, `2`) und Intervall-Kombinationen mit einer Periode ungleich 1 Tag | Freitext-Fallback | [Freitext-Fallback](#freitext-fallback) |
| M09 | `TimingSingleDosageForWhen` | Wie M08, für Tagesabschnitte (`when`) | Freitext-Fallback | [Freitext-Fallback](#freitext-fallback) |
| M10 | `TimingOnlyOneBounds` | `boundsDuration` nur an einem Teil der `Dosage`-Elemente | `boundsDuration` in die übrigen Elemente kopieren | [M10](#m10) |
| M11 | `TimingValuesPositive` | Periode null oder Behandlungsdauer null oder negativ (eine negative Periode schließt bereits die R4-Basisregel `tim-5` aus) | Vorhandenen Dosierungstext als Freitext übernehmen | [M03/M11](#m03-m11) |
| M12 | `ExtRequiresDosage-MR`, `ExtRequiresDosage-MD`, `ExtRequiresDosage-MS` | Text-Extension ohne Dosierung | Extensions entfernen | Schritt 1 des Ablaufs |
| M13 | `FreeTextSingleDosageOnly` | Mehrere `Dosage`-Elemente mit demselben Freitext | Zu einem Element zusammenfassen | Schritt 2 des Ablaufs |
| M14 | `TimingNoDuplicateValues` | Wochentage mit Tagesabschnitten oder Uhrzeiten, bei denen ein `Dosage`-Element denselben Wochentag, Tagesabschnitt oder dieselbe Uhrzeit mehrfach enthält (zum Beispiel montags `MORN`, `MORN` mit `frequency = 2`). In den übrigen Schemata schloss das bereits 1.0.7 aus | Doppelte Werte zusammenführen, `frequency` anpassen | [M14](#m14) |

Bei M01 und M05–M07 werden die Werte weder gerundet noch in andere Einheiten umgerechnet noch umgedeutet, auch wenn eine exakte Umrechnung möglich wäre (zum Beispiel eine Periode von `1.5 d` in `36 h`). „2 x alle 3 Tage“ wird also weder zu „alle 1,5 Tage“ noch zu „alle 36 Stunden“. Die Überführung erhält die Angabe der Quelle, wie sie verordnet wurde; deshalb gilt dort der Freitext-Fallback. Bei M10 wird ausschließlich ein bereits vorhandener Wert wiederholt; er wird nicht verändert.

### Freitext-Fallback

Der Freitext-Fallback gilt, wenn eine strukturierte 1.0.7-Dosierungs-Liste nach den Schritten M02, M14 und M10 weiterhin mindestens eine Invariante des 2.0.0-Profils verletzt. M03 und M11 werden stattdessen nach dem eigenen Ablauf [M03/M11](#m03-m11) behandelt. Die übrigen Fälle und ihre Invarianten stehen in der Fallübersicht. Die Dosierung wird dann als reine Freitext-Dosierung abgebildet. Zahlen, Einheiten und Zeitangaben werden dabei weder korrigiert noch umgerechnet; der Freitext gibt die Quelldosierung so wieder, wie sie strukturiert angegeben war.

#### Abbildung

1. **Text erzeugen:** Der Text wird immer mit der [Textgenerierung](./dosierung-textgenerierung.html) aus **allen** `Dosage`-Elementen der Quelle im Zustand nach den Schritten [M02](#m02), [M14](#m14) und [M10](#m10) erzeugt, mit der tatsächlich verwendeten Algorithmusversion (in dieser Beschreibung `2.0.0`). Eine vorhandene `renderedDosageInstruction` der Quellressource wird nicht übernommen, da Bestandsdaten häufig fehlerhaft sind und der Text sonst nicht zur Struktur passen muss.
2. **Dosierung ersetzen:** Die gesamte Dosierungs-Liste wird durch genau ein `Dosage`-Element ersetzt, das nur `text` mit dem Text aus Schritt 1 enthält, also ohne `timing` und ohne `doseAndRate` (`DosageStructuredOrFreeText`, `FreeTextSingleDosageOnly`).
3. **4-Schema prüfen:** Besteht der Text nur aus einem 4-Schema (zum Beispiel `1-0-1-0 Stück`), wird [M04](#m04) angewendet.
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

### M02 – Exponentialschreibweise {#m02}

#### Anlass

`DosageDoseValueDecimalNotation` verlangt eine einfache Dezimalschreibweise mit höchstens drei Nachkommastellen. Die Prüfung verwendet `value.toString()`. Ob dabei eine JSON-Exponentialnotation erkannt wird, hängt vom Parser ab: Nach gewöhnlichem JSON-Parsen sind `5e-1` und `0.5` derselbe Zahlenwert. M02 betrifft deshalb die Serialisierung im Quellpayload, nicht nur den geparsten Wert.

#### Auslöser

Ein Dosiswert ist im Quellpayload mit Exponent serialisiert, zum Beispiel `5e-1` oder `50e-2`.

#### Überführung

1. Den Wert dezimalgenau einlesen, ohne binäre Gleitkommaarithmetik.
2. Den Wert ohne Exponent serialisieren und dabei die Stellenzahl der Mantisse erhalten: `5e-1` → `0.5`, `50e-2` → `0.50`. Es wird nicht gerundet. FHIR behandelt die Genauigkeit eines `decimal` einschließlich nachfolgender Nullen als Teil des Werts, und die Textgenerierung gibt sie wieder (`je 0,50 Stück`).
3. Mit dem normalisierten Wert weiter nach dem [Ablauf](#ablauf) verfahren.

#### Beispiel

Quelle:

```json
{"value": 5e-1, "unit": "Stück"}
```

Ziel:

```json
{"value": 0.5, "unit": "Stück"}
```

#### Prüffälle

- `5e-1` wird `0.5` und bleibt strukturiert.
- `125e-3` wird `0.125` und bleibt strukturiert.
- `625e-4` wird `0.0625`; danach gilt M01.
- `50e-2` wird `0.50`, nicht `0.5`.
- `12e-1` wird `1.2`; danach gilt M01.
- `0e0` wird `0`; danach gilt M03.

### M03/M11 – Freitext aus fehlerhafter strukturierter Dosierung {#m03-m11}

#### Anlass

M03 (`DosageDoseValuePositive`) und M11 (`TimingValuesPositive`) beanstanden einen Dosiswert von null oder kleiner beziehungsweise eine Periode von null oder eine Behandlungsdauer von null oder kleiner. Für diese Dosierungen wird der vorhandene Dosierungstext der Quelle als Freitext übernommen. Die fehlerhaften strukturierten Werte werden nicht korrigiert.

#### Überführung

1. **Text übernehmen:** Den Wert von `renderedDosageInstruction` der Quelle als `Dosage.text` übernehmen. In 1.0.7 ist `renderedDosageInstruction` bei strukturierten Dosierungen Pflicht (`DosageStructuredRequiresGeneratedText`).
2. **Struktur verwerfen:** Die gesamte Dosierungsliste durch genau ein `Dosage`-Element ersetzen, das nur `text` enthält. `timing`, `doseAndRate` und die übrigen Dosierungsfelder entfallen. Die gesamte Liste wird ersetzt, weil Freitext in 2.0.0 nur in einem einzelnen `Dosage`-Element zulässig ist (`FreeTextSingleDosageOnly`).
3. **Wie reinen Freitext behandeln:** Weiter mit Schritt 2 des [Ablaufs](#ablauf): Besteht der Text nur aus einem 4-Schema, wird [M04](#m04) angewendet; danach werden die Text-Extensions gesetzt.

Der Text wird nicht neu erzeugt und nicht als strukturierte Dosierung interpretiert. Dosis- und Zeitwerte werden weder angepasst noch umgerechnet.

#### Beispiele

Texte, die der Algorithmus 1.0.1 für solche Dosierungen erzeugt hat:

- Dosis `0`: `0-0-0-0 Stück` wird nach M04 zu `täglich: 0-0-0-0 Stück`.
- Dosis `-1`: `-1-0-0-0 Stück` bleibt unverändert, der Text ist kein reines 4-Schema.
- Periode `0`: `alle 0 Tage: je 1 Stück` bleibt unverändert.

### M04 – 4-Schema im Freitext {#m04}

#### Anlass

`DosageFourSlotPatternInText` verbietet in 2.0.0 einen Freitext, der ausschließlich aus einem 4-Schema besteht, zum Beispiel `1-0-1-0` oder `1-0-1-0 Stück`. Ein 4-Schema innerhalb eines weiteren Textes, etwa in der Form `täglich: 1-0-1-0 Stück`, löst nur die Warnung `DosageFourSlotPatternInTextWarning` aus.

#### Auslöser

`Dosage.text` erfüllt den regulären Ausdruck aus `DosageFourSlotPatternInText`. Er steht hier ohne das String-Escaping des FHIRPath-Ausdrucks:

```text
^\s*\d+([.,]\d+)?(\s*/\s*\d+)?(\s*[-–]\s*\d+([.,]\d+)?(\s*/\s*\d+)?){3}(\s*[A-Za-zÄÖÜäöüß().]+)?\s*$
```

M04 gilt für bestehende Freitext-Dosierungen ebenso wie für einen Text, der im [Freitext-Fallback](#freitext-fallback) entsteht.

#### Überführung

1. Dem Text ohne führende und nachfolgende Leerzeichen `täglich: ` voranstellen. Der übrige Text bleibt unverändert.
2. `renderedDosageInstruction` auf exakt denselben Text setzen und `GeneratedDosageInstructionsMeta` angeben (siehe [Text-Extensions](#text-extensions)).

Der Text wird nicht in eine strukturierte Dosierung umgewandelt.

Das Voranstellen von `täglich: ` ist die einzige Ergänzung, die die Überführung vornimmt. Sie löst den Konflikt mit `DosageFourSlotPatternInText` und entspricht der Form, in der die Textgenerierung 2.0.0 ein strukturiertes 4-Schema ausgibt (zum Beispiel `täglich: 1-0-1-0 Stück`).

#### Beispiel

```text
Quelle:  Dosage.text = "1-0-1-0 Stück"
Ziel:    Dosage.text = "täglich: 1-0-1-0 Stück"
         renderedDosageInstruction = "täglich: 1-0-1-0 Stück"
```

#### Prüffälle

- `1-0-1-0` wird `täglich: 1-0-1-0`.
- `1/2-0-0-1 Stück` wird `täglich: 1/2-0-0-1 Stück`.
- `1-0-0` hat nur drei Slots und bleibt unverändert.
- `morgens 1-0-0-0` erfüllt den Ausdruck nicht und bleibt unverändert.

### M10 – Einheitlicher Behandlungszeitraum {#m10}

#### Anlass

M10 (`TimingOnlyOneBounds`) verlangt, dass alle `Dosage`-Elemente einer Ressource entweder keinen Behandlungszeitraum oder denselben Behandlungszeitraum enthalten. Im Profil 1.0.7 ist `Timing.repeat.bounds` auf `Duration` beschränkt. Fehlt `boundsDuration` nur in einzelnen Elementen, verletzt die Ressource M10. Unterschiedliche Werte oder Einheiten verletzen bereits das Profil 1.0.7 (`TimingOnlyOneBounds`) und sind nicht Gegenstand der Überführung.

#### Überführung

1. **Kein Zeitraum vorhanden:** Ist `boundsDuration` in keinem Element vorhanden, bleibt die Dosierung unverändert.
2. **Zeitraum in einem Teil der Elemente:** Das vollständige `boundsDuration` aus einem Element, das es enthält, in alle Elemente kopieren, in denen es fehlt. Bereits vorhandene Werte werden nicht überschrieben. `value`, `system`, `code` und `unit` bleiben unverändert.
3. **Weiter migrieren:** Anschließend mit den übrigen Migrationsschritten fortfahren. Das Kopieren allein garantiert nicht, dass die Ressource alle weiteren Invarianten von 2.0.0 erfüllt.

Die Prüfung erfolgt vor der Textgenerierung. Diese liest den Zeitrahmen nur aus dem ersten `Dosage`-Element; ohne M10 könnten fehlende Angaben in weiteren Elementen im erzeugten Text unberücksichtigt bleiben.

#### Beispiele

Der bereits angegebene Wert wird ergänzt, nicht verändert.

```text
Quelle:  Dosage[0].boundsDuration = 5 d
         Dosage[1].boundsDuration fehlt
Ziel:    Dosage[0].boundsDuration = 5 d
         Dosage[1].boundsDuration = 5 d
```

### M14 – Doppelte Werte innerhalb eines Elements {#m14}

#### Anlass

In 1.0.7 durfte ein `Dosage`-Element mit Wochentagen und Tagesabschnitten oder Uhrzeiten denselben Wochentag, Tagesabschnitt oder dieselbe Uhrzeit mehrfach enthalten. Das verpflichtende `frequency` zählte die Doppelung mit (`TimingFrequencyCount`). 2.0.0 schließt doppelte Werte innerhalb eines Elements aus (`TimingNoDuplicateValues`). Für `when` wertet FHIR mehrere Angaben ausdrücklich als Vereinigung, `dayOfWeek` und `timeOfDay` nennen die Tage und Uhrzeiten der Gabe. Ein doppelter Wert bezeichnet also keinen weiteren Zeitpunkt.

#### Überführung

1. In jedem `Dosage`-Element in `dayOfWeek`, `when` und `timeOfDay` jeweils nur das erste Vorkommen eines Werts behalten. Die Reihenfolge der übrigen Werte bleibt unverändert.
2. Wurde in einem Element ein Wert entfernt und ist dort `frequency` angegeben, `frequency` auf die Anzahl der verbleibenden Tagesabschnitte beziehungsweise Uhrzeiten multipliziert mit der Anzahl der verbleibenden Wochentage setzen (`TimingFrequencyCount`). Alle übrigen Angaben, auch Dosis, `period` und `periodUnit`, bleiben unverändert.
3. Mit dem Ergebnis weiter nach dem [Ablauf](#ablauf) verfahren.

#### Beispiele

```text
Quelle:  dayOfWeek = mon, when = MORN, MORN, frequency = 2
Ziel:    dayOfWeek = mon, when = MORN, frequency = 1
Text:    montags 1-0-0-0 Stück

Quelle:  dayOfWeek = mon, mon, timeOfDay = 08:00:00, frequency = 2
Ziel:    dayOfWeek = mon, timeOfDay = 08:00:00, frequency = 1
Text:    montags 08:00 Uhr — je 1 Stück
```

### Text-Extensions

Für 2.0.0 sind `renderedDosageInstruction` und `GeneratedDosageInstructionsMeta` bei jeder Dosierung erforderlich, auch bei Freitext (`DosageRequiresGeneratedText`). Bei Freitext stimmt `renderedDosageInstruction` exakt mit `Dosage.text` überein (`FreeTextMatchesRenderedText`). Die Umstellung von `DosageStructuredRequiresGeneratedText` auf `DosageRequiresGeneratedText` ist daher nicht nur eine Umbenennung: Auch bestehende Freitext-Dosierungen erhalten beide Extensions.

`GeneratedDosageInstructionsMeta` enthält die Sprache und in `algorithmVersion` die tatsächlich verwendete Version des Algorithmus der [Textgenerierung](./dosierung-textgenerierung.html). Das gilt auch für übernommenen Freitext, da die Textgenerierung einen Freitext unverändert übernimmt. Die Beispiele dieser Migrationsbeschreibung verwenden die Algorithmusversion `2.0.0`.

### Nicht Gegenstand der Überführung

Für die folgenden Bestandsdaten beschreibt dieser Leitfaden keine Abbildung. Wie ein System mit ihnen umgeht, entscheidet es selbst.

- **Dosierungen, die bereits das Profil 1.0.7 verletzen**, zum Beispiel doppelte Tagesabschnitte oder Uhrzeiten (außer innerhalb eines Elements mit Wochentagen, siehe [M14](#m14)), gemischte Tagesabschnitte und Uhrzeiten, fehlendes `timing` oder `doseAndRate`, unterschiedliche Dosis-Codes oder eine Anzeigeeinheit der Behandlungsdauer, die nicht zum UCUM-Code passt. Ihre Ungültigkeit ist keine Folge des Profilwechsels.
- **Dosisangaben ohne Zahlenwert:** `doseQuantity.value` ist in 2.0.0 Pflicht, in 1.0.7 war es optional. Ohne Zahlenwert lässt sich weder eine strukturierte Dosierung noch ein Dosierungstext bilden.
- **Dosierungen, für die die Textgenerierung im Freitext-Fallback keinen Text liefert** (siehe [Freitext-Fallback](#freitext-fallback)).

### Einheiten

Zeit- und Dosiseinheiten werden nicht umgerechnet. `value`, `system` und `code` von Dosis-, Perioden- und Dauerangaben bleiben unverändert, ebenso die Anzeige `unit`. Für `periodUnit` erlaubt das Ziel-ValueSet `min`, `h`, `d`, `wk` und `mo` (in 1.0.7 nur `d`, `wk` und `mo`), für `boundsDuration` die Codes `d`, `wk`, `mo` und `a`.
