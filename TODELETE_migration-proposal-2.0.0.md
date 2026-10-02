# Vorschlag: Migration von Dosierdaten 1.0.7 auf 2.0.0

**Status:** Arbeitsvorschlag für die technische und fachliche Abstimmung  
**Grundlage:** `migration-analysis-2.0.0-ballot.md` und die FSH-Referenzmodelle unter `fsh_107/`

## Ziel und Leitlinie

Die Migration soll alle Bestandsdaten vor dem Cutover in eine festgelegte 2.0.0-Repräsentation überführen, ohne eine klinische Aussage unbemerkt zu verändern. Eine nicht eindeutig abbildbare Ressource darf nicht einfach übersprungen werden: Für sie muss vor dem Cutover eine fachliche Korrektur, eine vereinbarte Zielrepräsentation oder eine explizite Kompatibilitätslösung festgelegt werden. Die unveränderte 1.0.7-Quelle bleibt zusätzlich als Auditnachweis erhalten.

Empfohlen wird eine **versionierte Ableitung statt Überschreiben**:

1. Die ursprüngliche Ressource einschließlich ihrer Version und des ursprünglichen Payloads unverändert archivieren.
2. Eine 2.0.0-Zielressource mit stabiler Zuordnung zur Quelle erzeugen.
3. Transformation, Software-/Mapping-Version, Zeitstempel, Validierungsergebnis und Prüferentscheidung dokumentieren. Dafür nach Möglichkeit FHIR `Provenance` und einen Migrationsmanifest-Eintrag verwenden.
4. Bei Anforderungen an bytegenaue Reversibilität zusätzlich die Originalbytes oder einen unveränderlichen Export samt Hash archivieren. Ein FHIR-Parse-and-serialize kann die Schreibweise von JSON-Zahlen normalisieren.

**Vorgeschlagene Fallback-Reihenfolge:** (1) strukturierte Daten unverändert übernehmen, wenn sie 2.0.0-konform sind; (2) wenn möglich strukturerhaltend und exakt normalisieren; (3) nur wenn die Struktur nicht valide abbildbar ist, die gesamte Dosierungsanweisung in eine einzelne reine Freitext-Dosierung überführen. Freitext ist nur zulässig, wenn der vollständige Inhalt eindeutig und fachlich verständlich gerendert werden kann. Im Ziel muss es genau ein `Dosage`-Element mit `text` und ohne `timing`/`doseAndRate` geben. Falls `renderedDosageInstruction` befüllt wird, muss sein Inhalt exakt mit `Dosage.text` übereinstimmen. Ein im Profil verbotenes nacktes 4-Schema darf nicht als Freitext stehen bleiben. Freitext erhält die klinische Aussage, aber nicht die strukturierte Maschinenverarbeitbarkeit; diese Einschränkung ist zu protokollieren. Die unveränderte Quelle bleibt archiviert.

## Nummerierter Fallkatalog

Die IDs sind stabile Diskussionsreferenzen. Die Empfehlung ist ein Ausgangspunkt, keine bereits beschlossene Migrationsregel. Für jeden Fall bleibt die konkrete Regel offen, bis sie fachlich festgelegt ist. „Kein Umbau erforderlich“ bedeutet, dass die jeweilige Änderung für sich allein keine Bestandsdatenumschreibung verlangt; sie ersetzt nicht die Validierung der gesamten Zielressource.

### Dosiswerte und Freitext

**M01 – Dosisbruchteil nicht erlaubt** (`DosageDoseQuantityAllowedFractions`)

Beispiel: `1.2` ist weder ganzzahlig noch einer der erlaubten Bruchteile. Nicht runden. Eine exakte Umrechnung in eine andere zulässige Einheit kann möglich sein, wenn Wirkstärke bzw. Konzentration eindeutig bekannt sind.

**Bewertung:** Freitext als gezielter Fallback ist praktikabel, wenn der Wert und die gesamte Einnahmeanweisung unverändert und eindeutig formulierbar sind. Zuerst exakte Einheitenumrechnung versuchen.

**Vorgeschlagene Regel:** Bei exakter zulässiger strukturierter Umrechnung strukturiert migrieren. Andernfalls die vollständige Dosierungsanweisung als einzelnes Freitext-`Dosage` migrieren; niemals runden. Nur automatisieren, wenn ein getesteter Renderer Wert, Einheit und Timing vollständig erhält, andernfalls fachlich freigeben.

