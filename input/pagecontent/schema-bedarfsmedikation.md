Bedarfsmedikation beschreibt eine Dosierung, die nicht ausschließlich nach einem festen Einnahmeplan, sondern bei auftretendem Bedarf angewendet wird. Der Bedarf wird dabei immer mit einem Einnahmeanlass angegeben, z. B. "bei Kopfschmerzen".

In diesem Anwendungsfall wird davon ausgegangen, dass die Bedarfsangabe in einer eigenen `Dosage`-Instanz abgebildet wird. Die Angaben zu Menge, Mindestabstand oder Maximalgabe beziehen sich dann auf diese Bedarfsdosierung.

Es wird zudem ermöglicht:

- einen oder mehrere Einnahmeanlässe als Freitext anzugeben
  - Bei der Angabe mehrere Bedingungen gelten diese als *oder* verknüpft. Es muss also nur eine der Bedingungen zutreffen.
- einen Mindestabstand zwischen zwei Gaben explizit über die Modifier Extension `MindestabstandZwischenGaben` anzugeben
- eine maximale Menge je Zeitraum anzugeben

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

- `asNeededBoolean = true` und
- `extension[asNeededFor]`

gemeinsam angegeben sind.

Folgende FHIRPath Expression auf Ebene von `Dosage` liefert die Angabe, ob es sich grundsätzlich um eine Bedarfsangabe handelt:

```
asNeeded.ofType(boolean) = true and
extension.where(url = 'http://hl7.org/fhir/5.0/StructureDefinition/extension-Dosage.asNeededFor').exists()
```

#### Reine Bedarfsdosierung

Eine reine Bedarfsdosierung liegt vor, wenn die `Dosage`-Instanz eine Bedarfsangabe enthält und kein `timing` angegeben ist.

Folgende FHIRPath Expression auf Ebene von `Dosage` liefert die Angabe, ob es sich um eine reine Bedarfsdosierung handelt:

```
(
  asNeeded.ofType(boolean) = true and
  extension.where(url = 'http://hl7.org/fhir/5.0/StructureDefinition/extension-Dosage.asNeededFor').exists()
) and timing.empty()
```

Für Bedarfsmedikation sind sowohl `asNeededBoolean = true` als auch die Extension `asNeededFor` verpflichtend anzugeben.

Der Einnahmeanlass wird als Freitext in `extension[asNeededFor].valueCodeableConcept.text` angegeben. Mehrere `asNeededFor`-Extensions können verwendet werden; sie sind fachlich als ODER-Verknüpfung zu interpretieren.

Bei Verwendung von `asNeededFor` muss `valueCodeableConcept.text` befüllt sein.

#### Bedarfsmedikation als Kennzeichnung eines Dosierschemas

Ist zusätzlich zur Bedarfsangabe ein `timing` angegeben, handelt es sich nicht um eine reine Bedarfsdosierung. Die Bedarfsangabe kennzeichnet dann ein bestehendes strukturiertes Dosierschema als Bedarfsmedikation, z. B. eine Einnahme bei Bedarf nach einem angegebenen Intervall oder Schema.

Für die konkrete Interpretation der Dosierung gelten in diesem Fall die Regeln des jeweils verwendeten strukturierten Dosierschemas. Lesende Systeme werten `asNeededBoolean` und `extension[asNeededFor]` aus und müssen dem Nutzer darstellen, dass das Dosierschema nur bei Bedarf angewendet wird.

### Strukturierte Angaben

Die einzunehmende Menge wird wie in den anderen strukturierten Dosierschemata über `doseAndRate.doseQuantity` angegeben.

Bei einer reinen Bedarfsdosierung wird `timing` nicht befüllt.

Der Mindestabstand zwischen zwei Gaben wird über die Modifier Extension `modifierExtension[MindestabstandZwischenGaben].valueDuration` angegeben.

`maxDosePerPeriod` kann optional verwendet werden, um eine maximale Menge je Zeitraum anzugeben. Dabei muss die Einheit im `numerator` der Einheit von `doseAndRate.doseQuantity` entsprechen.

Lesende Systeme werten `asNeededBoolean`, `extension[asNeededFor]`, `modifierExtension[MindestabstandZwischenGaben]` und `maxDosePerPeriod` aus. Sie müssen dem Nutzer insbesondere Einnahmeanlass, Mindestabstand und Maximalgabe verständlich darstellen.
