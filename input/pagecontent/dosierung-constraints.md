Auf dieser Seite sind alle Invarianten dieses Implementation Guides aufgeführt, jeweils mit einer kurzen Beschreibung, der Begründung für ihre Existenz und Beispielen, die die Regel verletzen beziehungsweise auslösen.

Die Gliederung folgt den beiden Profilfamilien und innerhalb davon dem Schweregrad. Da die dgMP-Profile von den DE-Profilen erben, gelten die Regeln der DE-Profile in beiden Welten; die dgMP-Profile fügen weitere Regeln hinzu und fassen mehrere Sachverhalte strenger. Wo es zu einer Warnung eine strengere dgMP-Entsprechung gibt, ist sie im jeweiligen Abschnitt verlinkt.

### DE-Profile

Die folgenden Invarianten sind auf den generischen Profilen [DosageDE](./StructureDefinition-DosageDE.html) und [TimingDE](./StructureDefinition-TimingDE.html) definiert. Sie gelten für alle Ressourcen nach diesen Profilen und - über die Vererbung - ebenso für Ressourcen nach den dgMP-Profilen.

#### Warnungen

##### DosageStructuredOrFreeTextWarning

**Beschreibung:**
Warnung in `DosageDE`, wenn eine Dosierungsangabe strukturierte Elemente (`timing`, `doseAndRate`) und Freitext (`text`) mischt.

