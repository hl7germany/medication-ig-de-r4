# Qualitätssicherung der Invarianten

Bis zum Ballot 2.0.0 sind mehrfach fehlerhafte oder fehlende Invarianten erst durch externe Hinweise oder Ballot-Kommentare aufgefallen. Diese Datei beschreibt, was dagegen automatisch läuft, wie Tests geschrieben werden und welche Maßnahmen noch offen sind.

## Was automatisch läuft

Die GitHub Action [`.github/workflows/ig-build.yml`](.github/workflows/ig-build.yml) läuft bei jedem Pull Request und jedem Push auf `main`:

1. **Invariantentests** (`tests/invariants`, einige Sekunden): Die FHIRPath-Ausdrücke werden aus den FSH-Dateien gelesen und mit fhirpath.js gegen tabellarische Testfälle ausgewertet, jeweils für alle drei Ressourcentypen.
2. **IG-Build** (`scripts/build-ig.sh`, ca. 5 Minuten): SUSHI, Textgenerierung, IG Publisher, danach `scripts/ig-expected-error-check.py`. Der Build schlägt fehl bei
   - unerwarteten Fehlern in gültigen Beispielen,
   - Negativbeispielen, die ihren Constraint nicht auslösen, oder Negativbeispielen ohne jeden Fehler,
   - Constraints, die nicht in allen drei Ressourcentypen durch Beispiele belegt sind,
   - nicht isolierten Negativbeispielen (siehe unten),
   - Fehlerbeispielen für DE-Regeln, die nicht auf einem DE-Profil liegen,
   - Broken Links.
3. **Erzeugte Includes entsprechen dem Repo-Stand**: Nach dem Build dürfen sich unter `input/` keine Dateien geändert haben. Wer Beispiele ändert, muss die neu erzeugten Includes mit einchecken.

Damit die Prüfungen wirken, braucht `main` eine Branch Protection (Repo-Admin, Settings → Branches): Status-Checks „Invariantentests (fhirpath.js)“ und „IG-Build und Prüfung der Beispiele“ erforderlich, mindestens eine Freigabe, offene Review-Kommentare vor dem Merge klären.

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
- `expect`: `true` heißt erfüllt. Bewertet wird wie im HAPI-Validator: Nur das Ergebnis `[true]` erfüllt die Invariante, `[false]` und ein leeres Ergebnis verletzen sie.

Lokal: `cd tests/invariants && npm install && npm test`. Der Runner nennt am Ende alle Invarianten, die noch keine Tests haben.

Bei neuen oder geänderten Invarianten gehören in die Tests:

- Grenzwerte: Feld fehlt, −1, 0, genau die Grenze, knapp darüber, mehrstellige Zahlen,
- jede Klausel und jeder Ressourcentyp-Zweig (`%resource.ofType(...)`),
- mehrere Dosage-Elemente, wenn die Regel über die Ressource hinweg prüft.

## Nebeneffekte bei Negativbeispielen

Ein `-C-`-Beispiel soll nur seinen eigenen Constraint verletzen. Löst es weitere aus, kann es eine zu lockere Regel verdecken. Beispiel: Die `dos-1`-Beispiele lagen auf den dgMP-Profilen und lösten immer auch den strengeren dgMP-Fehler aus. Dass `dos-1` selbst zu locker war, fiel nicht auf (HDB-924).

Unvermeidbare Nebeneffekte stehen je erwartetem Key in `scripts/expected-additional-constraints.json`, zum Beispiel `DosageStructuredRequiresGeneratedText` bei Beispielen, für die die Textgenerierung keinen Text erzeugt. Kommt ein neuer Nebeneffekt hinzu, schlägt der Build fehl. Ist er gewollt, wird die Datei mit `python3 scripts/ig-expected-error-check.py --write-baseline` nach einem Build neu geschrieben; die Änderung ist im Review zu prüfen.

## Offene Maßnahmen

### 4. Mutationstests für Invarianten

Die bisherige Abdeckung misst nur, ob ein Constraint irgendwo ausgelöst wird, nicht, ob jede Klausel getestet ist. So waren bei HDB-971 zunächst nur zwei von fünf Feldern durch Beispiele belegt, und die zu lockere `dos-1` blieb unbemerkt.

Ansatz: Der Runner in `tests/invariants` erzeugt je Invariante Varianten des Ausdrucks – Klausel entfernen, `>` ↔ `>=`, `<` ↔ `<=`, `and` ↔ `or`, `%resource.`-Präfix entfernen, Vergleich über `.toString()` statt `.toInteger()` – und lässt die Tests dagegen laufen. Jede Variante, die alle Tests besteht, zeigt einen ungetesteten Teil der Regel. Zunächst als Bericht, später mit Schwelle in der CI.

Aufwand: mittel, baut auf den Invariantentests auf.

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
