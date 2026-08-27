# Review: Planung vs. technische Umsetzung der Dosierungstextgenerierung

**Planungsstand:** [`ERPCHANGES-ErweiterteDosisTextgenerierung-270726-1059-182.md`](./ERPCHANGES-ErweiterteDosisTextgenerierung-270726-1059-182.md)  
**Umgesetzte Spezifikation:** [`input/pagecontent/dosierung-textgenerierung.md`](./input/pagecontent/dosierung-textgenerierung.md)  
**Review-Datum:** 29.07.2026

## Ziel und Abgrenzung

Dieses Review beschreibt, was sich zwischen der fachlichen Planung und der nach der technischen Umsetzung entstandenen Spezifikation geändert hat. Verglichen wird der Inhalt der beiden Markdown-Dateien. Es handelt sich nicht um einen erneuten Abgleich der Spezifikation mit dem Python-Skript oder den FSH-Profilen.

Redaktionelle Artefakte der PDF-Konvertierung, beispielsweise getrennte Wörter oder beschädigte Markdown-Formatierung, werden nicht als fachliche Änderungen gewertet.

## Kurzfazit

Aus dem Planungsdokument mit dem Status „IN ARBEIT“ ist eine normative, implementierbare Algorithmus-Spezifikation in Version **2.0.0** geworden.

Die im Verlauf des Planungsdokuments festgehaltenen fachlichen Entscheidungen wurden weitgehend übernommen:

- Bereiche werden mit „bis“ dargestellt; ein variables 4-Schema wird ausgeschrieben.
- Die Bedarfsmedikation wird einzeilig dargestellt.
- Der Doppelpunkt steht direkt hinter dem Einnahmeanlass beziehungsweise „bei Bedarf“.
- Uhrzeit- und Tagesabschnittssegmente werden mit Komma, Wochentagssegmente mit Semikolon getrennt.
- Die Nachtpause ist nicht Bestandteil des Algorithmus.
- Der Gedankenstrich bleibt entgegen dem im Verlauf dokumentierten KBV-Prüfvorschlag erhalten.

Die größten Abweichungen von der Planung sind:

1. `route` wird nicht ausgegeben und ist im dgMP-Profil ausgeschlossen.
2. Hinweise stammen nicht aus `additionalInstruction`, sondern aus `patientInstruction`.
3. Bedarf ist kein isoliertes Darstellungsschema mehr, sondern zusätzlich ein Querschnittsmerkmal aller strukturierten Schemata.
4. Schema-Erkennung, Mehrfach-`Dosage`-Aggregation, Normalisierung und Fehlerverhalten wurden vollständig und deterministisch festgelegt.
5. Ein nicht unterstützter Fall erzeugt keinen publizierbaren Fehlertext mehr, sondern führt zum Abbruch.
6. Bei Intervall-Kombinationen mit konkreten `timeOfDay`- oder `when`-Segmenten wird eine vorhandene `frequency` abweichend von der allgemeinen Planungsregel nicht mehr ausgegeben.

## Übernahme der fachlichen Entscheidungen aus der Planung