**Warum?**
Verhindert widersprüchliche oder doppelte Informationsquellen (Freitext vs. Struktur) und erleichtert die automatische Verarbeitung. Implementierungen sollten die strukturierte Variante bevorzugen und Freitext nur verwenden, wenn eine strukturierte Abbildung nicht möglich ist. In den dgMP-Profilen gilt für denselben Sachverhalt der Fehler [DosageStructuredOrFreeText](#dosagestructuredorfreetext).

Folgende Beispiele lösen eine Warnung aus:

{% include dosage-constraint-DosageStructuredOrFreeTextWarning-examples.md%}

##### DosageStructuredRequiresBothWarning

**Beschreibung:**  
Warnung in `DosageDE`, wenn bei einer strukturierten Dosierung nur zeitliche Angaben (`timing`) oder nur die Dosis (`doseAndRate`) vorhanden sind. Für reine Bedarfsdosierungen ist `doseAndRate` ohne `timing` zulässig und löst keine Warnung aus.

**Warum?**  
Eine strukturierte Dosierung sollte Zeit und Menge enthalten, um automatisiert interpretierbar zu sein. Als Warnung – und nicht als Fehler – ist der Constraint modelliert, weil es Fälle mit festen Einnahmezeiten, aber nicht vorab festgelegter Dosis gibt, etwa Insulin nach Plan zu definierten Zeiten. In den dgMP-Profilen gilt für denselben Sachverhalt der Fehler [DosageStructuredRequiresBoth](#dosagestructuredrequiresboth).

Folgende Beispiele lösen eine Warnung aus:

{% include dosage-constraint-DosageStructuredRequiresBothWarning-examples.md%}

##### FreeTextSingleDosageOnlyWarning

**Beschreibung:**  
Wird eine Dosierung als reiner Freitext angegeben, soll nur genau ein `Dosage`‑Element existieren.

**Warum?**  
Warnungs-Variante aus dem generischen Profil `DosageDE` zur error-Regel `FreeTextSingleDosageOnly` im dgMP‑Profil. Sie weist auf mehrere Freitext‑Dosierungen hin, ohne sie strikt zu verbieten.

Beispiele (Warnungskontext – mehrere Freitext‑Dosierungen):

{% include dosage-constraint-FreeTextSingleDosageOnlyWarning-examples.md%}

##### DosageDoseUnitSameCodeWarning

**Beschreibung:**  
Warnung in `DosageDE`, wenn die Dosierungsinstanzen innerhalb derselben Ressource unterschiedliche Dosiereinheiten (Codes) verwenden.

**Warum?**  
Gemischte Einheiten (z. B. Stück und mg) erschweren Vergleich, Summierung und Darstellung. Im generischen Profil bleibt es bei einer Warnung, weil sich fachlich begründete Mischformen nicht generell ausschließen lassen. In den dgMP-Profilen gilt für denselben Sachverhalt der Fehler [DosageDoseUnitSameCode](#dosagedoseunitsamecode).

Folgende Beispiele lösen eine Warnung aus:

{% include dosage-constraint-DosageDoseUnitSameCodeWarning-examples.md%}

##### DosageDoseValuePositiveWarning

**Beschreibung:**
Warnung in `DosageDE`, wenn `doseQuantity.value` oder `doseRange.high.value` nicht größer als `0` ist oder wenn `doseRange.low.value` negativ ist. Der Wert `0` ist ausschließlich als Untergrenze eines Bereichs zulässig.

**Warum?**
Negative Dosiswerte sind fachlich nicht als verabreichbare Arzneimittelmenge interpretierbar, und eine Einzeldosis oder Obergrenze von `0` beschreibt keine Anwendung. Im generischen DE-Profil bleibt die Regel eine Warnung; in den dgMP-Profilen gilt für denselben Sachverhalt der Fehler [DosageDoseValuePositive](#dosagedosevaluepositive). Als Untergrenze eines Bereichs wie „0 bis 2 Tabletten“ bleibt `0` erlaubt.

Folgende Beispiele lösen eine Warnung aus:

{% include dosage-constraint-DosageDoseValuePositiveWarning-examples.md%}

##### DosageWarnungViererschemaInText

**Beschreibung:**  
Warnung, wenn ein klassisches 4-Schema (z. B. Darstellung wie "1-0-1-0") irgendwo im Freitext vorkommt, obwohl eine strukturierte Abbildung möglich wäre.

**Warum?**  
Ermutigt zur strukturierten Modellierung der Einnahmezeiten anstelle rein schematischer Textdarstellungen, verbessert maschinelle Auswertbarkeit und Textgenerierung.

Der Constraint ist auf `DosageDE` als Warnung definiert, weil das 4-Schema in einem längeren Freitext auch als erläuternder Bestandteil auftreten kann. Besteht der Freitext **ausschließlich** aus einem 4-Schema, greift in den dgMP-Profilen zusätzlich der Fehler [DosageViererschemaInText](#dosageviererschemaintext).

Gültige Beispiele (Warnungskontext – Freitext enthält 4-Schema):

{% include dosage-constraint-DosageWarnungViererschemaInText-examples.md%}

##### TimingSingleDosageForTimeOfDayWarning

**Beschreibung:**  
Warnung in `TimingDE`, wenn bei täglicher Dosierung mit ausschließlich `timeOfDay` mehrere `Dosage`‑Elemente mit identischer Dosis verwendet werden.

**Warum?**  
Mehrere gleichartige Elemente sind unnötig aufgesplittert und erschweren die Auswertung. Im generischen Profil bleibt es bei einer Warnung, weil die Aufteilung dort nicht schadet. In den dgMP-Profilen gilt für denselben Sachverhalt der Fehler [TimingSingleDosageForTimeOfDay](#timingsingledosagefortimeofday).

Folgende Beispiele lösen eine Warnung aus:

{% include dosage-constraint-TimingSingleDosageForTimeOfDayWarning-examples.md%}

##### TimingSingleDosageForWhenWarning

**Beschreibung:**  
Warnung in `TimingDE`, wenn bei täglicher Dosierung mit ausschließlich `when` mehrere `Dosage`‑Elemente mit identischer Dosis verwendet werden.

**Warum?**  
Mehrere gleichartige Elemente sind unnötig aufgesplittert und erschweren die Auswertung. Im generischen Profil bleibt es bei einer Warnung, weil die Aufteilung dort nicht schadet. In den dgMP-Profilen gilt für denselben Sachverhalt der Fehler [TimingSingleDosageForWhen](#timingsingledosageforwhen).

Folgende Beispiele lösen eine Warnung aus:

{% include dosage-constraint-TimingSingleDosageForWhenWarning-examples.md%}

##### TimingBoundsUnitMatchesCodeWarning

**Beschreibung:**  
Warnung in `TimingDE`, wenn die Einheit (`boundsDuration.unit`) nicht zum UCUM‑Code (`boundsDuration.code`) passt.

**Warum?**  
Widersprüchliche Angaben wie `code='wk'` mit `unit='Tag(e)'` sind fast immer ein Fehler, die Einheit ist im generischen Profil aber nicht auf die deutschen Bezeichnungen festgelegt. In den dgMP-Profilen gilt für denselben Sachverhalt der Fehler [TimingBoundsUnitMatchesCode](#timingboundsunitmatchescode).

Folgende Beispiele lösen eine Warnung aus:

{% include dosage-constraint-TimingBoundsUnitMatchesCodeWarning-examples.md%}

#### Fehler

##### dos-1

**Beschreibung:**  
Basisregel aus dem generischen Profil `DosageDE`: Ein Anlass (`asNeededFor`) darf nur gesetzt sein, wenn `asNeeded` leer oder `true` ist. Das dgMP‑Profil verschärft dies über `AsNeededForRequiresAsNeeded` auf `asNeeded = true`.

**Warum?**  
Stellt sicher, dass ein Anlass nicht einer Nicht‑Bedarfsdosierung zugeordnet wird.

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-dos-1-examples.md%}

### dgMP-Profile

Zusätzlich zu den Regeln der DE-Profile gelten die folgenden Invarianten auf [DosageDgMP](./StructureDefinition-DosageDgMP.html), [TimingDgMP](./StructureDefinition-TimingDgMP.html) und den abstrakten Ressourcenprofilen des dgMP. Sie setzen durchgängig maschinell auswertbare Dosierungen durch, wie sie die [Textgenerierung](./dosierung-textgenerierung.html) voraussetzt.

#### Warnungen

##### DoseRangeNoVarPeriod

**Beschreibung:**  
Eine variable Einzeldosis (`doseRange`) und eine variable Periode (`periodMax`) sollten nicht gemeinsam verwendet werden.

**Warum?**  
Die Kombination aus variabler Dosis und variabler Periode ist für Implementierungen und Darstellung nur schwer eindeutig zu verarbeiten. Sie bleibt zulässig, löst aber eine Warnung aus.

Beispiele (Warnungskontext – variable Einzeldosis und variable Periode):

{% include dosage-constraint-DoseRangeNoVarPeriod-examples.md%}

##### TimingVarFreqOrPeriod

**Beschreibung:**  
Bei einer reinen Intervallangabe ohne Zeitpunkte sollten nicht gleichzeitig die Frequenz über `frequencyMax` und die Periode über `periodMax` variabel angegeben werden.

**Warum?**  
Die gleichzeitige Variation beider Achsen führt zu einem nur schwer eindeutig interpretierbaren Einnahmeschema — „1 bis 2 x alle 4 bis 6 Stunden“ lässt weder die Zahl der Gaben noch den Abstand eindeutig erkennen. Die Variation nur einer Achse bleibt zulässig, ebenso eine feste Frequenz größer als 1 zusammen mit einer Periode (`2 x alle 8 Stunden`): Dort sind Zahl der Gaben und Bezugszeitraum eindeutig bestimmt.

Bei `when`, `timeOfDay` oder `dayOfWeek` greift die Regel nicht. Dort ist `frequency` optional und redundant, weil die konkreten Zeitpunkte beziehungsweise Anwendungstage die Zahl der Gaben bereits festlegen; die Angabe dient ausschließlich der Rückwärtskompatibilität und begründet kein zusätzliches Intervallschema.

Folgende Beispiele lösen eine Warnung aus:

{% include dosage-constraint-TimingVarFreqOrPeriod-examples.md%}

#### Fehler: Timing-bezogen

Die folgenden Invarianten beziehen sich auf `Timing` — überwiegend auf `Timing.repeat` — und wirken über alle Dosierungsinstanzen einer Ressource.

##### TimingFrequencyCount

**Beschreibung:**  
Wird `frequency` bei konkreten Werten in `when`, `timeOfDay` oder `dayOfWeek` angegeben, muss der Wert deren Anzahl entsprechen. Bei einer Kombination aus Wochentagen und konkreten Zeitpunkten entspricht `frequency` dem Produkt beider Anzahlen.

**Warum?**  
Die optionale Angabe darf der bereits strukturiert ausgedrückten Häufigkeit nicht widersprechen. Bei Wochentagsschemata wird `frequency` nicht als Frequenz eines inneren Intervalls interpretiert.

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-TimingFrequencyCount-examples.md%}

##### TimingPeriodUnit

**Beschreibung:**  
`periodUnit` darf nur zusammen mit `period` angegeben werden. Bei `dayOfWeek` ist als redundante Angabe ausschließlich das Paar `period = 1` und `periodUnit = wk` zulässig. Eine [Kombination aus Zeitintervall und Tageszeiten- beziehungsweise Uhrzeiten-Bezug](./schema-intervall-kombination.html) darf Tage (`d`), Wochen (`wk`) oder Monate (`mo`) verwenden. Reine Intervalle verwenden weiterhin die vollständige gebundene Wertemenge.

**Warum?**  
So bleibt unterscheidbar, ob die Periode nur die bereits implizite wöchentliche Wiederholung eines Wochentagsschemas redundant ausdrückt oder den Einnahmerhythmus ausgewählter Tagesabschnitte beziehungsweise Uhrzeiten beschreibt. Minuten- oder Stundenintervalle werden nicht mit Wochentagen kombiniert.

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-TimingPeriodUnit-examples.md%}

##### TimingPeriodOnlyWholeNumber

**Beschreibung:**  
`period` und `periodMax` dürfen nur ganze Zahlen enthalten; Dezimalwerte sind nicht zulässig.

**Warum?**  
Eine gebrochene Periode (z. B. „alle 1,5 Tage") lässt sich weder eindeutig kommunizieren noch verlässlich in einen Einnahmeplan überführen. Für abweichende Rhythmen ist die nächstkleinere Zeiteinheit zu verwenden.

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-TimingPeriodOnlyWholeNumber-examples.md%}

##### TimingOnlyOneType

**Beschreibung:**  
Es darf pro Ressource nur eines der unterstützten Timing-Schemata verwendet werden: Tagesabschnitt/Uhrzeit, Wochentag, reines Intervall, Wochentag mit Tagesabschnitt/Uhrzeit oder eine [Kombination aus Zeitintervall und Tagesabschnitt/Uhrzeit](./schema-intervall-kombination.html). Redundante `frequency`-, `period`- und `periodUnit`-Angaben bleiben bei Wochentagsschemata sowie in den dafür vorgesehenen zeitbezogenen Schemata optional zulässig; sie machen aus einem Wochentagsschema kein Intervallschema. Eine variable Frequenz über `frequencyMax` ist ausschließlich in der reinen Intervallangabe zulässig.

**Warum?**  
Diese Einschränkung verhindert Mehrdeutigkeiten und sorgt dafür, dass die Dosierungszeitpunkte eindeutig interpretierbar bleiben. Konkrete Zeitpunkte in `when` oder `timeOfDay` sowie Wochentage in `dayOfWeek` legen die Zahl der Gaben bereits abschließend fest. Ein zusätzliches `frequencyMax` würde dieser Aufzählung widersprechen und in der Textgenerierung ersatzlos entfallen — aus `morgens, frequency 1, frequencyMax 3` entstünde `1-0-0-0 Stück`, ohne dass die Obergrenze im Text erschiene.

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-TimingOnlyOneType-examples.md%}

##### TimingOnlyOneWhen

**Beschreibung:**  
Es darf nicht derselbe Zeitraum des Tages (`when`) in mehreren Dosierungsinstanzen vorkommen.

**Warum?**  
Dadurch wird verhindert, dass Dosierungen mehrfach für denselben Zeitraum angegeben werden, was zu Überdosierung oder Verwirrung führen könnte.

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-TimingOnlyOneWhen-examples.md%}

##### TimingOnlyWhenOrTimeOfDay

**Beschreibung:**  
Es darf nicht die Tageszeit `timeOfDay` und der Zeitraum des Tages `when` in mehreren Dosierungsinstanzen gleichzeitig vorkommen.

**Warum?**  
Dadurch wird verhindert, dass Dosierungen gemischte Schemata anzeigen.

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-TimingOnlyWhenOrTimeOfDay-examples.md%}

##### TimingOnlyOneTimeOfDay

**Beschreibung:**  
Es darf nicht dieselbe Tageszeit (`timeOfDay`) in mehreren Dosierungsinstanzen vorkommen.

**Warum?**  
Auch hier wird sichergestellt, dass Dosierungen nicht mehrfach für dieselbe Uhrzeit definiert werden, um Redundanzen und Fehler zu vermeiden.

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-TimingOnlyOneTimeOfDay-examples.md%}

##### TimingOnlyOneDayOfWeek

**Beschreibung:**  
Es darf nicht derselbe Wochentag (`dayOfWeek`) in mehreren Dosierungsinstanzen vorkommen.

**Warum?**  
Dies verhindert doppelte Einträge für denselben Wochentag und stellt eine eindeutige Zuordnung sicher.

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-TimingOnlyOneDayOfWeek-examples.md%}

