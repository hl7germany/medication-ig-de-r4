## Hinweise zur Verwendung

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