| Thema | Planung | Umgesetzte Spezifikation | Bewertung |
|---|---|---|---|
| Bereichsdarstellung | Vier Optionen; im Verlauf Vorschlag für Option 2 | Durchgängig „bis“; variables 4-Schema wird ausgeschrieben | Entscheidung übernommen |
| Bedarfsdarstellung | Einzeiler oder Take-Wait-Stop | Ausschließlich Einzeiler | Entscheidung übernommen |
| Doppelpunkt bei Bedarf | Ursprüngliches Muster nach Mindestabstand; im Verlauf hinter Einnahmeanlass beschlossen | Direkt hinter `bei {Anlass}` beziehungsweise `bei Bedarf` | Verlaufsvotum übernommen |
| Segmenttrennung | Haupttext und Beispiele teilweise noch mit Semikolon für Uhrzeiten | Komma für Uhrzeiten/Tagesabschnitte, Semikolon für Wochentage | Verlaufsvotum umgesetzt und vereinheitlicht |
| Nachtpause | Im Planungsstand bereits gestrichen | Vollständig entfallen | Übernommen |
| Gedankenstrich | KBV schlug Entfernung vor; Entscheidung nach Heidelberg-Studie vertagt | EM DASH `—` bleibt verbindliches Trennzeichen | Offener Vorschlag nicht übernommen |
| Verabreichungsweg | Aufnahme noch offen | `route` wird nicht gelesen; im Profil `0..0` | Bewusste Scope-Reduktion |
| Ergänzende Hinweise | Planung über `additionalInstruction`, gegebenenfalls mehrfach | Ein einzelner Hinweis aus `patientInstruction` | Technisches FHIR-Mapping geändert |
| Frequenz bei Intervall-Kombinationen | Allgemeiner Intervallbaustein: bei `frequency > 1` Ausgabe als `{frequency} x alle {period} {Einheit}` | Bei konkreten `timeOfDay`-/`when`-Segmenten wird nur die Periode ausgegeben; `frequency` ist optional und bleibt im Text unberücksichtigt | Bewusste, fachlich noch zu bestätigende Abweichung |

## Änderungen im Detail

### 1. Status und normative Verbindlichkeit

**Planung**

- Status „IN ARBEIT“ und „in Vorstellung“.
- Die Referenzimplementierung prüft Felder, erkennt das Schema und erzeugt den Text.
- Mehrere Punkte sind noch als Optionen oder als Gegenstand einer Studie formuliert.

**Umsetzung**

- Die Seite selbst ist die **normative Festlegung** des Algorithmus.
- Die Python-Implementierung ist nur noch eine Beispielimplementierung. Bei Abweichungen gilt die Seite.
- Der Algorithmus ist explizit als Version **2.0.0** bezeichnet.
- Eine Implementierung darf dieselbe Versionsnummer verwenden, sobald sie den beschriebenen Algorithmus nachbildet.

**Auswirkung**

Die Verantwortlichkeit wurde umgekehrt: Nicht mehr das Skript definiert mittelbar das Verhalten, sondern die IG-Seite. Dadurch können unabhängige Implementierungen auf denselben normativen Text referenzieren.

### 2. Neuer Gesamtalgorithmus

Die Planung beschrieb hauptsächlich einzelne Textbausteine und Schemata. Neu hinzugekommen ist ein vollständiger Kontrollfluss:

1. Auswahl der Dosierungsliste abhängig vom `resourceType`.
2. Fehler bei nicht unterstütztem Ressourcentyp; leerer String bei leerer oder fehlender Dosierungsliste.
3. Abbruch bei gemeinsamem `timeOfDay` und `when`.
4. Abbruch bei mehreren `Dosage`-Elementen in Verbindung mit einer reinen Bedarfsdosierung.
5. Schema-Erkennung allein anhand des ersten `Dosage`-Elements.
6. Schemaspezifische Aggregation der Segmente.
7. Ergänzung von Zeitrahmen, Bedarf, Rhythmus, Maximalmenge und Hinweis.
8. Normalisierung und gegebenenfalls Großschreibung des ersten Zeichens.

Damit ist die Reihenfolge der Verarbeitung nicht mehr nur aus den Einzelabschnitten abzuleiten.

### 3. Explizite Schema-Erkennung

**Planung**

- Verweist darauf, dass die Referenzimplementierung das passende Schema erkennt.
- Verweist für die formale Definition auf Invarianten.
- Definiert keine vollständige, priorisierte Erkennungslogik.

**Umsetzung**

- Definiert die ausgewerteten Merkmale wie `hatText`, `hatTiming`, `hatDosis`, `hatWochentag`, `hatWhenCodes` und `hatUhrzeit`.
- Legt abgeleitete Bedingungen wie `istTagesmuster`, `istNichtTagesmuster` und `istReinesIntervall` fest.
- Definiert acht Erkennungsregeln in verbindlicher Prioritätsreihenfolge.
- Die Erkennung erfolgt ausschließlich anhand des ersten `Dosage`-Elements.
- Trifft keine Regel zu, wird abgebrochen; ein Ersatztext wird ausdrücklich nicht erzeugt.

