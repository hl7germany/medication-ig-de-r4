# Verwendung der Dosierungen in Profilen

Die Verwendung der in diesem IG benannten Dosage-Profile kann in diversen Ressourcen verwendet werden. Folgende Ressourcen haben eine Verwendung von Dosage:

* MedicationRequest
* MedicationDispense
* ...?

## TargetProfiles listen

Folgende Profile werden genutzt, um Dosierungen darzustellen:

und hier der Test mit capture:


## Constraint setzen
Um sicherzustellen, dass nur ein Dosierschema je Sequenz genutzt wird MUSS folgender Constraint auf dem Element angewendet werden, welches die Dosierung als TargetProfile nutzt:

`dosageInstruction.extension.where(url = 'http://de.gematik.dosage/StructureDefinition/dosage-category-ex').value.code.distinct().count() = 1`

## Sequenzen benutzen
Wenn Sequenzen benutzt werden MUSS auch jeweils eine Dauer gesetzt werden (`.timing.repeat.boundsDuration`).


