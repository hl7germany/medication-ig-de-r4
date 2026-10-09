# M01 – Dosisbruchteil nicht erlaubt

[Zur Migrationsübersicht](./migration-1.0.7-2.0.0.html)

## Anlass

`DosageDoseQuantityAllowedFractions` lässt in strukturierten Dosen nur ganze Werte und die Bruchteile `.25`, `.33`, `.5`, `.66` und `.75` zu. In 1.0.7 waren auch andere positive Werte wie `1.2` zulässig.

## Auslöser

Der Fall liegt vor, wenn ein strukturierter `doseQuantity.value` den Constraint verletzt. Werte in der JSON-Schreibweise mit Komma sind nicht zulässig; JSON-Zahlen werden mit Punkt serialisiert. Der Constraint gilt nicht für bereits vorhandenes Freitextfeld `Dosage.text`.

## Verbindliche Migration

1. Prüfen, ob eine explizite, versionierte Dosisumrechnung den Quellcode in einen zulässigen Zielcode mit mathematisch exakt gleichem Wert überführt. Ohne eine solche Umrechnung darf keine Einheit oder Wirkstärke geraten werden.
2. Ist keine exakte strukturierte Umrechnung verfügbar, den Renderer nur für genau ein vollständiges `Dosage`-Element mit positiver Dosis und unterstütztem Schema aufrufen.
3. Das Renderergebnis als einzige reine Freitext-Dosierung übernehmen, wenn es nichtleer ist und alle Zielinvarianten besteht. `timing` und `doseAndRate` entfallen; die ursprüngliche Ressource bleibt archiviert.
4. Bei Rendererfehler, mehreren Dosage-Elementen oder nicht konformer Textausgabe den deterministischen Archiv-Fallback der Übersicht verwenden.
5. Nie auf- oder abrunden.

## Beispiel

Quelle: strukturierte Dosis `1.2 Stück`, einmal täglich.

Exakte Codeumrechnung nicht vorhanden; der gepinnte Renderer kann den einzelnen vollständigen Fall darstellen:

```text
Dosage.text = "täglich: je 1,2 Stück"
```

Im Ziel werden `timing` und `doseAndRate` nicht parallel zu diesem Freitext gesetzt. Die Quellressource mit `value = 1.2` bleibt für die Wiederherstellung erhalten.

## Prüffälle

- `1.25` besteht den Bruchteils-Constraint und bleibt strukturiert.
- `1.2` löst M01 aus; kein Zahlenwert darf gerundet werden.
- `0` oder ein negativer Wert gehört zu M03, nicht zu dieser Renderer-Allowlist.
- Eine Renderer-Ausgabe, die nur ein nacktes 4-Schema enthält, darf nicht übernommen werden.