**M02 – Exponentialschreibweise** (`DosageDoseValueDecimalNotation`)

Beispiel: `50e-2` als `0.5` serialisieren. Das ist eine technische Normalisierung, wenn der numerische Wert exakt gleich bleibt und die Zielschreibweise die übrigen Dosisregeln erfüllt.

**Bewertung:** Zustimmung zur technischen Migration; Freitext nur als Rückfall, falls der normalisierte Wert an einer anderen Dosisregel scheitert.

**Vorgeschlagene Regel:** Mit dezimalgenauer Arithmetik kanonisieren und gegen die Fraction-/Positivitätsregeln validieren. Ist der Wert zulässig, strukturiert belassen. Ist er numerisch exakt, aber als strukturierter Dosiswert nicht zulässig, die vollständige Dosierungsanweisung als Freitext migrieren. Keine binäre Gleitkomma-Rundung.

**M03 – Dosiswert null oder negativ** (`DosageDoseValuePositive`)

Nicht automatisch auf einen positiven Wert ändern oder den Dosiswert entfernen. Zuerst klären, ob ein Datenfehler, eine Auslass-/Stoppanweisung oder eine andere klinische Bedeutung vorliegt.

**Bewertung:** Freitext ist möglich, aber nicht als blindes Kopieren von `0` oder einem negativen Wert. Solche Zeichenfolgen könnten als gültige Einnahmeanweisung missverstanden werden.

**Vorgeschlagene Regel:** Bei bestätigter und verständlich formulierbarer Semantik (z. B. explizit „keine Gabe“) die vollständige Anweisung als Freitext migrieren. Bei negativem Wert oder unklarer Nullbedeutung fachliche Korrektur verlangen; eine automatische Migration als Text ist dann nicht freigegeben.

**M04 – 4-Schema nur im Freitext** (`DosageFourSlotPatternInText`)

Beispiel: `1-0-1-0`. Ein strikt geankerter Regex kann das Muster erkennen und Werte extrahieren, bestimmt aber nicht, was die vier Positionen bedeuten.

**Bewertung:** Regex-basierte Strukturmigration ist geeignet, wenn pro Quellsystem die Slot-Bedeutung und Einheit verbindlich definiert sind. Regex allein reicht nicht zur semantischen Zuordnung.

**Vorgeschlagene Regel:** Mit Regex parsen, nur bei vollständigem Match und freigegebener Slot-Zuordnung strukturierte Dosage-/Timing-Felder erzeugen und anschließend validieren. Wenn Parsing oder Bedeutung nicht eindeutig ist, nicht als nacktes 4-Schema in Freitext übernehmen (das ist im dgMP-Zielprofil verboten); fachlich entscheiden oder eine lesbare Freitextform verwenden, die das Muster eindeutig auflöst.

### Perioden, Intervalle und Zeitrahmen

**M05 – Gebrochene Behandlungsdauer** (`TimingBoundsDurationOnlyWholeNumber`)

Eine exakte Umrechnung in eine zulässige ganzzahlige Einheit kann möglich sein, etwa `1.5 d` zu `36 h`, wenn dies dieselbe Dauer ausdrückt und `h` im Zielprofil zulässig ist. Kalenderbezogene Monate/Jahre nicht ohne festgelegte fachliche Regel in Tage umrechnen.

**Bewertung:** Strukturerhaltende Einheitenumrechnung ist der Vorzug; Freitext ist ein möglicher Fallback, wenn der Zeitraum vollständig und verständlich gerendert werden kann.

**Vorgeschlagene Regel:** Exakt in eine ganzzahlige erlaubte Einheit umrechnen und strukturiert migrieren. Ist keine eindeutige Zielperiode verfügbar, die gesamte Dosierungsanweisung als Freitext migrieren. Kalenderdauern nur nach festgelegter Kalenderregel automatisch umrechnen.

**M06 – Gebrochene Periode** (`TimingPeriodOnlyWholeNumber`)

Wie M05, aber bezogen auf `period`. Nur eine exakte Umrechnung mit erhaltener Wiederholungsbedeutung ist zulässig; die Zielperiode muss ganzzahlig und im Profil erlaubt sein.

