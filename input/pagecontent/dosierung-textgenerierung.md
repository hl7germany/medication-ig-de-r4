Diese Seite beschreibt die Erzeugung eines menschenlesbaren Dosierungstextes aus einer gesamten Arzneimittel‑Ressource (`MedicationRequest`, `MedicationDispense` oder `MedicationStatement`).

Referenz-Implementierung: [Python Skript](https://github.com/hl7germany/dgMP-DosageTextgenerierung-Skript/blob/main/medication-dosage-to-text.py). Die dortige Logik übernimmt die Prüfung der unterstützten Felder, die Erkennung des passenden Dosierschemas und die Texterzeugung. Das Skript ist außerhalb dieses Implementation Guides gelagert und kann eigenständig versioniert sein. In den Beispielen ist ersichtlich, welche Version der Referenzimplementierung zum Zeitpunkt der Erstellung genutzt wurde (siehe [Versionierung](#versionierung)).

Voraussetzung für eine erfolgreiche Texterzeugung ist stets ein **profilkonformer Input**; im Profil gestrichene Elemente sind nicht Teil der Verarbeitung.

Diese Seite stellt zwei Aspekte dar: **Teil A** beschreibt, wie jede einzelne Angabe einer `Dosage` in Text überführt wird. **Teil B** beschreibt, wie diese Bausteine je zulässigem Schema zu einem vollständigen Dosierungstext zusammengesetzt werden.

> Hinweis zur Bereichsdarstellung: Variable Angaben (Frequenz, Periode, Einzeldosis) werden durchgängig mit dem Wort **„bis"** gebildet (z. B. „1 bis 2 Stück"). Enthält das kompakte 4‑Schema einen variablen Wert, wird es in die ausgeschriebene Segmentform überführt (siehe [4‑Schema](#schema-mit-tageszeiten-bezug-4-schema)).

---

## Teil A: Übersetzung der einzelnen Angaben

### Dosis (`doseAndRate.doseQuantity` / `doseRange`)

Verwendet wird die erste vorhandene `doseQuantity` oder `doseRange`. Die Standardform lautet `je {Wert} {Einheit}` (z. B. `je 1 Stück`). Bei einem `doseRange` gilt abhängig davon, ob ein beidseitig oder einseitig begrenzter Bereich vorliegt:

* beidseitig: `je {von} bis {bis} {Einheit}` (z. B. `je 1 bis 2 Stück`)
* nur obere Grenze: `je bis zu {bis} {Einheit}` (z. B. `je bis zu 2 Stück`)

> Nur die untere Grenze (`low` ohne `high`) ist **nicht zulässig** und wird durch die Invariante `DoseRangeHighRequiredWhenLowPresent` ausgeschlossen.

Ganzzahlige Werte werden ohne Nachkommastelle dargestellt; überflüssige Dezimalstelle und Komma entfallen (`1.0` → `1`). Dezimalwerte werden mit **deutschem Dezimalkomma** ausgegeben (z. B. `1,5`).

Der so gebildete Dosis-Baustein – einschließlich der **Bereichsform** (`je {von} bis {bis} {Einheit}`) – ist in **allen** Schemata einsetzbar; überall dort, wo in Teil B der Platzhalter `{Dosis}` steht, kann ein fester Wert **oder** ein Bereich stehen (z. B. `alle 8 Stunden: je 1 bis 2 Stück`).

**Ausnahme:** Im kompakten 4‑Schema entfällt das vorangestellte `je`; dort erscheinen die Dosiswerte positionell (siehe Teil B).

### Zeitrahmen

#### Dauer (`boundsDuration`)

Eine begrenzte Anwendungsdauer wird vorangestellt als `für {Wert} {Einheit}`. Die Einheit wird nach den Regeln unter [Einheiten und Pluralisierung](#einheiten-und-pluralisierung) ausgegeben, z. B. `für 1 Tag` bzw. `für 7 Tage`.

#### Start- und Endzeitpunkt (`boundsPeriod`)

Start- und/oder Endzeitpunkt werden vorangestellt:

* nur Start (offenes Ende): `Ab dem {Startdatum}[ um {Uhrzeit}]`
* Start und Ende: `Vom {Startdatum}[ um {Uhrzeit}] bis zum {Enddatum}[ um {Uhrzeit}]`
* nur Ende: `Bis zum {Enddatum}[ um {Uhrzeit}]`

Das Datum wird im Format `TT.MM.JJJJ` ausgegeben, die Uhrzeit im Format `HH:MM Uhr`. Fehlt die Uhrzeit, entfällt der Zusatz `um {Uhrzeit}`.

### Intervall (`frequency` / `period` / `periodUnit`)

Aus Frequenz und Periode entsteht der einleitende Rhythmus:

* tägliches Muster (`periodUnit='d'`, `period=1`): `täglich` bei `frequency=1`, sonst `{frequency} x täglich`
* wöchentliches Muster (`periodUnit='wk'`, `period=1`): `wöchentlich` bzw. `{frequency} x wöchentlich`
* sonstige Perioden: `alle {period} {Einheit}` bei `frequency=1` (z. B. `alle 8 Stunden`), sonst `{frequency} x alle {period} {Einheit}`

Die Perioden-Einheit wird nach den Regeln unter [Einheiten und Pluralisierung](#einheiten-und-pluralisierung) ausgegeben. Frequenz und Periode können statt eines festen Wertes einen **Bereich** angeben; Bereiche werden mit „bis" gebildet: `{von} bis {bis} x täglich` (z. B. `2 bis 3 x täglich`) sowie `alle {von} bis {bis} {Einheit}` (z. B. `alle 2 bis 3 Tage`).

### Einheiten und Pluralisierung

Es sind zwei Arten von Einheiten zu unterscheiden:

**1. Zeit-Einheiten** (aus `periodUnit`, `boundsDuration.code`, `MindestabstandZwischenGaben`): Sie werden über eine **feste Tabelle** in ihre deutsche Bezeichnung übersetzt. Die Form richtet sich ausschließlich nach dem Wert: **Singular genau dann, wenn der Wert gleich `1` ist**, sonst **Plural**. Bei einem Bereich (`{von} bis {bis}`) wird stets die Plural-Form verwendet.

| Code | Singular (Wert = 1) | Plural (sonst) |
|------|---------------------|----------------|
| `s`  | Sekunde | Sekunden |
| `min`| Minute | Minuten |
| `h`  | Stunde | Stunden |
| `d`  | Tag | Tage |
| `wk` | Woche | Wochen |
| `mo` | Monat | Monate |
| `a`  | Jahr | Jahre |

Ist ein Code nicht in der Tabelle enthalten, wird der Code unverändert ausgegeben (Fallback).

**2. Dosis-Einheit** (`doseQuantity.unit` / `doseRange.*.unit`, z. B. „Stück", „mg", „Kapseln", „Tropfen"): Sie wird **wörtlich und unverändert** aus dem Input übernommen und **nicht** pluralisiert. Der Numerator der Maximalmenge (`maxDosePerPeriod.numerator.unit`) entspricht der Dosis-Einheit und wird ebenfalls wörtlich übernommen.

### Wochentage (`dayOfWeek`)

Wochentage werden, sofern vorhanden, in kanonischer Reihenfolge (Montag bis Sonntag) verarbeitet und in adverbialer Form dargestellt:

| Code | Text |
|------|------|
| `mon` | montags |
| `tue` | dienstags |
| `wed` | mittwochs |
| `thu` | donnerstags |
| `fri` | freitags |
| `sat` | samstags |
| `sun` | sonntags |

### Konkrete Zeiten (`timeOfDay`)

Uhrzeiten werden aufsteigend sortiert und im Format `HH:MM Uhr` ausgegeben (z. B. `08:00 Uhr`).

### Tagesabschnitt (`when`-Codes)

Die unterstützten Codes werden wie folgt abgebildet:

| Code | Text |
|------|------|
| `MORN` | morgens |
| `NOON` | mittags |
| `EVE` | abends |
| `NIGHT` | zur Nacht |

Je nach Schema erscheinen die Codes entweder als kompaktes, positionelles Muster (4‑Schema) oder als einzelne Abschnittsangaben analog zu Uhrzeiten (siehe Teil B).

### Einnahmeanlass (`asNeededFor`)

Der Einnahmeanlass wird bei Bedarfsmedikation vorangestellt als `bei {Anlass}` (z. B. `bei Kopfschmerzen`). Der Einnahmeanlass ist **optional**; fehlt er, wird generisch `bei Bedarf` gesetzt. Mehrere Einnahmeanlässe werden als ODER-Verknüpfung interpretiert. Details zur Zusammensetzung siehe [Schema für Bedarfsmedikation](#schema-für-bedarfsmedikation).

### Maximalmenge (`maxDosePerPeriod`)

Die Maximalmenge wird der Dosis nachgestellt als `nicht mehr als {Wert} {Einheit} {Zeitraum}`. Als Bezugszeitraum ist ausschließlich **24 Stunden** oder **1 Tag** zulässig (durchgesetzt über die Invariante `MaxDosePerPeriodOnly24hOr1d`). Die Auswahl wird eingabetreu wiedergegeben:

* `24 h` → `in 24 Stunden`
* `1 d` → `pro Tag`

Die Einheit entspricht der Dosiereinheit.

### Freitext-Hinweise (`patientInstruction`)

Ergänzende Einnahmehinweise werden aus `patientInstruction` als abschließender Satz mit vorangestelltem `Hinweis:` wiedergegeben (z. B. `Hinweis: Mit ausreichend Wasser einnehmen`).

> `additionalInstruction` wird **nicht** verwendet und ist im Profil `DosageDgMP` auf `0..0` gestrichen; es bleibt für künftige strukturierte Zusatzangaben reserviert.

### Trennzeichen

* **Doppelpunkt mit Leerzeichen** (`: `) trennt die Dosieranweisung in zwei Abschnitte. Links des Doppelpunkts stehen, sofern vorhanden, der Zeitrahmen, der Einnahmeanlass und das Intervall.
* **Gedankenstrich mit Leerzeichen** (` — `) verbindet eine Zeit- oder Abschnittsangabe mit der zugehörigen Dosis sowie die Dosis mit der Maximalmenge im Falle einer Bedarfsmedikation.
* **Komma mit Leerzeichen** (`, `) trennt aufeinanderfolgende Segmente unterschiedlicher **Tages- oder Uhrzeiten**, unabhängig davon, ob sie aus derselben oder aus verschiedenen `Dosage`-Einträgen stammen.
* **Semikolon mit Leerzeichen** (`; `) trennt aufeinanderfolgende **Wochentagssegmente**, unabhängig davon, ob sie aus derselben oder aus verschiedenen `Dosage`-Einträgen stammen.
* **Bindestrich** (`-`) trennt die vier Positionen des 4‑Schemas.

Es werden keine Zeilenumbrüche erzeugt; der Text einer Ressource steht in einer Zeile. Ausnahme ist die Freitext-Dosierung, in der mehrere `text`-Felder mit Leerzeichen verkettet werden.

**Normalisierung:** Mehrfache Leerzeichen durch ausgelassene Bestandteile werden zu einem Leerzeichen reduziert und vor Satzzeichen entfernt.

**Deterministische Reihenfolge:** Die Reihenfolge der Segmente im erzeugten Text ist grundsätzlich **unabhängig von der Reihenfolge der `Dosage`-Elemente** in der Ressource. Segmente werden ausschließlich nach ihrem Inhalt sortiert (Uhrzeiten aufsteigend, Tagesabschnitte in fester Reihenfolge morgens → mittags → abends → zur Nacht, Wochentage kanonisch Montag → Sonntag).

---

## Teil B: Aufbau je Schema

Ein generierter Dosierungstext folgt grundsätzlich dem Aufbau:

```
[{Zeitrahmen}] [{Intervall}]: [{Wochentag}] [{Zeit- oder Tagesabschnittsangabe} — ]{Dosis}[. Hinweis: {Instruktionen}]
```

`{…}` kennzeichnet einen Platzhalter, `[...]` einen optionalen Bestandteil, der nur erscheint, wenn die zugehörige Angabe vorliegt. Klammern können geschachtelt werden; eine äußere optionale Klammer entfällt vollständig, wenn alle inneren Bestandteile fehlen.

Je nach Schema werden einzelne Bestandteile weggelassen oder unterschiedlich kombiniert. Stehen mehrere Uhrzeiten, Tagesabschnitte oder Wochentage zur Verfügung, entstehen getrennte Segmente. Das kompakte **4‑Schema** und die **Bedarfsmedikation** stellen Ausnahmen von diesem allgemeinen Aufbau dar.

### Schema mit Tageszeiten-Bezug (4-Schema)

```
[[{Zeitrahmen} ]: ]<MORN>-<NOON>-<EVE>-<NIGHT> {Einheit}[. Hinweis: {Instruktionen}]
```

Nicht belegte Positionen erhalten den Wert `0`.

*Beispiel:* `für 5 Tage: 1-1-1-1 Kapseln`

> **Variabilität:** Enthält eine der Positionen einen variablen Wert (Bereich), wird das kompakte Schema in die ausgeschriebene Segmentform (nur belegte Positionen) überführt, z. B. `morgens — je 1 bis 2 Stück, abends — je 2 Stück`. Feste 4‑Schemata bleiben kompakt (`1-0-2-0 Stück`).

### Schema mit Uhrzeiten-Bezug

```
[{Zeitrahmen} ][{Intervall} ]täglich: {Zeit} — je {Dosis}[, {Zeit2} — je {Dosis2} …][. Hinweis: {Instruktionen}]
```

Jede Uhrzeit bildet mit ihrer Dosis ein Segment. Mehrere Segmente werden aufsteigend nach Uhrzeit sortiert und mit Komma getrennt; das gilt auch, wenn die Dosis zwischen mehreren oder allen Uhrzeiten übereinstimmt.

*Beispiel:* `täglich: 08:00 Uhr — je 1 Stück, 20:00 Uhr — je 2 Stück`

### Schema mit Wochentags-Bezug

```
[[{Zeitrahmen} ]: ]{Wochentag} — je {Dosis}[; {Wochentag2} — je {Dosis2} …][. Hinweis: {Instruktionen}]
```

Jeder belegte Tag bildet mit seiner Dosis ein Segment. Mehrere Segmente werden in kanonischer Reihenfolge der Wochentage sortiert und mit Semikolon getrennt; das gilt auch, wenn die Dosis zwischen mehreren oder allen Wochentagen übereinstimmt.

*Beispiel:* `montags — je 1 Stück; mittwochs — je 2 Stück`

### Schema für wiederkehrende Intervalle

```
[{Zeitrahmen} ]{Intervall}: je {Dosis}[. Hinweis: {Instruktionen}]
```

*Beispiele:* `alle 4 Stunden: je 1 Stück` · mit Dosis-Bereich: `alle 8 Stunden: je 1 bis 2 Stück`

### Schema für Kombinationen von Zeitintervallen

```
[{Zeitrahmen} ]{Intervall}: {Zeit oder Abschnitt} — je {Dosis}[, … ][. Hinweis: {Instruktionen}]
```

Jede Uhrzeit oder jeder Tagesabschnitt bildet gemeinsam mit seiner Dosis ein Segment. Das gilt auch, wenn die Dosis zwischen mehreren oder allen Segmenten übereinstimmt. Segmente mit Tagesabschnitten werden in der festen Reihenfolge morgens, mittags, abends, zur Nacht sortiert; Segmente mit Uhrzeiten aufsteigend. Die Segmente werden mit Komma getrennt.

*Beispiel:* `alle 2 Tage: 08:00 Uhr — je 1 Stück, 18:00 Uhr — je 2 Stück`

### Schema für Kombinationen von Wochentagen

```
Aufbau (mit Uhrzeiten):        [[{Zeitrahmen} ]: ]{Wochentag} {Zeit} — je {Dosis}[; …][. Hinweis: {Instruktionen}]
Aufbau (mit Tagesabschnitten): [[{Zeitrahmen} ]: ]{Wochentag} <MORN>-<NOON>-<EVE>-<NIGHT> {Einheit}[; …][. Hinweis: {Instruktionen}]
```

Jeder belegte Tag bildet mit seinen Uhrzeiten oder seinem Tagesabschnitts-Muster ein Segment. Mehrere Segmente werden in kanonischer Reihenfolge der Wochentage sortiert und mit Semikolon getrennt; das gilt auch, wenn die Angabe zwischen mehreren oder allen Wochentagen übereinstimmt. Innerhalb eines Tages werden Uhrzeiten aufsteigend dargestellt (mehrere Uhrzeiten mit Komma getrennt), Tagesabschnitte zum Vier-Positionen-Muster zusammengezogen.

*Beispiele:*

* `montags 08:00 Uhr — je 1 Stück, 12:00 Uhr — je 2 Stück; mittwochs 20:00 Uhr — je 1 Stück`
* `montags 1-0-1-0 Stück; mittwochs 2-1-2-0 Stück`

### Schema für Bedarfsmedikation

Eine Bedarfsmedikation liegt vor, wenn auf Ebene der `Dosage` `asNeededBoolean = true` gesetzt ist. Sie kann als **reine Bedarfsdosierung** (ohne `timing`) oder als **Kennzeichnung eines strukturierten Dosierschemas** auftreten (siehe [Bedarfsmedikation](./schema-bedarfsmedikation.html)).

```
[{Zeitrahmen} ]bei {Einnahmeanlass}: [im Abstand von mindestens {Mindestabstand} ]{Dosis}[ — nicht mehr als {Maximalmenge}][. Hinweis: {Instruktionen}]
```

* Sofern vorhanden, steht der **Zeitrahmen** am Anfang, gefolgt vom **Einnahmeanlass** und einem **Doppelpunkt**. Der Doppelpunkt steht damit direkt hinter dem Einnahmeanlass.
* Ist kein Einnahmeanlass angegeben, wird generisch `bei Bedarf` gesetzt.
* Das **erste Zeichen der Zeile** wird großgeschrieben (`Bei Kopfschmerzen: …`, `Bei Bedarf: …`).
* Ein optionaler **Mindestabstand** (`modifierExtension[MindestabstandZwischenGaben]`) und – bei strukturiertem Bedarf – das jeweilige Schema (Intervall, 4‑Schema …) folgen rechts des Doppelpunkts.
* Nach der Dosis wird die **Maximalmenge**, sofern angegeben, mit Gedankenstrich angebunden.

*Beispiele:*

* `Bei Kopfschmerzen: im Abstand von mindestens 4 Stunden je 1 Stück — nicht mehr als 6 Stück in 24 Stunden`
* `Bei Kopfschmerzen: alle 8 Stunden je 1 Stück`
* `Bei Bedarf: 1-0-2-0 Stück`

### Freitext-Dosierung

```
{Text}
```

Enthält die `Dosage` ausschließlich freien Text (`text` vorhanden, `timing` und `doseAndRate` leer), wird dieser **unverändert** übernommen. Bei reinem Freitext darf die Ressource **genau ein** `Dosage`-Element enthalten (Invariante `FreeTextSingleDosageOnly`), und `Dosage.text` ist `0..1`; es gibt also genau **ein** Textfeld – eine Verkettung mehrerer Freitexte findet nicht statt. Bei einer Freitext-Dosierung werden **keine** weiteren Bausteine (Hinweis, Maximalmenge, Normalisierung …) angehängt; der Freitext muss alle Angaben selbst enthalten.

*Beispiel:* `Nach Bedarf bei Schmerzen`

---

## Zusammensetzung typischer Muster

Für eine Übersicht der in diesem IG bereitgestellten Beispiele siehe [Beispiele von erzeugten Dosiertexten](./dosierung-beispiele.html).

## Fehler und Validierung

Felder außerhalb des unterstützten Umfangs oder nicht eindeutig klassifizierbare Muster führen zu einem Fehlertext mit Auflistung der betroffenen Felder. Die formale Definition der zulässigen Felder und die Schema-Erkennung sind in den Timing- und Dosierungs-Invarianten dieses IG spezifiziert (siehe [Constraints](./dosierung-constraints.html)).

## Versionierung

Die Version des Algorithmus ist im Skript hinterlegt (`__version__`) und wird über die Extension [GeneratedDosageInstructionsMeta](./StructureDefinition-GeneratedDosageInstructionsMeta.html) an validierenden Instanzen geführt. So lassen sich Textinhalt und verwendete Algorithmus-Version nachvollziehbar prüfen.

## Quellen / weiterführende Hinweise

* UK Core Implementation Guide for Medicines (Dose to Text Translation)
* NHS CUI User Interface Design Guidance (2015)
* Australian Commission: National Guidelines for On-Screen Display of Medicines Information (2017)
