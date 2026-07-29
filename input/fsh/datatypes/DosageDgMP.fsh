Profile: DosageDgMP
Parent: DosageDE
Id: DosageDgMP
Title: "Dosage dgMP"
Description: "Gibt an, wie das Medikament vom Patienten im Kontext dgMP eingenommen wird/wurde oder eingenommen werden soll."
* obeys DosageStructuredOrFreeText
* obeys DosageStructuredRequiresBoth
* obeys DosageStructuredRequiresGeneratedText
* obeys FreeTextSingleDosageOnly
* obeys FreeTextMatchesRenderedText
* obeys DosageDoseQuantityAllowedFractions
* obeys DosageDoseUnitSameCode
* obeys DosageDoseValueDecimalNotation
* obeys DosageViererschemaInText
* obeys PatientInstructionIdentical
* obeys MaxDoseSameUnitAsDose
* obeys MaxDosePerPeriodOnly24hOr1d
* obeys MaxDoseOnlyWhenAsNeeded
* obeys DoseRangeHighRequiredWhenLowPresent
* obeys DoseRangeLowAndHighSameUnit
* obeys DoseRangeNoVarPeriod
* obeys VarFreqNoMaxDose
* obeys VarPeriodNoMindestabstand
* obeys AsNeededForRequiresAsNeeded
* obeys AsNeededSingleDosageOnly
* obeys AsNeededIdentical
* obeys AsNeededForIdentical
* obeys MindestabstandIdentical
* obeys MindestabstandUnitMatchesCode
* obeys MaxDosePerPeriodIdentical
* timing only TimingDgMP
* doseAndRate 0..1 // Nur eine Dosierung für eine Medikation erlauben
  * ^comment = "Begründung Einschränkung Kardinalität: Nur eine Dosierung pro Medikation ist in der ersten Ausbaustufe des dgMP vorgesehen, um die Komplexität zu reduzieren und die Übersichtlichkeit zu erhöhen."
  * type 0..0
    * ^comment = "Begründung Einschränkung Kardinalität: Eine 'type'-Angabe ist in der ersten Ausbaustufe des dgMP nicht vorgesehen, um die Komplexität zu reduzieren und die Übersichtlichkeit zu erhöhen."
  * dose[x] MS
  * doseQuantity
  * doseQuantity from $kbv-dosiereinheit-vs
    * value 1..1 MS
    * system 1..1 MS
    * code 1..1 MS
    * unit 1..1 MS
  * doseRange
    * low MS
    * low from $kbv-dosiereinheit-vs
      * value 1..1 MS
      * system 1..1 MS
      * code 1..1 MS
      * unit 1..1 MS
    * high MS
    * high from $kbv-dosiereinheit-vs
      * value 1..1 MS
      * system 1..1 MS
      * code 1..1 MS
      * unit 1..1 MS
  * rate[x] 0..0
    * ^comment = "Begründung Einschränkung Kardinalität: Eine Verabreichungsmenge pro Zeiteinheit ist in der ersten Ausbaustufe des dgMP nicht vorgesehen, um die Komplexität zu reduzieren und die Übersichtlichkeit zu erhöhen."

// Remove unused Fields
* sequence 0..0
  * ^comment = "Begründung Einschränkung Kardinalität: Eine Dosier-Sequenz ist in der ersten Ausbaustufe des dgMP nicht vorgesehen, um die Komplexität zu reduzieren und die Übersichtlichkeit zu erhöhen."
* additionalInstruction 0..0
* patientInstruction 0..1 MS
  * ^short = "Ergänzende Anwendungshinweise für Patientinnen und Patienten"
  * ^definition = "Ergänzende, nicht strukturiert abbildbare Anwendungshinweise für die sichere, korrekte oder verständliche Anwendung des Arzneimittels."
  * ^comment = "Wenn mehrere Dosage-Elemente in einer Ressource vorhanden sind, muss patientInstruction in allen Dosierungen identisch befüllt werden."
* asNeeded[x]
  * ^comment = "Bedarfsdosierung, Bedingung kann mit der Extension asNeededFor näher spezifiziert werden."
