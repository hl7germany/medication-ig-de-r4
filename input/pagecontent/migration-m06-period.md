# M06 – Gebrochene Periode

[Zur Migrationsübersicht](./migration-1.0.7-2.0.0.html)

## Anlass

`TimingPeriodOnlyWholeNumber` verlangt ganzzahlige Werte für `Timing.repeat.period` und `periodMax`. Eine gebrochene Periode wie `1.5 d` ist strukturiert nicht mehr zulässig.

## Auslöser

M06 gilt, wenn `period` oder `periodMax` numerisch nicht ganzzahlig ist. Ein numerischer Wert `4.00` ist ganzzahlig und löst den Fall nicht aus. `periodMax` ist in 2.0.0 mitzuprüfen, war in einer gültigen dgMP-Quelle 1.0.7 jedoch ausgeschlossen; sein Vorhandensein erfordert daher zusätzlich eine Klärung des Quellprofilstands.

## Verbindliche Migration

1. Eine mathematisch exakte Umrechnung in eine ganzzahlige Periode nur mit einer freigegebenen Tabelle gemäß der Übersicht versuchen. Diese Anleitung liefert keine Zahlenumrechnungstabelle. Die Ziel-ValueSet-Einheiten sind `min`, `h`, `d`, `wk` und `mo`; nach der Umrechnung sämtliche Zielregeln erneut prüfen, auch M07.
2. `mo` nicht in Tage umrechnen; die Länge eines Monats ist kalenderabhängig.
3. Wenn keine exakte strukturierte Abbildung möglich ist, die [Renderer-Allowlist und Vollständigkeitsprüfung](./migration-1.0.7-2.0.0.html) anwenden. Genau ein vollständiges `Dosage`-Element mit positiver `doseQuantity` und unterstütztem Timing-Schema ist erforderlich.
4. Nur bedeutungstreuen Renderertext übernehmen: die gesamte Liste durch genau ein Dosage-Element mit ausschließlich `text` ersetzen, alte Text-Extensions und Struktur-Metadaten nicht übernehmen und das vollständige Ziel validieren. Bei Fehler oder Informationsverlust das [Archivverfahren](./migration-freitext-fallback.html) verwenden.
5. Keine Frequenz, Periode oder Einheit runden oder weglassen.

## Beispiel

Quelle: `frequency = 1`, `period = 1.5`, `periodUnit = d`, Dosis `1 Stück`.

Als UCUM-Zeitdauer entsprechen `1.5 d` exakt `36 h`. Eine strukturierte Umrechnung ist aber nur erlaubt, wenn eine freigegebene Tabelle diesen Anwendungskontext abdeckt und das Ergebnis alle Zielregeln erfüllt. Beispielsweise kann eine Angabe mit konkreter Uhrzeit nicht einfach auf `periodUnit = h` wechseln.

Ohne eine solche Tabelle bleibt der Renderer-Freitextpfad: `alle 1,5 Tage: je 1 Stück`, sofern dessen Voraussetzungen erfüllt sind.

## Was bleibt erhalten?

Die exakte Periode und ihre Zuordnung zur Dosis bleiben erhalten. Bei geprüfter Umrechnung bleibt die Darstellung strukturiert; im Freitextpfad entfällt die Struktur und die vollständige Dosierung steht in `text`. Die Quelle bleibt unverändert archiviert.

## Prüffälle

- `period = 2 d` bleibt strukturiert.
- `period = 1.5 d` wird nicht zu `1 d` oder `2 d` gerundet.
- `period = 1.5 mo` wird nicht automatisch in Tage konvertiert.
- Ohne freigegebene Tabelle findet keine automatische Umrechnung von `1.5 d` in `36 h` statt.
- `periodMax` ist ebenfalls auf Ganzzahligkeit zu prüfen.
