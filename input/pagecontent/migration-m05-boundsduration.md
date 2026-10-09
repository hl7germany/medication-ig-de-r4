# M05 – Gebrochene Behandlungsdauer

[Zur Migrationsübersicht](./migration-1.0.7-2.0.0.html)

## Anlass

`TimingBoundsDurationOnlyWholeNumber` verlangt einen ganzzahligen Wert in `Timing.repeat.boundsDuration.value`. Eine Dezimaldauer wie `1.5 d` ist deshalb strukturiert nicht mehr zulässig.

## Auslöser

M05 gilt, wenn `boundsDuration.value mod 1 != 0`. Ganzzahlige Werte wie `4.00` sind nicht betroffen, sofern der numerische Wert exakt ganzzahlig ist.

## Verbindliche Migration

1. Eine exakte Umrechnung in eine ganzzahlige, im Ziel-ValueSet zulässige Dauer darf nur erfolgen, wenn Einheit und Semantik exakt erhalten bleiben. Kalenderdauern in `mo` oder `a` dürfen nicht automatisch in Tage umgerechnet werden.
2. Ist keine exakte zulässige Umrechnung möglich, darf der Renderer nur bei genau einem vollständigen `Dosage`-Element und unterstütztem Schema verwendet werden.
3. Die Renderer-Ausgabe muss den vollständigen Zeitraum enthalten und gegen alle 2.0.0-Freitext-Constraints validieren. Andernfalls den Archiv-Fallback verwenden.
4. Nie Dauer runden oder auf eine angenommene Kalenderdefinition umdeuten.

## Beispiel

Quelle: `boundsDuration = 1.5 d`, Dosis 1 Stück täglich.

- Wenn eine freigegebene exakte Zielumrechnung existiert, die strukturierte Zielrepräsentation verwenden.
- Sonst kann der einzelne vollständige Rendererfall als `für 1,5 Tage: täglich: je 1 Stück` dargestellt werden.
- Bei mehreren Dosage-Elementen oder fehlendem Dosiswert Archiv-Fallback.

## Prüffälle

- `boundsDuration.value = 4` bleibt strukturiert.
- `1.5 d` darf nicht zu `2 d` oder `1 d` gerundet werden.
- `1.5 mo` darf nicht durch pauschale Tagesumrechnung verändert werden.
- Im Textpfad muss der Zeitraum im Ausgabetext enthalten sein.
