# Qualitätssicherung der Invarianten

Bis zum Ballot 2.0.0 sind mehrfach fehlerhafte oder fehlende Invarianten erst durch externe Hinweise oder Ballot-Kommentare aufgefallen. Diese Datei beschreibt, was dagegen automatisch läuft, wie Tests geschrieben werden und welche Maßnahmen noch offen sind.

## Was automatisch läuft

Die GitHub Action [`.github/workflows/ig-build.yml`](.github/workflows/ig-build.yml) läuft bei jedem Pull Request und jedem Push auf `main`:

1. **Invariantentests** (`tests/invariants`, einige Sekunden): Die FHIRPath-Ausdrücke werden aus den FSH-Dateien gelesen und mit fhirpath.js gegen tabellarische Testfälle ausgewertet, jeweils für alle drei Ressourcentypen. Eine Invariante ohne Testfälle lässt den Job fehlschlagen. Danach läuft die [Mutationsprüfung](#mutationsprüfung) (etwa eine halbe Minute), ihr Bericht steht in der Zusammenfassung des Jobs. Sie schlägt fehl, wenn bei einer Invariante mehr oder weniger Mutanten überleben als in `tests/invariants/mutation-known-survivors.json` eingetragen.
2. **Invariantentests mit HAPI** (`npm run test:hapi`, etwa eine Minute): Dieselben Testfälle werden mit der FHIRPath-Engine des HL7-Validators aus dem aktuellen `publisher.jar` ausgewertet, auf dem Element-Modell wie bei der Validierung. Der Job schlägt fehl bei
   - einer Abweichung vom erwarteten Ergebnis, die nicht in `tests/invariants/hapi-known-deviations.json` steht (dort stehen bekannte Fehler der Engine mit Issue),
   - einem Eintrag dort, der nicht mehr zutrifft, etwa nach einem Fix der Engine,
   - einer Invariante, die bei 40 Dosierungen länger als 60 ms braucht. Gemessen wird an je einer MedicationDispense im Uhrzeit-, Tageszeiten- und Wochentagsschema, als Summe über alle Kontext-Elemente und als schnellster von mehreren Läufen. Für bekannte langsame Invarianten steht ein eigenes Limit unter `runtime`.
3. **IG-Build** (`scripts/build-ig.sh`, ca. 5 Minuten): SUSHI, Textgenerierung, IG Publisher, danach `scripts/ig-expected-error-check.py`. Der Build schlägt fehl bei
   - unerwarteten Fehlern in gültigen Beispielen,
   - Negativbeispielen, die ihren Constraint nicht auslösen, oder Negativbeispielen ohne jeden Fehler,
   - Constraints, die nicht in allen drei Ressourcentypen durch Beispiele belegt sind,
   - nicht isolierten Negativbeispielen (siehe unten),
   - Fehlerbeispielen für DE-Regeln, die nicht auf einem DE-Profil liegen,
   - Broken Links.
4. **Erzeugte Includes entsprechen dem Repo-Stand**: Nach dem Build dürfen sich unter `input/` keine Dateien geändert haben. Wer Beispiele ändert, muss die neu erzeugten Includes mit einchecken.

Damit die Prüfungen wirken, braucht `main` eine Branch Protection (Repo-Admin, Settings → Branches): Status-Checks „Invariantentests (fhirpath.js)“, „Invariantentests (HAPI-FHIRPath)“ und „IG-Build und Prüfung der Beispiele“ erforderlich, mindestens eine Freigabe, offene Review-Kommentare vor dem Merge klären.

## Invariantentests schreiben

Testfälle liegen als JSON in `tests/invariants/cases/`. Jede Datei enthält eine Liste von Blöcken:

```json
[
  {
    "invariant": "DosageDoseValuePositive",
    "context": "Dosage",
    "cases": [
      { "name": "Menge 0", "dosage": { "doseAndRate": [{ "doseQuantity": { "value": 0, "unit": "Stück" } }] }, "expect": false }
    ]
  }
]
```

- `context`: Element, an dem die Invariante hängt: `Dosage`, `Timing.repeat` oder `Resource`.
- `dosage` oder `dosages`: ein oder mehrere Dosage-Elemente; `extension`: Extensions auf Ressourcenebene. `{{resourceType}}` wird durch den jeweiligen Ressourcentyp ersetzt, etwa für die URL von `renderedDosageInstruction`.
- `resourceTypes`: optional; ohne Angabe läuft jeder Fall für MedicationRequest, MedicationDispense und MedicationStatement.
- `{"$decimal": "1.0"}` anstelle einer Zahl: Dezimalzahl, deren Schreibweise zählt. JSON macht aus `1.0` sonst die Zahl `1`. fhirpath.js bekommt die Zahl, der HAPI-Job die Schreibweise. Das braucht es für Fälle, die HAPI je nach Schreibweise anders auswertet, etwa `1.0 mod 1`.
- `expect`: `true` heißt erfüllt. Bewertet wird wie im HAPI-Validator: Nur das Ergebnis `[true]` erfüllt die Invariante, `[false]` und ein leeres Ergebnis verletzen sie.

Lokal: `cd tests/invariants && npm install && npm test`. Der Runner nennt am Ende alle Invarianten, die noch keine Tests haben. `npm run test:hapi` braucht Java und nimmt `publisher.jar` aus `PUBLISHER_JAR`, `input-cache/` oder `~/.fhir/tools/publisher/`.

Bei neuen oder geänderten Invarianten gehören in die Tests:

- Grenzwerte: Feld fehlt, −1, 0, genau die Grenze, knapp darüber, mehrstellige Zahlen,
- jede Klausel und jeder Ressourcentyp-Zweig (`%resource.ofType(...)`),
- mehrere Dosage-Elemente, wenn die Regel über die Ressource hinweg prüft.

## Mutationsprüfung

`npm run test:mutation` (in `tests/invariants`) prüft, ob die Testfälle jede Stelle einer Invariante abdecken. Dazu verändert `mutate.js` den Ausdruck an jeweils genau einer Stelle und wertet alle Testfälle der Invariante gegen diese Variante (Mutant) aus:

- `and` ↔ `or`, `implies` → `and`, `xor` → `or`
- eine Klausel einer Verknüpfung oder die Bedingung von `implies` entfernen
- `=` ↔ `!=`, `<` ↔ `<=`, `>` ↔ `>=`
- `exists()` ↔ `empty()`, `all(…)` → `exists(…)`, `first()` ↔ `last()`, `toInteger()` → `toString()`, `.not()` oder `.distinct()` entfernen
- `%resource.` vor einem Pfad entfernen
- Zahlen um eins (bei Dezimalzahlen um eine Stelle) erhöhen und verringern, Texte ersetzen

Ein Mutant ist erkannt, wenn mindestens ein Testfall ein anderes Ergebnis als erwartet liefert. Der Bericht listet je Invariante die überlebenden Mutanten mit Zeile und Ausschnitt. Ein überlebender Mutant bedeutet eines von beiden:

- Der veränderte Teil der Regel ist ungetestet. Dann fehlt ein Testfall, der genau diesen Teil prüft.
- Der Mutant ist gleichwertig zum Original, etwa wenn eine Bedingung schon durch eine andere Klausel gilt. Dann wird er mit Begründung in `mutation-known-survivors.json` gezählt.

`mutation-known-survivors.json` nennt je Invariante die Anzahl der überlebenden Mutanten und warum kein Testfall sie erkennen kann oder soll. Die Prüfung schlägt fehl, wenn bei einer Invariante mehr oder weniger Mutanten überleben als eingetragen; eine Invariante ohne Eintrag darf keine überlebenden Mutanten haben. Mit Invarianten als Argument (`npm run test:mutation -- TimingOnlyOneType`) läuft die Prüfung nur für diese. Bei neuen oder geänderten Invarianten gehört der Bericht für die betroffenen Regeln in den Pull Request.

## Umformungen prüfen

Wird eine Invariante umgeformt, etwa für die Laufzeit, soll sie meist dasselbe Ergebnis liefern wie vorher. `npm run test:equivalence -- --base <ref>` (in `tests/invariants`) vergleicht dafür jede Invariante, deren Ausdruck sich gegenüber dem Git-Stand `<ref>` unterscheidet, mit ihrer früheren Fassung. Beide Fassungen werden an jedem Kontext-Element ausgewertet, die Ergebnisse (true, false, leer, mehrere Werte, Fehler) verglichen:

- an den Ressourcen aller Testfälle,
- an Zufallsinstanzen mit Kombinationen aus Timing- und Dosisfeldern (`--random <n>`, Standard 3000, fester Seed über `--seed`),
- an JSON-Ressourcen aus Verzeichnissen (`--examples <dir>`, etwa `fsh-generated/resources` nach einem SUSHI-Lauf).

Mit `--hapi` rechnet zusätzlich die Engine des HL7-Validators aus `publisher.jar` (`HapiEquivalence.java`). Das ist wichtig, weil HAPI in einzelnen Fällen anders rechnet als fhirpath.js. Testfälle mit `{"$decimal": …}` bekommt HAPI wie im HAPI-Job mit ihrer Schreibweise, etwa `14.0`; die Zufallsinstanzen enthalten nur Zahlen. `--head <ref>` vergleicht zwei Git-Stände statt des Arbeitsverzeichnisses, etwa für einen Patch auf einem älteren Release. Kontexte, Testfälle und Zufallsinstanzen kommen dabei immer aus dem Arbeitsverzeichnis. Einzelne Invarianten lassen sich als Argument angeben.

Der Bericht nennt je Invariante die Zahl der Abweichungen mit Richtung (etwa `false → true`) und Beispielen. Bei Abweichungen endet der Lauf mit Exit-Code 1. Für eine Umformung ohne fachliche Änderung muss der Bericht in beiden Engines „keine Abweichung“ zeigen; bei einer gewollten Änderung gehören Richtung und Umfang in den Pull Request.

### Freigabe im Pull Request

Der Workflow „Äquivalenzprüfung der Invarianten“ vergleicht in jedem Pull Request die Invarianten mit dem Stand der Zielbranch, mit fhirpath.js und HAPI. Weichen Ergebnisse ab, endet der Bericht mit einem Freigabe-Block, eine Zeile je Invariante und Richtung mit der Anzahl je Engine:

```
Äquivalenz-Freigabe:
- TimingOnlyOneDayOfWeek: false → true (fhirpath.js 290, HAPI 290)
```

Der Job ist grün, wenn die PR-Beschreibung genau diesen Block enthält, und rot, wenn eine Zeile fehlt, eine Anzahl abweicht oder eine Zeile nicht mehr auftritt. Eine gewollte Änderung wird freigegeben, indem man den Block aus der Job-Zusammenfassung in die PR-Beschreibung übernimmt; das Bearbeiten der Beschreibung startet die Prüfung neu. Ändert sich die Invariante danach erneut, passen die Anzahlen nicht mehr und die Freigabe ist zu erneuern. Der Block darf in einem Codeblock stehen. Ohne Abweichung ist kein Block nötig. Lokal liefert `--approval <datei>` dieselbe Prüfung gegen eine Textdatei.

## Nebeneffekte bei Negativbeispielen

Ein `-C-`-Beispiel soll nur seinen eigenen Constraint verletzen. Löst es weitere aus, kann es eine zu lockere Regel verdecken. Beispiel: Die `dos-1`-Beispiele lagen auf den dgMP-Profilen und lösten immer auch den strengeren dgMP-Fehler aus. Dass `dos-1` selbst zu locker war, fiel nicht auf (HDB-924).

Unvermeidbare Nebeneffekte stehen je erwartetem Key in `scripts/expected-additional-constraints.json`, zum Beispiel `DosageStructuredRequiresGeneratedText` bei Beispielen, für die die Textgenerierung keinen Text erzeugt. Kommt ein neuer Nebeneffekt hinzu, schlägt der Build fehl. Ist er gewollt, wird die Datei mit `python3 scripts/ig-expected-error-check.py --write-baseline` nach einem Build neu geschrieben; die Änderung ist im Review zu prüfen.

## Offene Maßnahmen

### 5. Differenztest zwischen Textgenerierung und Profil

Algorithmus und Profil prüfen dieselben Daten unabhängig voneinander und sind mehrfach auseinandergelaufen:

- `period = 1` mit `periodMax` ergibt „täglich“ statt „alle 1 bis 3 Tage“ ([dgMP-DosageTextgenerierung-Skript#20](https://github.com/hl7germany/dgMP-DosageTextgenerierung-Skript/issues/20)),
- der Algorithmus lehnte `boundsDuration ≤ 0` ab, das Profil nicht; umgekehrt erzeugte er „nicht mehr als -2 Stück in 24 Stunden“ (HDB-971),
- Issues #110, #111, #113 und #130.

Ansatz: Kombinationen aus Schemafeldern und Grenzwerten erzeugen und für jede sowohl die Invarianten (fhirpath.js) als auch den gepinnten Algorithmus ausführen. Geprüft wird:

1. Was das Profil für gültig hält, übersetzt der Algorithmus ohne Fehler.
2. Was der Algorithmus ablehnt, lehnt auch das Profil ab.
3. Jeder Zahlenwert aus den strukturierten Daten kommt im erzeugten Text vor. Das hätte „täglich“ für „alle 1 bis 3 Tage“ gefunden.

Aufwand: mittel. Abzustimmen mit dem Algorithmus-Repository, Vorschlag: Der Test läuft im IG gegen die in `scripts/dosage-algorithm.lock` gepinnte Version.

### 6. Checkliste und Nachverfolgbarkeit

- PR-Vorlage für Änderungen an Invarianten: Grenzwerte, drei Ressourcentypen, Paar aus DE-Warnung und dgMP-Fehler (die Warnregel muss in der Erkennung eine Obermenge der Fehlerregel sein), Verhalten bei leerem Ergebnis, Beispiele auf dem richtigen Profil, Doku, Anker und Release Notes.
- Jede normative Aussage in `input/pagecontent` („muss“, „darf nicht“, „verpflichtend“) ist einer Invariante zugeordnet oder als nicht maschinell prüfbar gekennzeichnet.
- Logical Models gegen Profile prüfen: Kardinalitäten und Abbildbarkeit. Offene Beispiele: `dosierungsdetails.anlass 0..1` bei mehreren zulässigen Anlässen; `wertBis` bei Dauer und Mindestabstand, obwohl `boundsDuration` und der Mindestabstand nur Einzelwerte zulassen.

Aufwand: gering, verlangt Disziplin im Review.

## Hintergrund: Welche Fehler durchgerutscht sind

| Klasse | Beispiele |
|---|---|
| Fehlende oder zu lockere Regeln | HDB-924 (`dos-1`), HDB-971 (0 und negative Werte, Maximalmenge unter Einzeldosis), #115, #119, #126, #128 |
| Falsche Ausdrücke | fehlende `%resource.`-Präfixe nur in den MD/MS-Zweigen (1.0.4); `"9" < "10"` als Zeichenkette; `distinct()` statt `distinct().count()`; Dosen 1, 1, 2 fälschlich akzeptiert; Warnregex keine Obermenge des Fehlerregex |
| Beispiele passen nicht zur Regel | #108, #112, #125, #129; `dos-1`-Beispiele auf dgMP-Profilen |
| Algorithmus, Profil und Spezifikation laufen auseinander | #20, #110, #111, #113, #130 |
| Doku und Logical Model veraltet | Anker nach Umbenennung; `anlass 0..1`; `wertBis` nicht abbildbar |