**Auswirkung**

Die Schemaauswahl ist nun unabhängig von Implementierungsdetails reproduzierbar. Gleichzeitig entsteht eine klare Abhängigkeit vom ersten `Dosage`-Element; die strukturelle Konsistenz weiterer Elemente wird durch Profilinvarianten vorausgesetzt.

### 4. Dosis und Bereiche

**Beibehalten**

- Es wird `doseAndRate[0]` verwendet.
- Ganzzahlen erscheinen ohne Nachkommastelle.
- Dezimalwerte verwenden das deutsche Dezimalkomma.
- Im festen kompakten 4-Schema entfällt „je“.
- Ein nur nach oben begrenzter Bereich wird als „bis zu“ dargestellt.

**Geändert oder präzisiert**

- `doseQuantity` hat ausdrücklich Vorrang vor `doseRange`.
- Bereiche werden nicht mehr mit Bindestrich, sondern durchgängig mit **„bis“** gebildet.
- Ein nur nach unten begrenzter `doseRange` ist unzulässig.
- Eine Dosis ist in jedem strukturierten Schema erforderlich.
- Pflichtfelder für `doseQuantity` und `doseRange` sind einzeln festgelegt.
- Bei einem beidseitigen Bereich müssen die Einheiten von `low` und `high` übereinstimmen.
- Die Ausgabeeinheit eines Bereichs stammt aus `high.unit`.
- Weitere `doseAndRate`-Einträge werden ausdrücklich ignoriert.

**Auswirkung**

Die aus der Planung gewählte Option 2 wurde konsequent auf alle Bereichswerte übertragen. Zusätzlich verhindert die Spezifikation Teiltexte ohne eindeutige Dosis.

### 5. Zeitrahmen

#### Dauer

Neu festgelegt wurden:

- `boundsDuration.value` und `.code` sind Pflicht, sobald `boundsDuration` vorhanden ist.
- Der Wert muss numerisch und größer als null sein.
- Die Ausgabeeinheit wird aus `.code` abgeleitet.

#### Start- und Endzeitpunkt

Gegenüber der Planung neu oder geändert:

- Ein allein vorhandenes Ende wird als `Bis zum {Enddatum}` unterstützt.
- `boundsPeriod` und `boundsDuration` schließen einander aus.
- `boundsPeriod` muss mindestens `start` oder `end` enthalten.
- Es ist ein vollständiges FHIR-`dateTime`-Datum erforderlich.
- Werte mit Uhrzeit müssen eine Zeitzone enthalten.
- Zeitpunkte werden verbindlich nach `Europe/Berlin` umgerechnet.
- Sekunden werden nicht ausgegeben.

**Auswirkung**

Insbesondere die Zeitzonenumrechnung ist eine technisch relevante Ergänzung. Sie macht auch Datumsverschiebungen durch UTC-Umrechnung und Sommerzeit deterministisch.

### 6. Intervalle und Zeiteinheiten

**Planung**

- Beschrieb tägliche, wöchentliche und sonstige Perioden.
- Erwähnte Bereiche für Frequenz und Periode.
- Verwendete in den Grundregeln noch den Bindestrich.

**Umsetzung**

- Bezieht `frequencyMax` und `periodMax` explizit in den Algorithmus ein.
- Unterscheidet eine feste Frequenz von genau 1, eine feste Frequenz größer als 1 und einen Frequenzbereich.
- Verwendet auch hier durchgängig „bis“.
- Definiert das Verhalten, wenn alle Intervallangaben fehlen.
- Unvollständige Intervallangaben führen dazu, dass keine Schema-Regel greift.
- Führt eine abschließende Tabelle zulässiger Zeiteinheiten ein.
- Definiert den exakten Bezugswert für Singular und Plural.
- Unterscheidet Zeit-Einheiten, die übersetzt und pluralisiert werden, von Dosis-Einheiten, die wörtlich übernommen werden.

