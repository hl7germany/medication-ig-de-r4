Diese Seite beschreibt die Erzeugung eines menschenlesbaren Dosierungstextes aus einer gesamten Arzneimittel‑Ressource (z. B. `MedicationRequest`, `MedicationDispense`, `MedicationStatement`).

Referenz-Implementierung: [Python Skript](./medication-dosage-to-text.py) (`__version__`). Die dortige Logik übernimmt automatisch Prüfung der unterstützten Felder und Erkennung des passenden Darstellungsmusters ("Schema"). Diese Seite konzentriert sich auf die konkrete Bildung der Textbausteine – also das „Wie wird welches strukturelle Element in Text überführt?“ – damit eine Nachimplementierung ohne Einsicht in den Code möglich ist.

## Überblick

Der Algorithmus bildet jeweils eine Dosage in folgendem grundsätzlichen Aufbau ab (sofern vorhanden):

`[Dauer] [Intervall / Grundrhythmus]: [optionale Einschränkung auf Wochentage] [Zeit- oder Tagesabschnittsangaben] [Dosisangabe]`

Je nach Schema (tägliches Schema, Intervall, Wochentage, konkrete Uhrzeiten, Tagesabschnitt-Codes) werden einzelne Teile weggelassen oder unterschiedlich kombiniert. Stehen mehrere Zeiten / Abschnitte oder mehrere Wochentage zur Verfügung, entstehen getrennte Teilsegmente.

## Textbausteine im Detail

### 1. Dauer (boundsDuration)
Vorangestellt als: `für {Wert} {Einheit}`. Danach folgt – falls weitere Angaben kommen – ein Doppelpunkt: `für 7 Tage: ...`  
Pluralisierung abhängig vom Wert (1 → Singular, sonst Plural). Einheiten (z. B. Tag/Tage, Woche/Wochen, Stunde/Stunden) entsprechen den hinterlegten Codes/Units.

### 2. Intervall / Grundrhythmus (frequency / period / periodUnit)
Aus der Kombination entsteht eine der Formen:
* Daily Pattern (`periodUnit='d'`, `period=1`):
  * `frequency=1` → `täglich`
  * `frequency>1` → `{frequency} x täglich`
* Wöchentlich (`periodUnit='wk'`, `period=1`): analog `wöchentlich` / `{frequency} x wöchentlich`
* Sonst:
  * `frequency=1` → `alle {period} {Einheit(pluralisiert falls nötig)}` (z. B. `alle 8 Stunden`)
  * `frequency>1` → `{frequency} x alle {period} {Einheit}` (z. B. `3 x alle 8 Stunden`)

Dieses Intervall steht typischerweise am Anfang (nach einer optionalen Dauer) und wird durch `:` vom rechten Teil getrennt, wenn rechts weitere Segmentangaben folgen.

### 3. Wochentage (dayOfWeek)
Wochentage werden – falls vorhanden – in kanonischer Reihenfolge Montag → Sonntag verarbeitet. Darstellung in adverbialer Form: `montags`, `dienstags`, `mittwochs`, ...  
Varianten:
* Einheitliche Dosis für mehrere Tage: wahlweise Aufzählung oder (vereinfacht) mehrere Zeilen – in Beispielen wird oft eine Zeile pro Tag verwendet.
* Unterschiedliche Dosen pro Tag → je eine eigene Zeile / eigenes Segment.

### 4. Konkrete Zeiten (timeOfDay)
Uhrzeiten werden als `HH:MM Uhr` ausgegeben (Sortierung aufsteigend).  
Mehrere Zeiten derselben Dosage → durch Semikolon + Leerzeichen getrennte Paare:  
`08:00 Uhr — je 1 Stück; 20:00 Uhr — je 2 Stück`

### 5. Tagesabschnitt (when Codes)
Unterstützte Codes und deutsche Abbildung:
* `MORN` → morgens
* `NOON` → mittags
* `EVE` → abends
* `NIGHT` → zur Nacht

Es gibt zwei Nutzungsarten:
1. Kompakte 4‑Schema Notation (nur when, tägliches Muster): Aus den vier Positionen (Reihenfolge fest: MORN-NOON-EVE-NIGHT) wird ein Muster gebildet: `<MORN>-<NOON>-<EVE>-<NIGHT> <Einheit>`; nicht belegte Positionen → `0`. Beispiel: Dosen morgens 1, abends 2 → `1-0-2-0 Stück`.
2. Als einzelne Abschnitte analog zu Uhrzeiten (z. B. bei Intervall + when): `morgens — je 1 Stück; abends — je 2 Stück`.

