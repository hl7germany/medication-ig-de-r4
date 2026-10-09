# M01 – Dosisbruchteil nicht erlaubt

[Zur Migrationsübersicht](./migration-1.0.7-2.0.0.html)

## Anlass

`DosageDoseQuantityAllowedFractions` lässt in strukturierten Dosen nur ganze Werte und die Bruchteile `.25`, `.33`, `.5`, `.66` und `.75` zu. In 1.0.7 waren auch andere positive Werte wie `1.2` zulässig.

## Auslöser

Der Fall liegt vor, wenn ein strukturierter `doseQuantity.value` den Constraint verletzt. Werte in der JSON-Schreibweise mit Komma sind nicht zulässig; JSON-Zahlen werden mit Punkt serialisiert. Der Constraint gilt nicht für bereits vorhandenes Freitextfeld `Dosage.text`.

## Verbindliche Migration

1. Eine strukturierte Umrechnung nur mit einer explizit freigegebenen, versionierten Tabelle gemäß der Übersicht versuchen. Diese Anleitung liefert keine Dosisumrechnungstabelle. Ohne sie bleiben Zahlenwert, System und Code unverändert; keine Einheit oder Wirkstärke raten.
2. Ist keine exakte strukturierte Abbildung verfügbar, die [Renderer-Allowlist und Vollständigkeitsprüfung](./migration-1.0.7-2.0.0.html) anwenden. Genau ein vollständiges `Dosage`-Element mit positiver `doseQuantity` und unterstütztem Schema ist erforderlich. Alle gleichzeitig vorliegenden Zielverletzungen prüfen.
3. Das Renderergebnis nur bei nachgewiesener Bedeutungstreue als einzige reine Freitext-Dosierung übernehmen. Das neue Dosage-Element enthält ausschließlich `text`; alte Text-Extensions und Struktur-Metadaten nicht übernehmen. Den vollständigen Zielzustand validieren und die Rendererherkunft im Migrationsbericht festhalten.
4. Bei Informationsverlust, Rendererfehler, mehreren Dosage-Elementen oder ungültigem Ziel das [Archivverfahren](./migration-freitext-fallback.html) verwenden. Eine nichtleere, profilkonforme Textausgabe allein reicht nicht aus.
5. Nie auf- oder abrunden.

## Beispiel

Quelle: strukturierte Dosis `1.2 Stück`, einmal täglich.

Exakte Codeumrechnung nicht vorhanden; der gepinnte Renderer kann den einzelnen vollständigen Fall darstellen:

```text
Dosage.text = "täglich: je 1,2 Stück"
```

Im Ziel werden `timing` und `doseAndRate` nicht parallel zu diesem Freitext gesetzt. Die Quellressource mit `value = 1.2` bleibt für die Wiederherstellung erhalten.

## Was bleibt erhalten?

Die vollständige Einnahmeangabe einschließlich des exakten Dosiswerts bleibt im Zieltext erhalten; die strukturierte Darstellung entfällt. Scheitert dieser Nachweis, bleibt nur die unveränderte Quelle im Archiv erhalten und es wird keine Ziel-Dosierung freigegeben.

## Prüffälle

- `1.25` besteht den Bruchteils-Constraint und bleibt strukturiert.
- `1.2` löst M01 aus; kein Zahlenwert darf gerundet werden.
- `0` oder ein negativer Wert gehört zu M03, nicht zu dieser Renderer-Allowlist.
- `1.2000000000000001` darf nicht als `1,2000000000000002` übernommen werden; die Dezimalvergleichsprüfung muss die Änderung erkennen.
- Eine Uhrzeit `08:00:30` darf nicht zu `08:00 Uhr` verkürzt werden.
- Eine Renderer-Ausgabe, die nur ein nacktes 4-Schema enthält, darf nicht übernommen werden.