##### TimingOnlyOneBounds

**Beschreibung:**  
Für den Zeitrahmen dürfen pro Ressource nur ein Wert und ein Code beziehungsweise ein Start- und ein Endzeitpunkt vorkommen — sowohl für die Dauer (`bounds` vom Typ `Duration`) als auch für Start/Ende (`bounds` vom Typ `Period`).

**Warum?**  
So wird ausgeschlossen, dass mehrere unterschiedliche Zeiträume für eine Dosierung angegeben werden, was die Interpretation erschweren würde. Die Textgenerierung liest den Zeitrahmen ausschließlich aus dem ersten `Dosage`-Element; ein abweichender Zeitrahmen in einem weiteren Element entfiele im erzeugten Text unbemerkt.

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-TimingOnlyOneBounds-examples.md%}

##### TimingBoundsDurationOnlyWholeNumber

**Beschreibung:**  
Der Wert der Gesamtdauer (`boundsDuration.value`) darf nur Ganzzahlen enthalten, Nachkommastellen sind nicht zulässig.

**Warum?**  
Verhindert unklare oder technisch nicht sinnvolle Angaben einer Behandlungsdauer mit Bruchteilen von Zeiteinheiten (z. B. „1,5 Tage“) und sorgt für konsistente, eindeutig interpretierbare Zeiträume.

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-TimingBoundsDurationOnlyWholeNumber-examples.md%}