**Auswirkung**

Die Pluralisierung und die Ausgabe von Maximalwerten sind nicht länger sprachlich implizit, sondern vollständig nachbildbar.

#### Abweichung bei Intervall-Kombinationen mit konkreten Zeitpunkten

**Planung / Source of Truth**

Die allgemeine Intervallregel bildet bei einer festen `frequency > 1` den Text
`{frequency} x alle {period} {Einheit}`. Da das Schema für Kombinationen von
Zeitintervallen den Platzhalter `{Intervall}` verwendet, ergibt sich daraus
beispielsweise:

```text
2 x alle 2 Tage: 08:00 Uhr — je 1 Stück, …
```

**Umsetzung**

Bei einer Intervall-Kombination wird der gemeinsame Einnahmerhythmus nur aus
`period`, `periodMax` und `periodUnit` gebildet. `frequency` ist optional und wird
auch dann nicht ausgegeben, wenn sie im Eingang vorhanden ist. Die Anzahl der
Anwendungen ergibt sich aus den explizit aufgeführten `timeOfDay`- oder
`when`-Segmenten.

Das Beispiel mit zwei `Dosage`-Elementen und fünf Einnahmezeitpunkten wird damit
wie folgt ausgegeben:

```text
alle 2 Tage: 08:00 Uhr — je 1 Stück, 10:00 Uhr — je 2 Stück, 14:00 Uhr — je 2 Stück, 20:00 Uhr — je 1 Stück, 22:00 Uhr — je 2 Stück
```

**Begründung und Status**

Bei aggregierten `Dosage`-Elementen kann jedes Element eine andere, zur jeweiligen
Zeitpunktliste passende `frequency` besitzen. Würde nur die `frequency` des ersten
Elements in das gemeinsame Präfix übernommen, bezöge sich beispielsweise `2 x`
sprachlich auf alle fünf nachfolgenden Segmente und wäre missverständlich.

Diese Ausnahme ist eine dokumentierte Abweichung von
`ERPCHANGES-ErweiterteDosisTextgenerierung-270726-1059-182.md`. Die ERPCHANGE-Datei
bleibt als Source of Truth unverändert. Die technische Abweichung bedarf daher
noch einer fachlichen Bestätigung.

### 7. Uhrzeiten, Tagesabschnitte und Wochentage

**Präzisierungen**

- Die Tabellen für Wochentage und `when`-Codes sind abschließend.
- Ein unbekannter `when`-Code führt zum Abbruch.
- `timeOfDay` akzeptiert exakt definierte Formate; ungültige Uhrzeiten führen zum Abbruch.
- `timeOfDay` und `when` dürfen nicht gemeinsam vorkommen.
- Sekunden und Sekundenbruchteile von `timeOfDay` entfallen in der Ausgabe.
- Segmente werden über alle `Dosage`-Elemente eingesammelt und gemeinsam sortiert.
- Die Reihenfolge ist damit grundsätzlich unabhängig von der Reihenfolge der `Dosage`-Elemente.

**Neue Gruppierung**

Unmittelbar aufeinanderfolgende Uhrzeiten mit derselben Dosis werden zu einer Zeitgruppe zusammengefasst:

```text
täglich: 08:00 Uhr, 20:00 Uhr — je 1 Stück
```

Die Planung erzeugte grundsätzlich ein eigenes Dosis-Segment je Uhrzeit.

### 8. Einnahmeanlass und Bedarf

**Planung**

- Beschreibt `bei {Anlass}`.
- Stellt Bedarf überwiegend als eigenes Schema dar.
- Lässt offen, was ohne Einnahmeanlass geschieht.
- Zeigt Mindestabstand und Doppelpunkt zunächst in einer anderen Reihenfolge.

