Diese Seite beschreibt die Überführung von Dosierungsangaben aus Version 1.0.7 in die Profile der Version 2.0.0. Sie ist systemneutral und legt keine konkrete Ablage- oder Transaktionsschnittstelle fest.

Die Migration MUSS die lesbare Dosierungsaussage erhalten. Die ursprünglichen 1.0.7-Daten MÜSSEN unverändert und versioniert archiviert bleiben. Die Migration DARF keine Dosis runden und keine medizinische Bedeutung aus fehlenden oder mehrdeutigen Daten ableiten.

### Geltungsbereich

Das Verfahren gilt für Dosierungsangaben in `MedicationRequest.dosageInstruction`, `MedicationDispense.dosageInstruction` und `MedicationStatement.dosage`, die nach dem DosageDgMP-/TimingDgMP-Modell von Version 1.0.7 gespeichert wurden.

Jede archivierte Ressourcenfassung wird unabhängig migriert. Das gilt auch für historische und als gelöscht gekennzeichnete Fassungen, sofern sie im Archiv erhalten und abrufbar sind. Eine Migration darf eine gelöschte Fassung nicht wieder als aktuelle Ressource aktivieren. Die Originalfassung bleibt mit ihrem ursprünglichen Profil, Inhalt und Versionskontext wiederherstellbar; die Zielrepräsentation erhält eine nachvollziehbare Zuordnung zur Quelle.

Fehlt eine Dosierungsangabe vollständig, wird keine Dosierung ergänzt. Neue 2.0.0-Felder, die in 1.0.7 nicht vorhanden waren, werden nicht aus Text oder anderen Feldern erraten.

### Implementierbarer Migrationsablauf

Die Migration verarbeitet eine Quellressource mit genau einem bekannten Profilstand 1.0.7 und erzeugt daraus eine Zielressource für 2.0.0. Ressourcenhistorie, Löschbehandlung, Ziel-IDs und Transaktionsprotokoll sind Eigenschaften des ausführenden Systems und nicht Teil der Dosierungsabbildung. Für jede verarbeitete Quellfassung muss die Zuordnung zur unveränderten Quelle erhalten bleiben.

Die Dosierungsfelder sind abhängig vom Ressourcentyp:

| Ressourcentyp | Quell-/Zielfeld |
|---|---|
| `MedicationRequest` | `dosageInstruction` |
| `MedicationDispense` | `dosageInstruction` |
| `MedicationStatement` | `dosage` |

Implementierungen MÜSSEN pro Ressource in dieser Reihenfolge vorgehen:

1. Den Eingabestand als 1.0.7 klassifizieren und unverändert archivieren. Eine Ressource ohne Dosierung unverändert übernehmen; keine Dosierung erzeugen.
2. Die Dosierungs-Liste des oben genannten Felds lesen. Andere Ressourcenelemente und nicht dosierungsbezogene Extensions unverändert übernehmen.
3. M04-Parsing anwenden, wenn `Dosage.text` ein vollständiges Viererschema ist. Sonst die Dosierungsliste unverändert als Kandidat übernehmen.
4. Exakte, strukturerhaltende Normalisierungen M02 und M18 anwenden. Keine Rundung. Eine Einheit darf nur umgerechnet werden, wenn eine explizite, versionierte Codezuordnung Quell- und Zieleinheit verbindet, die Umrechnung mathematisch exakt ist und Zielcode sowie Zieleinheit im 2.0.0-Profil zulässig sind. Wirkstärken dürfen nicht aus referenzierten Medication-Ressourcen abgeleitet werden.
5. Den Kandidaten gegen die Zielprofile 2.0.0 validieren. Ist er gültig und strukturiert, den gepinnten Renderer ausführen. Ist der Aufruf erfolgreich und nichtleer, die strukturierte Dosierung sowie neu erzeugte `renderedDosageInstruction`- und `GeneratedDosageInstructionsMeta`-Extensions übernehmen. Rendererfehler führen zum Archiv-Fallback.
6. Ist der Kandidat ungültig, den Renderer ausschließlich gemäß der unten definierten Allowlist ausführen. Rendererfehler oder ein Fall außerhalb der Allowlist führen direkt zum Archiv-Fallback.
7. Eine reine Freitext-Quellangabe unverändert übernehmen, sofern sie gegen 2.0.0 validiert. Eine vorhandene `renderedDosageInstruction` nur behalten, wenn sie exakt `Dosage.text` entspricht. Andernfalls `renderedDosageInstruction` und zugehörige Metadaten entfernen.
8. Die resultierende Ressource gegen 2.0.0 validieren. Bei Fehlschlag der strukturierten oder gerenderten Migration den Archiv-Fallback erzeugen und erneut validieren. Schlägt auch dieser fehl, den Lauf für diese Ressource als technischen Fehler markieren; Quelldaten bleiben erhalten.
9. Migrationsstatus, Fall-IDs, verwendete Regel-/Renderer-/Terminologieversionen sowie Validierungsergebnisse protokollieren.

