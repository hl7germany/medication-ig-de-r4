Logical: IntervalSchemeLogical
Parent: Base
Id: IntervalSchemeLogical
Title: "Fachliches Informationsmodell für das Schema für wiederkehrende Intervalle"
Description: """
Dieses Modell beschreibt eine Anwendung in regelmäßigen Abständen, ohne festzulegen, zu welchem genauen
Zeitpunkt das Arzneimittel angewendet wird. Es sagt also aus, wie oft in einem bestimmten Zeitraum eine
Dosis angewendet wird: zum Beispiel „dreimal täglich“ oder „einmal alle acht Stunden“.

Die Häufigkeit ergibt sich aus zwei Angaben: der Frequenz (wie oft) und der Periode (je welchem Zeitraum).
"""

* insert Kopf
* insert Hinweis
* insert Dosis
* insert Wiederholung
* dosierungsdetails.wiederholung.haeufigkeit 1..1 Base "Häufigkeit der Anwendung: wie oft je Zeitraum eine Dosis angewendet wird (z.B. „dreimal täglich“)."
  * frequenz[x] 1..1 positiveInt or Range "Wie oft je Periode eine Dosis angewendet wird. Möglich sind ein fester Wert (z.B. „1“), ein Bereich (z.B. „1 bis 2“) oder eine Obergrenze (z.B. „bis zu 2“). Nur ganze Zahlen sind zulässig."
  * periode[x] 1..1 Duration or Range "Zeitraum, auf den sich die Frequenz bezieht. Möglich sind ein fester Wert (z.B. „1 Tag“), ein Bereich (z.B. „1 bis 2 Tage“) oder eine Obergrenze. Mögliche Einheiten: Minute, Stunde, Tag, Woche und Monat. Nur ganze Zahlen sind zulässig."
* insert Bedarf
