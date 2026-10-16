Diese Seite beschreibt, wie Dosierungen aus dem dgMP-Profilstand 1.0.7 in den Zielprofilstand 2.0.0 überführt werden. Die Fallseiten erläutern einzelne Änderungen; der hier beschriebene Ablauf ist für ihre Kombination maßgeblich.

**Grundregel:** Die klinische Aussage MUSS erhalten bleiben. Die Migration DARF weder Zahlen runden noch fehlende Dosen, Einheiten oder Zeitangaben erraten. Lässt sich keine bedeutungstreue Zielrepräsentation nachweisen, bleibt die Quelle im Archiv; es wird keine verwendbare 2.0.0-Dosierung erzeugt.

### Geltungsbereich

Das Verfahren gilt für Dosierungen nach dem `DosageDgMP`-/`TimingDgMP`-Modell von Version 1.0.7:

| Ressourcentyp | Dosierungsfeld |
|---|---|
| `MedicationRequest` | `dosageInstruction` |
| `MedicationDispense` | `dosageInstruction` |
| `MedicationStatement` | `dosage` |

Das Verfahren umfasst auch Bestandsdaten, die als 1.0.7 geführt werden, aber bereits gegen das Quellprofil verstoßen. Die Quellvalidierung MUSS solche Daten im Migrationsbericht von gültigen 1.0.7-Quellen unterscheiden. M15–M18 beschreiben keine neuen Verschärfungen für zuvor gültige Quellen:

| Fall | Constraint | Einordnung gegenüber 1.0.7 |
|---|---|---|
| M15 | `TimingOnlyOneBounds` | Die gemeinsame Behandlungsdauer war bereits vorgeschrieben. Die Erweiterung um `boundsPeriod` betrifft ein in 1.0.7 ausgeschlossenes Feld (`bounds[x] only Duration`). |
| M16 | `DosageStructuredRequiresBoth` | Für Bedarfsangaben gelockert; fehlende Dosis oder fehlendes Timing einer regulären strukturierten Dosierung waren bereits unzulässig. |
| M17 | `DosageDoseUnitSameCode` | Für die in 1.0.7 zulässigen Dosisangaben unverändert. |
| M18 | `TimingBoundsUnitMatchesCode` | Unverändert; widersprüchliche Anzeigeeinheiten waren bereits unzulässig. |

Die ursprüngliche Ressourcenfassung MUSS unverändert, versioniert und wiederherstellbar archiviert werden. Jede Fassung wird unabhängig behandelt, auch eine historische oder als gelöscht gekennzeichnete Fassung, sofern ihr Inhalt noch abrufbar ist. Historische und gelöschte Fassungen dürfen durch die Migration nicht zu aktuellen Ressourcen werden.

Fehlt die Dosierung vollständig, wird keine ergänzt. Neue 2.0.0-Felder werden nicht aus Freitext oder anderen Angaben abgeleitet. Ablage, Ziel-IDs, Ressourcenhistorie und Transaktionen legt das ausführende System fest; die Zuordnung jeder Zielrepräsentation zur Quelle MUSS erhalten bleiben.

### Mögliche Ergebnisse

| Ergebnis | Bedeutung | Beispiel |
|---|---|---|
| **Unveränderte Dosierung** | Die vorhandenen Dosierungsangaben erfüllen bereits die Zielregeln. Profilkennzeichnung und erforderliche Text-Extensions werden separat geprüft beziehungsweise ergänzt. | Dosis `1.25 Stück` mit vollständigem Timing |
| **Strukturiert migriert** | Nur eine nachgewiesen bedeutungstreue Normalisierung oder Korrektur war erforderlich. | `5e-1` wird `0.5` (M02) |
| **Regulärer Freitext** | Die vollständige Dosierung wird bedeutungstreu in genau einem `Dosage.text` dargestellt; die strukturierte Darstellung entfällt. Die erforderlichen Text-Extensions stehen auf Ressourcenebene. | `täglich: je 1,2 Stück` (M01) |
| **Nur archiviert** | Es gibt keine sicher verwendbare Zielrepräsentation. Die unveränderte 1.0.7-Quelle bleibt erhalten; die automatische Migration ist für diese Fassung nicht erfolgreich. | Fehlende Dosis (M16) |

