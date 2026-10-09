# M20 – Reine Warnungen

[Zur Migrationsübersicht](./migration-1.0.7-2.0.0.html)

## Zweck

M20 fasst Warnungen zusammen, deren Auftreten für sich genommen keine Datenmigration auslöst. Eine Warnung ist nicht mit einem Fehler im konkreten 2.0.0-dgMP-Profil gleichzusetzen.

## Betroffene Warnungs-Constraints

Je nach tatsächlich verwendeter Profilstufe gehören dazu unter anderem `DosageDoseUnitSameCodeWarning`, `DosageDoseValuePositiveWarning`, `DosageFourSlotPatternInTextWarning`, `DosageStructuredRequiresBothWarning`, `AsNeededForRequiresAsNeededWarning`, `TimingSingleDosageForTimeOfDayWarning`, `TimingSingleDosageForWhenWarning`, `TimingBoundsUnitMatchesCodeWarning` und `TimingFreqOrPeriodGtOneWarning`.

## Migrationsregel

1. Eine reine Warnung verändert keine Ressourcendaten.
2. Warnungen werden im Migrationsbericht gezählt und getrennt von Fehlern ausgewiesen.
3. Wenn derselbe Sachverhalt im konkreten Zielprofil als Fehler definiert ist, gilt die zugehörige M-Fallregel, zum Beispiel M03, M04, M07, M13, M14, M16, M17 oder M18.
4. Validatorprofil und Severity müssen im Bericht enthalten sein, damit ein generischer Warnhinweis nicht fälschlich als dgMP-Fehler klassifiziert wird.

## Beispiel

Ein Wert `0` kann auf einem generischen DE-Profil eine Warnung auslösen; im dgMP-Profil verletzt er `DosageDoseValuePositive` und fällt unter M03. Die Regel M20 allein ändert den Wert nicht.

## Prüffälle

- Nur Warnung, kein harter Ziel-Constraint: Ressource unverändert übernehmen und Warnung protokollieren.
- Derselbe Wert löst im dgMP-Profil einen Fehler aus: die spezifische Fallregel ausführen.
- Warnungen dürfen nicht durch Entfernen der betroffenen Felder unterdrückt werden.
