[Zur Migrationsübersicht](./migration-1.0.7-2.0.0.html)

### Anlass

M10 (`TimingOnlyOneBounds`) verlangt, dass alle `Dosage`-Elemente einer Ressource entweder keinen Behandlungszeitraum oder denselben Behandlungszeitraum enthalten. Im Profil 1.0.7 ist `Timing.repeat.bounds` auf `Duration` beschränkt. Fehlt `boundsDuration` nur in einzelnen Elementen, verletzt die Ressource M10. Unterschiedliche Werte oder Einheiten verletzen bereits das Profil 1.0.7 (`TimingOnlyOneBounds`) und sind nicht Gegenstand der Überführung.

### Überführung

1. **Kein Zeitraum vorhanden:** Ist `boundsDuration` in keinem Element vorhanden, bleibt die Dosierung unverändert.
2. **Zeitraum in einem Teil der Elemente:** Das vollständige `boundsDuration` aus einem Element, das es enthält, in alle Elemente kopieren, in denen es fehlt. Bereits vorhandene Werte werden nicht überschrieben. `value`, `system`, `code` und `unit` bleiben unverändert.
3. **Weiter migrieren:** Anschließend mit den übrigen Migrationsschritten fortfahren. Das Kopieren allein garantiert nicht, dass die Ressource alle weiteren Invarianten von 2.0.0 erfüllt.

Die Prüfung erfolgt vor der Textgenerierung. Diese liest den Zeitrahmen nur aus dem ersten `Dosage`-Element; ohne M10 könnten fehlende Angaben in weiteren Elementen im erzeugten Text unberücksichtigt bleiben.

### Beispiele

Der bereits angegebene Wert wird ergänzt, nicht verändert.

```text
Quelle:  Dosage[0].boundsDuration = 5 d
         Dosage[1].boundsDuration fehlt
Ziel:    Dosage[0].boundsDuration = 5 d
         Dosage[1].boundsDuration = 5 d
```