* extension[asNeededFor]
  * valueCodeableConcept
    * coding 0..0
      * ^comment = "Begründung Einschränkung Kardinalität: Eine Codierung der Indikation für die Bedarfsdosierung ist in der aktuellen Ausbaustufe des dgMP nicht vorgesehen, um die Komplexität zu reduzieren und die Übersichtlichkeit zu erhöhen."
    * text 1.. MS
      * ^comment = "Indikation für die Bedarfsdosierung."
* modifierExtension[mindestabstandZwischenGaben]
  * valueDuration 1..1 MS
    * value 1..1 MS
    * system 1..1 MS
    * system = $ucum (exactly)
    * code 1..1 MS
    * code from MindestabstandUnitsOfTimeDgMPVS (required)
    * unit 1..1 MS
    * comparator 0..0
      * ^comment = "Begründung Einschränkung Kardinalität: Ein Komparator würde den Mindestabstand unbestimmt machen (z. B. '> 4 Stunden'); die Textgenerierung stellt ausschließlich den exakten Wert dar."
* site 0..0
  * ^comment = "Begründung Einschränkung Kardinalität: Eine Verabreichungsstelle ist in der aktuellen Ausbaustufe des dgMP nicht vorgesehen, um die Komplexität zu reduzieren und die Übersichtlichkeit zu erhöhen."
* route 0..0
  * ^comment = "Begründung Einschränkung Kardinalität: Ein Verabreichungsweg ist in der aktuellen Ausbaustufe des dgMP nicht vorgesehen, um die Komplexität zu reduzieren und die Übersichtlichkeit zu erhöhen."
* method 0..0
  * ^comment = "Begründung Einschränkung Kardinalität: Eine Verabreichungsmethode ist in der aktuellen Ausbaustufe des dgMP nicht vorgesehen, um die Komplexität zu reduzieren und die Übersichtlichkeit zu erhöhen."
* maxDosePerPeriod
* maxDosePerAdministration 0..0
  * ^comment = "Begründung Einschränkung Kardinalität: Eine maximale Dosis pro Verabreichung ist in der aktuellen Ausbaustufe des dgMP nicht vorgesehen, um die Komplexität zu reduzieren und die Übersichtlichkeit zu erhöhen."
* maxDosePerLifetime 0..0
  * ^comment = "Begründung Einschränkung Kardinalität: Eine maximale Dosis über die Lebenszeit ist in der aktuellen Ausbaustufe des dgMP nicht vorgesehen, um die Komplexität zu reduzieren und die Übersichtlichkeit zu erhöhen."

Invariant: DosageStructuredOrFreeText
Description: "Die Dosierungsangabe darf entweder nur als Freitext oder nur als vollständige strukturierte Information erfolgen — eine Mischung ist nicht erlaubt."
Expression: "(%resource.ofType(MedicationRequest).dosageInstruction | 
 %resource.ofType(MedicationDispense).dosageInstruction | 
 %resource.ofType(MedicationStatement).dosage).all(
  (text.exists() and timing.empty() and doseAndRate.empty()) or
  (text.empty() and (timing.exists() or doseAndRate.exists()))
)"
Severity: #error

Invariant: DosageStructuredRequiresBoth
Description: "Wenn eine strukturierte Dosierungsangabe erfolgt, müssen sowohl timing als auch doseAndRate angegeben werden. Für reine Bedarfsdosierungen darf doseAndRate auch ohne timing angegeben werden."
Expression: "(%resource.ofType(MedicationRequest).dosageInstruction |
 %resource.ofType(MedicationDispense).dosageInstruction |
 %resource.ofType(MedicationStatement).dosage).all(
  (timing.exists() implies doseAndRate.exists()) and
  (doseAndRate.exists() implies (
    timing.exists() or
    asNeeded.ofType(boolean) = true or
    extension.where(url='http://hl7.org/fhir/5.0/StructureDefinition/extension-Dosage.asNeededFor').exists()
  ))
)"
Severity: #error

