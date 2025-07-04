Profile: DosageDE
Parent: Dosage
Id: DosageDE
Title: "Dosage für deutschlandweite Nutzung"
Description: "Gibt an, wie das Medikament vom Patienten eingenommen wird/wurde oder eingenommen werden soll."
* obeys de-dosage-if-sequence-then-boundsDuration // Sequenzen müssen eine Dauer beinhalten

* text 0..1 MS
  * extension contains GeneratedDosageInstructions named generatedDosageInstructions 0..1 MS

* sequence MS

* additionalInstruction MS
  * text MS

* patientInstruction MS

* timing MS
* timing only TimingDE

* doseAndRate MS
  * doseQuantity MS
  * doseQuantity from DosageDoseQuantityDEVS

// Beschreibungen
* id
  * ^short = "Eindeutige ID für die Referenzierung zwischen Elementen"
  * ^definition = "Eindeutige ID für das Element innerhalb einer Ressource (für interne Verweise). Dies kann jeder beliebige Zeichenfolgenwert sein, der keine Leerzeichen enthält."
  * ^comment = "tbd"

* extension
  * ^short = "Zusätzlicher Inhalt, der von Implementierungen definiert wird"
  * ^definition = "Kann verwendet werden, um zusätzliche Informationen darzustellen, die nicht Teil der Basisdefinition des Elements sind. Um die Verwendung von Erweiterungen sicher und handhabbar zu machen, gibt es einen strikten Governance-Prozess für die Definition und Verwendung von Erweiterungen. Obwohl jeder Implementierer eine Erweiterung definieren kann, gibt es Anforderungen, die im Rahmen der Definition der Erweiterung erfüllt werden MÜSSEN."
  * ^comment = "Es darf kein Stigma mit der Verwendung von Erweiterungen durch eine beliebige Anwendung, ein Projekt oder einen Standard verbunden sein - unabhängig von der Institution oder Gerichtsbarkeit, die die Erweiterungen verwendet oder definiert. Die Verwendung von Erweiterungen ermöglicht es der FHIR-Spezifikation, für alle einen einfachen Kern beizubehalten."

* modifierExtension
  * ^short = "Erweiterungen, die nicht ignoriert werden dürfen, selbst wenn sie nicht erkannt werden"
  * ^definition = "Kann verwendet werden, um zusätzliche Informationen darzustellen, die nicht Teil der Basisdefinition des Elements sind und das Verständnis des Elements, in dem sie enthalten sind, und/oder das Verständnis der Nachkommen des enthaltenen Elements modifizieren. In der Regel bieten Modifizierer-Elemente Negationen oder Qualifikationen. Um die Verwendung von Erweiterungen sicher und handhabbar zu machen, gibt es einen strikten Governance-Prozess für die Definition und Verwendung von Erweiterungen. Obwohl jeder Implementierer eine Erweiterung definieren kann, gibt es Anforderungen, die im Rahmen der Definition der Erweiterung erfüllt werden MÜSSEN. Anwendungen, die eine Ressource verarbeiten, müssen auf Modifizierer-Erweiterungen prüfen. Modifizierer-Erweiterungen DÜRFEN NICHT die Bedeutung von Elementen auf Resource oder DomainResource ändern (einschließlich der Bedeutung von modifierExtension selbst)."
  * ^comment = "Es darf kein Stigma mit der Verwendung von Erweiterungen durch eine beliebige Anwendung, ein Projekt oder einen Standard verbunden sein - unabhängig von der Institution oder Gerichtsbarkeit, die die Erweiterungen verwendet oder definiert. Die Verwendung von Erweiterungen ermöglicht es der FHIR-Spezifikation, für alle einen einfachen Kern beizubehalten."

* sequence
  * ^short = "Die Reihenfolge der Dosierungsanweisungen"
  * ^definition = "Gibt die Reihenfolge an, in der die Dosierungsanweisungen angewendet oder interpretiert werden sollen."
  * ^comment = "Wenn die Sequenz nicht angegeben wird, dann gilt für alle angegebenen Dosierungen implizit die Sequenz 0."

* text
  * ^short = "Freitext-Dosierungsanweisungen, z. B. '3x täglich 1 Tablette'"
  * ^definition = "Freitext-Dosierungsanweisungen, z. B. '3x täglich 1 Tablette'. Als Quelle dient hier ausschließlich der Arzt oder Apotheker"
  * ^comment = "Die Freitextdosierung sollte nur angegeben werden, wenn aufgrund der Komplexität keine strukturierte Dosierung möglich ist, um widersprüchliche Anweisungen zu vermeiden."

