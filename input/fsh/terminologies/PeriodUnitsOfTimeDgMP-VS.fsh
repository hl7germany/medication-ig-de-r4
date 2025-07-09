ValueSet: PeriodUnitsOfTimeDgMPVS
Id: PeriodUnitsOfTimeDgMP
Title: "Zeiteinheiten für PeriodUnit in Dosierungen im dgMP"
Description: "Dieses ValueSet enthält dgMPV PeriodUnit Zeiteinheiten aus dem UCUM-CodeSystem in deutscher Übersetzung"
* include $ucum#d 
  * ^designation.language = #de-DE
  * ^designation.value = "Tag(e)"
* include $ucum#wk
  * ^designation.language = #de-DE
  * ^designation.value = "Woche(n)"
* include $ucum#mo
  * ^designation.language = #de-DE
  * ^designation.value = "Monat"