Invariant: DosageStructuredRequiresGeneratedText
Description: "Liegt eine strukturierte Dosierungsangabe vor (doseAndRate belegt, text leer, dazu timing oder eine reine Bedarfsdosierung), muss die Extension GeneratedDosageInstructionsMeta vorhanden sein."
Expression: "(
  (%resource.ofType(MedicationRequest).dosageInstruction |
   %resource.ofType(MedicationDispense).dosageInstruction |
   %resource.ofType(MedicationStatement).dosage
  ).exists(
    text.empty() and doseAndRate.exists() and
    (timing.exists() or asNeeded.ofType(boolean) = true)
  )
)
implies
(
%resource.extension.where(
  url = 'http://ig.fhir.de/igs/medication/StructureDefinition/GeneratedDosageInstructionsMeta'
).exists() and
(
  %resource.extension.where(
    url = 'http://hl7.org/fhir/5.0/StructureDefinition/extension-MedicationRequest.renderedDosageInstruction'
  ).exists() or
  %resource.extension.where(
    url = 'http://hl7.org/fhir/5.0/StructureDefinition/extension-MedicationDispense.renderedDosageInstruction'
  ).exists() or
  %resource.extension.where(
    url = 'http://hl7.org/fhir/5.0/StructureDefinition/extension-MedicationStatement.renderedDosageInstruction'
  ).exists()
)
)"
Severity: #error

Invariant: DosageViererschemaInText
Description: "Ein reines Viererschema (z. B. 1-0-1-0 oder 1-0-1-0 Stück) darf nicht als Freitext in Dosage.text angegeben werden, sondern ist strukturiert abzubilden."
Expression: "text.exists() implies text.matches('^\\\\s*\\\\d+([.,]\\\\d+)?(\\\\s*/\\\\s*\\\\d+)?(\\\\s*[-–]\\\\s*\\\\d+([.,]\\\\d+)?(\\\\s*/\\\\s*\\\\d+)?){3}(\\\\s*[A-Za-zÄÖÜäöüß().]+)?\\\\s*$').not()"
Severity: #error

Invariant: FreeTextSingleDosageOnly
Description: "Wenn eine Dosierung als reiner Freitext angegeben ist, darf nur genau ein Dosage-Element existieren."
Expression: "(
  (%resource.ofType(MedicationRequest).dosageInstruction |
   %resource.ofType(MedicationDispense).dosageInstruction |
   %resource.ofType(MedicationStatement).dosage
  ).exists(text.exists() and timing.empty() and doseAndRate.empty())
)
implies
(
  (%resource.ofType(MedicationRequest).dosageInstruction |
   %resource.ofType(MedicationDispense).dosageInstruction |
   %resource.ofType(MedicationStatement).dosage
  ).count() = 1
)"
Severity: #error

Invariant: FreeTextMatchesRenderedText
Description: "Wenn eine Dosierung als reiner Freitext angegeben ist (text vorhanden, timing und doseAndRate leer) UND die Extension renderedDosageInstruction befüllt ist, muss der Wert in dosageInstruction.text mit dem Wert in der Extension übereinstimmen."
Expression: "(
  (%resource.ofType(MedicationRequest).dosageInstruction |
   %resource.ofType(MedicationDispense).dosageInstruction |
   %resource.ofType(MedicationStatement).dosage
  ).where(text.exists() and timing.empty() and doseAndRate.empty()).exists()
)
implies
(
  (
    %resource.ofType(MedicationRequest).exists() and
    (
      %resource.extension.where(
        url = 'http://hl7.org/fhir/5.0/StructureDefinition/extension-MedicationRequest.renderedDosageInstruction'
      ).empty() or
      %resource.extension.where(
        url = 'http://hl7.org/fhir/5.0/StructureDefinition/extension-MedicationRequest.renderedDosageInstruction'
      ).value = %resource.dosageInstruction.text
    )
  ) or
  (
    %resource.ofType(MedicationDispense).exists() and
    (
      %resource.extension.where(
        url = 'http://hl7.org/fhir/5.0/StructureDefinition/extension-MedicationDispense.renderedDosageInstruction'
      ).empty() or
      %resource.extension.where(
        url = 'http://hl7.org/fhir/5.0/StructureDefinition/extension-MedicationDispense.renderedDosageInstruction'
      ).value = %resource.dosageInstruction.text
    )
  ) or
  (
    %resource.ofType(MedicationStatement).exists() and
    (
      %resource.extension.where(
        url = 'http://hl7.org/fhir/5.0/StructureDefinition/extension-MedicationStatement.renderedDosageInstruction'
      ).empty() or
      %resource.extension.where(
        url = 'http://hl7.org/fhir/5.0/StructureDefinition/extension-MedicationStatement.renderedDosageInstruction'
      ).value = %resource.dosage.text
    )
  )
)"
Severity: #error