##### TimingBoundsUnitMatchesCode

**Beschreibung:**  
In den dgMP-Profilen muss die Einheit (`boundsDuration.unit`) zum UCUM‑Code (`boundsDuration.code`) passen; z. B. `wk` nur mit „Woche(n)“, `d` nur mit „Tag(e)“, `mo` nur mit „Monat(e)“, `a` nur mit „Jahr(e)“.

**Warum?**  
Die Textgenerierung leitet die Zeiteinheit aus dem Code ab; eine abweichende `unit` würde eine Dauer anzeigen, die nicht der übermittelten entspricht.

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-TimingBoundsUnitMatchesCode-examples.md%}

##### TimingIntervalOnlyOneFrequency

**Beschreibung:**  
Bei Intervallangaben darf es nur eine Dosierungsinstanz geben.

**Warum?**  
Dadurch wird verhindert, dass ein Intervall mehrfach beschrieben wird, was zu widersprüchlichen Angaben führen könnte.

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-TimingIntervalOnlyOneFrequency-examples.md%}

##### TimingOnlyOnePeriodForDayOfWeek

**Beschreibung:**  
Wenn für einen Wochentag mehrere Einträge existieren, müssen sich deren Zeitangaben (`when`/`timeOfDay`) unterscheiden.

**Warum?**  
Dies stellt sicher, dass für jeden Wochentag die Dosierungszeitpunkte eindeutig sind und keine Dopplungen auftreten.

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-TimingOnlyOnePeriodForDayOfWeek-examples.md%}

##### TimingOnlyOneTimeForInterval

**Beschreibung:**  
Bei Intervallangaben mit Zeitpunkten (`when` oder `timeOfDay`) dürfen die Zeitangaben nicht mehrfach vorkommen und die Periodenangaben müssen eindeutig sein.

**Warum?**  
Damit wird verhindert, dass für ein Intervall mehrere widersprüchliche Zeitpunkte oder Perioden definiert werden.

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-TimingOnlyOneTimeForInterval-examples.md%}

##### TimingSingleDosageForTimeOfDay

**Beschreibung:**  
In den dgMP-Profilen sind bei täglicher Dosierung mit ausschließlich `timeOfDay` mehrere Tageszeiten in einem einzigen `Dosage`‑Element zu modellieren. Mehrere `Dosage`‑Elemente sind nur zulässig, wenn jedes Element eine eindeutige vollständige Dosis einschließlich ihres Datentyps (`Quantity` oder `Range`) besitzt.

**Warum?**  
Verhindert unnötige Aufsplitterung gleichartiger Dosierungen und sorgt für eine klare, eindeutige Modellierung der Tageszeiten.

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-TimingSingleDosageForTimeOfDay-examples.md%}

##### TimingSingleDosageForWhen

**Beschreibung:**  
In den dgMP-Profilen sind bei täglicher Dosierung mit ausschließlich `when` mehrere Zeitabschnitte des Tages in einem einzigen `Dosage`‑Element zu modellieren. Mehrere `Dosage`‑Elemente sind nur zulässig, wenn jedes Element eine eindeutige vollständige Dosis einschließlich ihres Datentyps (`Quantity` oder `Range`) besitzt.