**Archivdaten sind keine Freitext-Dosierung.** Ein JSON-Archivinhalt oder ein Warnpräfix in `Dosage.text` schützt nicht davor, dass ein Empfänger den Inhalt als Einnahmeanweisung behandelt. Das [gemeinsame Archivverfahren](./migration-archivverfahren.html) erzeugt deshalb keine solche Zielressource.

### Entscheidung auf einen Blick

Die Entscheidungen gelten für die gesamte Dosierungs-Liste einer Ressourcenfassung, nicht nur für ein fehlerhaftes Element.

| Prüfung | Weiteres Vorgehen |
|---|---|
| Keine Dosierung vorhanden? | Keine ergänzen; übrige Zielanforderungen prüfen. Text-Extensions ohne Dosierung nach M23 behandeln. |
| Reiner Freitext vorhanden? | Text unverändert prüfen; nacktes Viererschema nach M04 behandeln. Beide Text-Extensions bereitstellen und exakte Textgleichheit prüfen. |
| Struktur nach zulässigen Normalisierungen verwendbar? | Regulären Dosierungstext erzeugen und die vollständige Zielressource validieren. |
| Nur eine für Renderer-Freitext zugelassene Verletzung übrig? | Vollständigkeit und Bedeutungstreue prüfen, rendern und als einzelnen Freitext validieren. |
| Eine Voraussetzung oder Abschlussprüfung nicht erfüllt? | Keine Zielressource freigeben; Quelle archivieren und Ursache protokollieren. |

### Fallübersicht

Die Fall-IDs sind stabile Referenzen für Implementierung und Migrationsbericht. Ein Fall kann zusammen mit anderen Fällen auftreten; eine einzelne passende Fall-ID reicht nicht aus, um einen Rendereraufruf zu erlauben.

| Fall | Anlass | Bevorzugte Behandlung | Details |
|---|---|---|---|
| M01 | Dosisbruchteil im Ziel nicht erlaubt | Regulärer Freitext, sofern vollständig darstellbar | [M01](./migration-m01-dosisbruchteil.html) |
| M02 | Exponentialschreibweise im Quellpayload | Exakte Dezimalnormalisierung | [M02](./migration-m02-exponentialnotation.html) |
| M03 | Dosiswert null oder negativ | Nur archivieren | [Archivverfahren](./migration-archivverfahren.html) |
| M04 | Nacktes Viererschema im Freitext | Ohne belegte Bedeutung nur archivieren | [M04](./migration-m04-viererschema-freitext.html) |
| M05 | Gebrochene Behandlungsdauer | Zulässige exakte Umrechnung, sonst geprüfter Freitext | [M05](./migration-m05-boundsduration.html) |
| M06 | Gebrochene Periode | Zulässige exakte Umrechnung, sonst geprüfter Freitext | [M06](./migration-m06-period.html) |
| M07 | Frequenz und Periode beide größer als eins | Geprüfter Freitext ohne algebraische Umdeutung | [M07](./migration-m07-frequenz-periode.html) |
| M08–M17 | Fehlende, widersprüchliche oder nicht sicher vereinheitlichbare Angaben | Nur archivieren | [Betroffene Fälle](./migration-archivverfahren.html) |
| M18 | Anzeigeeinheit passt nicht zum Code | Anzeige korrigieren, sofern der Code nachweislich maßgeblich ist | [M18](./migration-m18-einheitenanzeige.html) |
| M19–M21 | Neue Felder, Warnungen und Lockerungen | Keine Änderung allein wegen dieser Regeln | Siehe Referenz unten |
| M22 | Periode oder Behandlungsdauer null oder negativ | Nur archivieren; keine Umdeutung als Freitext | [Archivverfahren](./migration-archivverfahren.html) |
| M23 | Text-Extension ohne Dosierung | Nur archivieren | [Archivverfahren](./migration-archivverfahren.html) |

### Verbindlicher Migrationsablauf

Implementierungen MÜSSEN pro Ressourcenfassung in dieser Reihenfolge vorgehen:

1. **Quelle sichern:** Den Eingabestand als 1.0.7 klassifizieren, gegen das Quellprofil validieren, die vollständige Quelle unverändert archivieren und alle verwendeten Versionen festlegen. Quellverstöße gesondert protokollieren. Bereits migrierte 2.0.0-Ziele nicht erneut als Quellen behandeln.
2. **Dosierungsart feststellen:** Die gesamte Dosierungs-Liste lesen. Andere Ressourcenelemente und nicht dosierungsbezogene Extensions unverändert übernehmen, sofern sie die Zielanforderungen erfüllen. Die Zielprofilkennzeichnung MUSS dem tatsächlichen Zielstand entsprechen; Quellprofil und Quellversion bleiben im Archiv nachvollziehbar.
3. **Freitext behandeln:** M04 nur nach seiner belegten Quellkonvention behandeln; ansonsten den vorhandenen Text unverändert lassen. Auch für reinen Freitext MÜSSEN auf Ressourcenebene `renderedDosageInstruction` und `GeneratedDosageInstructionsMeta` vorhanden sein (`DosageRequiresGeneratedText`). Die Textgenerierung übernimmt `Dosage.text` unverändert in die zum Ressourcentyp passende `renderedDosageInstruction`; beide Texte MÜSSEN exakt übereinstimmen (`FreeTextMatchesRenderedText`). Fehlende oder widersprüchliche Text-Extensions samt Metadaten für diese Freitextübernahme neu erzeugen. Sprache und tatsächlich verwendete Algorithmusversion angeben. Danach direkt zur Abschlussprüfung gehen.
4. **Struktur normalisieren:** M02 und M18 anwenden. Für M01, M05 oder M06 eine strukturierte Umrechnung nur mit der unten beschriebenen freigegebenen Zuordnung versuchen. Alle Änderungen auf exakte Werte beschränken.
5. **Kandidaten prüfen:** Die Zielanforderungen prüfen, zunächst ohne die Pflicht zur neu zu erzeugenden `renderedDosageInstruction` und `GeneratedDosageInstructionsMeta` (`DosageRequiresGeneratedText`). Ausschließlich diese noch nicht erfüllte Generierungspflicht verhindert die reguläre Textgenerierung nicht. Andere Fehler einzeln nach Constraint-Key klassifizieren.
6. **Darstellung wählen:** Hat die Struktur keine anderen Fehler, den regulären Renderer verwenden und Struktur sowie neu erzeugte Text-Extensions übernehmen. Bleiben ausschließlich die unten zugelassenen M01-/M05-/M06-/M07-Verletzungen, nach erfolgreicher Vollständigkeitsprüfung rendern und die ganze Liste durch genau ein `Dosage` mit `text`, ohne `timing` und ohne `doseAndRate` ersetzen. Anschließend die Textgenerierung auf das Freitextziel anwenden: Auf Ressourcenebene `renderedDosageInstruction` mit exakt diesem `Dosage.text` sowie `GeneratedDosageInstructionsMeta` mit Sprache und tatsächlich verwendeter Algorithmusversion erzeugen. Alte Struktur-Metadaten nicht übernehmen; die Herkunft der Struktur-zu-Freitext-Umwandlung zusätzlich im Migrationsbericht festhalten.
7. **Abschlussprüfung durchführen:** Die vollständige Zielressource einschließlich aller Extensions gegen das festgelegte Zielprofil validieren. Zusätzlich die Bedeutungstreue des Textes prüfen. Erst bei Erfolg freigeben.
8. **Ergebnis protokollieren:** Ergebnisart, Fall-IDs, Quell-/Zielzuordnung, Regel- und Abhängigkeitsversionen sowie Prüfresultate festhalten. Bei fehlender fachlicher Voraussetzung, Rendererfehler oder ungültigem Ziel das [Archivverfahren](./migration-archivverfahren.html) anwenden; technische Ausführungsfehler zusätzlich gesondert melden.

Eine Ressource ohne Dosierung durchläuft keine Dosierungsabbildung, muss aber vor einer Freigabe als 2.0.0-Ressource die übrigen Zielanforderungen erfüllen. Das Löschen einer vorhandenen Dosierung ist kein zulässiger Ersatz für eine fehlgeschlagene Migration.

### Textgenerierung und Bedeutungstreue

#### Reguläre Textgenerierung

Für bereits verwendbare strukturierte Dosierungen wird der Dosierungstext regulär neu erzeugt, auch nach M02 oder M18. Die nachfolgende Allowlist beschränkt nur die Umwandlung einer noch profilwidrigen Struktur in Freitext, nicht diese reguläre Generierung.