Invariant: DosageDoseQuantityAllowedFractions
Description: "Dosiswerte in doseQuantity oder doseRange dürfen nur ganzzahlig sein oder einen der folgenden Dezimalanteile verwenden: .25, .33, .5, .66 oder .75."
Expression: """
doseAndRate.all(
  (
    dose.ofType(Quantity).value.empty() or
    dose.ofType(Quantity).value.all(
      ($this mod 1 = 0) or
      ($this mod 1 = 0.25) or
      ($this mod 1 = 0.33) or
      ($this mod 1 = 0.5) or
      ($this mod 1 = 0.66) or
      ($this mod 1 = 0.75)
    )
  )
  and
  (
    dose.ofType(Range).low.value.empty() or
    dose.ofType(Range).low.value.all(
      ($this mod 1 = 0) or
      ($this mod 1 = 0.25) or
      ($this mod 1 = 0.33) or
      ($this mod 1 = 0.5) or
      ($this mod 1 = 0.66) or
      ($this mod 1 = 0.75)
    )
  )
  and
  (
    dose.ofType(Range).high.value.empty() or
    dose.ofType(Range).high.value.all(
      ($this mod 1 = 0) or
      ($this mod 1 = 0.25) or
      ($this mod 1 = 0.33) or
      ($this mod 1 = 0.5) or
      ($this mod 1 = 0.66) or
      ($this mod 1 = 0.75)
    )
  )
)
"""

Severity: #error

Invariant: DosageDoseUnitSameCode
Description: "Die Dosiereinheit muss über alle Dosierungen gleich sein."
Expression: "(%resource.ofType(MedicationRequest).dosageInstruction | %resource.ofType(MedicationDispense).dosageInstruction | %resource.ofType(MedicationStatement).dosage).all(
doseAndRate.exists() implies
  (
    (%resource.ofType(MedicationRequest).dosageInstruction | %resource.ofType(MedicationDispense).dosageInstruction | %resource.ofType(MedicationStatement).dosage).doseAndRate.dose.ofType(Quantity).code |
    (%resource.ofType(MedicationRequest).dosageInstruction | %resource.ofType(MedicationDispense).dosageInstruction | %resource.ofType(MedicationStatement).dosage).doseAndRate.dose.ofType(Range).low.code |
    (%resource.ofType(MedicationRequest).dosageInstruction | %resource.ofType(MedicationDispense).dosageInstruction | %resource.ofType(MedicationStatement).dosage).doseAndRate.dose.ofType(Range).high.code
  ).distinct().count() = 1
)"
Severity: #error

Invariant: DosageDoseValueDecimalNotation
Description: "Dosiswerte in doseQuantity oder doseRange müssen in einfacher Dezimalschreibweise mit maximal zwei Nachkommastellen angegeben werden. Die Exponentialschreibweise (z. B. 50e-2 statt 0.5) ist nicht zulässig."
Expression: """
doseAndRate.all(
  (
    dose.ofType(Quantity).value.empty() or
    dose.ofType(Quantity).value.toString().matches('^[0-9]+([.][0-9]{1,2})?$')
  )
  and
  (
    dose.ofType(Range).low.value.empty() or
    dose.ofType(Range).low.value.toString().matches('^[0-9]+([.][0-9]{1,2})?$')
  )
  and
  (
    dose.ofType(Range).high.value.empty() or
    dose.ofType(Range).high.value.toString().matches('^[0-9]+([.][0-9]{1,2})?$')
  )
)
"""
Severity: #error