**Bewertung:** Zustimmung zur exakten Einheitenumrechnung; nicht ganzzahlig darstellbare oder semantisch unsichere Perioden können als vollständige Textanweisung migriert werden.

**Vorgeschlagene Regel:** Exakte zulässige Umrechnung bevorzugen. Sonst gesamte Anweisung als Freitext, sofern der Renderer Periodenwert, Einheit, Frequenz und begleitende Angaben unmissverständlich erhält. Keine isolierte Umwandlung nur des `period`-Feldes in Text bei gleichzeitig strukturierter Dosierung.

**M07 – Frequenz und Periode beide größer als eins** (`TimingFreqOrPeriodGtOne`)

Bei einem reinen Intervall kann `2` Gaben pro `8 h` zu `1` Gabe pro `4 h` normalisiert werden, wenn eine gleichmäßige Verteilung fachlich gemeint ist. FHIR frequency/period beschreibt eine Häufigkeit innerhalb eines Zeitraums und beweist für sich genommen keine gleichmäßige Verteilung.

**Bewertung:** Strukturelle Normalisierung ist nur bei fachlich bestätigtem gleichmäßigem Intervall sicher. Sonst ist vollständiger Freitext die verlustärmere Zieloption.

**Vorgeschlagene Regel:** Bei bestätigter Gleichverteilung mathematisch äquivalent und ganzzahlig normalisieren. Andernfalls vollständige Dosierungsanweisung in ein einzelnes Freitext-`Dosage` migrieren, sofern die ursprüngliche Intervallbedeutung lesbar darstellbar ist.

**M08 – Widersprüchliche Intervallangabe ohne vollständige Intervallfelder** (`TimingOnlyOneTimeForInterval`)

Die neue Schemaerkennung prüft auch Fälle ohne vollständig angegebene `frequency`, `period` und `periodUnit`. Fehlende Werte nicht aus den vorhandenen Zeitpunkten ableiten.

**Bewertung:** Freitext ist hier ein robuster Fallback, wenn er alle Zeitpunkte und Dosen abbildet. Struktur ergänzen, wenn die fehlenden Werte verbindlich aus einer anderen Quelle hervorgehen.

**Vorgeschlagene Regel:** Bei eindeutig belegter Intervallsemantik fehlende Pflichtfelder strukturiert ergänzen; sonst die vollständige Anweisung als Freitext migrieren. Bei widersprüchlichen Angaben zunächst fachlich auflösen, nicht automatisch auswählen.

**M09 – Doppelte `when`-Werte** (`TimingOnlyOneWhen`)

Gleiche `when`-Angaben über mehrere Dosage-Elemente hinweg prüfen, auch wenn keine Intervallfelder belegt sind. Zusammenführung in ein Dosage-Element nur, wenn die Dosis und alle weiteren Angaben gleich bleiben.

**Bewertung:** Erst redundante identische Einträge strukturiert deduplizieren. Wenn die Zeitangaben bestehen bleiben, aber nicht konform modellierbar sind, ist Freitext möglich, sofern alle Dosiszuordnungen erhalten bleiben.

**Vorgeschlagene Regel:** Exakt redundante `when`-Werte in einer strukturierten Dosage zusammenführen und Frequenz neu validieren. Bei nicht verlustfrei zusammenführbaren Fällen die vollständigen Anweisungen in einem Freitext-`Dosage` formulieren und fachlich freigeben.

**M10 – Doppelte `timeOfDay`-Werte** (`TimingOnlyOneTimeOfDay`)

Wie M09 für Uhrzeiten. Duplikate nur dann entfernen oder aggregieren, wenn sie redundant sind und dadurch keine Dosiszuordnung verloren geht.

**Bewertung:** Strukturierte Aggregation gleicher Uhrzeiten ist vorzuziehen; andernfalls Freitext mit expliziter Zuordnung von Uhrzeit und Dosis.

**Vorgeschlagene Regel:** Redundante identische Angaben zusammenführen und Zielvalidierung ausführen. Wenn dadurch Dosiszuordnungen nicht eindeutig strukturiert bleiben, die vollständige Anweisung als Freitext migrieren.

**M11 – Doppelte `dayOfWeek`-Werte** (`TimingOnlyOneDayOfWeek`)

