# Gemeinsames Archivverfahren bei nicht migrierbaren Dosierungen

[Zur Migrationsübersicht](./migration-1.0.7-2.0.0.html)

Dieses Verfahren wird verwendet, wenn keine bedeutungstreue, valide 2.0.0-Dosierung nachgewiesen werden kann. Das Ergebnis lautet **Nur archiviert**: Die vollständige 1.0.7-Quelle bleibt unverändert erhalten; es wird keine 2.0.0-Zielressource mit einer verwendbaren Dosierung freigegeben.

Der bisher als Freitext-Fallback bezeichnete Ansatz, Quell-JSON mit einem Warnpräfix in `Dosage.text` abzulegen, wird nicht verwendet. Lesende Systeme erkennen dieses Feld als Freitext-Dosierung. Weder der Präfix noch eine erfolgreiche Profilvalidierung verhindert zuverlässig seine Verwendung als Einnahmeanweisung.

## Betroffene Fälle

| Fall | Constraint | Grund für den Fallback |
|---|---|---|
| M03 | `DosageDoseValuePositive` | Null- oder Negativwert erlaubt keine sichere Dosisinterpretation; Standardrenderer weist ihn zurück. |
| M08 | `TimingOnlyOneTimeForInterval` | Intervallangaben sind unvollständig oder widersprüchlich; fehlende Felder dürfen nicht abgeleitet werden. |
| M09 | `TimingOnlyOneWhen` | Doppelte Tagesabschnitts-Codes können unterschiedliche Dosierungen tragen. |
| M10 | `TimingOnlyOneTimeOfDay` | Doppelte Uhrzeiten können unterschiedliche Dosierungen tragen. |
| M11 | `TimingOnlyOneDayOfWeek` | Doppelte Wochentage können unterschiedliche Dosierungen tragen. |
| M12 | `TimingOnlyWhenOrTimeOfDay` | Tagesabschnitt und konkrete Uhrzeit sind nicht ohne Fachentscheidung gleichzusetzen. |
| M13 | `TimingSingleDosageForTimeOfDay` | Wiederholte Uhrzeiten haben keine eindeutige vollständige Dosiszuordnung. |
| M14 | `TimingSingleDosageForWhen` | Wiederholte `when`-Angaben haben keine eindeutige vollständige Dosiszuordnung. |
| M15 | `TimingOnlyOneBounds` | Bounds sind nur teilweise gesetzt; sie dürfen nicht auf weitere Dosage-Elemente kopiert werden. |
| M16 | `DosageStructuredRequiresBoth` | `timing` oder `doseAndRate` fehlt; es darf kein Wert erfunden werden. |
| M17 | `DosageDoseUnitSameCode` | Unterschiedliche Dosis-Codes können ohne versionierte exakte Umrechnung nicht vereinheitlicht werden. |

Das Verfahren gilt außerdem, wenn bei M01, M02, M04, M05, M06, M07 oder M18 eine erforderliche Voraussetzung fehlt, die Vollständigkeitsprüfung scheitert, der Renderer einen Fehler liefert oder das Ziel ungültig bleibt. Auch ein nicht durch die Falltabelle abgedeckter Zielverstoß darf nicht durch eine erfundene Transformation umgangen werden.

M19–M21 lösen allein keine Archiventscheidung aus. Andere gleichzeitig vorliegende Fehler sind trotzdem zu behandeln.

## Verbindlicher Ablauf

Die Entscheidung gilt für die gesamte Dosierungs-Liste einer Ressourcenfassung. Fehlerhafte Elemente dürfen nicht entfernt werden, um die übrigen Elemente als scheinbar vollständige Ziel-Dosierung freizugeben.

1. Die vollständige Originalressource mit ursprünglicher Profilkennzeichnung, Inhalt und Versionskontext unverändert archivieren. Auch Dosage-Reihenfolge, Extensions und ursprüngliche Zahlenschreibweisen erhalten.
2. Einen gegebenenfalls erzeugten Zielkandidaten nicht als erfolgreich migrierte Ressource veröffentlichen. Keine Dosierung löschen, keinen Warntext als Einnahmeanweisung einsetzen und keinen klinischen Ressourcenstatus erfinden.
3. Im getrennten Migrationsbericht das Ergebnis `Nur archiviert`, die Quellreferenz, betroffene Fall-IDs und konkrete Prüfursachen festhalten. Dieser Ergebniswert ist ein Migrationsstatus, kein FHIR-Ressourcenstatus.
4. Technische Fehler, etwa einen nicht ausführbaren Validator oder Renderer, zusätzlich als solche protokollieren. Die Quelle auch bei technischen Fehlern erhalten.
5. Eine fachliche Klärung außerhalb der automatischen Migration ermöglichen. Eine später bestätigte Dosierung ist eine eigene, nachvollziehbar dokumentierte Entscheidung; sie wird nicht durch dieses Archivverfahren erzeugt.

## Trennung von Archiv und Versorgung

Das ausführende System MUSS Archiv und freigegebene Zielressourcen technisch getrennt behandeln. Archivfassungen dürfen nicht als erfolgreich migrierte aktive 2.0.0-Dosierungen ausgeliefert werden. Die konkrete Archivschnittstelle ist nicht Teil dieser Anleitung; sie MUSS die unveränderte Quelle wiederherstellbar und ausdrücklich als Originalfassung zugänglich machen.

Dieses Verfahren entscheidet nicht, ob eine bestehende 1.0.7-Ressource im Quellsystem weiterverwendet werden darf. Es erzeugt weder eine Absetzung noch eine neue Einnahmeanweisung. Ein System, das ausschließlich 2.0.0 akzeptiert, muss die fehlende migrierte Dosierung als offenen Migrationsfall behandeln, nicht als fehlenden Therapiebedarf.

## Fallbeispiele

### M03 – Nichtpositive Dosis

Quelle: `doseQuantity.value = 0`. Der Wert bleibt in der Originalressource erhalten. Es gibt kein freigegebenes Ziel; die Migration behauptet weder „keine Gabe“ noch korrigiert sie den Wert.

### M12 – Gemischtes Timing

Quelle: Ein Dosage-Element hat `when = MORN`, ein anderes `timeOfDay = 08:00`. Beide Objekte bleiben im Archiv erhalten; `MORN` wird nicht in `08:00` umgewandelt.

### M16 – Fehlende Dosis

Quelle: `timing` ist vorhanden, `doseAndRate` fehlt. Die Migration ergänzt keine angenommene Dosis und gibt keine unvollständige Ziel-Dosierung frei.

## Prüffälle

- Die vollständige Quelle einschließlich Array-Reihenfolge und Extensions bleibt unverändert wiederherstellbar.
- Es wird weder eine Teil-Dosierung noch eine Zielressource mit Archiv-JSON in `Dosage.text` freigegeben.
- Der Migrationsbericht unterscheidet `Nur archiviert`, erfolgreiche Migration und technischen Fehler.
- Historische und gelöschte Fassungen werden nicht als aktuelle Ressourcen aktiviert.
- Eine erneute Verarbeitung derselben Quelle mit denselben Regeln trifft dieselbe Archiventscheidung.