Invariant: PatientInstructionIdentical
Description: "Wenn patientInstruction in einer Ressource mit mehreren Dosierungen verwendet wird, muss das Feld in allen Dosage-Elementen identisch befüllt sein."
Expression: "(
  (
    %resource.ofType(MedicationRequest).dosageInstruction |
    %resource.ofType(MedicationDispense).dosageInstruction |
    %resource.ofType(MedicationStatement).dosage
  ).patientInstruction.distinct().count() <= 1
)
and
(
  (
    (
      %resource.ofType(MedicationRequest).dosageInstruction |
      %resource.ofType(MedicationDispense).dosageInstruction |
      %resource.ofType(MedicationStatement).dosage
    ).patientInstruction.exists()
  )
  implies
  (
    (
      %resource.ofType(MedicationRequest).dosageInstruction |
      %resource.ofType(MedicationDispense).dosageInstruction |
      %resource.ofType(MedicationStatement).dosage
    ).all(patientInstruction.exists())
  )
)"
Severity: #error

Invariant: MaxDoseSameUnitAsDose
Description: "maxDosePerPeriod muss die gleiche Einheit, den gleichen Code und das gleiche System wie doseQuantity verwenden."
Severity: #error
Expression: "
  maxDosePerPeriod.empty() or (
    (
      doseAndRate.dose.ofType(Quantity).exists() and
      doseAndRate.dose.ofType(Quantity).system = maxDosePerPeriod.numerator.system and
      doseAndRate.dose.ofType(Quantity).code = maxDosePerPeriod.numerator.code and
      doseAndRate.dose.ofType(Quantity).unit = maxDosePerPeriod.numerator.unit
    ) or (
      doseAndRate.dose.ofType(Range).exists() and
      (
        doseAndRate.dose.ofType(Range).low.empty() or (
          doseAndRate.dose.ofType(Range).low.system = maxDosePerPeriod.numerator.system and
          doseAndRate.dose.ofType(Range).low.code = maxDosePerPeriod.numerator.code and
          doseAndRate.dose.ofType(Range).low.unit = maxDosePerPeriod.numerator.unit
        )
      ) and (
        doseAndRate.dose.ofType(Range).high.empty() or (
          doseAndRate.dose.ofType(Range).high.system = maxDosePerPeriod.numerator.system and
          doseAndRate.dose.ofType(Range).high.code = maxDosePerPeriod.numerator.code and
          doseAndRate.dose.ofType(Range).high.unit = maxDosePerPeriod.numerator.unit
        )
      )
    )
  )
"

Invariant: MaxDosePerPeriodOnly24hOr1d
Description: "maxDosePerPeriod ist nur mit einem Bezugszeitraum von 24 Stunden (24 h) oder 1 Tag (1 d) zulässig. Andere Perioden (z. B. maximal 3 alle 6 h) sind nicht erlaubt."
Severity: #error
Expression: "maxDosePerPeriod.empty() or (
  (maxDosePerPeriod.denominator.value = 24 and maxDosePerPeriod.denominator.code = 'h') or
  (maxDosePerPeriod.denominator.value = 1 and maxDosePerPeriod.denominator.code = 'd')
)"

Invariant: DoseRangeHighRequiredWhenLowPresent
Description: "Wenn bei doseRange eine Untergrenze angegeben wird, muss auch eine Obergrenze angegeben werden."
Severity: #error
Expression: "doseAndRate.dose.ofType(Range).low.empty() or doseAndRate.dose.ofType(Range).high.exists()"

Invariant: DoseRangeLowAndHighSameUnit
Description: "Unter- und Obergrenze einer variablen Einzeldosis müssen dieselbe Maßeinheit verwenden."
Severity: #error
Expression: "doseAndRate.dose.ofType(Range).low.empty()
or doseAndRate.dose.ofType(Range).high.empty()
or (
  doseAndRate.dose.ofType(Range).low.system = doseAndRate.dose.ofType(Range).high.system
  and doseAndRate.dose.ofType(Range).low.code = doseAndRate.dose.ofType(Range).high.code
  and doseAndRate.dose.ofType(Range).low.unit = doseAndRate.dose.ofType(Range).high.unit
)"

