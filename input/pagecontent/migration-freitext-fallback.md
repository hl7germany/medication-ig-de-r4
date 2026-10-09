# Gemeinsamer Freitext-Fallback

[Zur Migrationsübersicht](./migration-1.0.7-2.0.0.html)

Diese Regel wird verwendet, wenn die 1.0.7-Dosierung wegen fehlender, widersprüchlicher oder nicht sicher umrechenbarer Angaben nicht als klinisch belastbare 2.0.0-Struktur oder reguläre Renderer-Freitextangabe dargestellt werden kann. Sie erhält den vollständigen Quellinhalt, erzeugt aber **keine ausführbare oder fachlich bestätigte Einnahmeanweisung**.

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

Der Fallback wird außerdem verwendet, wenn eine der strukturierten Migrationen M01, M05, M06, M07 oder M18 ihre festgelegte Vorbedingung nicht erfüllt, der Renderer fehlschlägt oder die Zielvalidierung nicht besteht. Die Einzelfallseiten beschreiben diese Übergänge.

M19–M21 lösen diesen Fallback nicht aus: Bei ihnen ist keine Datenänderung erforderlich.

## Verbindlicher Ablauf

Die Migration wendet den Fallback auf die gesamte Dosierungs-Liste einer einzelnen Ressourcenfassung an. Sie darf nicht nur das fehlerhafte Element auslagern und andere Dosage-Elemente strukturiert daneben stehen lassen.

1. Die Quellressource und ihre Version unverändert archivieren.
2. Das zum Ressourcentyp gehörende Feld lesen: `MedicationRequest.dosageInstruction`, `MedicationDispense.dosageInstruction` oder `MedicationStatement.dosage`.
3. Die Dosage-Elemente in ihrer ursprünglichen Array-Reihenfolge vollständig kanonisch serialisieren.
4. Alle Elemente der Dosierungsliste durch genau ein neues `Dosage`-Element ersetzen. Darin ausschließlich `text` mit folgendem Aufbau setzen:

   ```text
   [ARCHIV-MIGRATION 1.0.7->2.0.0; NICHT ALS EINNAHMEANWEISUNG VERWENDEN] <kanonisches JSON-Array>
   ```

5. `timing`, `doseAndRate` und alle anderen Dosage-Felder im neuen Element leer lassen. Keine Dose, Einheit oder Timing-Angabe zusätzlich ableiten.
6. Resource-level `renderedDosageInstruction` und `GeneratedDosageInstructionsMeta` entfernen. Der Archivtext ist keine Ausgabe des Dosierungstext-Renderers. Alle nicht dosierungsbezogenen Extensions unverändert erhalten.
7. Die Zielressource gegen das 2.0.0-Profil validieren. Bei erfolgreicher Validierung Status `Archiv-Fallback` setzen und die betroffenen M-Fall-IDs protokollieren. Bei Fehlschlag die Quelle erhalten und einen technischen Fehler melden; keine alternative Transformation erraten.

## Kanonische Serialisierung

Das JSON-Array MUSS die kompletten Quellobjekte enthalten, nicht nur die Felder, die den Constraint ausgelöst haben. Dadurch bleiben auch Codes, Systeme, Einheiten, Extensions und nicht für die Migration ausgewertete Informationen verfügbar.

Die Serialisierung MUSS:

- UTF-8 verwenden;
- Objekt-Schlüssel rekursiv lexikografisch nach Unicode-Codepoint sortieren;
- keine optionalen Leerzeichen oder Zeilenumbrüche ausgeben;
- Strings standardkonform als JSON escapen;
- Array-Reihenfolge erhalten;
- Zahlen dezimalgenau, ohne Exponentialnotation und ohne Rundung darstellen;
- `null` und vorhandene Extensions erhalten.

Fehlende JSON-Felder bleiben fehlend und werden nicht mit `null` ergänzt. Das unveränderte archivierte Quellobjekt bleibt maßgeblich für die Wiederherstellung der ursprünglichen Zahlenschreibweise und Bytefolge.

## Erkennung und Verwendung

Ein empfangendes System MUSS den Präfix `ARCHIV-MIGRATION 1.0.7->2.0.0; NICHT ALS EINNAHMEANWEISUNG VERWENDEN` erkennen. Es DARF den nachfolgenden JSON-Inhalt nicht als normale Dosierungsanweisung anzeigen, ausführen oder als fachlich geprüften Text weitergeben. Die Ressource ist eine 2.0.0-konforme Archiv-Repräsentation; sie ist nicht automatisch für eine aktive Therapieentscheidung geeignet.

## Fallbeispiele

### M03 – Nichtpositive Dosis

Quelle: `doseQuantity.value = 0`. Der Wert bleibt im serialisierten Originalobjekt erhalten. Die Migration behauptet weder „keine Gabe“ noch korrigiert sie den Wert.

### M12 – Gemischtes Timing

Quelle: Ein Dosage-Element hat `when = MORN`, ein anderes `timeOfDay = 08:00`. Beide Objekte werden vollständig serialisiert; `MORN` wird nicht in `08:00` umgewandelt.

### M16 – Fehlende Dosis

Quelle: `timing` ist vorhanden, `doseAndRate` fehlt. Die Migration ergänzt keine angenommene Dosis, sondern archiviert das vollständige Dosage-Objekt im Fallback.

## Prüffälle

- Zwei oder mehr Dosage-Elemente ergeben genau ein Ziel-Dosage-Element.
- Die Array-Reihenfolge und alle Felder der Quelldosages bleiben im JSON erhalten.
- Es gibt im Ziel-Fallback weder `timing` noch `doseAndRate`.
- Gerenderte Text-Extensions und deren Metadaten sind entfernt.
- Der Fallback-Präfix ist exakt und maschinenlesbar.
- Ein wiederholter Lauf über eine als migriert markierte Zielressource verarbeitet sie nicht erneut als 1.0.7-Quelle.
