Die normative Spezifikation des Algorithmus zur Erzeugung menschenlesbarer Dosierungstexte ist in ein eigenständiges Repository ausgelagert:

**➜ [hl7germany/dgMP-DosageTextgenerierung-Skript](https://github.com/hl7germany/dgMP-DosageTextgenerierung-Skript)**

Dort sind Algorithmenbeschreibung, Referenzimplementierung und Versionsverlauf zu finden.

## Algorithmusversion

Die zu verwendende Version des Algorithmus ist **nicht in diesem IG festgelegt**, sondern wird verbindlich über die Releasezyklen des dgMP-Projekts bestimmt. Die jeweils gültige Version ist den Release-Notes zu entnehmen.

Bei der Bereitstellung des Dosierungstextes ist die verwendete Version in der Extension [GeneratedDosageInstructionsMeta](./StructureDefinition-GeneratedDosageInstructionsMeta.html) anzugeben (Feld `algorithmVersion`). Der vollständige Ablauf ist unter [Bereitstellung des Dosierungstextes](./dosierung-text-hinzufuegen.html) beschrieben.
