Logical: IntervalSchemeLogical
Parent: Base
Id: IntervalSchemeLogical
Title: "Fachliches Informationsmodell für das Schema für wiederkehrende Intervalle"
Description: """
Dieses Schema beschreibt eine Anwendung in regelmäßigen Abständen, ohne eine Aussage darüber zu treffen, zu welchem spezifischen
Zeitpunkt das Arzneimittel anzuwenden ist. Das Intervall setzt sich aus der Frequenz (wie oft) und der Periode (je welchem Zeitraum) zusammen.
"""

* insert Zeitrahmen
* insert Einzelgabe
* einzelgabe.frequenz[x] 1..1 positiveInt or Range "Häufigkeit: wie oft je Periode eine Dosis anzuwenden ist. Die Angabe kann als fester Wert (z.B. \"1\"), Bereich (z.B. \"1-2\") oder Obergrenze (\"bis zu 2\") erfolgen. Nur ganze Zahlen sind zulässig."
* einzelgabe.periode[x] 1..1 Duration or Range "Zeitraum, auf den sich die Häufigkeit bezieht. Die Angabe kann als fester Wert (z.B. \"1 Woche\"), Bereich (z.B. \"1-2 Wochen\") oder Obergrenze (\"bis zu 2 Wochen\") erfolgen. Mögliche Einheiten: Minute, Stunde, Tag, Woche und Monat. Nur ganze Zahlen sind zulässig."
* insert Bedarfsangabe
* insert Hinweise
