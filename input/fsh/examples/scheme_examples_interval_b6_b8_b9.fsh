// B6 — Wiederkehrende Intervalle: doseRange nur mit oberer Grenze (high ohne low)
// Erwarteter generierter Text: "täglich: je bis zu 2 Stück"
Instance: Example-MR-Dosage-interval-b6-doserange-highonly
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Dosage-interval-b6-doserange-highonly"
Description: "Wiederkehrende Intervalle mit doseRange nur obere Grenze (kein low): frequency=1, period=1, periodUnit=d, doseRange.high=2 Stück. Zeigt die 'bis zu'-Formulierung."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodUnit = #d
  * doseAndRate[+].doseRange
    * high.value = 2
    * high.system = $kbv-dosiereinheit
    * high.code = #1
    * high.unit = "Stück"

// B8 — Wöchentliches Muster (period=1, periodUnit=wk, frequency=1)
// Erwarteter generierter Text: "wöchentlich: je 1 Stück"
Instance: Example-MR-Dosage-interval-b8-weekly
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Dosage-interval-b8-weekly"
Description: "Wiederkehrende Intervalle: wöchentliches Muster (frequency=1, period=1, periodUnit=wk). Analog zum bestehenden Beispiel 'monatlich: je 1 Stück'."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * frequency = 1
    * period = 1
    * periodUnit = #wk
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"

// B9 — Frequenz = 1 mit Nicht-Tages-Periode. Frequenz und Periode duerfen nicht
// beide groesser als 1 sein (TimingFreqOrPeriodGtOne); "2 x alle 8 Stunden" wird
// als "alle 4 Stunden" ausgedrueckt.
// Erwarteter generierter Text: "alle 4 Stunden: je 1 Stück"
Instance: Example-MR-Dosage-interval-b9-4h
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Dosage-interval-b9-4h"
Description: "Wiederkehrende Intervalle mit einer Periode unter einem Tag."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * frequency = 1
    * period = 4
    * periodUnit = #h
  * doseAndRate.doseQuantity = 1 $kbv-dosiereinheit#1 "Stück"