**Warum?**  
Verhindert unnötige Aufsplitterung gleichartiger Dosierungen und sorgt für eine klare, eindeutige Modellierung der Tagesabschnitte.

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-TimingSingleDosageForWhen-examples.md%}

##### TimingVarFreqGtMin

**Beschreibung:**  
Wenn `frequencyMax` verwendet wird, muss der maximale Wert größer als `frequency` sein.

**Warum?**  
Dadurch wird sichergestellt, dass tatsächlich ein Bereich und kein redundanter oder widersprüchlicher Einzelwert modelliert wird.

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-TimingVarFreqGtMin-examples.md%}

##### TimingVarPeriodGtMin

**Beschreibung:**  
Wenn `periodMax` verwendet wird, muss der maximale Wert größer als `period` sein.

**Warum?**  
Dadurch wird sichergestellt, dass tatsächlich ein Bereich und kein redundanter oder widersprüchlicher Einzelwert modelliert wird.

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-TimingVarPeriodGtMin-examples.md%}



Die folgenden Invarianten beziehen sich auf das Dosage-Element insgesamt (nicht nur auf `timing.repeat`). Sie wirken über alle Dosierungsinstanzen einer Ressource (z. B. alle `dosageInstruction` eines `MedicationRequest`).

#### Fehler: Dosage-bezogen

Die folgenden Invarianten beziehen sich auf das Dosage-Element insgesamt (nicht nur auf `timing.repeat`). Sie wirken über alle Dosierungsinstanzen einer Ressource (z. B. alle `dosageInstruction` eines `MedicationRequest`).

##### DosageStructuredOrFreeText

**Beschreibung:**  
In den dgMP-Profilen darf eine Dosierungsangabe entweder vollständig strukturiert (mit `timing` und/oder `doseAndRate`) oder ausschließlich als Freitext (`text`) vorliegen - eine Mischung ist nicht zulässig.

**Warum?**  
Verhindert widersprüchliche oder doppelte Informationsquellen (Freitext vs. Struktur) und erleichtert automatische Verarbeitung (z. B. Generierung patientenverständlicher Texte).

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-DosageStructuredOrFreeText-examples.md%}

##### DosageStructuredRequiresBoth

**Beschreibung:**  
Wenn in den dgMP-Profilen eine strukturierte Dosierung angegeben wird, müssen sowohl zeitliche Angaben (`timing`) als auch die Dosis (`doseAndRate`) vorhanden sein. Für reine Bedarfsdosierungen darf `doseAndRate` auch ohne `timing` angegeben werden.

**Warum?**  
Der dgMP setzt auf durchgängig maschinell auswertbare Dosierungen; die Textgenerierung benötigt Zeit und Menge gemeinsam. Eine Dosierung, deren Menge erst außerhalb der Ressource festgelegt wird, ist im dgMP als Freitext-Dosierung abzubilden.

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-DosageStructuredRequiresBoth-examples.md%}

##### DosageStructuredRequiresGeneratedText

**Beschreibung:**  
Liegt eine strukturierte Dosierung vor, muss die Extension `GeneratedDosageInstructionsMeta` existieren sowie genau eine der FHIR R5 RenderedDosageInstruction-Extensions passend zur Ressource (MedicationRequest/Dispense/Statement). Als strukturiert gilt eine Dosierung, bei der `doseAndRate` befüllt und `text` leer ist und die entweder ein `timing` trägt **oder** eine reine Bedarfsdosierung (`asNeededBoolean = true`) ist.

**Warum?**  
Dokumentiert, dass ein (maschinen-)generierter, patientenlesbarer Dosierungstext verfügbar ist und stellt die Nachvollziehbarkeit der Generierung sicher. Die reine Bedarfsdosierung ist ausdrücklich eingeschlossen: Sie kommt gemäß [DosageStructuredRequiresBoth](#dosagestructuredrequiresboth) ohne `timing` aus, ist aber ebenso renderbar wie jede andere strukturierte Dosierung — eine Anknüpfung allein an `timing` würde sie unbeabsichtigt von der Pflicht ausnehmen.

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-DosageStructuredRequiresGeneratedText-examples.md%}

##### FreeTextMatchesRenderedText

**Beschreibung:**  
Wenn eine Dosierung als reiner Freitext angegeben ist (nur `text`, kein `timing`/`doseAndRate`), muss der Wert in `dosageInstruction.text` exakt mit dem Wert in der Extension `renderedDosageInstruction` übereinstimmen.

**Warum?**  
Verhindert Inkonsistenzen zwischen der Freitextangabe und der gerenderten Dosierungsanweisung. Dies stellt sicher, dass der vom Anwender eingegebene Freitext konsistent in der Extension für die Darstellung übernommen wird.

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-FreeTextMatchesRenderedText-examples.md%}

##### FreeTextSingleDosageOnly

**Beschreibung:**  
Wenn eine Dosierung als reiner Freitext angegeben ist (nur `text`, kein `timing`/`doseAndRate`), darf in der Ressource insgesamt nur genau ein `Dosage`‑Eintrag vorkommen.

**Warum?**  
Verhindert widersprüchliche oder doppelte Freitextangaben, die nicht automatisch zusammengeführt werden können. Fördert eindeutige, konsolidierte Freitext‑Anweisungen, wenn keine strukturierte Modellierung erfolgt.

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-FreeTextSingleDosageOnly-examples.md%}

##### DosageDoseUnitSameCode

**Beschreibung:**  
In den dgMP-Profilen müssen alle Dosierungsinstanzen innerhalb derselben Ressource dieselbe Dosiereinheit (Code) verwenden.

