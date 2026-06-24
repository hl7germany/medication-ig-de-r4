Dieser Abschnitt beschreibt die ergänzende Verwendung von Dosage.patientInstruction für zusätzliche Anwendungshinweise, für die im dgMP keine strukturierte Abbildung vorgesehen ist. Das Feld ist optional und kann jedes bestehende strukturierte Dosierschema ergänzen.

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

### Verwendung und Konsistenz von patientInstruction

Diese Ergänzung wird daran erkannt, dass `Dosage.patientInstruction` befüllt ist. Das Feld ergänzt ein bestehendes Dosierschema und ersetzt es nicht. Es handelt sich daher nicht um ein eigenständiges Dosierschema, sondern um eine zusätzliche Information innerhalb eines bereits vorhandenen Schemas.

Wenn mehrere `Dosage`-Elemente in einer Ressource vorhanden sind, muss `patientInstruction` in allen Dosierungen identisch befüllt sein.

Im dgMP wird diese Anforderung durch den Constraint `PatientInstructionIdentical` im Profil [DosageDgMP](./StructureDefinition-DosageDgMP.html) geprüft. Die zugrunde liegende FHIRPath-Expression lautet:

```fhirpath
(
  (
    %resource.ofType(MedicationRequest).dosageInstruction |
    %resource.ofType(MedicationDispense).dosageInstruction |
    %resource.ofType(MedicationStatement).dosage
  ).patientInstruction.distinct().count() <= 1
)
and
(
  (
    (
      %resource.ofType(MedicationRequest).dosageInstruction |
      %resource.ofType(MedicationDispense).dosageInstruction |
      %resource.ofType(MedicationStatement).dosage
    ).patientInstruction.exists()
  )
  implies
  (
    (
      %resource.ofType(MedicationRequest).dosageInstruction |
      %resource.ofType(MedicationDispense).dosageInstruction |
      %resource.ofType(MedicationStatement).dosage
    ).all(patientInstruction.exists())
  )
)
```

Lesende Systeme werten `patientInstruction` als ergänzenden Hinweis zur Dosierung aus. Das Feld ist nicht als Ausweichfeld für strukturiert erfassbare Dosierinformationen zu verwenden.