* additionalInstruction
  * ^short = "Zusätzliche Anweisungen oder Warnhinweise für den Patienten - z. B. „zu den Mahlzeiten“, „kann Schläfrigkeit verursachen“"
  * ^definition = "Zusätzliche Anweisungen für den Patienten zur Einnahme des Medikaments (z. B. „zu den Mahlzeiten“ oder „eine halbe bis eine Stunde vor dem Essen einnehmen“) oder Warnhinweise zum Medikament (z. B. „kann Schläfrigkeit verursachen“ oder „Hautkontakt mit direktem Sonnenlicht oder Sonnenlampen vermeiden“)."
  * ^comment = "Informationen zur Verabreichung oder Zubereitung des Medikaments (z. B. „so schnell wie möglich über den intraperitonealen Port infundieren“ oder „unmittelbar nach Medikament X“) sollten in dosage.text angegeben werden."

* patientInstruction
  * ^short = "Patienten- oder verbraucherorientierte Anweisungen"
  * ^definition = "Anweisungen in Begriffen, die vom Patienten oder Verbraucher verstanden werden."
  * ^comment = "tbd"

* timing
  * ^short = "Wann das Medikament verabreicht werden soll"
  * ^definition = "Wann das Medikament verabreicht werden soll."
  * ^comment = "Dieses Attribut muss nicht immer ausgefüllt sein, während Dosage.text in der Regel ausgefüllt wird. Wenn beide ausgefüllt sind, sollte Dosage.text den Inhalt von Dosage.timing widerspiegeln."

* site
  * ^short = "Körperstelle zur Verabreichung"
  * ^definition = "Körperstelle, an der das Medikament verabreicht werden soll."
  * ^comment = "Wenn der Anwendungsfall Attribute aus der BodySite-Ressource erfordert (z. B. zur Identifizierung und separaten Nachverfolgung), dann verwenden Sie die Standardextension Bodysite. Kann ein Übersichtscode sein oder ein Verweis auf eine sehr präzise Definition der Stelle oder beides."

* route
  * ^short = "Wie das Medikament in den Körper gelangen soll"
  * ^definition = "Wie das Medikament in den Körper gelangen soll."
  * ^comment = "tbd"

* method
  * ^short = "Technik zur Verabreichung des Medikaments"
  * ^definition = "Technik zur Verabreichung des Medikaments."
  * ^comment = "Terminologien präkoordinieren diesen Begriff häufig mit dem Verabreichungsweg und/oder der Darreichungsform."

* doseAndRate
  * ^short = "Menge des verabreichten Medikaments"
  * ^definition = "Die verabreichte Menge des Medikaments."
  * ^comment = "tbd"

* doseAndRate.extension
  * ^short = "Zusätzlicher Inhalt, der von Implementierungen definiert wird"
  * ^definition = "Kann verwendet werden, um zusätzliche Informationen darzustellen, die nicht Teil der Basisdefinition des Elements sind. Um die Verwendung von Erweiterungen sicher und handhabbar zu machen, gibt es einen strikten Governance-Prozess für die Definition und Verwendung von Erweiterungen. Obwohl jeder Implementierer eine Erweiterung definieren kann, gibt es Anforderungen, die im Rahmen der Definition der Erweiterung erfüllt werden MÜSSEN."
  * ^comment = "Es darf kein Stigma mit der Verwendung von Erweiterungen durch eine beliebige Anwendung, ein Projekt oder einen Standard verbunden sein - unabhängig von der Institution oder Gerichtsbarkeit, die die Erweiterungen verwendet oder definiert. Die Verwendung von Erweiterungen ermöglicht es der FHIR-Spezifikation, für alle einen einfachen Kern beizubehalten."

* doseAndRate.type
  * ^short = "Art der angegebenen Dosis oder Rate"
  * ^definition = "Die Art der angegebenen Dosis oder Rate, z. B. verordnet oder berechnet."
  * ^comment = "tbd"

* maxDosePerPeriod
  * ^short = "Obergrenze für das Medikament pro Zeiteinheit"
  * ^definition = "Obergrenze für das Medikament pro Zeiteinheit."
  * ^comment = "Dies ist als Ergänzung zur Dosierung gedacht, wenn es eine Obergrenze gibt. Zum Beispiel „2 Tabletten alle 4 Stunden bis maximal 8/Tag“."

