# Konzepte zur Erstellung von Dosierungen

In Deutschland gibt es diverse möglichkeiten, wie Dosierungen angegeben werden können (siehe [Arten von Dosierungen](./usage.html)).

Diese Seite beschreibt, wie im Rahmen dieses ImplementationGuides vorgegangen wird, um neue Arten der Dosierung in FHIR abzubilden. Weiterhin werden Konzepte vorgestellt, welche Vorgaben getroffen wurden, um bestimmte Aspekte von Dosierungen abzubilden.

## Weiterentwicklung der Arten von Dosierungen

Für die Profilierung wird die FHIR-Ressource [Dosage](http://hl7.org/fhir/R4/dosage.html) verwendet. Es gibt ein abstraktes Profil "DosageDE", welches übergreifende Beschreibungen und Profilierungen enthält, die für alle Dosierungen gelten.

{% capture profiles %}
StructureDefinition/de-dosage
{% endcapture %}

Davon abgeleitet gibt es dann für jede Art der Dosierung ein Profil, was entsprechende Einschränkungen enthält, um die Art der Dosierung abzubilden. Es werden via Kardinalität alle Felder gestrichen, welche für diese Art der Dosierung nicht verwendet werden dürfen.
Dies soll Implementierern helfen jede Art der Dosierung einfacher zu verstehen und zu implementieren.

### Kardinalitäten und Weiterentwicklung

Dieses Projekt wird iterativ weiterentwickelt. Zur Einfachheit werden Felder, die in der aktuellen Ausbaustufe nicht betrachtet werden, via Kardinalität 0..0 gestrichen. Das bedeutet nicht, dass diese Felder in der Zukunft nicht doch relevant werden könnten. Daher sollte die Implementierung beim Lesen der Profile so gestaltet sein, dass zusätzliche Angaben nicht zu einem Fehler führen, sondern eher das, was verarbeitet werden kann verarbeitet wird und der Rest ignoriert. TBD

## Nutzung des Feldes .text

Für eine schnelle Verwendbarkeit der Profile im Feld wurde sich darauf geeinigt, dass ...
ALT: Um ggf. gegensätzliche Beschreibungen zu vermeiden, wurde sich darauf geeinigt, dass...

## Verwendung mehrerer Dosages

Jede Dosage kennzeichnet eine Kombination von Eventrhythmus (z.B. 3x tägl.) und einer Dosierung je auftretendem Event (2 Tabletten oder 400mg)

## Nutzung von Sequenzen

Es ist möglich aufeinander aufbauende Dosierungen zu beschreiben, z.B. für 2 Wochen 3x1 Tablette und für 1 Woche 1x täglich. Um diese Phasen der Dosierung abzugrenzen werden Sequenzen von Dosierungen verwendet.

## Strukturierte Angabe der Einheit

Für Berechnungen der Reichweite ist es nötig, dass die Einheiten z.B. mg und ml strukturiert über ein CodeSystem angegeben werden. Daher gibt es ein eingeschränktes ValueSet (TBD) welches den Auszug aller Einheiten trägt, die in den Arzneimitteldaten der TBD aufgeführt sind. Dieses ValueSet ermöglicht damit die angabe strukturierter Einheiten als Grundlage möglicher Reichweitenberechnungen.

## Verwendung von Kardinalitäten

Dieser IG unterstützt ein Dosage Profil, welches in verschiedenen Anwendungsfällen eingesetzt werden kann. Es wird darauf verzichtet diverse Profile für jeden einzelnen Anwendungsfall zu erstellen. 
Das Streichen von Kardinalitäten drückt aus, dass eine Funktionalität der Dosierung in der aktuellen Stufe nicht genutzt werden darf.