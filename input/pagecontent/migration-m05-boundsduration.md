# M05 – Gebrochene Behandlungsdauer

[Zur Migrationsübersicht](./migration-1.0.7-2.0.0.html)

## Anlass

`TimingBoundsDurationOnlyWholeNumber` verlangt einen ganzzahligen Wert in `Timing.repeat.boundsDuration.value`. Eine Dezimaldauer wie `1.5 d` ist deshalb strukturiert nicht mehr zulässig.

## Auslöser

M05 gilt, wenn `boundsDuration.value mod 1 != 0`. Ganzzahlige Werte wie `4.00` sind nicht betroffen, sofern der numerische Wert exakt ganzzahlig ist.

## Verbindliche Migration

1. Eine exakte Umrechnung in eine ganzzahlige, im Ziel-ValueSet zulässige Dauer nur mit einer freigegebenen Tabelle gemäß der Übersicht versuchen. Diese Anleitung liefert keine Zahlenumrechnungstabelle. Kalenderdauern in `mo` oder `a` dürfen nicht automatisch in Tage umgerechnet werden. Stunden sind für `boundsDuration` im Ziel nicht zugelassen.
2. Ist keine exakte zulässige Umrechnung möglich, die [Renderer-Allowlist und Vollständigkeitsprüfung](./migration-1.0.7-2.0.0.html) anwenden. Genau ein vollständiges `Dosage`-Element mit positiver `doseQuantity` und unterstütztem Schema ist erforderlich; weitere Fehler dürfen den Pfad nicht sperren.
3. Die Ausgabe muss Dosis, Timing und vollständigen Behandlungszeitraum dezimalgenau erhalten. Bei Erfolg die gesamte Liste durch genau ein Dosage-Element mit ausschließlich `text` ersetzen, alte Text-Extensions und Struktur-Metadaten nicht übernehmen und das vollständige Ziel validieren. Andernfalls das [Archivverfahren](./migration-freitext-fallback.html) verwenden.
4. Nie Dauer runden oder auf eine angenommene Kalenderdefinition umdeuten.

## Beispiel

Quelle: `boundsDuration = 1.5 d`, Dosis 1 Stück täglich.

- Wenn eine freigegebene exakte Zielumrechnung existiert, die strukturierte Zielrepräsentation verwenden.
- Ohne eine solche Umrechnung kann der geprüfte einzelne Rendererfall als `für 1,5 Tage täglich: je 1 Stück` dargestellt werden.
- Bei mehreren Dosage-Elementen, fehlendem Dosiswert oder Informationsverlust: nur archivieren.

## Was bleibt erhalten?

Im Freitextpfad bleiben Dosis, Einnahmezeit und exakte Behandlungsdauer im Text erhalten; die strukturierte Darstellung entfällt. Die vollständige Originalressource bleibt unabhängig vom Ergebnis archiviert.

## Prüffälle

- `boundsDuration.value = 4` bleibt strukturiert.
- `1.5 d` darf nicht zu `2 d` oder `1 d` gerundet werden.
- `1.5 mo` darf nicht durch pauschale Tagesumrechnung verändert werden.
- `1.5 d` darf nicht strukturiert zu `36 h` werden, weil `h` für die Ziel-Dauer nicht zugelassen ist.
- Im Textpfad muss der Zeitraum im Ausgabetext enthalten sein.