Invariant: DoseRangeNoVarPeriod
Description: "Eine variable Einzeldosis und eine variable Periode sollten nicht gemeinsam verwendet werden."
Severity: #warning
Expression: "doseAndRate.dose.ofType(Range).empty() or timing.repeat.periodMax.empty()"

Invariant: VarFreqNoMaxDose
Description: "Variable Frequenz und maximale Dosis pro Zeitraum dürfen nicht gemeinsam verwendet werden."
Severity: #error
Expression: "timing.repeat.frequencyMax.empty() or maxDosePerPeriod.empty()"

Invariant: VarPeriodNoMindestabstand
Description: "Variable Periode und Mindestabstand zwischen zwei Einzelgaben dürfen nicht gemeinsam verwendet werden."
Severity: #error
Expression: "timing.repeat.periodMax.empty() or modifierExtension.where(url='http://ig.fhir.de/igs/medication/StructureDefinition/MindestabstandZwischenGaben').empty()"

Invariant: AsNeededForRequiresAsNeeded
Description: "Ein Einnahmeanlass (asNeededFor) darf nur bei einer Bedarfsdosierung (asNeededBoolean=true) angegeben werden."
Severity: #error
Expression: "extension.where(url='http://hl7.org/fhir/5.0/StructureDefinition/extension-Dosage.asNeededFor').exists() implies asNeeded.ofType(boolean) = true"

Invariant: AsNeededSingleDosageOnly
Description: "Wenn eine Bedarfsdosierung mit asNeededBoolean = true ohne timing angegeben ist, muss genau ein Dosage-Element in der Ressource existieren."
Expression: "(
  %resource.ofType(MedicationRequest).dosageInstruction |
  %resource.ofType(MedicationDispense).dosageInstruction |
  %resource.ofType(MedicationStatement).dosage
).where(
  asNeeded.ofType(boolean) = true and timing.empty()
).exists()
implies
(
  %resource.ofType(MedicationRequest).dosageInstruction |
  %resource.ofType(MedicationDispense).dosageInstruction |
  %resource.ofType(MedicationStatement).dosage
).count() = 1"
Severity: #error

Invariant: MaxDoseOnlyWhenAsNeeded
Description: "Eine Maximalmenge (maxDosePerPeriod) darf nur bei einer Bedarfsdosierung (asNeededBoolean=true) angegeben werden."
Severity: #error
Expression: "maxDosePerPeriod.empty() or asNeeded.ofType(boolean) = true"

// --- Konsistenz der Rahmen-Angaben über mehrere Dosage-Elemente ---
// Die Textgenerierung liest Bedarfskennzeichen, Einnahmeanlass, Mindestabstand und
// Maximalmenge ausschließlich aus dem ersten Dosage-Element. Ohne die folgenden
// Invarianten könnten abweichende Angaben in weiteren Elementen unbemerkt entfallen.

Invariant: AsNeededIdentical
Description: "Das Bedarfskennzeichen (asNeededBoolean) muss über alle Dosage-Elemente einer Ressource identisch befüllt sein."
Severity: #error
Expression: "(
  (
    %resource.ofType(MedicationRequest).dosageInstruction |
    %resource.ofType(MedicationDispense).dosageInstruction |
    %resource.ofType(MedicationStatement).dosage
  ).asNeeded.ofType(boolean).distinct().count() <= 1
)
and
(
  (
    (
      %resource.ofType(MedicationRequest).dosageInstruction |
      %resource.ofType(MedicationDispense).dosageInstruction |
      %resource.ofType(MedicationStatement).dosage
    ).asNeeded.ofType(boolean).exists()
  )
  implies
  (
    (
      %resource.ofType(MedicationRequest).dosageInstruction |
      %resource.ofType(MedicationDispense).dosageInstruction |
      %resource.ofType(MedicationStatement).dosage
    ).all(asNeeded.ofType(boolean).exists())
  )
)"

Invariant: AsNeededForIdentical
Description: "Der Einnahmeanlass (asNeededFor) muss über alle Dosage-Elemente einer Ressource identisch befüllt sein. Mehrere Anlässe je Element sind zulässig, müssen dann aber in allen Elementen übereinstimmen."
Severity: #error
/* Jedes Dosage-Element muss genauso viele verschiedene Anlässe tragen wie die
   Ressource insgesamt. Zwei Mengen gleicher Mächtigkeit, deren Vereinigung
   dieselbe Mächtigkeit hat, sind identisch — unabhängig von der Reihenfolge. */
