Die normative Spezifikation des Algorithmus zur Erzeugung menschenlesbarer Dosierungstexte ist in ein eigenständiges Repository ausgelagert:

**➜ [hl7germany/dgMP-DosageTextgenerierung-Skript](https://github.com/hl7germany/dgMP-DosageTextgenerierung-Skript)**

Dort sind Algorithmenbeschreibung, Referenzimplementierung und Versionsverlauf zu finden.

### Vorbedingung: validierte Ressource

Die Textgenerierung setzt eine **gegen das Profil validierte Ressource** voraus. Der Algorithmus ist kein Validator und ersetzt keinen: Er prüft weder Wertebereiche (etwa `DosageDoseValuePositive`, `TimingValuesPositive`) noch Kardinalitäten oder Invarianten, die den Text nicht berühren. Er bricht nur ab, wenn der Text nicht bildbar wäre oder eine Angabe der Ressource unterschlagen beziehungsweise mehrdeutig wiedergeben würde.

Daraus folgt für alle Systeme:

- Die Profilvalidierung MUSS **vor** der Textgenerierung erfolgen. Eine nicht validierte Ressource kann je nach fehlendem Feld zu einem unvollständigen Text oder zu einem Laufzeitfehler führen.
- Ein erfolgreich erzeugter Dosierungstext ist **kein Nachweis** der Profilkonformität. Insbesondere erzeugt der Algorithmus auch für Konstellationen einen Text, die das Profil als Fehler oder Warnung führt (zum Beispiel eine Dosis von `0`).

### Algorithmusversion

Die zu verwendende Version des Algorithmus ist **nicht in diesem IG festgelegt**, sondern wird verbindlich über die Releasezyklen des dgMP-Projekts bestimmt. Die jeweils gültige Version ist den Release-Notes zu entnehmen.

Bei der Bereitstellung des Dosierungstextes ist die verwendete Version in der Extension [GeneratedDosageInstructionsMeta](./StructureDefinition-GeneratedDosageInstructionsMeta.html) anzugeben (Feld `algorithmVersion`). Der vollständige Ablauf ist unter [Bereitstellung des Dosierungstextes](./dosierung-text-hinzufuegen.html) beschrieben.

#### In diesem Guide verwendete Version

Die Beispieltexte dieses Guide wurden mit der Algorithmusversion
**[2.0.0-rc.2](https://github.com/hl7germany/dgMP-DosageTextgenerierung-Skript/releases/tag/2.0.0-rc.2)**
erzeugt. Die Angabe dient allein der Nachvollziehbarkeit — sie legt **nicht** fest,
welche Version zu verwenden ist. Dieselbe Version steht als `algorithmVersion` in
jeder Beispielressource, sodass sich jeder abgebildete Text seiner Herkunft
zuordnen lässt.
