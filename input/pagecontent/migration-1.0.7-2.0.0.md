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
3. Für jedes `Dosage.text`, das den M04-Constraint-Ausdruck erfüllt, exakt `täglich: ` vor den unveränderten Text setzen. Das Muster wird nicht geparst und die Dosierung nicht strukturiert umgewandelt.
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

Für M04 werden weder Dosiswerte noch Einheiten geparst oder umcodiert. Der ursprüngliche `Dosage.text` bleibt nach dem Präfix bytegetreu erhalten.

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

- **M01:** genau ein vollständiges `Dosage`-Element mit positiver Dosis, unterstütztem Timing-Schema und erfolgreicher Vollständigkeitsprüfung. Renderer-Freitext muss gegen alle 2.0.0-Textinvarianten validiert werden.
- **M05/M06:** genau ein vollständiges `Dosage`-Element mit `doseAndRate` und unterstütztem Timing-Schema.
- **M07:** genau ein reines Intervallschema (`frequency`, `period`, `periodUnit`, keine `when`, `timeOfDay` oder `dayOfWeek`) mit `doseAndRate`.
- **M18:** nur nach erfolgreicher Korrektur der Anzeigeeinheit und erfolgreicher Validierung der gesamten strukturierten Zielressource.

M03 und M08–M17 verwenden den gemeinsamen [Freitext-Fallback](./migration-freitext-fallback.html). Auch wenn eine der strukturierten Migrationen M01, M05, M06, M07 oder M18 an ihrer festgelegten Vorbedingung, am Renderer oder an der Zielvalidierung scheitert, wird dieses einheitliche Fallback-Verfahren verwendet. M19–M21 erfordern keine Datenänderung.

Das Ergebnis wird ausschließlich dann als Renderertext übernommen, wenn der Aufruf erfolgreich ist, eine nichtleere Zeichenkette liefert, die Eingabe vollständig zur Allowlist passt und die resultierende Freitext-Dosierung gegen das Zielprofil validiert. Es gibt keine heuristische Prüfung anhand von Teilstrings. M04 verwendet den Renderer nicht.

#### Gemeinsamer Freitext-Fallback

Fälle ohne sichere strukturierte Zielabbildung werden nicht jeweils anders behandelt. Es gilt das einheitliche Verfahren auf der Seite [Gemeinsamer Freitext-Fallback](./migration-freitext-fallback.html). Dort sind das Serialisierungsformat, die technische Erkennung und alle betroffenen M-Fälle zusammengefasst.

### Fallregeln

Die Fall-IDs dienen als stabile Referenzen für die unten festgelegten Migrationsregeln.

| Fall | Constraint(s) | Einordnung | Beschreibung |
|---|---|---|---|
| M01 – Dosisbruchteil nicht erlaubt | `DosageDoseQuantityAllowedFractions` | Konvertierung möglich | [M01](./migration-m01-dosisbruchteil.html) |
| M02 – Exponentialschreibweise | `DosageDoseValueDecimalNotation` | Strukturierte Normalisierung | [M02](./migration-m02-exponentialnotation.html) |
| M03 – Dosiswert null oder negativ | `DosageDoseValuePositive` | Gemeinsamer Freitext-Fallback | [M03](./migration-freitext-fallback.html) |
| M04 – 4-Schema im Freitext | `DosageFourSlotPatternInText` | Textmigration möglich | [M04](./migration-m04-viererschema-freitext.html) |
| M05 – Gebrochene `boundsDuration` | `TimingBoundsDurationOnlyWholeNumber` | Konvertierung möglich | [M05](./migration-m05-boundsduration.html) |
| M06 – Gebrochene `period` | `TimingPeriodOnlyWholeNumber` | Konvertierung möglich | [M06](./migration-m06-period.html) |
| M07 – `frequency > 1` und `period > 1` | `TimingFreqOrPeriodGtOne` | Konvertierung möglich | [M07](./migration-m07-frequenz-periode.html) |
| M08–M17 – Fehlende, widersprüchliche oder nicht sicher umrechenbare Informationen | jeweiliger Constraint siehe Fallbackseite | Gemeinsamer Freitext-Fallback | [Betroffene Fälle und Ablauf](./migration-freitext-fallback.html) |
| M18 – Anzeigeeinheit passt nicht zum Code | `TimingBoundsUnitMatchesCode` | Strukturierte Korrektur möglich | [M18](./migration-m18-einheitenanzeige.html) |
| M19–M21 – Neue Felder, reine Warnungen und Lockerungen | — | Keine Datenmigration | Es werden keine Dosierungsdaten geändert. |

### Abschlussprüfung

Jede migrierte Zielressource MUSS gegen das festgelegte 2.0.0-Profil validiert werden. Die Prüfung MUSS mindestens folgende Invarianten umfassen: zulässige Dosisbruchteile und Dezimalschreibweise, positive strukturierte Dosiswerte, Freitextregel für 4-Schemata, ganzzahlige Dauer und Periode, Intervallregel, Eindeutigkeit der Zeit-/Wochentagsangaben, vollständige und einheitliche Zeitrahmen sowie Vollständigkeit der strukturierten Dosierung.

Der Migrationslauf MUSS pro Ressourcenfassung Ausgangsversion, Zielversion, angewandte Fall-IDs, Renderer-/Serializer-Version und Validierungsergebnis protokollieren. Eine Ressourcenfassung gilt als migriert, wenn sie entweder strukturiert 2.0.0-konform ist oder eine valide einzelne Freitext-Dosierung mit gekennzeichnetem Archiv-Fallback enthält. Die Originalfassung muss weiterhin abrufbar bleiben.