### Verbindliche Einheiten- und Versionsregeln

Vor dem Lauf MUSS die Implementierung die konkrete Ziel-IG-Paketversion, Validatorversion, Renderer-Version, UCUM-Version, Terminologiepaketversion und Version der nachfolgenden Mappingtabelle festlegen. Fehlt eine Abhängigkeit oder stimmt ihre Version nicht mit dem Migrationsmanifest überein, MUSS der Lauf vor der Datenänderung abbrechen.

Für `Timing.repeat.boundsDuration.code` ist `unit` auf die deutsche Designation der Ziel-ValueSet-Version zu setzen:

| UCUM-Code | Kanonischer Wert für `unit` |
|---|---|
| `d` | `Tag(e)` |
| `wk` | `Woche(n)` |
| `mo` | `Monat(e)` |
| `a` | `Jahr(e)` |

Für `Timing.repeat.periodUnit` gilt das Ziel-ValueSet `PeriodUnitsOfTimeDgMPVS`: `min`, `h`, `d`, `wk` und `mo`. Die kanonischen deutschen Designations sind `Minute(n)`, `Stunde(n)`, `Tag(e)`, `Woche(n)` und `Monat(e)`. Eine Konvertierung von `mo` oder `a` in eine andere Kalendereinheit ist nicht exakt definiert und DARF nicht automatisch erfolgen.

Für Dosisangaben gilt als Default: Haben alle betroffenen Mengen denselben `system`- und `code`-Wert, bleiben diese Codes erhalten; die Display-Einheit wird nicht zur Änderung des Zahlenwerts verwendet. Unterscheiden sich Codes, DARF keine Umrechnung stattfinden. M17 wechselt dann in den Archiv-Fallback. Eine spätere freigegebene Umrechnungstabelle muss Quellcode, Zielcode, exakten Umrechnungsfaktor, Terminologieversion und Gültigkeit enthalten und ist versioniert mit der Migration auszuliefern.

Für M04 wird die Einheit mit einer versionierten Expansion des Ziel-ValueSets `kbv-dosiereinheit-vs` abgeglichen. Der Parser trimmt äußere Leerzeichen und normalisiert Unicode nach NFKC; danach muss die Einheit exakt einer `display`- oder `designation`-Zeichenfolge genau eines Concepts entsprechen. Es werden keine unscharfen Treffer, Abkürzungen oder frei erfundenen Synonyme akzeptiert. Kein Treffer, mehrere Treffer oder fehlende Einheit ohne explizite Quellsystem-Defaultregel bedeuten Archiv-Fallback.

Die Verarbeitung ist Dunkelverarbeitung. Mehrdeutige klinische Bedeutungen werden nicht erraten; sie führen deterministisch zum Archiv-Fallback. Derselbe Quellinhalt mit denselben Regel- und Abhängigkeitsversionen MUSS bytegleich denselben Zielinhalt erzeugen. Ein bereits migrierter 2.0.0-Zieldatensatz wird nicht erneut als 1.0.7-Quelle verarbeitet.

### Textgenerierung und Fallback

#### Gepinnter Renderer

Für die in diesem Guide geprüften Fälle wurde die Referenzimplementierung des Dosierungstext-Algorithmus in Version `2.0.0-ballot` verwendet. Die normative Algorithmusspezifikation bleibt maßgeblich; die Beispielimplementierung ist kein allgemeiner Ersatz für Profilvalidierung oder Migration.

Der geprüfte Renderer kann folgende für diese Migration freigegebene Fälle vollständig in Text ausdrücken:

- Eine strukturierte Dosis `1.2 Stück` wird beispielsweise als `täglich: je 1,2 Stück` gerendert.
- Eine Dauer `boundsDuration = 1.5 d` wird als `für 1,5 Tage ...` gerendert.
- Eine Periode `period = 1.5 d` wird als `alle 1,5 Tage ...` gerendert.
- Eine Frequenz `2` bei einer Periode von `8 h` wird als `2 x alle 8 Stunden ...` gerendert. Der Renderer normalisiert diese Angabe nicht zu „alle 4 Stunden“.
- Mehrere unterschiedliche Dosen zu derselben Uhrzeit werden jeweils ausgegeben, zum Beispiel `08:00 Uhr — je 1 Stück, 08:00 Uhr — je 2 Stück`.

Der Renderer wird nur in folgenden Fällen aufgerufen:

Der Renderer wird nur in folgenden Fällen aufgerufen:
- **M05/M06:** genau ein unterstütztes Intervall-/Timing-Schema mit `doseAndRate`, sofern M05-Zeitrahmen entweder in allen Elementen fehlen oder identisch sind.

**M18:** nur nach erfolgreicher Korrektur der Anzeigeeinheit und erfolgreicher Validierung der gesamten strukturierten Zielressource.
Alle übrigen M-Fälle verwenden den Archiv-Fallback. Insbesondere DARF der Renderer nicht für mehrere `Dosage`-Elemente aus einer ungültigen Quellressource, `doseQuantity.value <= 0`, fehlendes `doseAndRate`, doppelte `when`, gemischte `when`-/`timeOfDay`-Schemata oder unterschiedliche Zeitrahmen über Dosage-Elemente verwendet werden. Bei M15 unterschlägt er sonst Zeitrahmen nach dem ersten Element. Für doppelte `timeOfDay`-Werte, doppelte `dayOfWeek`-Werte und Wiederholungen mit uneindeutigen Dosen gibt es keine freigegebene Allowlist; sie fallen ebenfalls auf den Archiv-Fallback zurück.

Das Ergebnis wird ausschließlich dann als Renderertext übernommen, wenn der Aufruf erfolgreich ist, eine nichtleere Zeichenkette liefert und die Eingabe vollständig zur Allowlist passt. Es gibt keine heuristische Prüfung anhand von Teilstrings. Ein Renderertext für ein 4-Schema, der nach `Dosage.text` geschrieben wird, ist unzulässig; M04 muss zuvor strukturiert migriert sein.
Das Ergebnis wird ausschließlich dann als Renderertext übernommen, wenn der Aufruf erfolgreich ist, eine nichtleere Zeichenkette liefert und die Eingabe vollständig zur Allowlist passt. Es gibt keine heuristische Prüfung anhand von Teilstrings. Für Renderer-Fallbacks ist die Ausgabe zusätzlich als einzelne reine Freitext-Dosierung gegen das Zielprofil zu validieren. Ein Renderertext für ein 4-Schema, der nach `Dosage.text` geschrieben wird, ist unzulässig; M04 muss zuvor strukturiert migriert sein. Besteht die Renderer-Ausgabe die Invariante `DosageFourSlotPatternInText` nicht, folgt Archiv-Fallback.
| M01 – Dosisbruchteil nicht erlaubt | Exakte, explizit versionierte Dosisumrechnung versuchen. Fehlt sie, Renderer nur für genau ein `Dosage`-Element mit positiver Dosis und wenn der resultierende Text die Freitext-Zielinvarianten besteht. Sonst Archiv-Fallback. Nie runden. |

#### Deterministischer Freitext-Fallback

Wenn eine strukturierte Abbildung nicht sicher möglich oder der Renderer nicht freigegeben ist, MUSS die Migration alle ursprünglichen `Dosage`-Elemente in einem einzigen Freitext-`Dosage`-Element abbilden. Das Format ist verbindlich:

`[ARCHIV-MIGRATION 1.0.7->2.0.0; NICHT ALS EINNAHMEANWEISUNG VERWENDEN] <kanonisches JSON-Array der ursprünglichen Dosage-Elemente>`

Die JSON-Serialisierung MUSS UTF-8 verwenden, Objekt-Schlüssel rekursiv lexikografisch nach Unicode-Codepoint sortieren, keine bedeutungslose Leerraumformatierung enthalten, JSON-Strings standardkonform escapen und Array-Reihenfolgen unverändert lassen. Zahlen MÜSSEN mit dezimalgenauer Arithmetik verarbeitet und ohne Exponentialnotation serialisiert werden; der numerische Wert darf nicht gerundet werden. `null`, fehlende Felder, Extensions und alle übrigen Felder der Dosage-Objekte sind zu erhalten. Das archivierte Original bleibt maßgeblich für die Wiederherstellung ursprünglicher Zahlenschreibweisen.