Expression: "(
  %resource.ofType(MedicationRequest).dosageInstruction |
  %resource.ofType(MedicationDispense).dosageInstruction |
  %resource.ofType(MedicationStatement).dosage
).all(
  extension.where(
    url='http://hl7.org/fhir/5.0/StructureDefinition/extension-Dosage.asNeededFor'
  ).value.ofType(CodeableConcept).text.distinct().count()
  =
  (
    %resource.ofType(MedicationRequest).dosageInstruction |
    %resource.ofType(MedicationDispense).dosageInstruction |
    %resource.ofType(MedicationStatement).dosage
  ).extension.where(
    url='http://hl7.org/fhir/5.0/StructureDefinition/extension-Dosage.asNeededFor'
  ).value.ofType(CodeableConcept).text.distinct().count()
)"

Invariant: MindestabstandIdentical
Description: "Der Mindestabstand zwischen Gaben muss über alle Dosage-Elemente einer Ressource identisch befüllt sein."
Severity: #error
/* Die distinct()-Prüfungen allein genügen nicht: Ein Element, das value oder code
   nicht mit einem tatsächlichen primitiven Wert belegt, steuert keinen vergleichbaren
   Wert zur Menge bei und könnte unbemerkt bleiben. Deshalb muss jede vorhandene
   Extension genau einen tatsächlichen Wert und einen tatsächlichen Code beitragen.
   hasValue() ist nötig, weil ein FHIR-Primitive auch ohne eigenen Wert existieren
   kann, wenn es lediglich eine Extension trägt. */
Expression: "(
  (
    %resource.ofType(MedicationRequest).dosageInstruction |
    %resource.ofType(MedicationDispense).dosageInstruction |
    %resource.ofType(MedicationStatement).dosage
  ).modifierExtension.where(
    url='http://ig.fhir.de/igs/medication/StructureDefinition/MindestabstandZwischenGaben'
  ).value.ofType(Duration).value.where($this.hasValue()).count()
  =
  (
    %resource.ofType(MedicationRequest).dosageInstruction |
    %resource.ofType(MedicationDispense).dosageInstruction |
    %resource.ofType(MedicationStatement).dosage
  ).modifierExtension.where(
    url='http://ig.fhir.de/igs/medication/StructureDefinition/MindestabstandZwischenGaben'
  ).count()
)
and
(
  (
    %resource.ofType(MedicationRequest).dosageInstruction |
    %resource.ofType(MedicationDispense).dosageInstruction |
    %resource.ofType(MedicationStatement).dosage
  ).modifierExtension.where(
    url='http://ig.fhir.de/igs/medication/StructureDefinition/MindestabstandZwischenGaben'
  ).value.ofType(Duration).code.where($this.hasValue()).count()
  =
  (
    %resource.ofType(MedicationRequest).dosageInstruction |
    %resource.ofType(MedicationDispense).dosageInstruction |
    %resource.ofType(MedicationStatement).dosage
  ).modifierExtension.where(
    url='http://ig.fhir.de/igs/medication/StructureDefinition/MindestabstandZwischenGaben'
  ).count()
)
and
(
  (
    %resource.ofType(MedicationRequest).dosageInstruction |
    %resource.ofType(MedicationDispense).dosageInstruction |
    %resource.ofType(MedicationStatement).dosage
  ).modifierExtension.where(
    url='http://ig.fhir.de/igs/medication/StructureDefinition/MindestabstandZwischenGaben'
  ).value.ofType(Duration).value.distinct().count() <= 1
)
and
(
  (
    %resource.ofType(MedicationRequest).dosageInstruction |
    %resource.ofType(MedicationDispense).dosageInstruction |
    %resource.ofType(MedicationStatement).dosage
  ).modifierExtension.where(
    url='http://ig.fhir.de/igs/medication/StructureDefinition/MindestabstandZwischenGaben'
  ).value.ofType(Duration).code.distinct().count() <= 1
)
and
(
  (
    (
      %resource.ofType(MedicationRequest).dosageInstruction |
      %resource.ofType(MedicationDispense).dosageInstruction |
      %resource.ofType(MedicationStatement).dosage
    ).modifierExtension.where(
      url='http://ig.fhir.de/igs/medication/StructureDefinition/MindestabstandZwischenGaben'
    ).exists()
  )
  implies
  (
    (
      %resource.ofType(MedicationRequest).dosageInstruction |
      %resource.ofType(MedicationDispense).dosageInstruction |
      %resource.ofType(MedicationStatement).dosage
    ).all(
      modifierExtension.where(
        url='http://ig.fhir.de/igs/medication/StructureDefinition/MindestabstandZwischenGaben'
      ).exists()
    )
  )
)"