**Warum?**  
Die Textgenerierung übernimmt die gemeinsame Dosis-Einheit aus der ersten auswertbaren Dosis; unterschiedliche Einheiten würden im erzeugten Text stillschweigend verlorengehen. Zudem setzt der dgMP auf durchgängig maschinell vergleichbare Dosierungen.

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-DosageDoseUnitSameCode-examples.md%}

##### DosageDoseQuantityAllowedFractions

**Beschreibung:**  
Dosiswerte in `doseQuantity` und `doseRange` dürfen nur ganzzahlig sein oder einen der Dezimalanteile `.25`, `.33`, `.5`, `.66` oder `.75` verwenden.

**Warum?**  
Bildet die in der Praxis teilbaren Darreichungsformen ab (halbe, viertel oder drittel Einheiten) und verhindert Dosiswerte, die sich nicht verabreichen lassen. Die zulässige Schreibweise des Werts regelt zusätzlich [DosageDoseValueDecimalNotation](#dosagedosevaluedecimalnotation).

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-DosageDoseQuantityAllowedFractions-examples.md%}

##### DosageDoseValueDecimalNotation

**Beschreibung:**  
Dosiswerte in `doseQuantity.value` sowie `doseRange.low.value` und `doseRange.high.value` müssen in einfacher Dezimalschreibweise mit maximal zwei Nachkommastellen angegeben werden (z. B. `0.5`, `1`, `2.25`). Die vom Datentyp `decimal` erlaubte Exponentialschreibweise ist unzulässig; `0.5` darf also nicht als `50e-2` übermittelt werden.

**Warum?**  
Der Constraint `DosageDoseQuantityAllowedFractions` schränkt den Wertebereich ein, arbeitet dafür aber auf dem geparsten Zahlenwert und ist gegenüber der Notation blind. Da Dosiswerte in der Praxis auch textnah weiterverarbeitet und angezeigt werden, legt dieser Constraint zusätzlich die Schreibweise fest und hält sie an der BMP-Spezifikation ausgerichtet.

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-DosageDoseValueDecimalNotation-examples.md%}

##### DosageDoseValuePositive

**Beschreibung:**
`doseQuantity.value` und `doseRange.high.value` müssen größer als `0` sein. Für `doseRange.low.value` ist zusätzlich der Wert `0` zulässig. Die Regel prüft damit alle im dgMP zulässigen Varianten der Einzeldosis.

**Warum?**
Eine negative Dosis beschreibt keine verabreichbare Arzneimittelmenge und kann nicht sinnvoll in eine Dosierungsanweisung überführt werden. Dasselbe gilt für den Wert `0` als Einzeldosis oder als Obergrenze eines Bereichs: Beides ergäbe eine Anweisung, nach der nichts anzuwenden ist („0-0-0-0 Stück“ beziehungsweise „je bis zu 0 Stück“). Benötigt wird `0` ausschließlich als Untergrenze einer variablen Dosis, zum Beispiel für „0 bis 2 Tabletten“. Der Constraint hält die Profilvalidierung konsistent mit der defensiven Prüfung der Textgenerierung.

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-DosageDoseValuePositive-examples.md%}

##### DoseRangeHighRequiredWhenLowPresent

**Beschreibung:**  
Wenn bei `doseRange` eine Untergrenze (`low`) angegeben wird, muss auch eine Obergrenze (`high`) vorhanden sein.

**Warum?**  
Die Modellierung einer variablen Einzeldosis soll stets einen tatsächlich interpretierbaren Bereich ergeben und keine einseitige Untergrenze.

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-DoseRangeHighRequiredWhenLowPresent-examples.md%}

##### DoseRangeLowAndHighSameUnit

**Beschreibung:**  
Unter- und Obergrenze einer variablen Einzeldosis müssen dieselbe Maßeinheit (`system`, `code`, `unit`) verwenden.

**Warum?**  
Nur so ist der Bereich fachlich konsistent interpretierbar; gemischte Einheiten würden Mehrdeutigkeiten und Rechenfehler erzeugen.

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-DoseRangeLowAndHighSameUnit-examples.md%}

##### VarFreqNoMaxDose

**Beschreibung:**  
Variable Frequenz (`frequencyMax`) und `maxDosePerPeriod` dürfen nicht gemeinsam verwendet werden.

**Warum?**  
Beide Angaben begrenzen die Häufigkeit bzw. Gesamtmenge pro Zeitraum. In Kombination entsteht eine doppelte, potenziell widersprüchliche Modellierung.

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-VarFreqNoMaxDose-examples.md%}

##### MindestabstandOnlyPureAsNeeded

**Beschreibung:**  
`modifierExtension[MinimumIntervalBetweenAdministrations]` ist ausschließlich bei einer reinen Bedarfsmedikation zulässig, also zusammen mit `asNeededBoolean = true` und ohne `timing`.

**Warum?**  
Ein strukturierter Rhythmus legt den Abstand zwischen zwei Gaben bereits fest. Ein zusätzlicher, schwächerer Mindestabstand daneben ergibt eine widersprüchliche Anweisung — etwa „alle 8 Stunden, mindestens 6 Stunden Abstand", bei der offenbleibt, welche Angabe gilt. Beim Bedarfsfall ohne Rhythmus ist der Mindestabstand dagegen die einzige zeitliche Schranke und damit sinnvoll.

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-MindestabstandOnlyPureAsNeeded-examples.md%}

##### DosageViererschemaInText

