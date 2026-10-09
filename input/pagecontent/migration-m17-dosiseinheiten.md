# M17 – Unterschiedliche Dosis-Codes oder Einheiten

[Zur Migrationsübersicht](./migration-1.0.7-2.0.0.html)

## Anlass

`DosageDoseUnitSameCode` verlangt im dgMP-Profil, dass die Codes der strukturierten Dosisangaben über eine Ressource gleich sind. Die Prüfung vergleicht den Code; sie beweist nicht, dass unterschiedliche Codes physikalisch äquivalent sind oder dass identische Codes stets denselben Display-Text haben.

## Auslöser

Mindestens zwei strukturierte Dosisangaben haben unterschiedliche Dosis-Codes und der Zielvalidator meldet `DosageDoseUnitSameCode`.

## Verbindliche Migration

1. Ohne eine explizite, versionierte Umrechnungstabelle keine Dosis-Codes vereinheitlichen und keine Zahlenwerte umrechnen.
2. Eine zugelassene Umrechnung muss Quell-/Zielsystem und -code, exakten Faktor, Terminologieversion und Gültigkeit festlegen. Die Zielwerte müssen mathematisch exakt und im Profil zulässig sein.
3. Ist eine solche Tabelle nicht vorhanden oder der Fall nicht vollständig abgedeckt, die komplette Dosage-Liste im Archiv-Fallback abbilden.
4. Bei gleichem Code, aber unterschiedlichen `unit`-Anzeigen, greift dieser Codevergleich nicht notwendigerweise. Nur Anzeigeabweichungen nicht als Mengen-Konvertierung behandeln; M18 betrifft stattdessen UCUM-Daueranzeigen.

## Beispiel

Quelle: zwei Dosages mit unterschiedlichen Dosis-Codes und jeweils `value = 1`.

Ohne freigegebene Umrechnung ist nicht belegt, dass beide Werte dieselbe Menge bezeichnen. Ziel: vollständiger Archiv-Fallback; weder Codes noch Zahlenwerte werden vereinheitlicht.

## Prüffälle

- Derselbe `code` in allen Dosisangaben: M17 löst keine Codeverschiedenheit aus.
- Unterschiedliche Codes ohne Mapping: Archiv-Fallback.
- Unterschiedliche Codes mit versioniertem exaktem Mapping: konvertieren und gesamte Ressource validieren.
- Ein anderer `unit`-Displaytext allein ist kein Beweis für eine andere numerische Menge.