Wie M09 für Wochentage. Wochentage in einem einzelnen Timing können nur dann zusammengeführt werden, wenn Frequenz und zugeordnete Dosis anschließend weiterhin korrekt sind.

**Bewertung:** Strukturierte Zusammenführung ist vorzuziehen, wenn die Dosis an allen Tagen gleich ist und Frequenz korrekt bleibt. Andernfalls Freitext mit expliziten Tagen und Dosen.

**Vorgeschlagene Regel:** Wochentage strukturiert aggregieren und Frequenz neu bestimmen, wenn die Zuordnung eindeutig ist; sonst die gesamte Anweisung als Freitext migrieren.

**M12 – Gemischte `when`- und `timeOfDay`-Schemata** (`TimingOnlyWhenOrTimeOfDay`)

Prüfen, ob die Ressource zwei alternative oder widersprüchliche Schemata enthält. Nicht eines der beiden Felder stillschweigend verwerfen.

**Bewertung:** Bei eindeutig interpretierbarer Kombination kann die vollständige Aussage in Freitext erhalten werden. Wenn die Angaben einander widersprechen, ist vorher eine fachliche Entscheidung nötig.

**Vorgeschlagene Regel:** Wenn beide Zeitangaben gemeinsam eine verständliche Aussage bilden, gesamte Dosierung als Freitext migrieren. Bei echter Mehrdeutigkeit fachlich auflösen; keine der Angaben automatisch verwerfen.

**M13 – Wiederholte Tageszeiten mit nicht eindeutiger Dosis** (`TimingSingleDosageForTimeOfDay`)

Bei mehreren Dosage-Elementen muss jedes eine eindeutige vollständige Dosis tragen. Identische Dosis- und Timing-Angaben können nach bestätigter Redundanz in einem Element aggregiert werden; unterschiedliche oder widersprüchliche Dosen benötigen fachliche Entscheidung.

**Bewertung:** Strukturierte Zusammenführung ist gut, wenn jeder Zeitpunkt eindeutig einer Dosis zugeordnet ist. Andernfalls kann ein einzelner Text alle Zeitpunkt-Dosis-Paare erhalten.

**Vorgeschlagene Regel:** Eindeutige unterschiedliche Dosen strukturiert zuordnen und identische Duplikate aggregieren. Wenn 2.0.0 keine verlustfreie Struktur zulässt, vollständige Liste aller Zeitpunkt-Dosis-Paare als Freitext migrieren.

**M14 – Wiederholte `when`-Angaben mit nicht eindeutiger Dosis** (`TimingSingleDosageForWhen`)

Analog zu M13 für Tageszeit-Codes wie morgens oder abends. Dosiswerte einschließlich Datentyp vergleichen und keine abweichende Dosiszuordnung verlieren.

**Bewertung:** Wie M13: erst strukturelle Zuordnung/Redundanz prüfen, Freitext als Rückfall.

**Vorgeschlagene Regel:** Eindeutige Dosen strukturiert zuordnen. Sonst alle `when`-Dosis-Paare in ein einzelnes Freitext-`Dosage` migrieren, sofern die Textform eindeutig und vollständig ist.

**M15 – Zeitrahmen nur teilweise belegt** (`TimingOnlyOneBounds`)

Fehlende Zeitrahmen nur ergänzen, wenn für alle Dosage-Elemente nachweislich derselbe Zeitraum gilt. Wenn unterschiedliche Zeiträume fachlich beabsichtigt sind, muss eine Zielmodellierung festgelegt werden; nicht einfach kopieren oder entfernen.

**Bewertung:** Identische Zeitrahmen strukturell ergänzen; bei unterschiedlichen Rahmen ist Freitext eine mögliche Abbildung, wenn jeder Zeitraum einer Dosis eindeutig zugeordnet werden kann.

**Vorgeschlagene Regel:** Nachweislich gemeinsame Zeitgrenze auf alle Dosages übertragen. Sind Zeitrahmen verschieden oder nicht sicher zuordenbar, vollständige Dosierungsanweisung inklusive der jeweiligen Zeiträume als Freitext migrieren und fachlich freigeben.

### Struktur, Einheiten und Profilkontext

**M16 – Strukturierte Dosierung enthält nur `timing` oder nur `doseAndRate`** (`DosageStructuredRequiresBoth`)