**Umsetzung**

- Ohne Einnahmeanlass wird `bei Bedarf` erzeugt.
- Mehrere `asNeededFor`-Angaben werden als deutsche Oder-Aufzählung verbunden.
- Es wird ausschließlich `valueCodeableConcept.text` passender Extensions mit exakter kanonischer URL gelesen.
- Leere oder unvollständige Anlassangaben führen zum Abbruch.
- Bedarf ist ein **Querschnittsmerkmal**: Eine Bedarfskennzeichnung kann mit allen strukturierten Timing-Schemata kombiniert werden.
- Nur Bedarf ohne `timing` ist ein eigenes Schema.
- Eine reine Bedarfsdosierung erlaubt genau ein `Dosage`-Element.
- Das erste Zeichen des Gesamtergebnisses wird bei Bedarf großgeschrieben.

**Geänderter Einzeiler**

Der Doppelpunkt steht nun direkt hinter dem Einnahmeanlass:

```text
Bei Kopfschmerzen: im Abstand von mindestens 4 Stunden je 1 Stück
```

statt des ursprünglichen Planungsmusters:

```text
Bei Kopfschmerzen im Abstand von mindestens 6 Stunden: je 1 Stück
```

### 9. Mindestabstand

Die Planung verwendete den Mindestabstand im Bedarfsschema, spezifizierte sein FHIR-Mapping aber nicht vollständig.

Neu festgelegt wurden:

- Quelle ist die erste passende `modifierExtension` mit der exakten URL `MindestabstandZwischenGaben`.
- `valueDuration`, `.value` und `.code` sind Pflicht.
- Der Wert muss numerisch und größer als null sein.
- Erlaubt sind ausschließlich Minuten und Stunden.
- Die Einheit wird aus `.code` abgeleitet.
- Ein Comparator ist nicht zulässig.
- Der Mindestabstand wird nur im Bedarfsfall ausgegeben.

### 10. Maximalmenge

**Beibehalten**

- Ausgabe als `nicht mehr als {Wert} {Einheit} {Zeitraum}`.
- `24 h` wird als `in 24 Stunden`, `1 d` als `pro Tag` wiedergegeben.

**Neu oder präzisiert**

- Die Maximalmenge ist nur bei `asNeededBoolean = true` zulässig und wird nur dort gelesen.
- Pflichtfelder von Zähler und Nenner sind vollständig definiert.
- Nur die Nenner `24 h` und `1 d` sind zulässig.
- Die Maximalmenge wird bei mehreren Segmenten genau einmal am Ende der gesamten Dosierungsanweisung ergänzt.
- Ein anschließender Hinweis steht erst nach der Maximalmenge.

### 11. Verabreichungsweg und Hinweise

Hier liegt die deutlichste Änderung des FHIR-Mappings vor.

#### Verabreichungsweg

**Planung:** `route` sollte möglicherweise als deutscher EDQM-Term ausgegeben werden.  
**Umsetzung:** `route` wird nicht gelesen oder ausgegeben und ist im Profil `DosageDgMP` auf `0..0` eingeschränkt.

#### Hinweise

**Planung:** Hinweise stammen aus `additionalInstruction`; mehrere Hinweise werden mit Semikolon verbunden.  
**Umsetzung:** Hinweise stammen aus dem einzelnen String `patientInstruction` (`0..1`). `additionalInstruction` wird nicht verwendet und ist im Profil auf `0..0` gesetzt.

Zusätzlich wurden folgende Regeln festgelegt:

- Führender und abschließender Leerraum wird entfernt.
- Ein leerer Hinweis wird nicht ausgegeben.
- Der Hinweis wird als eigener Satz mit `Hinweis:` angehängt.
- Vor `Hinweis:` wird genau ein abschließender Punkt sichergestellt.

**Auswirkung**

Die geplante Semikolon-Verkettung mehrerer strukturierter Hinweise entfällt. Stattdessen gibt es genau einen freien Einnahmehinweis.

