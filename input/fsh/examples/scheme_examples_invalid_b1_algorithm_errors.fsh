// B1 — Negativbeispiele: defensive Fehlerbehandlung des Dosierungstext-Algorithmus
// CAVE: Diese Ressourcen sind NICHT vollständig profilkonform.
// Sie zeigen absichtliche Profilverstöße, um das Fehlerverhalten des Algorithmus
// (ValueError-Abbrüche) zu dokumentieren. Sie erscheinen NICHT in der Zusammenfassung
// der unterstützten Dosierkonfigurationen.

// B1.1 — tim-10-Verletzung: timeOfDay und when gleichzeitig in einem Dosage-Element
// Erwarteter Algorithmusfehler: "timeOfDay und when dürfen nicht gemeinsam angegeben werden (tim-10)."
Instance: Invalid-Dosage-AlgorithmError-Tim10-B1
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid: timeOfDay und when gleichzeitig (tim-10)"
Description: "CAVE: Invalides Beispiel für Algorithmus-Fehlerbehandlung. Setzt sowohl timing.repeat.timeOfDay als auch timing.repeat.when in einem einzigen Dosage-Element – Verstoß gegen FHIR-Invariante tim-10. Erwarteter Algorithmusfehler: 'timeOfDay und when dürfen nicht gemeinsam angegeben werden (tim-10).'"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Testmedikament"
* dosageInstruction[+]
  * timing.repeat
    * timeOfDay[+] = "08:00:00"
    * when[+] = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

// B1.2 — Doppelte 4-Schema-Belegung: zwei Dosage-Elemente beide mit when=MORN
// Erwarteter Algorithmusfehler: "Doppelte Belegung des Tagesabschnitts 'MORN' im 4-Schema."
Instance: Invalid-Dosage-AlgorithmError-Duplicate4SchemaMORN-B1
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid: Doppelte 4-Schema-Belegung (MORN)"
Description: "CAVE: Invalides Beispiel für Algorithmus-Fehlerbehandlung. Zwei Dosage-Elemente belegen beide den Tagesabschnitt MORN mit unterschiedlicher Dosis. Erwarteter Algorithmusfehler: 'Doppelte Belegung des Tagesabschnitts 'MORN' im 4-Schema.'"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Testmedikament"
* dosageInstruction[+]
  * timing.repeat
    * when[+] = #MORN
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
* dosageInstruction[+]
  * timing.repeat
    * when[+] = #MORN
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"

// B1.3 — boundsPeriod + boundsDuration gleichzeitig
// Erwarteter Algorithmusfehler: "boundsPeriod und boundsDuration dürfen nicht gleichzeitig vorhanden sein."
Instance: Invalid-Dosage-AlgorithmError-BoundsBoth-B1
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid: boundsPeriod und boundsDuration gleichzeitig"
Description: "CAVE: Invalides Beispiel für Algorithmus-Fehlerbehandlung. Ein Dosage-Element setzt sowohl timing.repeat.boundsDuration als auch timing.repeat.boundsPeriod – Verstoß gegen TimingOnlyOneBounds. Erwarteter Algorithmusfehler: 'boundsPeriod und boundsDuration dürfen nicht gleichzeitig vorhanden sein.'"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Testmedikament"
* dosageInstruction[+]
  * timing.repeat
    * when[+] = #MORN
    * boundsDuration = 7 $ucum#d "Tag(e)"
    * boundsPeriod.start = "2026-01-01"
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

// B1.4 — Fehlende doseQuantity.unit
// Erwarteter Algorithmusfehler: "doseQuantity.unit ist für die Textgenerierung erforderlich."
Instance: Invalid-Dosage-AlgorithmError-MissingDoseUnit-B1
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Invalid: doseQuantity.unit fehlt"
Description: "CAVE: Invalides Beispiel für Algorithmus-Fehlerbehandlung. doseQuantity.value ist gesetzt, aber doseQuantity.unit fehlt. Erwarteter Algorithmusfehler: 'doseQuantity.unit ist für die Textgenerierung erforderlich.'"
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Testmedikament"
* dosageInstruction[+]
  * timing.repeat
    * when[+] = #MORN
  * doseAndRate[+].doseQuantity
    * value = 1
    * system = $kbv-dosiereinheit
    * code = #1
