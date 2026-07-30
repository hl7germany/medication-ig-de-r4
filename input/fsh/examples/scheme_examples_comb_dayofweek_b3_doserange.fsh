// B3 — Kombination Wochentage: Variabilität durch doseRange (Umschalten auf Segmentform)
// Da mindestens ein Tag einen variablen Wert enthält, wird die ausgeschriebene
// Segmentform für ALLE Tage verwendet.
// Erwarteter generierter Text: "montags morgens — je 1 bis 2 Stück; mittwochs abends — je 2 Stück"
Instance: Example-MR-Dosage-comb-dayofweek-b3-doserange-mixed
InstanceOf: MedicationRequestDgMP
Usage: #example
Title: "Example-MR-Dosage-comb-dayofweek-b3-doserange-mixed"
Description: "Wochentags-Kombination mit Variabilität: montags morgens doseRange (1–2 Stück), mittwochs abends doseQuantity (2 Stück). Da ein Tag einen variablen Wert enthält, wird die ausgeschriebene Segmentform für alle Tage verwendet."
* subject.display = "Patient"
* status = #active
* intent = #order
* medicationCodeableConcept.text = "Ibuprofen 400mg"
* dosageInstruction[+]
  * timing.repeat
    * dayOfWeek[+] = #mon
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
    * dayOfWeek[+] = #wed
    * when[+] = #EVE
  * doseAndRate.doseQuantity = 2 $kbv-dosiereinheit#1 "Stück"
