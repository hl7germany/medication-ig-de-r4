Instance: Example-Dosage-Freetext
InstanceOf: DE_DOSAGE
Usage: #inline
Title: "Example Dosage Freetext"
* text = "Bitte 1x am Tag nehmen"

Instance: Example-Dosage-DailyFourScheme-1-MORN
InstanceOf: DE_DOSAGE
Usage: #inline
Title: "Example Dosage Daily Four Scheme 1 Morn"
* text = "1 Morgens"
* timing.repeat.when = #MORN
* doseAndRate.doseQuantity.value = 1

Instance: Example-Dosage-DailyFourScheme-1-NIGHT
InstanceOf: DE_DOSAGE
Usage: #inline
Title: "Example Dosage Daily Four Scheme 1 Night"
* text = "1 Nachts"
* timing.repeat.when = #NIGHT
* doseAndRate.doseQuantity.value = 1

Instance: Example-Dosage-DailyFourScheme-05-EVE
InstanceOf: DE_DOSAGE
Usage: #inline
Title: "Example Dosage Daily Four Scheme 0.5 Evening"
* text = "0.5 Abends"
* timing.repeat.when = #EVE
* doseAndRate.doseQuantity.value = 0.5

Instance: Example-Dosage-DailyFourScheme-special-duration-1
InstanceOf: DE_DOSAGE
Usage: #inline
Title: "Example Morning 1 Evening half"
* text = "1 Morgens für 2 Wochen"
* timing.repeat.when = #MORN
* timing.repeat.boundsDuration.value = 2
* timing.repeat.boundsDuration.unit = "Wochen"
* doseAndRate.doseQuantity.value = 1

/*
TODO
Instance: Example-Dosage-DailyFourScheme-special-duration-2
InstanceOf: DE_DOSAGE
Usage: #inline
Title: "Example Morning 1 Evening half"
* timing.repeat.when = #EVE
* timing.repeat.boundsDuration.value = 4
* timing.repeat.boundsDuration.unit = "Wochen"
* doseAndRate.doseQuantity.value = 0.5

Instance: Example-Dosage-dailyDayTime-12
InstanceOf: DE_DOSAGE
Usage: #inline
Title: "Example Dosage Time Of Day"
* timing.repeat.timeOfDay = "12:00:00"
* doseAndRate.doseQuantity.value = 1
* doseAndRate.doseQuantity.unit = "Tablette"

Instance: Example-Dosage-dailyDayTime-20
InstanceOf: DE_DOSAGE
Usage: #inline
Title: "Example Dosage Time Of Day"
* timing.repeat.timeOfDay = "20:00:00"
* doseAndRate.doseQuantity.value = 1
* doseAndRate.doseQuantity.unit = "Tablette"

Instance: Example-Dosage-dailyDayTime-15-seq1
InstanceOf: DE_DOSAGE
Usage: #inline
Title: "Example Dosage Time Of Day"
* sequence = 1
* timing.repeat.timeOfDay = "15:00:00"
* doseAndRate.doseQuantity.value = 1
* doseAndRate.doseQuantity.unit = "Tablette"

Instance: Example-Dosage-interval-daily
InstanceOf: DE_DOSAGE
Usage: #inline
Title: "Example Dosage Daily 1 Tablet"
* timing.repeat.frequency = 3
* timing.repeat.period = 1
* timing.repeat.periodUnit = #d
* doseAndRate.doseQuantity.value = 1
* doseAndRate.doseQuantity.unit = "Tablette"

Instance: Example-Dosage-interval-flex
InstanceOf: DE_DOSAGE
Usage: #inline
Title: "Example Dosage flex interval"
* timing.repeat.frequency = 2
* timing.repeat.period = 3
* timing.repeat.periodUnit = #h
* doseAndRate.doseQuantity.value = 3
* doseAndRate.doseQuantity.unit = "Tröpfchen"

Instance: Example-Dosage-weekDay-mon
InstanceOf: DE_DOSAGE
Usage: #inline
Title: "Example Dosage Wochentagen"
* timing.repeat.dayOfWeek = #mon
* doseAndRate.doseQuantity.value = 1

Instance: Example-Dosage-weekDay-thu
InstanceOf: DE_DOSAGE
Usage: #inline
Title: "Example Dosage Wochentagen"
* timing.repeat.dayOfWeek = #thu
* doseAndRate.doseQuantity.value = 1

Instance: Example-Dosage-weekDay-sat
InstanceOf: DE_DOSAGE
Usage: #inline
Title: "Example Dosage Wochentagen"
* timing.repeat.dayOfWeek = #sat
* doseAndRate.doseQuantity.value = 1

// Examples with Sequence

Instance: Example-Dosage-DailyFourScheme-1-MORN-seq0
InstanceOf: DE_DOSAGE
Usage: #inline
Title: "Example Dosage Daily Four Scheme 1 Morn"
* sequence = 0
* timing.repeat.when = #MORN
* timing.repeat.boundsDuration.value = 2
* timing.repeat.boundsDuration.unit = "Wochen"
* doseAndRate.doseQuantity.value = 1

Instance: Example-Dosage-DailyFourScheme-1-NIGHT-seq0
InstanceOf: DE_DOSAGE
Usage: #inline
Title: "Example Dosage Daily Four Scheme 1 Night"
* sequence = 0
* timing.repeat.when = #NIGHT
* timing.repeat.boundsDuration.value = 2
* timing.repeat.boundsDuration.unit = "Wochen"
* doseAndRate.doseQuantity.value = 1

*/