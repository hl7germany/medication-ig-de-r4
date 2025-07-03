ValueSet: De_Dosage_UCUM_UnitsOfTime_DgMP
Id: De-dosage-ucum-units-of-time-dg-mp
Title: "De Dosage UCUM Units Of Time Dg MP"
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