### 6. Dosis (doseAndRate.doseQuantity)
Format: `je {value} {unit}` (falls `unit` vorhanden).  
Die erste vorhandene `doseQuantity` wird genutzt. Dezimalwerte werden unverändert wiedergegeben.

### 7. Zusammensetzung typischer Muster

Die folgenden Muster zeigen, wie die oben beschriebenen Bausteine kombiniert werden. Der Algorithmus entscheidet automatisch anhand der vorhandenen Felder (Details zur Erkennung werden an anderer Stelle beschrieben):

| Muster | Beschreibung | Aufbau | Beispiel |
|--------|--------------|--------|----------|
| 4‑Schema | Tagesabschnittscodes ohne Zeiten/Wochentage, tägliches Muster | `[Dauer ]<MORN>-<NOON>-<EVE>-<NIGHT> <Einheit>` | `1-0-2-0 Stück` / `für 5 Tage: 1-1-1-1 Kapseln` |
| TimeOfDay | Konkrete Uhrzeiten an einem Tag | `[Dauer ][täglich|{Intervall}]: Zeit — je Dosis[; Zeit2 — je Dosis2 …]` | `täglich: 08:00 Uhr — je 1 Stück; 20:00 Uhr — je 2 Stück` |
| DayOfWeek | Bestimmte Wochentage, einheitliche oder unterschiedliche Dosen | Je Tag eine Zeile: `{Wochentag} — je {Dosis}` | `montags — je 2 mg` (mehrere Zeilen) |
| DayOfWeek + Time | Wochentage plus Uhrzeiten oder when | `{Wochentag}: Zeit/Abschnitt — je Dosis[; …]` je Tag | `montags: 08:00 Uhr — je 1 Stück; 20:00 Uhr — je 1 Stück` |
| Intervall | Reines Intervall ohne Zeiten | `[Dauer ]{Intervall}: je {Dosis}` | `alle 8 Stunden: je 1 Stück` |
| Intervall + Zeiten/Abschnitte | Intervall plus konkrete Zeiten oder when | `{Intervall}: Zeit/Abschnitt — je Dosis[; …]` | `alle 2 Stunden: 08:00 Uhr — je 1 Stück; 10:00 Uhr — je 1 Stück` |
| FreeText | Nur freier Dosierungstext (kein Timing) | Zusammengeführter Text | `Nach Bedarf bei Schmerzen` |

Für eine Übersicht der in diesem IG bereitgestellten Beispiele siehe [Beispiele von erzeugen Dosiertexten](./dosierung-beispiele.html).

### 8. Trennzeichen und Layout
* Doppelpunkt (`:`) trennt linken Rahmen (Dauer / Intervall / täglich) vom rechten Teil mit konkreten Zeit-/Dosisangaben.
* Geviertstrich / Gedankenstrich (` — `) verbindet Zeit- oder Abschnittsangabe mit der Dosis.
* Semikolon + Leerzeichen (`; `) trennt mehrere Zeit-/Abschnitt-Dosis-Paare innerhalb derselben Dosage.
* Mehrere Dosierungen der Resource werden durch Zeilenumbrüche getrennt.

### 9. Fehler & Validierung
Ergibt sich aus Feldverwendungen außerhalb des unterstützten Umfangs oder aus nicht eindeutig klassifizierbaren Mustern, liefert das Skript einen Fehlertext (Auflistung der betroffenen Felder). Die formale Definition der zulässigen Felder und die Schema-Erkennung sind an anderer Stelle im IG spezifiziert.

### 10. Versionierung & Erweiterungen
Die Version des Skripts (`__version__`) spiegelt den Stand dieser Beschreibung wider. Erweiterungen (zusätzliche Felder oder neue Muster) werden inkrementell ergänzt und in künftigen Versionen dokumentiert.

### 11. Quellen / weiterführende Hinweise
* UK Core Implementation Guide for Medicines (Dose to Text Translation)
* NHS CUI User Interface Design Guidance (2015)
* Australian Commission: National Guidelines for On-Screen Display of Medicines Information (2017)