**Beschreibung:**  
`Dosage.text` darf nicht ausschließlich aus einem 4-Schema bestehen. Erfasst wird der reine Fall – vier durch `-` oder `–` getrennte Werte, optional mit Nachkommastellen, Bruchangabe und nachgestellter Einheit (z. B. `1-0-1-0`, `0,5-0-0,5-0`, `1-0-1-0 Stück`). Ein 4-Schema, das in einen Text eingebettet ist, löst weiterhin nur die Warnung `DosageWarnungViererschemaInText` aus.

**Warum?**  
Ein Freitext, der nur ein 4-Schema enthält, trägt keine Information, die nicht strukturiert über `timing.repeat.when` und `doseAndRate` abbildbar wäre. Er entzieht die Dosierung der maschinellen Auswertung und der Textgenerierung, die genau diese Darstellung aus strukturierten Angaben selbst erzeugt (siehe [Dosis Textgenerierung](./dosierung-textgenerierung.html)).

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-DosageViererschemaInText-examples.md%}

##### PatientInstructionIdentical

**Beschreibung:**  
Wird `patientInstruction` in einer Ressource mit mehreren Dosierungen verwendet, muss das Feld in allen `Dosage`‑Elementen identisch befüllt sein.

**Warum?**  
Verhindert widersprüchliche patientenbezogene Anwendungshinweise innerhalb derselben Ressource und stellt eine einheitliche Darstellung sicher.

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-PatientInstructionIdentical-examples.md%}

##### MaxDoseSameUnitAsDose

**Beschreibung:**  
`maxDosePerPeriod` muss dieselbe Einheit, denselben Code und dasselbe System wie `doseQuantity` verwenden.

**Warum?**  
Nur bei gleicher Einheit lässt sich die Maximalmenge fachlich korrekt zur Einzeldosis in Beziehung setzen (z. B. „je 1 Stück — nicht mehr als 6 Stück in 24 Stunden“).

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-MaxDoseSameUnitAsDose-examples.md%}

##### MaxDosePerPeriodOnly24hOr1d

**Beschreibung:**  
`maxDosePerPeriod` ist nur mit einem Bezugszeitraum von **24 Stunden** (`24 h`) oder **1 Tag** (`1 d`) zulässig. Andere Perioden (z. B. „maximal 3 alle 6 h“) sind nicht erlaubt.

**Warum?**  
Fachliche Festlegung: Die Maximalmenge wird stets auf einen Tag bezogen. Die beiden gleichwertigen Schreibweisen `24 h` und `1 d` bleiben zur Wahl, um unterschiedliche Erfassungsgewohnheiten zu unterstützen; abweichende Zeiträume würden die einheitliche Darstellung („… in 24 Stunden“) und Auswertung erschweren.

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-MaxDosePerPeriodOnly24hOr1d-examples.md%}

##### MaxDoseOnlyWhenAsNeeded

**Beschreibung:**  
Eine Maximalmenge (`maxDosePerPeriod`) darf nur bei einer Bedarfsdosierung (`asNeededBoolean = true`) angegeben werden.

**Warum?**  
Die Maximalmenge wird in der Textgenerierung ausschließlich im Bedarfsfall dargestellt. Ohne die Kopplung an `asNeededBoolean` könnte eine profilvalide Nicht-Bedarf-Dosierung eine `maxDosePerPeriod` tragen, die im generierten Text stillschweigend entfiele – der Constraint verhindert diese Inkonsistenz.

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-MaxDoseOnlyWhenAsNeeded-examples.md%}

##### MaxDosePerPeriodIdentical

**Beschreibung:**  
Enthält eine Ressource mehrere `Dosage`-Elemente, muss `maxDosePerPeriod` in allen Elementen identisch befüllt sein — in Zähler (Wert und Einheit) wie in Nenner (Wert und Code). Entweder tragen alle Elemente die Angabe oder keines, und jede vorhandene Angabe muss alle vier Teilfelder führen.

**Warum?**  
Die Maximalmenge gilt für die Gesamtmenge im Bezugszeitraum, nicht je Einzelsegment. Die Textgenerierung liest sie ausschließlich aus dem ersten `Dosage`-Element und stellt sie einmal am Ende der Anweisung dar (siehe [Dosis Textgenerierung](./dosierung-textgenerierung.html)). Ohne diesen Constraint könnte ein zweites Element eine abweichende Obergrenze führen, die im erzeugten Text unbemerkt entfiele — mit unmittelbarer Auswirkung auf die Arzneimittelsicherheit.

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-MaxDosePerPeriodIdentical-examples.md%}

##### AsNeededForRequiresAsNeeded

**Beschreibung:**  
Ein Anlass (`extension[asNeededFor]`) darf nur bei einer Bedarfsdosierung (`asNeededBoolean = true`) angegeben werden. Eine Bedarfsdosierung selbst benötigt keinen Anlass.

**Warum?**  
Ein Anlass ohne Bedarfskennzeichnung wäre fachlich unstimmig. Umgekehrt ist der Anlass optional, da eine Bedarfsdosierung auch ohne konkrete Indikation zulässig ist.

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-AsNeededForRequiresAsNeeded-examples.md%}

##### AsNeededSingleDosageOnly

**Beschreibung:**
Eine reine Bedarfsdosierung (`asNeededBoolean = true` ohne `timing`) darf nur als einziges `Dosage`-Element der Ressource angegeben werden.

