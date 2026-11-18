Im Folgenden werden alle definierten Invarianten für das Timing-Profil aufgelistet, jeweils mit einer kurzen Beschreibung und der Begründung für ihre Existenz. Diese Regeln sorgen für eine konsistente und eindeutige Modellierung von Dosierungszeitpunkten im FHIR-Kontext.

Neben den Timing-bezogenen Regeln existieren weitere Invarianten auf Ebene des Dosage-Elements (Profil `DosageDE` bzw. `DosageDgMP`). Diese steuern, wie strukturierte und Freitext‑Dosierungen zulässig kombiniert werden und stellen Konsistenz bei Dosiereinheiten sicher. Alle aktuell definierten Constraints sind nachfolgend aufgeführt.

### Timing-bezogene Constraints

#### TimingFrequencyCount

**Beschreibung:**  
Die Häufigkeit (`frequency`) muss mit der Anzahl der angegebenen Zeitpunkte (`timeOfDay` oder `when`) übereinstimmen, abhängig davon, welche Felder gesetzt sind.

**Warum?**  
Diese Regel stellt sicher, dass die Anzahl der Dosierungen pro Periode korrekt mit den angegebenen Zeitpunkten übereinstimmt. So wird verhindert, dass widersprüchliche oder unklare Dosierungsangaben entstehen.

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-TimingFrequencyCount-examples.md%}

#### TimingPeriodUnit

**Beschreibung:**  
Wenn Wochentage (`dayOfWeek`) angegeben sind, muss die Zeiteinheit (`periodUnit`) "Woche" (`wk`) sein, andernfalls "Tag" (`d`).

**Warum?**  
Dadurch wird sichergestellt, dass die Zeiteinheit zur Angabe der Dosierungsperiode konsistent zu den verwendeten Feldern passt und keine Missverständnisse bei der Interpretation entstehen.

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-TimingPeriodUnit-examples.md%}

#### TimingOnlyOneType

**Beschreibung:**  
Es darf pro Dosierung nur eine Art der Zeitangabe verwendet werden (z.B. ausschließlich `4-Schema`, `TimeOfDay`, `DayOfWeek`, `Interval`, Kombinationen wie `DayOfWeek+TimeOfDay` oder `Interval+TimeOfDay`).

**Warum?**  
Diese Einschränkung verhindert Mehrdeutigkeiten und sorgt dafür, dass die Dosierungszeitpunkte eindeutig interpretierbar bleiben.

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-TimingOnlyOneType-examples.md%}

#### TimingOnlyOneWhen

**Beschreibung:**  
Es darf nicht derselbe Zeitraum des Tages (`when`) in mehreren Dosierungsinstanzen vorkommen.

**Warum?**  
Dadurch wird verhindert, dass Dosierungen mehrfach für denselben Zeitraum angegeben werden, was zu Überdosierung oder Verwirrung führen könnte.

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-TimingOnlyOneWhen-examples.md%}

#### TimingOnlyWhenOrTimeOfDay

**Beschreibung:**  
Es darf nicht die Tageszeit `timeOfDay` und der Zeitraum des Tages `when` in mehreren Dosierungsinstanzen gleichzeitig vorkommen.

**Warum?**  
Dadurch wird verhindert, dass Dosierungen gemischte Schemata anzeigen.

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-TimingOnlyWhenOrTimeOfDay-examples.md%}

#### TimingOnlyOneTimeOfDay

**Beschreibung:**  
Es darf nicht dieselbe Tageszeit (`timeOfDay`) in mehreren Dosierungsinstanzen vorkommen.

**Warum?**  
Auch hier wird sichergestellt, dass Dosierungen nicht mehrfach für dieselbe Uhrzeit definiert werden, um Redundanzen und Fehler zu vermeiden.

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-TimingOnlyOneTimeOfDay-examples.md%}

#### TimingOnlyOneDayOfWeek

**Beschreibung:**  
Es darf nicht derselbe Wochentag (`dayOfWeek`) in mehreren Dosierungsinstanzen vorkommen.

**Warum?**  
Dies verhindert doppelte Einträge für denselben Wochentag und stellt eine eindeutige Zuordnung sicher.

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-TimingOnlyOneDayOfWeek-examples.md%}

#### TimingOnlyOneBounds

**Beschreibung:**  
Für die Dauer (`bounds` vom Typ `Duration`) dürfen pro Ressource nur ein Wert und ein Code vorkommen.

**Warum?**  
So wird ausgeschlossen, dass mehrere unterschiedliche Zeiträume für eine Dosierung angegeben werden, was die Interpretation erschweren würde.

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-TimingOnlyOneBounds-examples.md%}