Im generischen `DosageDE` ist die entsprechende Prüfung eine Warnung; im dgMP-Zielprofil ist sie ein Fehler.

**Bewertung:** Freitext ist der vorgesehene Fallback, wenn die unvollständige strukturierte Aussage vollständig wiedergegeben werden kann. Fehlende Werte nicht erfinden.

**Vorgeschlagene Regel:** Fehlendes `timing` oder `doseAndRate` aus einer verlässlichen Quelle ergänzen, wenn verfügbar. Sonst die vorhandene vollständige Aussage als einzelnes Freitext-`Dosage` migrieren. Kann sie so keine sinnvolle Dosieranweisung ergeben, fachlich korrigieren lassen.

**M17 – Unterschiedliche Dosis-Codes über Dosage-Elemente** (`DosageDoseUnitSameCodeWarning` bzw. dgMP-Dosis-Einheitenprüfung)

Auf eine gemeinsame Einheit normalisieren, wenn die Einheiten dieselbe Bedeutung haben und die Umrechnung exakt ist. Bei nicht äquivalenten Codes oder Einheiten nicht automatisch umrechnen.

**Bewertung:** Strukturierte exakte Einheitenumrechnung ist klar vorzuziehen. Freitext als Fallback vermeidet eine falsche Gleichsetzung nicht äquivalenter Einheiten.

**Vorgeschlagene Regel:** Äquivalente Einheiten exakt in einen gemeinsamen zulässigen Code umrechnen. Wenn Codes/Einheiten nicht äquivalent sind oder nicht sicher umgerechnet werden können, alle Dosis-Einheit-Zuordnungen in einem Freitext-`Dosage` erhalten.

**M18 – Anzeigeeinheit passt nicht zum UCUM-Code** (`TimingBoundsUnitMatchesCodeWarning`)

Wenn der UCUM-Code eindeutig ist, kann die Anzeigeeinheit über eine freigegebene Code-zu-Anzeige-Zuordnung korrigiert werden. Numerischen Wert und Code dabei nicht verändern. Profilabhängig prüfen, ob es Warnung oder Fehler ist.

**Bewertung:** Zustimmung unter der Bedingung, dass der Code gültig und fachlich maßgeblich ist. Bei strukturierten Dosierungen anschließend den gerenderten Text neu erzeugen.

**Vorgeschlagene Regel:** `unit` anhand des gültigen Codesystems-Codes korrigieren; `value` und `code` nicht ändern. Den betroffenen `renderedDosageInstruction` mit der festgelegten Algorithmusversion neu generieren und Metadaten aktualisieren. Ist der Code selbst ungültig oder widerspricht er der fachlich maßgeblichen Einheit, manuell klären.

**M19 – Neue Felder ohne 1.0.7-Quelle**

Umfasst unter anderem `asNeededBoolean`, `asNeededFor`, `doseRange`, `frequencyMax`, `periodMax`, `maxDosePerPeriod`, `patientInstruction` und `boundsPeriod`.

**Bewertung:** Zustimmung: keine Migration dieser Felder, sofern keine unabhängige Quelle entsprechende Angaben enthält.

**Vorgeschlagene Regel:** Ohne verlässliche Zusatzquelle nicht befüllen. Diese Felder sind kein Migrationshindernis; übrige vorhandene Daten trotzdem gegen das Zielprofil validieren.

**M20 – Warnung ohne zusätzliche harte Zielregel**

Reine Warnungen ohne korrespondierende harte Zielregel müssen keine Datenumschreibung auslösen. Sie bleiben für Monitoring und Qualitätsberichte sichtbar. Eine Warnung darf nicht ignoriert werden, wenn dieselbe Bedingung im konkreten 2.0.0-dgMP-Profil als Fehler auftritt.

**Bewertung:** Zustimmung: reine Warnungen können ohne Migration übernommen werden; Validierungsfehler bleiben durch den jeweils zuständigen Fall abzudecken.

**Vorgeschlagene Regel:** Warnungen protokollieren, aber nicht als Grund für Freitextkonvertierung verwenden. Für harte dgMP-Fehler die spezifische Regel des Fallkatalogs anwenden.

**M21 – Lockerungen, Bugfixes und Constraint-Key-Änderung**

