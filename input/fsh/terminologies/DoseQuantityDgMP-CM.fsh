// Instance: KBV-CS-SFHIR-BMP-DOSIEREINHEIT-to-EDQM-UCUM
// InstanceOf: ConceptMap
// Usage: #definition
// * url = "http://ig.fhir.de/igs/medication/ConceptMap/KBV-CS-SFHIR-BMP-DOSIEREINHEIT-to-EDQM-UCUM"
// * status = #draft
// * targetCanonical = Canonical(DosageDoseQuantityDGMPVS)
// * group[0].source = $kbv-dosiereinheit
// * group[=].target = $edqm
// * group[=].element[0].code = #2
// * group[=].element[=].display = "Pkg."
// * group[=].element[=].target.code = #15016000
// * group[=].element[=].target.display = "Behältnis (Container, Pkg.)"
// * group[=].element[=].target.equivalence = #equivalent
// * group[=].element[+].code = #3
// * group[=].element[=].display = "Flasche"
// * group[=].element[=].target.code = #15009000
// * group[=].element[=].target.display = "Flasche"
// * group[=].element[=].target.equivalence = #equivalent
// * group[=].element[+].code = #4
// * group[=].element[=].display = "Beutel"
// * group[=].element[=].target.code = #15005000
// * group[=].element[=].target.display = "Beutel"
// * group[=].element[=].target.equivalence = #equivalent
// * group[=].element[+].code = #5
// * group[=].element[=].display = "Hub"
// * group[=].element[=].target.code = #15001000
// * group[=].element[=].target.display = "Betätigung (Sprühstoß)"
// * group[=].element[=].target.equivalence = #equivalent
// * group[=].element[+].code = #6
// * group[=].element[=].display = "Tropfen"
// * group[=].element[=].target.code = #15022000
// * group[=].element[=].target.display = "Tropfen"
// * group[=].element[=].target.equivalence = #equivalent
// * group[=].element[+].code = #b
// * group[=].element[=].display = "Applikatorfüllung"
// * group[=].element[=].target.code = #15004000
// * group[=].element[=].target.display = "Applikatorfüllung"
// * group[=].element[=].target.equivalence = #equivalent
// * group[=].element[+].code = #d
// * group[=].element[=].display = "Dosierbriefchen"
// * group[=].element[=].target.code = #15045000
// * group[=].element[=].target.display = "Beutelchen"
// * group[=].element[=].target.equivalence = #equivalent
// * group[=].element[+].code = #e
// * group[=].element[=].display = "Dosierpipette"
// * group[=].element[=].target.code = #15041000
// * group[=].element[=].target.display = "Dosierpipette"
// * group[=].element[=].target.equivalence = #equivalent
// * group[=].element[+].code = #f
// * group[=].element[=].display = "Dosierspritze"
// * group[=].element[=].target.code = #15052000
// * group[=].element[=].target.display = "Dosierspritze"
// * group[=].element[=].target.equivalence = #equivalent
// * group[=].element[+].code = #h
// * group[=].element[=].display = "Glas"
// * group[=].element[=].target.code = #15017000
// * group[=].element[=].target.display = "Cup"
// * group[=].element[=].target.equivalence = #equivalent
// * group[+].source = $kbv-dosiereinheit
// * group[=].target = $ucum
// * group[=].element[0].code = #1
// * group[=].element[=].display = "Stück"
// * group[=].element[=].target.code = #1
// * group[=].element[=].target.display = "unit (Stück)"
// * group[=].element[=].target.equivalence = #equivalent
// * group[=].element[+].code = #l
// * group[=].element[=].display = "Mio E"
// * group[=].element[=].target.code = #10*6
// * group[=].element[=].target.display = "Million Einheiten"
// * group[=].element[=].target.equivalence = #equivalent
// * group[=].element[+].code = #m
// * group[=].element[=].display = "Mio IE"
// * group[=].element[=].target.code = #10*6.[iU]
// * group[=].element[=].target.display = "Million Internationale Einheiten"
// * group[=].element[=].target.equivalence = #equivalent
// * group[=].element[+].code = #p
// * group[=].element[=].display = "IE"
// * group[=].element[=].target.code = #[iU]
// * group[=].element[=].target.display = "Internationale Einheit"
// * group[=].element[=].target.equivalence = #equivalent
// * group[=].element[+].code = #q
// * group[=].element[=].display = "cm"
// * group[=].element[=].target.code = #cm
// * group[=].element[=].target.display = "Zentimeter"
// * group[=].element[=].target.equivalence = #equivalent
// * group[=].element[+].code = #r
// * group[=].element[=].display = "l"
// * group[=].element[=].target.code = #L
// * group[=].element[=].target.display = "Liter"
// * group[=].element[=].target.equivalence = #equivalent
// * group[=].element[+].code = #s
// * group[=].element[=].display = "ml"
// * group[=].element[=].target.code = #mL
// * group[=].element[=].target.display = "Milliliter"
// * group[=].element[=].target.equivalence = #equivalent
// * group[=].element[+].code = #t
// * group[=].element[=].display = "g"
// * group[=].element[=].target.code = #g
// * group[=].element[=].target.display = "Gramm"
// * group[=].element[=].target.equivalence = #equivalent
// * group[=].element[+].code = #u
// * group[=].element[=].display = "kg"
// * group[=].element[=].target.code = #kg
// * group[=].element[=].target.display = "Kilogramm"
// * group[=].element[=].target.equivalence = #equivalent
// * group[=].element[+].code = #v
// * group[=].element[=].display = "mg"
// * group[=].element[=].target.code = #mg
// * group[=].element[=].target.display = "Milligramm"
// * group[=].element[=].target.equivalence = #equivalent