#### TimingIntervalOnlyOneFrequency

**Beschreibung:**  
Bei Intervallangaben darf es nur eine Dosierungsinstanz geben.

**Warum?**  
Dadurch wird verhindert, dass ein Intervall mehrfach beschrieben wird, was zu widersprüchlichen Angaben führen könnte.

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-TimingIntervalOnlyOneFrequency-examples.md%}

#### TimingOnlyOnePeriodForDayOfWeek

**Beschreibung:**  
Wenn für einen Wochentag mehrere Einträge existieren, müssen sich deren Zeitangaben (`when`/`timeOfDay`) unterscheiden.

**Warum?**  
Dies stellt sicher, dass für jeden Wochentag die Dosierungszeitpunkte eindeutig sind und keine Dopplungen auftreten.

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-TimingOnlyOnePeriodForDayOfWeek-examples.md%}

#### TimingOnlyOneTimeForInterval

**Beschreibung:**  
Bei Intervallangaben mit Zeitpunkten (`when` oder `timeOfDay`) dürfen die Zeitangaben nicht mehrfach vorkommen und die Periodenangaben müssen eindeutig sein.

**Warum?**  
Damit wird verhindert, dass für ein Intervall mehrere widersprüchliche Zeitpunkte oder Perioden definiert werden.

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-TimingOnlyOneTimeForInterval-examples.md%}

#### TimingBoundsUnitMatchesCode

**Beschreibung:**  
Die Einheit (`boundsDuration.unit`) muss zum UCUM‑Code (`boundsDuration.code`) passen; z. B. `wk` nur mit „Woche(n)“, `d` nur mit „Tag(e)“, `mo` nur mit „Monat(e)“, `a` nur mit „Jahr(e)“.

**Warum?**  
Verhindert widersprüchliche Angaben wie `code='wk'` mit `unit='Tag(e)'`.

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-TimingBoundsUnitMatchesCode-examples.md%}

#### TimingBoundsDurationPositive

**Beschreibung:**  
`boundsDuration.value` muss größer als `0` sein.

**Warum?**  
Eine Dauer von `0` oder darunter beschreibt keinen Zeitraum. Die Textgenerierung 1.0.1 lässt eine Dauer von `0` im Text weg; der Text gibt dann eine unbefristete Anwendung wieder.

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-TimingBoundsDurationPositive-examples.md%}

#### TimingValuesPositiveWarning

**Beschreibung:**  
Warnung in `TimingDE`, wenn `period`, `periodMax`, `boundsDuration.value` oder `boundsRange.high.value` nicht größer als `0` ist oder `boundsRange.low.value` negativ ist. Die dgMP-Profile übernehmen die Warnung; eine Dauer von `0` oder darunter ist dort zusätzlich ein Fehler (`TimingBoundsDurationPositive`). Eine negative Periode schließt bereits die FHIR-Basisregel `tim-5` aus.

**Warum?**  
Eine Periode oder Dauer von `0` beschreibt keinen Zeitraum. Ab Version 2.0.0 ist das in den dgMP-Profilen ein Fehler.

Folgende Beispiele lösen eine Warnung aus:

{% include dosage-constraint-TimingValuesPositiveWarning-examples.md%}

#### TimingPeriodOnlyWholeNumberWarning

**Beschreibung:**  
Warnung in `TimingDgMP`, wenn `period` keine ganze Zahl ist, zum Beispiel `1.5`.

**Warum?**  
Ab Version 2.0.0 sind in den dgMP-Profilen nur ganzzahlige Perioden zulässig.

Folgende Beispiele lösen eine Warnung aus:

{% include dosage-constraint-TimingPeriodOnlyWholeNumberWarning-examples.md%}

#### TimingBoundsDurationOnlyWholeNumberWarning

**Beschreibung:**  
Warnung in `TimingDgMP`, wenn `boundsDuration.value` keine ganze Zahl ist, zum Beispiel `1.5`.

**Warum?**  
Ab Version 2.0.0 sind in den dgMP-Profilen nur ganzzahlige Behandlungsdauern zulässig.

Folgende Beispiele lösen eine Warnung aus:

{% include dosage-constraint-TimingBoundsDurationOnlyWholeNumberWarning-examples.md%}


#### TimingSingleDosageForTimeOfDay

**Beschreibung:**  
Wenn nur `timeOfDay` verwendet wird und täglich dosiert wird, sind mehrere Tageszeiten in einem einzigen `Dosage`‑Element zu modellieren. Mehrere `Dosage`‑Elemente sind nur zulässig, wenn sich die Dosis (Wert) unterscheidet.