### 12. Trennzeichen, Unicode und Normalisierung

Die in der Planung beschlossenen Trennzeichen wurden übernommen und technisch präzisiert:

- Doppelpunkt: Trennung von Rahmen/Bedarf/Intervall und Kerntext.
- EM DASH `—`: Verbindung von Zeit oder Tagesabschnitt und Dosis sowie von Dosis und Maximalmenge.
- Komma: Trennung von Uhrzeit- und Tagesabschnittssegmenten.
- Semikolon: Trennung von Wochentagssegmenten.
- HYPHEN-MINUS `-`: ausschließlich Positionstrenner im kompakten 4-Schema.

Neu hinzugekommen sind:

- verbindliche Unicode-Codepoints für alle erzeugten Satz- und Trennzeichen;
- `x` statt des Multiplikationszeichens `×`;
- U+0020 als einziges erzeugtes Leerzeichen;
- NFC-Normalisierung der erzeugten festen Wortbestandteile;
- Reduktion jeder Leerraumfolge auf ein Leerzeichen;
- Entfernung von Leerraum vor `;`, `:`, `.`, `,`;
- keine Normalisierung der unverändert übernommenen Freitext-Dosierung.

Der im Planungsverlauf erwähnte Vorschlag, den Gedankenstrich zu entfernen, wurde damit nicht umgesetzt.

### 13. Änderungen an den einzelnen Schemata

#### 4-Schema

- Option 2 ist verbindlich umgesetzt.
- Feste Werte bleiben kompakt.
- Bei einem Bereich wird in Tagesabschnittssegmente ausgeschrieben.
- Doppelte Belegung eines Tagesabschnitts führt zum Fehler.
- Frequenz- und Periodenangaben beeinflussen die Darstellung nicht.
- Bei Wochentagskombinationen wird die ausgeschriebene Form für alle Tage verwendet, sobald irgendein Tag einen Bereich enthält.

#### Uhrzeiten-Bezug

- Uhrzeiten werden ressourcenweit sortiert.
- Benachbarte Uhrzeiten mit gleicher Dosis werden gruppiert.
- Mehrere Gruppen werden mit Komma statt Semikolon getrennt.
- Der Marker ist immer `täglich`; vorhandene Frequenzwerte werden nicht zusätzlich ausgegeben.

#### Wochentags-Bezug

- Wochentage bleiben einzelne, mit Semikolon getrennte Segmente.
- Frequenz- und Periodenwerte werden in diesem Schema ausdrücklich ignoriert.
- Für nicht profilkonforme Doppelbelegungen ist festgelegt, dass die später durchlaufene Dosis gewinnt.

#### Wiederkehrende Intervalle

- Eine Dosis ist zwingend.
- Es ist genau ein `Dosage`-Element zulässig.
- Die gestrichene Nachtpause ist vollständig entfernt.

#### Kombination von Zeitintervallen

- Zeit- und Tagesabschnittssegmente werden mit Komma getrennt.
- Für defensiv verarbeiteten, nicht profilkonformen Mischinput ist die Reihenfolge festgelegt: Tagesabschnitte vor Uhrzeiten.
- Bei mehrfacher Belegung desselben Zeitschlüssels gewinnt das zuerst durchlaufene Element.
- `period` und `periodUnit` bestimmen den gemeinsamen Einnahmerhythmus; `frequency` ist optional und wird nicht ausgegeben.
- Nicht tägliche Kombinationen mit `when` werden als Intervall-Kombination und nicht als reines 4-Schema erkannt.
- Die unterdrückte Frequenzausgabe ist eine dokumentierte, fachlich noch zu bestätigende Abweichung von der ERPCHANGE-Source-of-Truth.

#### Kombination von Wochentagen

- Innerhalb eines Tages können Uhrzeiten gleicher Dosis gruppiert werden.
- Zwischen Uhrzeitgruppen steht ein Komma, zwischen Wochentagen ein Semikolon.
- Bei variablen Tagesabschnittsdosen wird die Notation über alle Tage hinweg einheitlich ausgeschrieben.
- Frequenz- und Periodenwerte beeinflussen die Ausgabe nicht.

