Diese Seite beschreibt die Überführung von Dosierungsangaben aus Version 1.0.7 in die Profile der Version 2.0.0. Sie ist systemneutral und legt keine konkrete Ablage- oder Transaktionsschnittstelle fest.

Die Migration MUSS die lesbare Dosierungsaussage erhalten. Die ursprünglichen 1.0.7-Daten MÜSSEN unverändert und versioniert archiviert bleiben. Die Migration DARF keine Dosis runden und keine medizinische Bedeutung aus fehlenden oder mehrdeutigen Daten ableiten.

### Geltungsbereich

Das Verfahren gilt für Dosierungsangaben in `MedicationRequest.dosageInstruction`, `MedicationDispense.dosageInstruction` und `MedicationStatement.dosage`, die nach dem DosageDgMP-/TimingDgMP-Modell von Version 1.0.7 gespeichert wurden.

Jede archivierte Ressourcenfassung wird unabhängig migriert. Das gilt auch für historische und als gelöscht gekennzeichnete Fassungen, sofern sie im Archiv erhalten und abrufbar sind. Eine Migration darf eine gelöschte Fassung nicht wieder als aktuelle Ressource aktivieren. Die Originalfassung bleibt mit ihrem ursprünglichen Profil, Inhalt und Versionskontext wiederherstellbar; die Zielrepräsentation erhält eine nachvollziehbare Zuordnung zur Quelle.

Fehlt eine Dosierungsangabe vollständig, wird keine Dosierung ergänzt. Neue 2.0.0-Felder, die in 1.0.7 nicht vorhanden waren, werden nicht aus Text oder anderen Feldern erraten.

### Migrationsprinzip

Die Verarbeitung erfolgt in dieser Reihenfolge:

1. Die 1.0.7-Quelle unverändert sichern und die Dosierungsangaben aus der jeweiligen Ressourcenfassung extrahieren.
2. 2.0.0-konforme strukturierte Angaben unverändert übernehmen.
3. Eindeutige, exakte Normalisierungen strukturiert durchführen, zum Beispiel eine Exponentialzahl als gleichwertige einfache Dezimalzahl serialisieren oder eine Dauer in eine exakt äquivalente zulässige Einheit umrechnen.
4. Bekannte Viererschemata nur mit vollständigem Muster und bekannter Slot-Semantik strukturiert abbilden.
5. Den 2.0.0-Textgenerierungsalgorithmus nur für Dosierungen verwenden, deren vollständige Aussage er nachweislich abbildet.
6. In allen übrigen Fällen eine einzelne, gekennzeichnete Freitext-Dosierung mit einer deterministischen Darstellung der vollständigen ursprünglichen `Dosage`-Elemente erzeugen.
7. Die Zielressource gegen die 2.0.0-Profile validieren und das Ergebnis sowie den angewandten Migrationspfad protokollieren.

Alle Transformationen MÜSSEN deterministisch und idempotent sein. Ein erneuter Lauf über dasselbe Quellobjekt MUSS denselben Zielinhalt erzeugen. Die Migration ist eine Dunkelverarbeitung: Es gibt keine manuelle Einzelfallprüfung. Deshalb DARF ein nicht renderbarer Fall weder verworfen noch durch eine vermutete klinische Korrektur „repariert“ werden.

### Textgenerierung und Fallback

#### Gepinnter Renderer

Für die in diesem Guide geprüften Fälle wurde die Referenzimplementierung des Dosierungstext-Algorithmus in Version `2.0.0-ballot` verwendet. Die normative Algorithmusspezifikation bleibt maßgeblich; die Beispielimplementierung ist kein allgemeiner Ersatz für Profilvalidierung oder Migration.

Der geprüfte Renderer kann unter anderem folgende Werte vollständig in Text ausdrücken:

- Eine strukturierte Dosis `1.2 Stück` wird beispielsweise als `täglich: je 1,2 Stück` gerendert.
- Eine Dauer `boundsDuration = 1.5 d` wird als `für 1,5 Tage ...` gerendert.
- Eine Periode `period = 1.5 d` wird als `alle 1,5 Tage ...` gerendert.
- Eine Frequenz `2` bei einer Periode von `8 h` wird als `2 x alle 8 Stunden ...` gerendert. Der Renderer normalisiert diese Angabe nicht zu „alle 4 Stunden“.
- Mehrere unterschiedliche Dosen zu derselben Uhrzeit werden jeweils ausgegeben, zum Beispiel `08:00 Uhr — je 1 Stück, 08:00 Uhr — je 2 Stück`.

Der Renderer allein reicht für die Migration nicht aus. Die geprüfte Implementierung bricht bei Dosiswerten `<= 0`, bei fehlender Dosis und bei nicht unterstützten Schema-Kombinationen ab. Sie bricht auch bei doppelten `when`-Angaben und gemischten `when`-/`timeOfDay`-Schemata ab. Bei unterschiedlichen Zeitrahmen über mehrere `Dosage`-Elemente gibt sie nur den Zeitrahmen des ersten Elements aus und würde damit Daten verlieren. Ein 4-Schema kann sie als kompakten Text wie `1-0-1-0 Stück` ausgeben; dieses nackte Muster ist in `Dosage.text` im 2.0.0-dgMP-Profil unzulässig.