**Warum?**  
Verhindert unnötige Aufsplitterung gleichartiger Dosierungen und sorgt für eine klare, eindeutige Modellierung der Tageszeiten.

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-TimingSingleDosageForTimeOfDay-examples.md%}

#### TimingSingleDosageForWhen

**Beschreibung:**  
Wenn nur `when` verwendet wird und täglich dosiert wird, sind mehrere Zeitabschnitte des Tages in einem einzigen `Dosage`‑Element zu modellieren. Mehrere `Dosage`‑Elemente sind nur zulässig, wenn sich die Dosis (Wert) unterscheidet.

**Warum?**  
Verhindert unnötige Aufsplitterung gleichartiger Dosierungen und sorgt für eine klare, eindeutige Modellierung der Tagesabschnitte.

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-TimingSingleDosageForWhen-examples.md%}

### Dosage-bezogene Constraints

Die folgenden Invarianten beziehen sich auf das Dosage-Element insgesamt (nicht nur auf `timing.repeat`). Sie wirken über alle Dosierungsinstanzen einer Ressource (z. B. alle `dosageInstruction` eines `MedicationRequest`).

#### DosageStructuredOrFreeText / DosageStructuredOrFreeTextWarning

**Beschreibung:**  
Eine Dosierungsangabe darf entweder vollständig strukturiert (mit `timing` und/oder `doseAndRate`) oder ausschließlich als Freitext (`text`) vorliegen - eine Mischung ist nicht zulässig.

**Hinweis zur Ausprägung:**  
Im generischen Profil `DosageDE` ist dies als Warnung (`warning`) modelliert (`DosageStructuredOrFreeTextWarning`), im dgMP‑Spezialprofil (`DosageDgMP`) als Fehler (`error`, Invariante `DosageStructuredOrFreeText`). Implementierungen sollten die strukturierte Variante bevorzugen und Freitext nur verwenden, wenn eine strukturierte Abbildung nicht möglich ist.

**Warum?**  
Verhindert widersprüchliche oder doppelte Informationsquellen (Freitext vs. Struktur) und erleichtert automatische Verarbeitung (z. B. Generierung patientenverständlicher Texte).

Beispiele (Fehlerfall – Mischform aus Text und Struktur):

{% include dosage-constraint-DosageStructuredOrFreeText-examples.md%}

Gültige Varianten (Warnungskontext – nur Text oder nur Struktur):

{% include dosage-constraint-DosageStructuredOrFreeTextWarning-examples.md%}

#### DosageStructuredRequiresBoth

**Beschreibung:**  
Wenn eine strukturierte Dosierung angegeben wird, müssen sowohl zeitliche Angaben (`timing`) als auch die Dosis (`doseAndRate`) vorhanden sein.

**Warum?**  
Stellt sicher, dass eine strukturierte Dosierung hinreichend vollständig ist, um automatisiert interpretiert werden zu können (Zeit + Menge).

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-DosageStructuredRequiresBoth-examples.md%}

#### DosageStructuredRequiresGeneratedText

**Beschreibung:**  
Liegt eine strukturierte Dosierung vor (strukturierte Elemente befüllt, Freitext leer), muss die Extension `GeneratedDosageInstructionsMeta` existieren sowie genau eine der FHIR R5 RenderedDosageInstruction-Extensions passend zur Ressource (MedicationRequest/Dispense/Statement).

**Warum?**  
Dokumentiert, dass ein (maschinen-)generierter, patientenlesbarer Dosierungstext verfügbar ist und stellt die Nachvollziehbarkeit der Generierung sicher.

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-DosageStructuredRequiresGeneratedText-examples.md%}

#### FreeTextMatchesRenderedText

**Beschreibung:**  
Wenn eine Dosierung als reiner Freitext angegeben ist (nur `text`, kein `timing`/`doseAndRate`), muss der Wert in `dosageInstruction.text` exakt mit dem Wert in der Extension `renderedDosageInstruction` übereinstimmen.

**Warum?**  
Verhindert Inkonsistenzen zwischen der Freitextangabe und der gerenderten Dosierungsanweisung. Dies stellt sicher, dass der vom Anwender eingegebene Freitext konsistent in der Extension für die Darstellung übernommen wird.

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-FreeTextMatchesRenderedText-examples.md%}

#### FreeTextSingleDosageOnly

