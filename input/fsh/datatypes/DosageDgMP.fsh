Profile: DosageDgMP
Parent: DosageDE
Id: DosageDgMP
Title: "Dosage dgMP"
Description: "Gibt an, wie das Medikament vom Patienten im Kontext dgMP eingenommen wird/wurde oder eingenommen werden soll."
* obeys DosageStructuredOrFreeText
* obeys DosageStructuredRequiresGeneratedText
* obeys FreeTextSingleDosageOnly
* obeys FreeTextMatchesRenderedText
* obeys PatientInstructionIdentical
* obeys MaxDoseSameUnitAsDose
* obeys DoseRangeHighRequiredWhenLowPresent
* obeys DoseRangeLowAndHighSameUnit
* obeys DoseRangeNoVarPeriod
* obeys VarFreqNoMaxDose
* obeys VarPeriodNoMindestabstand
* obeys AsNeededRequiresAsNeededFor
* timing only TimingDgMP
* doseAndRate 0..1 // Nur eine Dosierung für eine Medikation erlauben
  * ^comment = "Begründung Einschränkung Kardinalität: Nur eine Dosierung pro Medikation ist in der ersten Ausbaustufe des dgMP vorgesehen, um die Komplexität zu reduzieren und die Übersichtlichkeit zu erhöhen."
  * type 0..0
    * ^comment = "Begründung Einschränkung Kardinalität: Eine 'type'-Angabe ist in der ersten Ausbaustufe des dgMP nicht vorgesehen, um die Komplexität zu reduzieren und die Übersichtlichkeit zu erhöhen."
  * dose[x] MS
  * doseQuantity
  * doseQuantity from $kbv-dosiereinheit-vs
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
    * system 1..1 MS
    * code 1..1 MS
    * unit 1..1 MS
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

Invariant: DosageStructuredRequiresGeneratedText
Description: "Liegt eine strukturierte Dosierungsangabe vor (timing und doseAndRate belegt, text leer), muss die Extension GeneratedDosageInstructionsMeta vorhanden sein."
Expression: "(
  (%resource.ofType(MedicationRequest).dosageInstruction |
   %resource.ofType(MedicationDispense).dosageInstruction |
   %resource.ofType(MedicationStatement).dosage
  ).exists(timing.exists() and doseAndRate.exists() and text.empty())
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

Invariant: AsNeededRequiresAsNeededFor
Description: "Bei Bedarfsmedikation müssen asNeededBoolean=true und ein Einnahmeanlass gemeinsam angegeben werden."
Severity: #error
Expression: "(
  extension.where(url='http://hl7.org/fhir/5.0/StructureDefinition/extension-Dosage.asNeededFor').exists() and
  asNeeded.ofType(boolean) = true
) or (
  extension.where(url='http://hl7.org/fhir/5.0/StructureDefinition/extension-Dosage.asNeededFor').empty() and
  (
    asNeeded.ofType(boolean).empty() or
    asNeeded.ofType(boolean) = false
  )
)"
