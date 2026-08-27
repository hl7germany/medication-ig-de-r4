## Hinweise zur Verwendung

### Legacy-Angaben

In früheren Fassungen dieses Guide waren `frequency`, `period` und
`periodUnit` in allen Dosierschemata verpflichtend — auch dort, wo sie nur
wiederholen, was Wochentage, Tagesabschnitte oder Uhrzeiten bereits
ausdrücken. Sie sind heute nur noch dort erforderlich, wo sie tatsächlich
ein Intervall beschreiben.

Damit bestehende Verordnungsdaten gültig bleiben, sind diese Angaben als
**Legacy-Angaben** weiterhin zulässig, sofern sie dem jeweiligen Schema nicht
widersprechen. Sie begründen kein zusätzliches Intervallschema und verändern
den erzeugten Dosierungstext nicht: Eine Verordnung mit und eine ohne diese
Felder erzeugen denselben Text.

Welche Kombination im einzelnen Schema zulässig ist, beschreibt die jeweilige
Seite im Abschnitt „Dosierschemata"; durchgesetzt wird es über die Invarianten
[`TimingOnlyOneType` und `TimingPeriodUnit`](./dosierung-constraints.html).

<div style="border-left:4px solid #f2c200; padding:10px; background:#fff9d6; margin:1em 0;">
  <p>
    <strong>Invariante: tim-9</strong><br>
    Die Invariante <code>tim-9</code> enthält einen 
    <a href="https://jira.hl7.org/browse/FHIR-37729">bekannten Fehler</a>.
    Dieser wurde in einigen Validatoren bereits behoben. 
    Sollte ein Validator ohne den entsprechenden Fix verwendet werden, 
    ist die tim-9-Definition aus FHIR R5 zu verwenden:<br>
    <code>offset.empty() or (when.exists() and when.select($this in ('C' | 'CM' | 'CD' | 'CV')).allFalse())</code><br>
    Siehe auch die entsprechende Beschreibung in 
    <a href="https://hl7.org/fhir/datatypes.html#timing">FHIR R5 (Timing)</a>.
  </p>
</div>