**Beschreibung:**  
Wenn eine Dosierung als reiner Freitext angegeben ist (nur `text`, kein `timing`/`doseAndRate`), darf in der Ressource insgesamt nur genau ein `Dosage`‑Eintrag vorkommen.

**Warum?**  
Verhindert widersprüchliche oder doppelte Freitextangaben, die nicht automatisch zusammengeführt werden können. Fördert eindeutige, konsolidierte Freitext‑Anweisungen, wenn keine strukturierte Modellierung erfolgt.

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-FreeTextSingleDosageOnly-examples.md%}

#### DosageDoseUnitSameCode

**Beschreibung:**  
Alle Dosierungsinstanzen innerhalb derselben Ressource müssen dieselbe Dosiereinheit (Code) verwenden.

**Warum?**  
Verhindert inkonsistente oder schwer vergleichbare Einträge (z. B. Mischung von Einheiten wie Stück vs. mg) und reduziert Interpretationsfehler bei Summierung oder Darstellung.

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-DosageDoseUnitSameCode-examples.md%}

#### DosageDoseValueNotNegative

**Beschreibung:**  
`doseQuantity.value` darf nicht negativ sein.

**Warum?**  
Eine negative Dosis beschreibt keine anwendbare Arzneimittelmenge.

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-DosageDoseValueNotNegative-examples.md%}

#### DosageDoseValuePositiveWarning

**Beschreibung:**  
Warnung in `DosageDE`, wenn `doseQuantity.value` oder `doseRange.high.value` nicht größer als `0` ist oder `doseRange.low.value` negativ ist. Die dgMP-Profile übernehmen die Warnung; eine negative Dosis ist dort zusätzlich ein Fehler (`DosageDoseValueNotNegative`).

**Warum?**  
Eine Dosis von `0` beschreibt keine Anwendung. Ab Version 2.0.0 ist eine Dosis von `0` oder darunter in den dgMP-Profilen ein Fehler.

Folgende Beispiele lösen eine Warnung aus:

{% include dosage-constraint-DosageDoseValuePositiveWarning-examples.md%}

#### DosageLimitsPositiveWarning

**Beschreibung:**  
Warnung in `DosageDE`, wenn bei `maxDosePerPeriod` der Zähler oder der Nenner nicht größer als `0` ist. Der Ausdruck prüft außerdem den Mindestabstand (`MinimumIntervalBetweenAdministrations`), den es erst ab Version 2.0.0 gibt.

**Warum?**  
Eine Maximalmenge oder ein Bezugszeitraum von `0` ist nicht sinnvoll. In den dgMP-Profilen ist `maxDosePerPeriod` ausgeschlossen; deshalb gibt es hier keine Beispiele.

#### DosageDoseQuantityAllowedFractionsWarning

**Beschreibung:**  
Warnung in `DosageDgMP`, wenn ein Dosiswert keine ganze Zahl ist und keinen der Bruchteile `.125`, `.25`, `.33`, `.5`, `.66` oder `.75` hat, zum Beispiel `1.2`.

**Warum?**  
Ab Version 2.0.0 sind in den dgMP-Profilen nur diese Bruchteile zulässig.

Folgende Beispiele lösen eine Warnung aus:

{% include dosage-constraint-DosageDoseQuantityAllowedFractionsWarning-examples.md%}

#### DosageDoseValueDecimalNotationWarning

**Beschreibung:**  
Warnung in `DosageDgMP`, wenn ein Dosiswert mehr als drei Nachkommastellen hat oder mit Exponent angegeben ist (zum Beispiel `5e-1`). Ob ein Exponent erkannt wird, hängt vom JSON-Parser ab. Ein negativer Dosiswert löst die Warnung ebenfalls aus.

**Warum?**  
Ab Version 2.0.0 ist in den dgMP-Profilen nur die einfache Dezimalschreibweise mit höchstens drei Nachkommastellen zulässig.

Folgende Beispiele lösen eine Warnung aus:

{% include dosage-constraint-DosageDoseValueDecimalNotationWarning-examples.md%}


#### DosageWarnungViererschemaInText

**Beschreibung:**  
Warnung, wenn ein klassisches 4-Schema (z. B. Darstellung wie "1-0-1-0") im Freitext angegeben wird, obwohl eine strukturierte Abbildung möglich wäre.

**Warum?**  
Ermutigt zur strukturierten Modellierung der Einnahmezeiten anstelle rein schematischer Textdarstellungen, verbessert maschinelle Auswertbarkeit und Textgenerierung.

Gültige Beispiele (Warnungskontext – Freitext enthält 4-Schema):

{% include dosage-constraint-DosageWarnungViererschemaInText-examples.md%}
