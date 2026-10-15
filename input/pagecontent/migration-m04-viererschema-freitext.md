# M04 – 4-Schema im Freitext

[Zur Migrationsübersicht](./migration-1.0.7-2.0.0.html)

## Anlass

`DosageFourSlotPatternInText` verbietet in 2.0.0 einen Freitext, der vollständig einem 4-Schema entspricht, zum Beispiel `1-0-0-0`. Die Erkennung verlangt vier Zahlen-Slots; diese dürfen Dezimalwerte oder Teilungsverhältnisse enthalten. Ein Einheitstext ist optional. Der Ausdruck erkennt die Schreibform, nicht die belegte klinische Bedeutung.

## Auslöser

Für jedes befüllte `Dosage.text` wird genau der Constraint-Ausdruck des Zielprofils verwendet:

```text
^\\s*\\d+([.,]\\d+)?(\\s*/\\s*\\d+)?(\\s*[-–]\\s*\\d+([.,]\\d+)?(\\s*/\\s*\\d+)?){3}(\\s*[A-Za-zÄÖÜäöüß().]+)?\\s*$
```

## Verbindliche Migration

1. Ohne eine explizite, versionierte Quellkonvention den Text nicht automatisch interpretieren. Insbesondere nicht pauschal `täglich:` voranstellen: Der Regex-Treffer allein belegt keine tägliche Wiederholung.
2. Eine zusätzliche Quellkonvention muss Slot-Bedeutung, Wiederholungsfrequenz, Zahlen- und Teilungsschreibweise sowie Dosis-System und -Code eindeutig festlegen. Diese Anleitung liefert keine solche Konvention. Eine Arzneimittelreferenz oder ein angezeigter Einheitenname allein reicht nicht aus.
3. Nur bei vollständig belegter Bedeutung eine exakte strukturierte Abbildung nach dieser Konvention erzeugen. Null-Slots bedeuten dabei nur dann keine Gabe, wenn die Konvention dies festlegt; es werden keine strukturierten Null-Dosen erzeugt. Anschließend den regulären Text erzeugen und sämtliche Zielregeln sowie die Vollständigkeitsprüfung der Übersicht anwenden.
4. Ist die Bedeutung nicht belegt oder die strukturierte Abbildung nicht zulässig, das [Archivverfahren](./migration-freitext-fallback.html) verwenden. Keine bloße Textumformulierung zur Umgehung des Constraints vornehmen.

Die ursprüngliche Ressourcenfassung bleibt unverändert archiviert. Alte Renderer-Extensions dürfen nicht als Herkunft der neu erzeugten Darstellung übernommen werden.

## Beispiel

```text
Quelle:   Dosage.text = "1-0-0-0 Stück"
Nachweis: Keine versionierte Quellkonvention vorhanden
Ergebnis: Nur archiviert; keine 2.0.0-Dosierung freigegeben
```

Wenn eine freigegebene Quellkonvention dagegen ausdrücklich „morgens, mittags, abends, nachts; jeden Tag; Stück mit festgelegtem System und Code“ festlegt, kann die Quelle als Dosis `1` mit `when = MORN` abgebildet werden. Diese Bedeutung stammt dann aus der dokumentierten Quellkonvention, nicht aus dem Regex.

## Prüffälle

- `1-0-0-0` ohne Quellkonvention wird nur archiviert; es wird kein `täglich:` ergänzt.
- Eine belegte Quellkonvention erlaubt nur eine exakte Abbildung ohne Rundung oder geratenen Einheiten-Code.
- `1-0-0` matcht nicht, weil nur drei Slots vorhanden sind; M04 ändert den Text nicht.
- Ein Text mit weiterem Zusatz, der den vollständigen Ausdruck nicht erfüllt, wird nicht geändert.
- Eine erzeugte strukturierte Dosierung muss einschließlich neuer Text-Extensions gegen das Zielprofil validieren.