#### Bedarfsmedikation

- Ausschließlich die einzeilige Option wurde übernommen.
- Bedarf kann zusätzlich zu einem strukturierten Schema auftreten.
- Mindestabstand, strukturiertes Schema und Dosis stehen rechts des Doppelpunkts.
- Die Maximalmenge wird einmal am Ende angefügt.
- Der generische Anlass `bei Bedarf` wurde ergänzt.
- Die Take-Wait-Stop-Darstellung mit Zeilenumbrüchen ist entfallen.

#### Freitext

- Profilkonform ist genau ein reines Freitext-`Dosage`-Element zulässig.
- Der Text wird an Anfang und Ende getrimmt, ansonsten aber nicht verändert oder normalisiert.
- Weitere Bausteine wie Maximalmenge und `patientInstruction` werden nicht angehängt.
- Bei nicht profilkonformen mehreren Freitext-Elementen bleibt als defensives Verhalten die Verkettung der getrimmten Texte bestehen.
- `Dosage.text` wird in strukturierten Schemata vollständig ignoriert.

### 14. Mehrfach-`Dosage`-Aggregation

Dieser Bereich war in der Planung nur über einzelne Sortier- und Trennregeln angedeutet. Die Umsetzung legt nun fest:

- Zeit-, Tagesabschnitts- und Wochentagssegmente werden über alle `Dosage`-Elemente gesammelt.
- Rahmenangaben werden ausschließlich aus dem ersten `Dosage`-Element gelesen.
- Dazu zählen Zeitraum, Bedarfskennzeichen, Einnahmeanlass, Mindestabstand, Maximalmenge und Hinweis.
- Profilinvarianten müssen die Gleichheit dieser Angaben über alle Elemente sicherstellen.
- Wiederkehrende Intervalle und reine Bedarfsdosierungen erlauben nur ein `Dosage`-Element.
- Die gemeinsame Dosis-Einheit aggregierender Schemata stammt aus dem ersten Element mit auswertbarer Dosis.
- Die Ausgabereihenfolge ist bei profilkonformem Input deterministisch und unabhängig von der Eingabereihenfolge.

**Auswirkung**

Die technische Umsetzung macht eine wichtige Architekturentscheidung sichtbar: Segmentdaten werden aggregiert, Rahmendaten dagegen zentral aus dem ersten Eintrag gelesen.

### 15. Feldreferenz und Extension-URLs

Neu hinzugekommen ist eine vollständige Feldreferenz für jeden dynamischen Textbaustein. Darin werden die tatsächlich gelesenen Unterpfade dokumentiert.

Außerdem sind die exakten kanonischen URLs für

- `asNeededFor` und
- `MindestabstandZwischenGaben`

festgelegt. Extensions werden nicht anhand eines Kurznamens oder Suffixes, sondern nur über die exakte URL erkannt.

### 16. Fehler und Validierung

**Planung**

- Nicht unterstützte Felder oder nicht klassifizierbare Muster sollten zu einem Fehlertext mit einer Liste betroffener Felder führen.

**Umsetzung**

- Ein solcher Fehlertext wird nicht mehr als Dosierungstext erzeugt.
- Der Algorithmus bricht bei nicht eindeutig darstellbaren Angaben mit einem Fehler ab.
- Die konkreten Fehlerfälle und überwiegend auch die `ValueError`-Texte sind dokumentiert.
- Der Algorithmus führt trotzdem keine vollständige Profilvalidierung durch.
- Profilvalidierung bleibt Voraussetzung.
- Bewusste Ausnahmen bestehen bei Konstellationen, die im generischen `DosageDE` nur Warnungen sind, insbesondere mehrere reine Freitexte oder Freitext neben strukturierten Angaben.

**Auswirkung**

