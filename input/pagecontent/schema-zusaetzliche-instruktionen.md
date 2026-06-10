Dieses Schema beschreibt die ergänzende Verwendung von `Dosage.patientInstruction` für zusätzliche, nicht strukturiert abbildbare Anwendungshinweise. Das Feld ist optional und kann jedes bestehende strukturierte Dosierschema ergänzen.

Es ist ausschließlich für Inhalte vorgesehen, die nicht bereits eindeutig in strukturierten Feldern ausgedrückt werden können. Typische Beispiele sind:

- qualitative Zusatzhinweise wie "Tablette nicht zerkauen" oder "vor Gebrauch schütteln"
- situative Hinweise wie "bei Fieber über 39 Grad Arzt kontaktieren" oder "Einnahme aussetzen bei Auftreten von Schwindel"

Nicht über `patientInstruction` abgebildet werden sollen insbesondere:

- Dosis
- Anwendungshäufigkeit oder Anwendungszeitpunkt
- Behandlungsdauer

### Beispiel

{% fragment MedicationRequest/Example-MR-Dosage-1010-PatientInstruction JSON %}

Folgende weitere Beispiele sind in diesem IG dargestellt:

| Beispiel | Beispiel Datei |
| -------- | ------- |
| Strukturierte Dosierung mit identischer zusätzlicher Instruktion in allen Dosierungen | [Example-MR-Dosage-1010-PatientInstruction](./MedicationRequest-Example-MR-Dosage-1010-PatientInstruction.html) |

### Angabe und Erkennung der Dosierart

Diese Ergänzung wird daran erkannt, dass `Dosage.patientInstruction` befüllt ist. Das Feld ergänzt ein bestehendes Dosierschema und ersetzt es nicht.

Wenn mehrere `Dosage`-Elemente in einer Ressource vorhanden sind, muss `patientInstruction` in allen Dosierungen identisch befüllt sein.

Folgende FHIRPath-Expression auf Ebene der übergeordneten Ressource prüft diese Anforderung:

```fhirpath
(
  dosageInstruction.patientInstruction.distinct().count() <= 1
)
and
(
  dosageInstruction.patientInstruction.exists()
  implies dosageInstruction.all(patientInstruction.exists())
)
```

Lesende Systeme werten `patientInstruction` als ergänzenden Hinweis zur Dosierung aus. Das Feld ist nicht als Ausweichfeld für strukturiert erfassbare Dosierinformationen zu verwenden.