Das Ziel enthält exakt ein `Dosage`-Element mit ausschließlich `text`; `timing`, `doseAndRate` und alle übrigen Dosage-Felder bleiben in diesem Ziel-Element leer. Bei Migrations-Fallback werden die resource-level Extensions für `renderedDosageInstruction` und `GeneratedDosageInstructionsMeta` entfernt, da der Archivtext nicht vom Textgenerierungsalgorithmus stammt. Andere Extensions bleiben unverändert. Der Präfix verhindert eine Verwechslung mit einem nackten Viererschema. Ein empfangendes System MUSS diesen exakten Präfix erkennen und DARF den Text nicht als ausführbare Einnahmeanweisung oder als fachlich bestätigte Dosierung darstellen.

Dieser Text ist ein gekennzeichneter Archivinhalt und KEINE fachlich bestätigte Einnahmeanweisung. Systeme, die ihn als Dosierung anzeigen oder weiterverwenden, MÜSSEN ihn als nicht fachlich bewerteten Migrations-Fallback kennzeichnen und dürfen ihn nicht als neu geprüfte Dosierungsanweisung darstellen. Ob die Zielanwendung solche Datensätze für die Versorgung verwenden darf, ist außerhalb dieser Transformationsregel festzulegen.

Wird Text mit dem festgelegten Dosierungstext-Algorithmus generiert, muss der Wert in `Dosage.text` mit `renderedDosageInstruction` übereinstimmen; `GeneratedDosageInstructionsMeta` MUSS die tatsächlich verwendete Algorithmusversion und Sprache ausweisen. Wird stattdessen der deterministische Archiv-Fallback verwendet, DARF er nicht fälschlich als Ausgabe des Dosierungstext-Algorithmus gekennzeichnet werden. Eine vorhandene gerenderte Text-Extension ist in diesem Fall zu entfernen oder durch eine nachweislich übereinstimmende, korrekt erzeugte Ausgabe zu ersetzen.

### Fallregeln

Die Fall-IDs dienen als stabile Referenzen für die unten festgelegten Migrationsregeln.