Vor Übernahme eines Renderergebnisses MUSS die Migration daher prüfen, dass jedes Quell-`Dosage`-Element vollständig berücksichtigt wurde und kein Wert, Zeitrahmen, Code oder Dosis-/Zeitpunkt-Paar fehlt. Rendererfehler oder unvollständige Ausgabe führen zum unten beschriebenen Fallback, nicht zum Abbruch der Dunkelverarbeitung.

#### Deterministischer Freitext-Fallback

Wenn eine strukturierte Abbildung nicht sicher möglich oder der Renderer nicht vollständig ist, MUSS die Migration alle ursprünglichen `Dosage`-Elemente als ein einziges Freitext-`Dosage`-Element abbilden:

- `Dosage.text` enthält einen eindeutigen Präfix, zum Beispiel `Historische Dosierangabe, automatisch migriert und nicht fachlich bewertet:`.
- Darauf folgt eine deterministische, vollständige Serialisierung der ursprünglichen `Dosage`-Elemente mit allen Dosierungsfeldern, Werten, Codes, Systemen, Einheiten, Timing-Angaben und Extensions. Für die Serialisierung ist eine festgelegte kanonische JSON-Darstellung zu verwenden.
- Das Ziel-`Dosage`-Element enthält ausschließlich `text`; `timing` und `doseAndRate` werden nicht gesetzt. Alle Dosierangaben der Quelle werden in diesem einen Element zusammengeführt.
- Der Präfix verhindert, dass ein nacktes 4-Schema als Dosierungstext fehlinterpretiert wird. Die Darstellung ist ein Archiv-Fallback, keine fachliche Bestätigung oder neue Verordnung.
- Das unveränderte Quellobjekt bleibt für bytegenaue Wiederherstellung maßgeblich. Die Textserialisierung allein garantiert keine Erhaltung der ursprünglichen JSON-Schreibweise, etwa der Schreibweise einer Zahl in Exponentialnotation.

Wird Text mit dem festgelegten Dosierungstext-Algorithmus generiert, muss der Wert in `Dosage.text` mit `renderedDosageInstruction` übereinstimmen; `GeneratedDosageInstructionsMeta` MUSS die tatsächlich verwendete Algorithmusversion und Sprache ausweisen. Wird stattdessen der deterministische Archiv-Fallback verwendet, DARF er nicht fälschlich als Ausgabe des Dosierungstext-Algorithmus gekennzeichnet werden. Eine vorhandene gerenderte Text-Extension ist in diesem Fall zu entfernen oder durch eine nachweislich übereinstimmende, korrekt erzeugte Ausgabe zu ersetzen.

### Fallregeln

Die Fall-IDs dienen als stabile Referenzen für die unten festgelegten Migrationsregeln.

