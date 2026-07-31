Logical: WhenSchemeLogical
Parent: Base
Id: WhenSchemeLogical
Title: "Fachliches Informationsmodell für das Schema mit Tageszeiten-Bezug"
Description: """
Dieses Modell beschreibt die tägliche Anwendung eines Arzneimittels, ausgerichtet an den Tageszeiten
„Morgen“, „Mittag“, „Abend“ und „Nacht“. Es sagt also aus, zu welchen groben Tagesabschnitten und in
welcher Menge das Arzneimittel angewendet wird hne eine genaue Uhrzeit festzulegen.

Welcher Zeitraum mit einer Tageszeit konkret gemeint ist, ergibt sich aus dem Tagesablauf der anwendenden
Person oder aus einrichtungsinternen Konventionen.

Es ist das in Deutschland gebräuchlichste Dosierschema. Es wird häufig auch „Viererschema“ oder
„MMAN-Schema“ genannt und üblicherweise als Kette von vier Zahlen dargestellt (z.B. „1-0-2-0“ für
eine Tablette morgens, keine mittags, zwei abends und keine zur Nacht).
"""

* insert Kopf
* insert Hinweis
* insert Dosis
* insert Wiederholung
* dosierungsdetails.wiederholung.tageszeiten 1..* Coding "Tageszeit(en) der Anwendung, ausgedrückt als morgens | mittags | abends | zur Nacht"
* dosierungsdetails.wiederholung.tageszeiten from http://ig.fhir.de/igs/medication/ValueSet/TimingWhenDgMP (required)
* insert Bedarf