Invariant: MindestabstandUnitMatchesCode
Description: "Die Anzeigeeinheit des Mindestabstands (valueDuration.unit) muss zum UCUM-Code passen (z. B. 'Stunde(n)' nur mit code='h')."
Severity: #error
Expression: "modifierExtension.where(
  url='http://ig.fhir.de/igs/medication/StructureDefinition/MindestabstandZwischenGaben'
).value.ofType(Duration).all(
  (
    code = 'min'
    implies
    (unit = 'Minute(n)' or unit = 'Minute' or unit = 'Minuten')
  ) and (
    code = 'h'
    implies
    (unit = 'Stunde(n)' or unit = 'Stunde' or unit = 'Stunden')
  )
)"

Invariant: MaxDosePerPeriodIdentical
Description: "Die Maximalmenge (maxDosePerPeriod) gilt für die Gesamtmenge im Bezugszeitraum und muss über alle Dosage-Elemente einer Ressource identisch befüllt sein."
Severity: #error
/* Wie bei MindestabstandIdentical genügen die distinct()-Prüfungen allein nicht:
   Ein Element, das ein Teilfeld gar nicht belegt, steuert nichts zur Menge bei.
   Deshalb muss jede vorhandene Maximalmenge alle vier Teilfelder führen. */
Expression: "(
  (
    %resource.ofType(MedicationRequest).dosageInstruction |
    %resource.ofType(MedicationDispense).dosageInstruction |
    %resource.ofType(MedicationStatement).dosage
  ).maxDosePerPeriod.all(
    numerator.value.hasValue() and numerator.unit.hasValue() and
    denominator.value.hasValue() and denominator.code.hasValue()
  )
)
and
(
  (
    %resource.ofType(MedicationRequest).dosageInstruction |
    %resource.ofType(MedicationDispense).dosageInstruction |
    %resource.ofType(MedicationStatement).dosage
  ).maxDosePerPeriod.numerator.value.distinct().count() <= 1
)
and
(
  (
    %resource.ofType(MedicationRequest).dosageInstruction |
    %resource.ofType(MedicationDispense).dosageInstruction |
    %resource.ofType(MedicationStatement).dosage
  ).maxDosePerPeriod.numerator.unit.distinct().count() <= 1
)
and
(
  (
    %resource.ofType(MedicationRequest).dosageInstruction |
    %resource.ofType(MedicationDispense).dosageInstruction |
    %resource.ofType(MedicationStatement).dosage
  ).maxDosePerPeriod.denominator.value.distinct().count() <= 1
)
and
(
  (
    %resource.ofType(MedicationRequest).dosageInstruction |
    %resource.ofType(MedicationDispense).dosageInstruction |
    %resource.ofType(MedicationStatement).dosage
  ).maxDosePerPeriod.denominator.code.distinct().count() <= 1
)
and
(
  (
    (
      %resource.ofType(MedicationRequest).dosageInstruction |
      %resource.ofType(MedicationDispense).dosageInstruction |
      %resource.ofType(MedicationStatement).dosage
    ).maxDosePerPeriod.exists()
  )
  implies
  (
    (
      %resource.ofType(MedicationRequest).dosageInstruction |
      %resource.ofType(MedicationDispense).dosageInstruction |
      %resource.ofType(MedicationStatement).dosage
    ).all(maxDosePerPeriod.exists())
  )
)"