| Fall | Migrationsregel |
|---|---|
| M01 – Dosisbruchteil nicht erlaubt | Zuerst eine exakte, zulässige Einheitenumrechnung versuchen. Ist keine möglich, Dosierung mit dem gepinnten Renderer als Freitext abbilden, sofern alle Angaben vollständig gerendert werden. Nie runden. |
| M02 – Exponentialschreibweise | Mit dezimalgenauer Arithmetik in einfache Dezimalschreibweise umwandeln. Bei zulässigem Dosiswert Struktur beibehalten. Verletzt der Wert eine andere Dosisregel, M01 anwenden. |
| M03 – Dosiswert null oder negativ | Nicht mit dem Standardrenderer verarbeiten. Deterministischen Archiv-Fallback verwenden; den Wert als historischen Rohwert kennzeichnen und nicht als klinische „keine Gabe“-Aussage interpretieren. |
| M04 – 4-Schema im Freitext | Mit vollständig verankertem Regex parsen. Die Positionen sind verbindlich morgens, mittags, abends, nachts. Nur bei vollständigem Match, eindeutig ermittelten Dosiswerten und einer auflösbaren Einheit in `when`-Codes `MORN`, `NOON`, `EVE`, `NIGHT` überführen. Null-Slots bedeuten keine Gabe in diesem Slot. Nicht parsebare Muster als gekennzeichnete Archivdarstellung ablegen, nicht als nacktes 4-Schema. |
| M05 – Gebrochene `boundsDuration` | Eine exakte Umrechnung in eine im Zielprofil zulässige ganzzahlige Einheit bevorzugen. Sonst Renderertext übernehmen, wenn er den vollständigen Zeitrahmen korrekt darstellt und alle Zeitrahmen identisch sind. Andernfalls Archiv-Fallback. |
| M06 – Gebrochene `period` | Eine exakte Umrechnung mit erhaltener Periodenbedeutung bevorzugen. Ist sie nicht möglich, die vollständige Dosierung durch den Renderer als Freitext abbilden; bei Fehler oder unvollständiger Ausgabe Archiv-Fallback. |
| M07 – `frequency > 1` und `period > 1` | Keine Gleichverteilung unterstellen und keine Frequenz-/Periodenumrechnung vornehmen. Die konkrete Kombination mit dem Renderer wörtlich darstellen; bei unvollständiger Ausgabe Archiv-Fallback. |
| M08 – Unvollständige oder widersprüchliche Intervallangabe | Keine fehlenden Timing-Werte ableiten. Renderer nur verwenden, wenn er alle angegebenen Werte ohne Auslassung ausgibt; sonst Archiv-Fallback. |
| M09 – Doppelte `when`-Werte | Nicht stillschweigend deduplizieren. Da der Renderer doppelte Codes ablehnen kann, bei Duplikaten Archiv-Fallback verwenden. |
| M10 – Doppelte `timeOfDay`-Werte | Renderertext verwenden, wenn jedes Uhrzeit-Dosis-Paar erhalten bleibt. Andernfalls Archiv-Fallback. |
| M11 – Doppelte `dayOfWeek`-Werte | Nur nach erfolgreicher Vollständigkeitsprüfung des Renderergebnisses als Text übernehmen; andernfalls Archiv-Fallback. |
| M12 – Gemischte `when`- und `timeOfDay`-Schemata | Keine der Angaben verwerfen und keine gemeinsame Bedeutung unterstellen. Da der Renderer die Kombination ablehnt, Archiv-Fallback verwenden. |
| M13 – Wiederholte Tageszeiten mit nicht eindeutiger Dosis | Renderertext nur verwenden, wenn alle Zeitpunkt-Dosis-Paare enthalten sind. Sonst Archiv-Fallback. |
| M14 – Wiederholte `when`-Angaben mit nicht eindeutiger Dosis | Renderertext nur nach Vollständigkeitsprüfung übernehmen; bei Fehler oder verlorener Zuordnung Archiv-Fallback. |
| M15 – Zeitrahmen nur teilweise oder unterschiedlich belegt | Einen Rahmen nicht auf andere `Dosage`-Elemente übertragen. Bei ungleichen Rahmen keinen Renderer verwenden, der nur den ersten Rahmen ausgibt; vollständigen Archiv-Fallback verwenden. |
| M16 – Nur `timing` oder nur `doseAndRate` vorhanden | Keine fehlenden Dosis- oder Timing-Werte erfinden. Der Renderer unterstützt diese Fälle nicht zuverlässig; Archiv-Fallback verwenden. |
| M17 – Unterschiedliche Dosis-Codes/Einheiten | Physikalisch äquivalente Einheiten exakt auf einen im Zielprofil zulässigen gemeinsamen Code normalisieren. Sonst Dosis-Wert-Einheit-Zuordnungen vollständig im Renderertext erhalten oder Archiv-Fallback verwenden. |
| M18 – Anzeigeeinheit passt nicht zum Code | Wenn der Code gültig und maßgeblich ist, `unit` aus der festgelegten Code-/Terminologiezuordnung korrigieren, `value` und `code` unverändert lassen und gerenderten Text mit dem gepinnten Algorithmus neu erzeugen. Bei ungültigem oder widersprüchlichem Code Archiv-Fallback verwenden. |
| M19 – Neue 2.0.0-Felder ohne 1.0.7-Quelle | Nicht künstlich befüllen. Bereits vorhandene Quellangaben bleiben erhalten, soweit sie im Zielprofil zulässig sind. |
| M20 – Reine Warnungen | Keine Datenänderung allein zur Beseitigung einer Warnung. Eine Bedingung, die im konkreten Zielprofil ein Fehler ist, wird nach der zugehörigen M-Fallregel behandelt. |
| M21 – Lockerungen, Bugfixes und Constraint-Key-Änderungen | Keine Dosierungsdaten ändern. Konsumenten von Constraint-Keys müssen den neuen Namen verarbeiten, soweit sie solche Meldungen auswerten. |

### Abschlussprüfung

Jede migrierte Zielressource MUSS gegen das festgelegte 2.0.0-Profil validiert werden. Die Prüfung MUSS mindestens folgende Invarianten umfassen: zulässige Dosisbruchteile und Dezimalschreibweise, positive strukturierte Dosiswerte, Freitextregel für 4-Schemata, ganzzahlige Dauer und Periode, Intervallregel, Eindeutigkeit der Zeit-/Wochentagsangaben, vollständige und einheitliche Zeitrahmen sowie Vollständigkeit der strukturierten Dosierung.

Der Migrationslauf MUSS pro Ressourcenfassung Ausgangsversion, Zielversion, angewandte Fall-IDs, Renderer-/Serializer-Version und Validierungsergebnis protokollieren. Eine Ressourcenfassung gilt als migriert, wenn sie entweder strukturiert 2.0.0-konform ist oder eine valide einzelne Freitext-Dosierung mit gekennzeichnetem Archiv-Fallback enthält. Die Originalfassung muss weiterhin abrufbar bleiben.
