ValueSet: DurationUnitsOfTimeDgMPVS
Id: DosageUnitsOfTimeDgMP
Title: "Zeiteinheiten für die DurationUnit in Dosierungen im dgMP"
Description: "Dieses ValueSet enthält dgMPV DurationUnit Zeiteinheiten aus dem UCUM-CodeSystem in deutscher Übersetzung"
* include $ucum#d 
  * ^designation.language = #de-DE
  * ^designation.value = "Tag(e)"
* include $ucum#wk
  * ^designation.language = #de-DE
  * ^designation.value = "Woche(n)"
* include $ucum#mo
  * ^designation.language = #de-DE
  * ^designation.value = "Monat"
* include $ucum#a
  * ^designation.language = #de-DE
  * ^designation.value = "Jahr(e)"