Die gelockerten Timing-Regeln sowie unveränderte Ausdrücke benötigen keine Datenumschreibung. Beim Umbenennen von `DosageWarnungViererschemaInText` zu `DosageFourSlotPatternInTextWarning` müssen Auswertungen und Integrationen angepasst werden, die den alten Constraint-Key auslesen.

**Bewertung:** Zustimmung: keine Ressourcendaten-Migration; allenfalls technische Anpassung der auswertenden Systeme.

**Vorgeschlagene Regel:** Keine Daten ändern. Constraint-Key-Verbraucher im Validator-/Monitoring-Setup auf den neuen Namen umstellen und deren Tests aktualisieren.

## Ablauf

### 1. Bestand sichern und klassifizieren

- Nur Ressourcen identifizieren, die tatsächlich als 1.0.7-Dosierungsdaten geführt werden; Typen `MedicationRequest`, `MedicationDispense` und `MedicationStatement` getrennt auswerten.
- Ursprungsressource, ID/Version, referenzierte Ressource und vorhandene Provenienz erfassen.
- Bestand zunächst mit dem 1.0.7-Profil validieren und Ergebnisse als Ausgangsbefund sichern.
- Anschließend mit 2.0.0 validieren und Fehler nach den oben genannten Migrationsfällen klassifizieren. Fehlende neue Felder nicht als Migrationsfehler zählen.

### 2. Sichere Normalisierungen anwenden

Zuerst deterministische, strukturerhaltende Änderungen automatisieren. Wenn die Zielstruktur danach weiterhin nicht konform ist, nur bei vollständiger und verständlicher Renderbarkeit auf eine einzelne reine Freitext-Dosierung zurückfallen. Transformationen müssen idempotent sein. Vorher-/Nachher-Werte, verwendete Parser-/Renderer-Version, angewandte Fall-ID und Verlust der strukturierten Verarbeitbarkeit protokollieren.

### 3. Fachliche Ausnahmefälle entscheiden

Jede Ressource erhält einen stabilen Status, mindestens `strukturiert migriert`, `als Freitext migriert`, `fachlich korrigiert` oder `technischer Fehler`. Mehrdeutige Fälle werden vor dem Cutover entschieden. Sie dürfen nicht übersprungen oder als erfolgreich migriert gezählt werden.

### 4. Ziel validieren und freigeben

- Jede erzeugte Ressource gegen die tatsächlich verwendeten 2.0.0-Profile und Terminologien validieren.
- Neue Fehler müssen entweder durch eine nachvollziehbare verlustfreie Transformation oder durch fachliche Entscheidung aufgelöst werden. Warnungen separat berichten.
- Zahlenwerte, UCUM-Code und Anzeigeeinheit gemeinsam auf Plausibilität prüfen; Rundung ist keine zulässige automatische Reparatur.
- Stichproben sowie alle manuell entschiedenen Fälle fachlich freigeben. Erst danach Zielressourcen produktiv schalten.

## Abnahmekriterien

- Für jede Zielressource ist die konkrete 1.0.7-Quelle auffindbar; die Quelle ist unverändert wiederherstellbar.
- Kein numerischer Dosiswert wurde gerundet oder ohne fachliche Freigabe verändert. Jede Freitextkonvertierung ist als Verlust strukturierter Verarbeitbarkeit dokumentiert.
- Jede Umrechnung erhält den exakten Wert und eine zulässige Zielrepräsentation.
- Alle Zielressourcen bestehen die für sie geltende 2.0.0-Validierung. Vor dem Cutover verbleiben keine ungeklärten Migrationsfälle.
- Mengen, Fehler, Warnungen und Ausnahmegründe sind je Ressourcentyp und Transformationsregel auswertbar.
- Ein erneuter Migrationslauf liefert dasselbe Ergebnis.

## Noch fachlich festzulegen

1. Welche konkrete 2.0.0-Ballot-/Release-Version und welche Validator-/Terminologiepakete sind verbindlich?
2. Welche Perioden- und Dauer-Einheiten sind für automatische Umrechnungen zugelassen, insbesondere bei Kalenderdauern?
3. Wer darf eine klinische Äquivalenz bei Intervallnormalisierungen und Zusammenführung mehrfacher Dosage-Elemente bestätigen?
4. Wie werden nicht konforme, aber revisionspflichtige Altdaten im Zielsystem auffindbar und von neu erstellten 2.0.0-Daten unterscheidbar gehalten?