**Warum?**
Ohne zeitliche Zuordnung lassen sich mehrere Bedarfsdosen nicht eindeutig zu einer gemeinsamen Dosierungsanweisung aggregieren. Die Beschränkung verhindert, dass die Textgenerierung nur das erste Element ausgibt und weitere Dosen unbemerkt entfallen.

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-AsNeededSingleDosageOnly-examples.md%}

##### AsNeededIdentical

**Beschreibung:**
Enthält eine Ressource mehrere `Dosage`-Elemente, muss das Bedarfskennzeichen (`asNeededBoolean`) in allen Elementen identisch befüllt sein. Entweder tragen alle Elemente die Angabe oder keines.

**Warum?**
Die Bedarfskennzeichnung gilt für die Dosierung als Ganzes und entscheidet über die gesamte Textform: Sie erzeugt das vorangestellte „Bei …“, schaltet Mindestabstand und Maximalmenge frei und bewirkt die Großschreibung am Zeilenanfang. Die Textgenerierung liest sie ausschließlich aus dem ersten `Dosage`-Element. Wäre nur ein späteres Element als Bedarf gekennzeichnet, entfiele die Kennzeichnung vollständig und eine Bedarfsmedikation erschiene als festes Einnahmeschema.

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-AsNeededIdentical-examples.md%}

##### AsNeededForIdentical

**Beschreibung:**
Enthält eine Ressource mehrere `Dosage`-Elemente, muss der Anlass (`extension[asNeededFor]`) in allen Elementen übereinstimmen. Mehrere Anlässe je Element sind zulässig, müssen dann aber in jedem Element dieselben sein; auf die Reihenfolge kommt es nicht an.

**Warum?**
Der Anlass wird ausschließlich aus dem ersten `Dosage`-Element gelesen und dem Text vorangestellt (siehe [Dosis Textgenerierung](./dosierung-textgenerierung.html)). Ein nur in einem späteren Element angegebener oder dort abweichender Anlass würde im erzeugten Text ersatzlos entfallen und die Dosierung auf ein generisches „Bei Bedarf“ reduzieren.

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-AsNeededForIdentical-examples.md%}

##### MindestabstandIdentical

**Beschreibung:**
Enthält eine Ressource mehrere `Dosage`-Elemente, muss der Mindestabstand zwischen Gaben (`modifierExtension[minimumIntervalBetweenAdministrations]`) in allen Elementen identisch befüllt sein — in Wert wie in Zeiteinheit. Entweder tragen alle Elemente die Angabe oder keines, und jede vorhandene Angabe muss vollständig sein (`valueDuration.value` **und** `valueDuration.code`).

**Warum?**
Der Mindestabstand wird ausschließlich aus dem ersten `Dosage`-Element gelesen. Da es sich um eine `modifierExtension` handelt, verändert er die zulässige Anwendung der Dosierung; ein nur in einem späteren Element hinterlegter Abstand entfiele im erzeugten Text unbemerkt.

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-MindestabstandIdentical-examples.md%}

##### MindestabstandUnitMatchesCode

**Beschreibung:**
Die Anzeigeeinheit des Mindestabstands (`valueDuration.unit`) muss zum UCUM-Code passen: `min` nur mit „Minute(n)“, „Minute“ oder „Minuten“, `h` nur mit „Stunde(n)“, „Stunde“ oder „Stunden“. Als Code sind ausschließlich `min` und `h` zulässig (ValueSet `MindestabstandUnitsOfTimeDgMPVS`).

**Warum?**
Die Textgenerierung leitet die ausgeschriebene Einheit aus `.code` ab. Ohne diesen Constraint könnte eine profilvalide Ressource `code = 'h'` mit `unit = 'Tag(e)'` führen — der erzeugte Text spräche dann von Stunden, während die Ressource Tage anzeigt. Der Constraint entspricht [TimingBoundsUnitMatchesCode](#timingboundsunitmatchescode) für den Zeitrahmen.

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-MindestabstandUnitMatchesCode-examples.md%}

#### Fehler: Auf Ressourcen-Ebene

Die folgende Invariante ist an den Elternressourcen modelliert, weil sie einen Fall abdeckt, in dem gar kein `Dosage`-Objekt vorliegt. Sie existiert je einmal für `MedicationRequest`, `MedicationDispense` und `MedicationStatement` (Constraint-Keys `ExtRequiresDosage-MR`, `ExtRequiresDosage-MD` und `ExtRequiresDosage-MS`).

##### DosageExtensionsRequireDosage

**Beschreibung:**
Wenn auf einer MedicationRequest, MedicationDispense oder MedicationStatement die Extension `GeneratedDosageInstructionsMeta` oder die für die jeweilige Ressource passende Extension `renderedDosageInstruction` vorliegt, muss die Ressource mindestens eine Dosierung enthalten (`dosageInstruction` bzw. `dosage`).

**Warum?**
Die Dosierungs-Extensions enthalten Metadaten beziehungsweise den gerenderten Text zu einer Dosierungsangabe. Ohne Dosierung fehlt ihr fachlicher Bezug. Da es in diesem Fall kein `Dosage`-Objekt gibt, ist die Anforderung als Constraint an den jeweiligen Elternressourcen modelliert.

**Hinweis zur Implementierung:**
Diese Invariante ist nicht auf den Dosage-Profilen definiert, sondern auf den abstrakten Profilen `MedicationRequestDgMP`, `MedicationDispenseDgMP` und `MedicationStatementDgMP`. Eigene Implementierungsprofile, die nicht von diesen abstrakten dgMP-Profilen ableiten, müssen den jeweils passenden Constraint daher manuell übernehmen.