* maxDosePerAdministration
  * ^short = "Obergrenze für das Medikament pro Verabreichung"
  * ^definition = "Obergrenze für das Medikament pro Verabreichung."
  * ^comment = "Dies ist als Ergänzung zur Dosierung gedacht, wenn es eine Obergrenze gibt. Zum Beispiel eine dosisflächenbezogene Dosis mit einer Höchstmenge wie 1,5 mg/m2 (maximal 2 mg) i.v. über 5 - 10 Minuten hätte doseQuantity von 1,5 mg/m2 und maxDosePerAdministration von 2 mg."

* maxDosePerLifetime
  * ^short = "Obergrenze für das Medikament über die Lebenszeit des Patienten"
  * ^definition = "Obergrenze für das Medikament über die Lebenszeit des Patienten."
  * ^comment = "tbd"

* doseAndRate.dose[x]
  * ^short = "Menge des Medikaments pro Dosis"
  * ^definition = "Menge des Medikaments pro Dosis."
  * ^comment = "Beachten Sie, dass dies die Menge des angegebenen Medikaments angibt, nicht die Menge für die einzelnen Wirkstoffe. Jede Wirkstoffmenge kann in der Medication-Ressource kommuniziert werden. Zum Beispiel, wenn man angeben möchte, dass eine Tablette 375 mg enthält und die Dosis eine Tablette beträgt, kann man die Medication-Ressource verwenden, um zu dokumentieren, dass die Tablette aus 375 mg des Wirkstoffs XYZ besteht. Alternativ, wenn die Dosis 375 mg beträgt, muss man möglicherweise nur angeben, dass es sich um eine Tablette handelt. Bei einer Infusion wie Dopamin, bei der 400 mg Dopamin in 500 ml einer Infusionslösung gemischt werden, würde dies alles in der Medication-Ressource kommuniziert werden. Wenn die Verabreichung nicht als sofortig vorgesehen ist (Rate ist vorhanden oder Timing hat eine Dauer), kann dies angegeben werden, um die Gesamtmenge anzugeben, die über den im Zeitplan angegebenen Zeitraum verabreicht werden soll, z. B. 500 ml in der Dosis, wobei Timing verwendet wird, um anzugeben, dass dies über 4 Stunden erfolgen soll."

* doseAndRate.rate[x]
  * ^short = "Menge des Medikaments pro Zeiteinheit"
  * ^definition = "Menge des Medikaments pro Zeiteinheit."
  * ^comment = "Es ist möglich, sowohl eine Rate als auch eine Dosismenge anzugeben, um vollständige Details darüber zu liefern, wie das Medikament verabreicht und bereitgestellt werden soll. Wenn die Rate im Laufe der Zeit geändert werden soll, sollte jede Änderung je nach lokalen Regeln/Vorschriften als neue Version der MedicationRequest mit aktualisierter Rate erfasst werden oder mit einer neuen MedicationAdministration. Es ist möglich, eine Rate über die Zeit anzugeben (z. B. 100 ml/Stunde) entweder mit rateRatio oder rateQuantity. Die rateQuantity-Variante erfordert, dass Systeme die UCUM-Grammatik parsen können, bei der ml/Stunde enthalten ist, anstatt eines spezifischen Verhältnisses, bei dem die Zeit als Nenner angegeben ist. Wenn eine Rate wie 500 ml über 2 Stunden angegeben wird, ist die Verwendung von rateRatio semantisch möglicherweise korrekter als die Angabe mit rateQuantity von 250 mg/Stunde."

* asNeeded[x]
  * ^short = "Nach Bedarf einnehmen (für x)"
  * ^definition = "Gibt an, ob das Medikament nur bei Bedarf innerhalb eines bestimmten Dosierungsplans eingenommen wird (Boolean-Option), oder gibt die Voraussetzung für die Einnahme des Medikaments an (CodeableConcept)."
  * ^comment = "Kann „nach Bedarf“ ohne Grund ausdrücken, indem der Boolean auf True gesetzt wird. In diesem Fall wird das CodeableConcept nicht ausgefüllt. Oder man kann „nach Bedarf“ mit Grund angeben, indem das CodeableConcept ausgefüllt wird. In diesem Fall wird angenommen, dass der Boolean auf True gesetzt ist. Wenn der Boolean auf False gesetzt wird, wird die Dosis nach Plan verabreicht und ist nicht „prn“ oder „nach Bedarf“."



// Invarianten
// TODO
Invariant: de-dosage-if-sequence-then-boundsDuration
Description: "If a sequence is given the duration must be stated"
Expression: "sequence.exists() implies timing.repeat.bounds.exists()"
Severity: #error

