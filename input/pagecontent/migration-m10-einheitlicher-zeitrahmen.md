[Zur Migrationsübersicht](./migration-1.0.7-2.0.0.html)

### Anlass

M10 (`TimingOnlyOneBounds`) verlangt, dass alle `Dosage`-Elemente einer Ressource entweder keinen Behandlungszeitraum oder denselben Behandlungszeitraum enthalten. Im Profil 1.0.7 ist `Timing.repeat.bounds` auf `Duration` beschränkt. Fehlt `boundsDuration` nur in einzelnen Elementen, verletzt die Ressource M10; unterschiedliche Werte oder Einheiten sind ebenfalls nicht eindeutig überführbar.

### Überführung

1. **Vorhandene Angaben vergleichen:** Alle `timing.repeat.boundsDuration` der Dosierungsliste betrachten. Für die Eindeutigkeit müssen `value` und `code` übereinstimmen.
2. **Kein Zeitraum vorhanden:** Ist `boundsDuration` in keinem Element vorhanden, bleibt die Dosierung unverändert.
3. **Ein eindeutiger Zeitraum vorhanden:** Gibt es genau eine Kombination aus `value` und `code`, das vollständige `boundsDuration` aus einem Element mit dieser Angabe in alle Elemente kopieren, in denen es fehlt. Bereits vorhandene Werte werden nicht überschrieben. `value`, `system`, `code` und `unit` bleiben unverändert.
4. **Widersprüchliche Zeiträume:** Gibt es mehrere unterschiedliche `value`- oder `code`-Angaben, Migration abbrechen. Es wird weder ein Wert ausgewählt noch gemittelt, umgerechnet oder durch Freitext ersetzt. Das System entscheidet, was der fehlgeschlagene Migrationsversuch bedeutet.
5. **Weiter migrieren:** Nach erfolgreicher Anwendung M10 auf die gesamte Dosierungsliste erneut prüfen und anschließend mit den übrigen Migrationsschritten fortfahren. Das Kopieren allein garantiert nicht, dass die Ressource alle weiteren Invarianten von 2.0.0 erfüllt.

Die Prüfung erfolgt vor der Textgenerierung. Diese liest den Zeitrahmen nur aus dem ersten `Dosage`-Element; ohne M10 könnten abweichende oder fehlende Angaben in weiteren Elementen im erzeugten Text unberücksichtigt bleiben.

### Beispiele

Eindeutiger Zeitraum: Der bereits angegebene Wert wird ergänzt, nicht verändert.

```text
Quelle:  Dosage[0].boundsDuration = 5 d
         Dosage[1].boundsDuration fehlt
Ziel:    Dosage[0].boundsDuration = 5 d
         Dosage[1].boundsDuration = 5 d
```

Widersprüchliche Zeiträume führen zum Abbruch:

```text
Quelle:  Dosage[0].boundsDuration = 5 d
         Dosage[1].boundsDuration = 7 d
Ergebnis: Migration abgebrochen; System entscheidet über den weiteren Umgang.
```