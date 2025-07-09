// TODO: Infusion A direkt nach Infusion B geben soll laut FHIR Standard in .text. Hier müsste man noch eine Extension "PractitionerInstruction" definieren, 
// um .text nur für FreitextDosierungen zu verwenden und nicht für strukturierte Dosierungen.
Profile: DosageDE
Parent: Dosage
Id: DosageDE
Title: "Dosage für deutschlandweite Nutzung"
Description: "Gibt an, wie das Medikament vom Patienten eingenommen wird/wurde oder eingenommen werden soll."
* extension contains GeneratedDosageInstructions named generatedDosageInstructions 0..1 MS
* text 0..1 MS
  * ^short = "Freitext-Dosierungsanweisungen, z. B. 'Maximal 3x täglich 1 Tablette bei Bedarf'"
  * ^definition = "Freitext-Dosierungsanweisungen, z. B. 'Maximal 3x täglich 1 Tablette bei Bedarf'. Als Quelle dient hier ausschließlich der Arzt oder Apotheker"
  * ^comment = "Die Freitextdosierung sollte nur angegeben werden, wenn aufgrund der Komplexität keine strukturierte Dosierung möglich ist, um widersprüchliche Anweisungen zu vermeiden."
* timing MS
  * ^short = "Wann das Medikament verabreicht werden soll"
  * ^definition = "Wann das Medikament verabreicht werden soll."
  * ^comment = "Um widersprüchliche Anweisungen zu vermeiden, ist entweder Dosage.timing oder Dosage.text zu befüllen. Falls eine strukturierte Dosierung als Text abgebildet werden soll ist dafür die GeneratedDosageInstructions Extension zu verwenden."
* timing only TimingDE
* doseAndRate MS
  * ^short = "Menge des verabreichten Medikaments"
  * ^definition = "Die verabreichte Menge des Medikaments."
  * doseQuantity MS
    * ^short = "Menge des Medikaments pro Dosis"
    * ^definition = "Menge des Medikaments pro Dosis."
    * ^comment = "Beachten Sie, dass dies die Menge des angegebenen Medikaments angibt, nicht die Menge für die einzelnen Wirkstoffe. Jede Wirkstoffmenge kann in der Medication-Ressource kommuniziert werden. Zum Beispiel, wenn man angeben möchte, dass eine Tablette 375 mg enthält und die Dosis eine Tablette beträgt, kann man die Medication-Ressource verwenden, um zu dokumentieren, dass die Tablette aus 375 mg des Wirkstoffs XYZ besteht. Alternativ, wenn die Dosis 375 mg beträgt, muss man möglicherweise nur angeben, dass es sich um eine Tablette handelt. Bei einer Infusion wie Dopamin, bei der 400 mg Dopamin in 500 ml einer Infusionslösung gemischt werden, würde dies alles in der Medication-Ressource kommuniziert werden. Wenn die Verabreichung nicht als sofortig vorgesehen ist (Rate ist vorhanden oder Timing hat eine Dauer), kann dies angegeben werden, um die Gesamtmenge anzugeben, die über den im Zeitplan angegebenen Zeitraum verabreicht werden soll, z. B. 500 ml in der Dosis, wobei Timing verwendet wird, um anzugeben, dass dies über 4 Stunden erfolgen soll."
  * doseQuantity from DosageDoseQuantityDEVS