Die Beispiele wurden mit der Referenzimplementierung `2.0.0-rc.2` geprüft. Für den tatsächlichen Lauf MUSS die konkrete zugelassene Algorithmus- und Implementierungsversion festgelegt werden; die normative Algorithmusspezifikation bleibt maßgeblich. Ein erfolgreicher Rendereraufruf ersetzt weder Profilvalidierung noch eine Prüfung auf Informationsverlust.

#### Allowlist für Renderer-Freitext

Dieser Pfad setzt genau ein vollständiges `Dosage`-Element mit positiver `doseQuantity`, vollständig belegter Einheit und unterstütztem Timing-Schema voraus. Nach den Normalisierungen dürfen neben der noch fehlenden Generierungspflicht ausschließlich diese Fehler verbleiben:

| Fall | Zulässige verbleibende Zielverletzung | Zusätzliche Voraussetzung |
|---|---|---|
| M01 | `DosageDoseQuantityAllowedFractions`, gegebenenfalls `DosageDoseValueDecimalNotation` wegen der Nachkommastellenzahl | Der exakte positive Dosiswert wird unverändert dargestellt. |
| M05 | `TimingBoundsDurationOnlyWholeNumber` | Der vollständige Behandlungszeitraum wird dargestellt. |
| M06 | `TimingPeriodOnlyWholeNumber` | Die vollständige Periode wird dargestellt. |
| M07 | `TimingFreqOrPeriodGtOne` | Reines Intervall mit `frequency`, `period`, `periodUnit`; keine `when`, `timeOfDay` oder `dayOfWeek`. |

Mehrere dieser Fälle dürfen nur gemeinsam behandelt werden, wenn alle Voraussetzungen erfüllt sind. M03, M08–M17 und M22 sperren diesen Pfad. M04 verwendet keinen Renderer für die Interpretation des Quelltextes; M18 muss vor dem Rendern geklärt sein. Insbesondere MÜSSEN `period`, gegebenenfalls `periodMax` und `boundsDuration.value` positiv sein (`TimingValuesPositive`); Ganzzahligkeit allein reicht nicht aus.

#### Verbindliche Vollständigkeitsprüfung

Die Implementierung MUSS vor der Textübernahme mit einer versionierten, feldbezogenen Prüfung nachweisen:

- Jede klinisch relevante Quellangabe ist im Ziel erhalten oder eindeutig im Text dargestellt. Nicht unterstützte Felder, Extensions und Modifier-Extensions dürfen nicht stillschweigend entfallen. Eine bloße nichtleere Ausgabe oder ein Teilstringvergleich reicht nicht aus.
- Alle dargestellten Dosis-, Dauer- und Periodenwerte stimmen dezimalgenau mit der Quelle beziehungsweise der freigegebenen exakten Umrechnung überein. Dazu die ausgegebenen Zahlen feldbezogen wieder mit Dezimalarithmetik einlesen und vergleichen. Gleitkommaänderungen dürfen nicht als Normalisierung akzeptiert werden.
- Alle Zeitpunkte und Zeitrahmen bleiben in ihrer Bedeutung erhalten. Mit dem geprüften Renderer sind Uhrzeiten nur zulässig, wenn Sekunden und Sekundenbruchteile fehlen oder null sind. Für `boundsPeriod` sind unvollständige Datumsangaben oder nichtnull Sekunden und Sekundenbruchteile ohne nachgewiesen verlustfreie Darstellung ausgeschlossen.
- Häufigkeit, Reihenfolge und Zuordnung von Dosen zu Zeitangaben bleiben erhalten. Aus `2` pro `8 h` darf nicht automatisch `1` pro `4 h` werden. Unterschiedliche Anzeigeeinheiten dürfen nicht unbemerkt durch die Einheit des ersten Elements ersetzt werden.

Kann diese Prüfung für die verwendete Renderer-Version oder einen Quellinhalt nicht durchgeführt werden, wird kein Renderertext freigegeben. Das gilt auch für regulär erzeugten Text einer ansonsten gültigen Struktur.

Beispiele für den Freitextpfad:

| Vollständige Quelle | Regulärer Zieltext |
|---|---|
| `1.2 Stück`, einmal täglich | `täglich: je 1,2 Stück` |
| `1 Stück` täglich für `1.5 d` | `für 1,5 Tage täglich: je 1 Stück` |
| `1 Stück`, einmal alle `1.5 d` | `alle 1,5 Tage: je 1 Stück` |
| `1 Stück`, zweimal pro `8 h` | `2 x alle 8 Stunden: je 1 Stück` |

Eine Ausgabe wie `1,2000000000000002` für den Quellwert `1.2000000000000001` oder `08:00 Uhr` für `08:00:30` ist nicht bedeutungstreu und darf nicht übernommen werden.

### Einheiten- und Versionsreferenz

Vor dem Lauf MUSS ein Migrationsmanifest Quell- und Ziel-IG-Paketversion, Validatorversion, Algorithmusversion, Prüfsumme der Rendererimplementierung, UCUM- und Terminologieversion sowie die Versionen der Migrationsregeln und Vollständigkeitsprüfung festlegen. Fehlt eine benötigte Abhängigkeit oder stimmt ihre Version nicht, MUSS der Lauf vor einer Zieländerung abbrechen.

Diese Anleitung liefert **keine freigegebene Zahlen- oder Codeumrechnungstabelle**. Ohne zusätzlich freigegebene Tabelle finden keine solchen Umrechnungen statt. Eine solche Tabelle MUSS Quell- und Zielsystem, Codes, exakten Faktor, Anwendungskontext, Terminologieversion und Gültigkeit enthalten und mit dem Manifest versioniert werden. Nach jeder Umrechnung sind sämtliche Zielregeln erneut zu prüfen; insbesondere kann eine Periodenumrechnung zusätzlich M07 auslösen.

Wirkstärken dürfen nicht aus referenzierten Medication-Ressourcen abgeleitet werden. Anzeigen allein bestimmen weder Zahlenwerte noch Codes. `mo` und `a` dürfen nicht automatisch in andere Zeiteinheiten umgerechnet werden; eine pauschale Kalenderdefinition ist nicht zulässig.

Für M18 ist folgende Anzeigezuordnung festgelegt, sofern der UCUM-Code nachweislich maßgeblich ist:

| `boundsDuration.code` | Kanonischer Wert für `unit` |
|---|---|
| `d` | `Tag(e)` |
| `wk` | `Woche(n)` |
| `mo` | `Monat(e)` |
| `a` | `Jahr(e)` |

Bereits zulässige deutsche Varianten müssen nicht normalisiert werden. Für `periodUnit` erlaubt das Ziel-ValueSet `min`, `h`, `d`, `wk` und `mo`; dieses Codefeld besitzt kein separates `unit`-Anzeigefeld.

Für Dosisangaben bleiben `system` und `code` ohne freigegebene Umrechnung unverändert. Unterschiedliche Codes führen bei M17 zum Archivverfahren. Gleiche Codes allein belegen nicht, dass unterschiedliche Systeme oder Anzeigen beim Rendern austauschbar sind.

Derselbe Quellinhalt mit denselben Regel-, Abhängigkeits- und Serialisierungsversionen MUSS dieselbe Zielrepräsentation liefern. Laufzeitabhängige Protokollangaben gehören nicht in diesen Vergleich. Die Verarbeitung erfolgt ohne heuristische klinische Entscheidungen.

### Warum M19–M21 keine Datenmigration auslösen

Diese Fälle sind Teil des Umfangs, damit ein implementierendes System weiß, welche Änderungen es ausdrücklich **nicht** vornehmen soll.

