Die normative Spezifikation des Algorithmus zur Erzeugung menschenlesbarer Dosierungstexte ist in ein eigenständiges Repository ausgelagert:

**➜ [hl7germany/dgMP-DosageTextgenerierung-Skript](https://github.com/hl7germany/dgMP-DosageTextgenerierung-Skript)**

Dort sind Algorithmenbeschreibung, Referenzimplementierung und Versionsverlauf zu finden.

## Algorithmusversion

Die zu verwendende Version des Algorithmus ist **nicht in diesem IG festgelegt**, sondern wird verbindlich über die Releasezyklen des dgMP-Projekts bestimmt. Die jeweils gültige Version ist den Release-Notes zu entnehmen.

Bei der Bereitstellung des Dosierungstextes ist die verwendete Version in der Extension [GeneratedDosageInstructionsMeta](./StructureDefinition-GeneratedDosageInstructionsMeta.html) anzugeben (Feld `algorithmVersion`). Der vollständige Ablauf ist unter [Bereitstellung des Dosierungstextes](./dosierung-text-hinzufuegen.html) beschrieben.

### In diesem Guide verwendete Version

Die Beispieltexte dieses Guide wurden mit der Algorithmusversion
**[2.0.0-ballot](https://github.com/hl7germany/dgMP-DosageTextgenerierung-Skript/releases/tag/2.0.0-ballot)**
erzeugt. Die Angabe dient allein der Nachvollziehbarkeit — sie legt **nicht** fest,
welche Version zu verwenden ist. Dieselbe Version steht als `algorithmVersion` in
jeder Beispielressource, sodass sich jeder abgebildete Text seiner Herkunft
zuordnen lässt.
