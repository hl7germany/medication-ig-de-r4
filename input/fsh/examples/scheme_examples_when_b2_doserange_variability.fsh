// B2 — 4-Schema: Variabilität durch doseRange (Umschalten auf Segmentform)
// Enthält eine Position einen variablen Wert (Bereich), wird das kompakte 4-Schema
// in die ausgeschriebene Segmentform überführt.
// Erwarteter generierter Text: "morgens — je 1 bis 2 Stück, abends — je 2 Stück"
Instance: Example-MR-Dosage-when-b2-doserange-mixed
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Dosage-when-b2-doserange-mixed"
Description: "4-Schema mit Variabilität: morgens doseRange (1–2 Stück), abends doseQuantity (2 Stück). Da eine Position einen variablen Wert enthält, wird die ausgeschriebene Segmentform erzeugt."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * when[+] = #MORN
  * doseAndRate[+].doseRange
    * low.value = 1
    * low.system = $kbv-dosiereinheit
    * low.code = #1
    * low.unit = "Stück"
    * high.value = 2
    * high.system = $kbv-dosiereinheit
    * high.code = #1
    * high.unit = "Stück"
* dosageInstruction[+]
  * timing.repeat
    * when[+] = #EVE
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"
