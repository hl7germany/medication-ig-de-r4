{% include StructureDefinition-PRNSchemeLogical-intro.md %}

{% include StructureDefinition-PRNSchemeLogical-diff.xhtml %}

### Beispiel

{% fragment MedicationRequest/Example-MR-Dosage-Bedarfsmedikation-Kopfschmerzen JSON %}

Folgende weitere Beispiele sind in diesem IG dargestellt:

| Beispiel | Beispiel Datei |
| -------- | ------- |
| Bei Kopfschmerzen: 1 Stück, Mindestabstand 4 Stunden, maximal 6 Stück pro 24 Stunden | [Example-MR-Dosage-Bedarfsmedikation-Kopfschmerzen](MedicationRequest-Example-MR-Dosage-Bedarfsmedikation-Kopfschmerzen.html) |

### Angabe und Erkennung der Dosierart

Bedarfsangaben können in zwei unterschiedlichen Formen auftreten:

1. als reine Bedarfsdosierung ohne festes Einnahmeschema
2. als Bedarfskennzeichnung zu einem bestehenden strukturierten Dosierschema

Eine Bedarfsangabe wird daran erkannt, dass auf Ebene von `Dosage`

- `asNeededBoolean = true`

angegeben ist. Der Anlass `extension[asNeededFor]` ist optional und beschreibt den Bedarf lediglich näher.

Folgende FHIRPath Expression auf Ebene von `Dosage` liefert die Angabe, ob es sich grundsätzlich um eine Bedarfsangabe handelt:

```
asNeeded.ofType(boolean) = true
```

#### Reine Bedarfsdosierung

Eine reine Bedarfsdosierung liegt vor, wenn die `Dosage`-Instanz eine Bedarfsangabe enthält und kein `timing` angegeben ist.

Folgende FHIRPath Expression auf Ebene von `Dosage` liefert die Angabe, ob es sich um eine reine Bedarfsdosierung handelt:

```
asNeeded.ofType(boolean) = true and timing.empty()
```

Für eine Bedarfsmedikation ist `asNeededBoolean = true` verpflichtend. Der Anlass `asNeededFor` ist optional; umgekehrt darf `asNeededFor` nur bei `asNeededBoolean = true` angegeben werden.

Der Anlass wird als Freitext in `extension[asNeededFor].valueCodeableConcept.text` angegeben. Mehrere `asNeededFor`-Extensions können verwendet werden; sie sind fachlich als ODER-Verknüpfung zu interpretieren.

Bei Verwendung von `asNeededFor` muss `valueCodeableConcept.text` befüllt sein.

#### Bedarfsmedikation als Kennzeichnung eines Dosierschemas

Ist zusätzlich zur Bedarfsangabe ein `timing` angegeben, handelt es sich nicht um eine reine Bedarfsdosierung. Die Bedarfsangabe kennzeichnet dann ein bestehendes strukturiertes Dosierschema als Bedarfsmedikation, z. B. eine Einnahme bei Bedarf nach einem angegebenen Intervall oder Schema.

Für die konkrete Interpretation der Dosierung gelten in diesem Fall die Regeln des jeweils verwendeten strukturierten Dosierschemas. Lesende Systeme werten `asNeededBoolean` und `extension[asNeededFor]` aus und müssen dem Nutzer darstellen, dass das Dosierschema nur bei Bedarf angewendet wird.

### Strukturierte Angaben

Die einzunehmende Menge wird wie in den anderen strukturierten Dosierschemata über `doseAndRate.doseQuantity` angegeben.

Bei einer reinen Bedarfsdosierung wird `timing` nicht befüllt.

Der Mindestabstand zwischen zwei Gaben wird über die Modifier Extension `modifierExtension[MinimumIntervalBetweenAdministrations].valueDuration` angegeben.

`maxDosePerPeriod` kann optional verwendet werden, um eine maximale Menge je Zeitraum anzugeben. Wie der Mindestabstand ist die Angabe der reinen Bedarfsdosierung vorbehalten: Ein strukturierter Rhythmus legt bereits fest, wie viel im Bezugszeitraum angewendet wird. Dabei muss die Einheit im `numerator` der Einheit von `doseAndRate.doseQuantity` entsprechen. Als Bezugszeitraum (`denominator`) ist ausschließlich **24 Stunden** (`24 h`) oder **1 Tag** (`1 d`) zulässig; andere Perioden sind nicht erlaubt. Die Auswahl wird eingabetreu wiedergegeben: `24 h` ergibt „in 24 Stunden", `1 d` ergibt „pro Tag".

Lesende Systeme werten `asNeededBoolean`, `extension[asNeededFor]`, `modifierExtension[MinimumIntervalBetweenAdministrations]` und `maxDosePerPeriod` aus. Sie müssen dem Nutzer insbesondere Anlass, Mindestabstand und Maximalgabe verständlich darstellen.
