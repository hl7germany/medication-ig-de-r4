Profile: DosageDgMP
Parent: DosageDE
Id: DosageDgMP
Title: "Dosage dgMP"
Description: "Gibt an, wie das Medikament vom Patienten im Kontext dgMP eingenommen wird/wurde oder eingenommen werden soll."
* obeys DosageStructuredOrFreeText
* obeys DosageStructuredRequiresGeneratedText
  
* timing only TimingDgMP
* doseAndRate 0..1 // Nur eine Dosierung für eine Medikation erlauben
  * ^comment = "Begründung Einschränkung Kardinalität: Nur eine Dosierung pro Medikation ist in der ersten Ausbaustufe des dgMP vorgesehen, um die Komplexität zu reduzieren und die Übersichtlichkeit zu erhöhen."
  * type 0..0
    * ^comment = "Begründung Einschränkung Kardinalität: Eine 'type'-Angabe ist in der ersten Ausbaustufe des dgMP nicht vorgesehen, um die Komplexität zu reduzieren und die Übersichtlichkeit zu erhöhen."
  * dose[x] only SimpleQuantity
    * ^comment = "Begründung Einschränkung Datentyp: Nur einfache Mengenangaben sind in der ersten Ausbaustufe des dgMP vorgesehen, um die Komplexität zu reduzieren und die Übersichtlichkeit zu erhöhen."
  * doseQuantity
  * doseQuantity from $kbv-dosiereinheit-vs
    * system 1..1 MS
    * code 1..1 MS
    * unit 1..1 MS
  * rate[x] 0..0
    * ^comment = "Begründung Einschränkung Kardinalität: Eine Verabreichungsmenge pro Zeiteinheit ist in der ersten Ausbaustufe des dgMP nicht vorgesehen, um die Komplexität zu reduzieren und die Übersichtlichkeit zu erhöhen."

// Remove unused Fields
* sequence 0..0
  * ^comment = "Begründung Einschränkung Kardinalität: Eine Dosier-Sequenz ist in der ersten Ausbaustufe des dgMP nicht vorgesehen, um die Komplexität zu reduzieren und die Übersichtlichkeit zu erhöhen."
* additionalInstruction 0..0
* patientInstruction 0..0
* asNeeded[x] 0..0
  * ^comment = "Begründung Einschränkung Kardinalität: Eine Bedarfsdosis ist in der ersten Ausbaustufe des dgMP nicht vorgesehen, um die Komplexität zu reduzieren und die Übersichtlichkeit zu erhöhen."
* site 0..0
  * ^comment = "Begründung Einschränkung Kardinalität: Eine Verabreichungsstelle ist in der ersten Ausbaustufe des dgMP nicht vorgesehen, um die Komplexität zu reduzieren und die Übersichtlichkeit zu erhöhen."
* route 0..0
  * ^comment = "Begründung Einschränkung Kardinalität: Ein Verabreichungsweg ist in der ersten Ausbaustufe des dgMP nicht vorgesehen, um die Komplexität zu reduzieren und die Übersichtlichkeit zu erhöhen."
* method 0..0
  * ^comment = "Begründung Einschränkung Kardinalität: Eine Verabreichungsmethode ist in der ersten Ausbaustufe des dgMP nicht vorgesehen, um die Komplexität zu reduzieren und die Übersichtlichkeit zu erhöhen."
* maxDosePerPeriod 0..0
  * ^comment = "Begründung Einschränkung Kardinalität: Eine maximale Dosis pro Zeitraum ist in der ersten Ausbaustufe des dgMP nicht vorgesehen, um die Komplexität zu reduzieren und die Übersichtlichkeit zu erhöhen."
* maxDosePerAdministration 0..0
  * ^comment = "Begründung Einschränkung Kardinalität: Eine maximale Dosis pro Verabreichung ist in der ersten Ausbaustufe des dgMP nicht vorgesehen, um die Komplexität zu reduzieren und die Übersichtlichkeit zu erhöhen."
* maxDosePerLifetime 0..0
  * ^comment = "Begründung Einschränkung Kardinalität: Eine maximale Dosis über die Lebenszeit ist in der ersten Ausbaustufe des dgMP nicht vorgesehen, um die Komplexität zu reduzieren und die Übersichtlichkeit zu erhöhen."

Invariant: DosageStructuredOrFreeText
Description: "Die Dosierungsangabe darf entweder nur als Freitext oder nur als vollständige strukturierte Information erfolgen — eine Mischung ist nicht erlaubt."
Expression: "(%resource.ofType(MedicationRequest).dosageInstruction | 
 ofType(MedicationDispense).dosageInstruction | 
 ofType(MedicationStatement).dosage).all(
  (text.exists() and timing.empty() and doseAndRate.empty()) or
  (text.empty() and (timing.exists() or doseAndRate.exists()))
)
"
Severity: #error

Invariant: DosageStructuredRequiresGeneratedText
Description: "Liegt eine strukturierte Dosierungsangabe vor (timing und doseAndRate belegt, text leer), muss die Extension GeneratedDosageInstructions vorhanden sein."
Expression: "(%resource.ofType(MedicationRequest).dosageInstruction | 
 ofType(MedicationDispense).dosageInstruction | 
 ofType(MedicationStatement).dosage).all(
  (timing.exists() and doseAndRate.exists() and text.empty()) 
  implies 
  %resource.extension.where(url = 'http://ig.fhir.de/igs/medication/StructureDefinition/GeneratedDosageInstructionsMeta').exists()
)
"
Severity: #error