Dies ist eine sicherheitsrelevante Änderung: Ein Fehler wird nicht als scheinbar gültige generierte Dosieranweisung publiziert. Die technische Verarbeitung folgt dem Prinzip „Abbruch statt zweifelhafter Teil- oder Ersatzausgabe“.

## Entfallene Planungsinhalte

Folgende Inhalte sind in der umgesetzten Spezifikation nicht mehr Bestandteil des Algorithmus:

- Nachtpause `(nachts Pause)`;
- Verabreichungsweg aus `route`;
- Hinweise aus `additionalInstruction`;
- Verkettung mehrerer `additionalInstruction`-Hinweise mit Semikolon;
- dreigeteilte Take-Wait-Stop-Darstellung;
- Fehlertext als Ergebnis der Dosierungstextgenerierung;
- Bindestrich als Bereichskonnektor;
- mehrere getrennte Uhrzeitsegmente bei unmittelbar aufeinanderfolgenden Uhrzeiten mit gleicher Dosis.

Die frühere technische Ausarbeitung mit leerer Anforderungstabelle und der chronologische Verlauf wurden nicht in die normative Algorithmusseite übernommen.

## Neu hinzugekommene Inhalte

Gegenüber der Planung sind insbesondere neu:

- normativer Status und Algorithmus-Version 2.0.0;
- vollständiger Gesamtalgorithmus als Ablauf und Pseudocode;
- priorisierte Schema-Erkennung;
- vollständige Pflichtfeld- und Fehlerregeln;
- defensive Behandlung nicht profilkonformer Eingaben;
- genaue Mehrfach-`Dosage`-Aggregation;
- explizite Feldreferenz;
- exakte Extension-URLs;
- Zeitzonenumrechnung nach `Europe/Berlin`;
- abschließende Tabellen zulässiger Zeit- und Tagescodes;
- Unicode-Codepoints und NFC-Vorgaben;
- vollständige Leerraum- und Satzzeichen-Normalisierung;
- Gruppierung von Uhrzeiten gleicher Dosis;
- generischer Bedarf ohne Anlass;
- Aufzählung mehrerer Einnahmeanlässe;
- verbindliche Position von Maximalmenge und Hinweis;
- Dokumentation der Profileinschränkungen für `route` und `additionalInstruction`.

## Gesamtbewertung

Die umgesetzte Spezifikation ist keine bloße redaktionelle Fortschreibung der Planung, sondern deren technische Konsolidierung. Die fachlichen Richtungsentscheidungen aus dem Planungsverlauf wurden übernommen, während offene oder technisch nicht eindeutig abbildbare Punkte konkretisiert beziehungsweise aus dem Scope entfernt wurden.

Besonders nachvollziehbar sind:

- der Wechsel von einem erzeugten Fehlertext zu einem echten Abbruch;
- die normative Prioritätsreihenfolge der Schema-Erkennung;
- die Trennung zwischen aggregierten Segmentdaten und Rahmendaten aus dem ersten `Dosage`-Element;
- die exakte Definition von FHIR-Pfaden, Pflichtfeldern, Codes und Extension-URLs;
- der Ausschluss von `route` und `additionalInstruction` entsprechend dem tatsächlichen Profilumfang;
- die Festlegung von Unicode, Normalisierung und Zeitzone für reproduzierbare Ergebnisse.

Die wichtigste fachliche Erweiterung gegenüber der Planung ist die Behandlung von Bedarf als Querschnittsmerkmal. Dadurch können Einnahmeanlass, Mindestabstand und Maximalmenge mit einem regulären Timing-Schema kombiniert werden, ohne für jede Kombination ein separates Bedarfsschema definieren zu müssen.

Als bewusste Implementierungsabhängigkeit bleibt bestehen, dass die Schema-Erkennung und die Rahmenangaben vom ersten `Dosage`-Element ausgehen. Die Spezifikation dokumentiert diese Abhängigkeit klar und verweist für die erforderliche Konsistenz weiterer Elemente auf Profilinvarianten.
