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

#### TimingVarFreqOrPeriod

**Beschreibung:**  
Variable Frequenz (`frequencyMax`) und variable Periode (`periodMax`) dürfen nicht gemeinsam verwendet werden.

**Warum?**  
Die gleichzeitige Variation beider Achsen führt zu einem nur schwer eindeutig interpretierbaren Einnahmeschema.

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-TimingVarFreqOrPeriod-examples.md%}

#### TimingVarFreqGtMin

**Beschreibung:**  
Wenn `frequencyMax` verwendet wird, muss der maximale Wert größer als `frequency` sein.

**Warum?**  
Dadurch wird sichergestellt, dass tatsächlich ein Bereich und kein redundanter oder widersprüchlicher Einzelwert modelliert wird.

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-TimingVarFreqGtMin-examples.md%}

#### TimingVarPeriodGtMin

**Beschreibung:**  
Wenn `periodMax` verwendet wird, muss der maximale Wert größer als `period` sein.

**Warum?**  
Dadurch wird sichergestellt, dass tatsächlich ein Bereich und kein redundanter oder widersprüchlicher Einzelwert modelliert wird.

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-TimingVarPeriodGtMin-examples.md%}

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

#### DoseRangeHighRequiredWhenLowPresent

**Beschreibung:**  
Wenn bei `doseRange` eine Untergrenze (`low`) angegeben wird, muss auch eine Obergrenze (`high`) vorhanden sein.

**Warum?**  
Die Modellierung einer variablen Einzeldosis soll stets einen tatsächlich interpretierbaren Bereich ergeben und keine einseitige Untergrenze.

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-DoseRangeHighRequiredWhenLowPresent-examples.md%}

#### DoseRangeLowAndHighSameUnit

**Beschreibung:**  
Unter- und Obergrenze einer variablen Einzeldosis müssen dieselbe Maßeinheit (`system`, `code`, `unit`) verwenden.

**Warum?**  
Nur so ist der Bereich fachlich konsistent interpretierbar; gemischte Einheiten würden Mehrdeutigkeiten und Rechenfehler erzeugen.

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-DoseRangeLowAndHighSameUnit-examples.md%}

#### VarFreqNoMaxDose

**Beschreibung:**  
Variable Frequenz (`frequencyMax`) und `maxDosePerPeriod` dürfen nicht gemeinsam verwendet werden.

**Warum?**  
Beide Angaben begrenzen die Häufigkeit bzw. Gesamtmenge pro Zeitraum. In Kombination entsteht eine doppelte, potenziell widersprüchliche Modellierung.

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-VarFreqNoMaxDose-examples.md%}

#### VarPeriodNoMindestabstand

**Beschreibung:**  
Variable Periode (`periodMax`) und `extension[MindestabstandZwischenGaben]` dürfen nicht gemeinsam verwendet werden.

**Warum?**  
Beide Angaben beschreiben Abstände zwischen Gaben. Ihre gleichzeitige Verwendung erzeugt konkurrierende Zeitlogiken.

Folgende Beispiele sind nicht valide, da sie den Constraint brechen:

{% include dosage-constraint-VarPeriodNoMindestabstand-examples.md%}

#### DosageWarnungViererschemaInText

**Beschreibung:**  
Warnung, wenn ein klassisches 4-Schema (z. B. Darstellung wie "1-0-1-0") im Freitext angegeben wird, obwohl eine strukturierte Abbildung möglich wäre.

**Warum?**  
Ermutigt zur strukturierten Modellierung der Einnahmezeiten anstelle rein schematischer Textdarstellungen, verbessert maschinelle Auswertbarkeit und Textgenerierung.

Gültige Beispiele (Warnungskontext – Freitext enthält 4-Schema):

{% include dosage-constraint-DosageWarnungViererschemaInText-examples.md%}