| Fall | Betroffene Constraints | Begründung und Verhalten |
|---|---|---|
| M19 – Neue 2.0.0-Felder | `AsNeededForIdentical`, `AsNeededForRequiresAsNeeded`, `AsNeededIdentical`, `AsNeededSingleDosageOnly`, `DosageLimitsPositive`, `DoseRangeHighRequiredWhenLowPresent`, `DoseRangeLowAndHighSameUnit`, `DoseRangeNoVarPeriod`, `MaxDoseNotBelowDose`, `MaxDoseOnlyPureAsNeeded`, `MaxDosePerPeriodOnly24hOr1d`, `MaxDoseSameUnitAsDose`, `MinimumIntervalOnlyPureAsNeeded`, `MinimumIntervalUnitMatchesCode`, `PatientInstructionIdentical`, `TimingBoundsPeriodMatchesTime`, `TimingBoundsPeriodNotForWhen`, `TimingVarFreqGtMin`, `TimingVarPeriodGtMin`, `dos-1` | Diese Regeln prüfen Elemente, die in 1.0.7 nicht strukturiert vorhanden waren, zum Beispiel `doseRange`, `asNeededBoolean`, `maxDosePerPeriod`, `periodMax`, `boundsPeriod` oder `patientInstruction`. Die Migration befüllt diese Felder nicht durch Vermutungen. Vorhandene 1.0.7-Felder werden trotzdem nach den übrigen Regeln validiert. |
| M20 – Warnungen ohne neue harte Zielverletzung | `DosageDoseUnitSameCodeWarning`, `DosageDoseValuePositiveWarning`, `DosageFourSlotPatternInTextWarning`, `DosageLimitsPositiveWarning`, `DosageStructuredRequiresBothWarning`, `AsNeededForRequiresAsNeededWarning`, `TimingBoundsUnitMatchesCodeWarning`, `TimingFreqOrPeriodGtOneWarning`, `TimingSingleDosageForTimeOfDayWarning`, `TimingSingleDosageForWhenWarning`, `TimingValuesPositiveWarning` | Eine reine Warnung macht eine Ressource nicht ungültig und löst allein keine Umschreibung aus. Sie wird im Bericht gezählt. Wenn dieselbe Bedingung im dgMP-Zielprofil ein Fehler ist, gilt stattdessen die zugehörige Regel M03, M04, M07, M13, M14, M16, M17, M18, M19 oder M22. |
| M21 – Lockerungen, unveränderte Regeln und Key-Rename | `TimingOnlyOneType`, `TimingPeriodUnit`, `TimingFrequencyCount`, `DosageStructuredRequiresBoth`, `TimingOnlyOnePeriodForDayOfWeek`, `DosageWarnungViererschemaInText` → `DosageFourSlotPatternInTextWarning` | Diese Änderungen lösen für zuvor gültige 1.0.7-Dosierungen allein keine Änderung der Dosierungsdaten aus. Zielvalidierung bleibt erforderlich. Validatoren und Monitoring müssen beim Key-Rename den neuen Namen auswerten. Verschärfte Änderungen sind separat in M08–M14 beschrieben. |

Die Umstellung von `DosageStructuredRequiresGeneratedText` auf `DosageRequiresGeneratedText` ist nicht nur ein Key-Rename: Auch Freitext benötigt nun beide Text-Extensions; `FreeTextMatchesRenderedText` verlangt die vorhandene, exakt übereinstimmende `renderedDosageInstruction`. Bestehende Freitext-Dosierungen durchlaufen deshalb Schritt 3, auch wenn `Dosage.text` unverändert bleibt.

### Abschlussprüfung

Jede migrierte Zielressource MUSS gegen das festgelegte 2.0.0-Profil validiert werden. Die Prüfung MUSS mindestens folgende Invarianten umfassen: zulässige Dosisbruchteile und Dezimalschreibweise, positive strukturierte Dosiswerte, positive Perioden und Behandlungsdauern (`TimingValuesPositive`), Freitextregel für 4-Schemata, ganzzahlige Dauer und Periode, Intervallregel, Eindeutigkeit der Zeit-/Wochentagsangaben, vollständige und einheitliche Zeitrahmen sowie Vollständigkeit der strukturierten Dosierung. Auch bei Freitext MÜSSEN beide Text-Extensions vorhanden sein (`DosageRequiresGeneratedText`) und `renderedDosageInstruction` und `Dosage.text` exakt übereinstimmen (`FreeTextMatchesRenderedText`).

Eine Ressourcenfassung gilt als erfolgreich migriert, wenn die vollständige Zielressource valide ist und die Dosierung entweder unverändert, strukturiert normalisiert oder als bedeutungstreuer regulärer Freitext erhalten bleibt. Auch bei strukturierter Darstellung ist die Bedeutungstreue der erzeugten Text-Extensions erforderlich.

Das Ergebnis `Nur archiviert` ist keine erfolgreiche 2.0.0-Migration. Der Bericht MUSS es von erfolgreichen Migrationen und technischen Ausführungsfehlern unterscheiden. Die unveränderte Originalfassung bleibt in allen Fällen abrufbar.
