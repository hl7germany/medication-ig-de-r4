# Infrastruktur zur Bereitstellung des Textes der Dosierung

WIP!!

Idee: E-Rezept-Fachdienst und ePA Aktensysteme implementieren den Algorithmus zur Generierung von Text aus strukturierten Dosierinformationen.
Annahme ist, dass PS (PVS und AVS) dieses Textfeld nicht brauchen, da sie mit Umsetzung von eMP die strukturierten Daten lesen können müssen.

Implementierung wird für die eML und FdVs getätigt. Ablauf wäre für ein E-Rezept wie folgt:
1. PVS erzeugt Verordnung mit strukturierter Dosierung
2. E-Rezept-Fachdienst erzeugt (wie bisher auch) eine JSON Kopie für den Abruf des E-Rezept-Fachdienst 
   1. Der Text wird für die strukturierten Daten generiert und unter Dosage.text jeweils gesetzt
   2. E-Rezept-FdV kann entweder die strukturierten Daten anzeigen, oder den Text
3. Der E-Rezept-Fachdienst sendet die Verordnungsdaten an das ePA AS
4. Die Aktensysteme generieren den Text und setzen es in die Objekte für die eML