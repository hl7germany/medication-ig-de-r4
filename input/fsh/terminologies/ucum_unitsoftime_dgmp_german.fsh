ValueSet: DosageUnitsOfTimeDgMP
Id: DosageUnitsOfTimeDgMP
Title: "DosageUnitsOfTimeDgMP"
Description: "This Valueset extracts unitsoftime from ucum in German"
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