| Fall | Migrationsregel |
|---|---|
| M02 – Exponentialschreibweise | Mit dezimalgenauer Arithmetik in einfache Dezimalschreibweise umwandeln. Bei zulässigem Dosiswert Struktur beibehalten. Verletzt der Wert eine andere Dosisregel, M01 anwenden. |
| M03 – Dosiswert null oder negativ | Nicht mit dem Standardrenderer verarbeiten. Deterministischen Archiv-Fallback verwenden; den Wert als historischen Rohwert kennzeichnen und nicht als klinische „keine Gabe“-Aussage interpretieren. |
| M04 – 4-Schema im Freitext | Mit Python-`re.fullmatch` und folgendem Muster parsen: `r"\s*(?P<morn>(?:0|[1-9][0-9]*)(?:[.,][0-9]{1,2})?)\s*-\s*(?P<noon>(?:0|[1-9][0-9]*)(?:[.,][0-9]{1,2})?)\s*-\s*(?P<eve>(?:0|[1-9][0-9]*)(?:[.,][0-9]{1,2})?)\s*-\s*(?P<night>(?:0|[1-9][0-9]*)(?:[.,][0-9]{1,2})?)(?:\s+(?P<unit>[^\r\n]+?))?\s*"`. Capture-Gruppen sind morgens, mittags, abends, nachts und optionale Einheit. Komma wird vor Decimal-Konvertierung zu Punkt. Einheit MUSS nach `strip()` exakt über eine versionierte Mappingtabelle einem erlaubten Dosiscode zugeordnet sein; leere Einheit ist nur zulässig, wenn eine explizite Quellsystemregel eine Standardeinheit festlegt. Jeder positive Slot wird ein eigenes `Dosage`-Element mit `timing.repeat.when` `MORN`, `NOON`, `EVE` bzw. `NIGHT` und entsprechender `doseQuantity`; Null-Slots werden ausgelassen. Das Ergebnis danach gegen 2.0.0 validieren. Kein positiver Slot, unbekannte Einheit, ungültiges Dezimalformat oder fehlgeschlagene Zielvalidierung führt zum Archiv-Fallback. |
| M05 – Gebrochene `boundsDuration` | Nur exakte Umrechnung in ein ganzzahliges `boundsDuration` mit zulässigem Code. Ist das nicht möglich, Renderer nur für genau ein Dosage-Element und unterstütztes Schema verwenden; sonst Archiv-Fallback. Kalenderperioden nicht umrechnen. |
| M06 – Gebrochene `period` | Exakte Umrechnung auf ganzzahliges `period` und zulässige `periodUnit` versuchen. Nur exakte UCUM-Umrechnungen, zum Beispiel `1.5 d` zu `36 h`; Monate nicht umrechnen. Sonst Renderer nur für genau ein Dosage-Element und unterstütztes Schema, andernfalls Archiv-Fallback. |
| M07 – `frequency > 1` und `period > 1` | Keine Gleichverteilung unterstellen und nicht normalisieren. Das reine Intervall mit `doseAndRate` vom gepinnten Renderer als Text erzeugen; bei Fehler Archiv-Fallback. |
| M08 – Unvollständige oder widersprüchliche Intervallangabe | Keine Werte ableiten. Immer Archiv-Fallback. |
| M09 – Doppelte `when`-Werte | Nicht deduplizieren; immer Archiv-Fallback. |
| M10 – Doppelte `timeOfDay`-Werte | Nicht deduplizieren; immer Archiv-Fallback. |
| M11 – Doppelte `dayOfWeek`-Werte | Nicht deduplizieren; immer Archiv-Fallback. |
| M12 – Gemischte `when`- und `timeOfDay`-Schemata | Keine Angaben verwerfen oder umdeuten; immer Archiv-Fallback. |
| M13 – Wiederholte Tageszeiten mit nicht eindeutiger Dosis | Keine Dosiszuordnung zusammenführen; immer Archiv-Fallback. |
| M14 – Wiederholte `when`-Angaben mit nicht eindeutiger Dosis | Keine Dosiszuordnung zusammenführen; immer Archiv-Fallback. |
| M15 – Zeitrahmen nur teilweise oder unterschiedlich belegt | Rahmen nicht kopieren, vereinheitlichen oder verwerfen; immer Archiv-Fallback. |
| M16 – Nur `timing` oder nur `doseAndRate` vorhanden | Keine Felder ergänzen; immer Archiv-Fallback. |
| M17 – Unterschiedliche Dosis-Codes/Einheiten | Ohne bereitgestellte exakte, versionierte Umrechnungstabelle keine Codekonvertierung durchführen; Archiv-Fallback verwenden. Bei identischem `system` und `code` bleibt die Struktur erhalten. |
| M18 – Anzeigeeinheit passt nicht zum Code | `unit` gemäß der verbindlichen UCUM-Tabelle oben aktualisieren, `value` und `code` erhalten, gesamte Ressource validieren und Text mit dem gepinnten Renderer neu erzeugen. Unbekannter Code oder fehlgeschlagene Validierung: Archiv-Fallback. |
| M19 – Neue 2.0.0-Felder ohne 1.0.7-Quelle | Nicht künstlich befüllen. Bereits vorhandene Quellangaben bleiben erhalten, soweit sie im Zielprofil zulässig sind. |
| M20 – Reine Warnungen | Keine Datenänderung allein zur Beseitigung einer Warnung. Eine Bedingung, die im konkreten Zielprofil ein Fehler ist, wird nach der zugehörigen M-Fallregel behandelt. |
| M21 – Lockerungen, Bugfixes und Constraint-Key-Änderungen | Keine Dosierungsdaten ändern. Konsumenten von Constraint-Keys müssen den neuen Namen verarbeiten, soweit sie solche Meldungen auswerten. |

### Abschlussprüfung

Jede migrierte Zielressource MUSS gegen das festgelegte 2.0.0-Profil validiert werden. Die Prüfung MUSS mindestens folgende Invarianten umfassen: zulässige Dosisbruchteile und Dezimalschreibweise, positive strukturierte Dosiswerte, Freitextregel für 4-Schemata, ganzzahlige Dauer und Periode, Intervallregel, Eindeutigkeit der Zeit-/Wochentagsangaben, vollständige und einheitliche Zeitrahmen sowie Vollständigkeit der strukturierten Dosierung.

Der Migrationslauf MUSS pro Ressourcenfassung Ausgangsversion, Zielversion, angewandte Fall-IDs, Renderer-/Serializer-Version und Validierungsergebnis protokollieren. Eine Ressourcenfassung gilt als migriert, wenn sie entweder strukturiert 2.0.0-konform ist oder eine valide einzelne Freitext-Dosierung mit gekennzeichnetem Archiv-Fallback enthält. Die Originalfassung muss weiterhin abrufbar bleiben.
