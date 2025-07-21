Im Folgenden werden alle definierten Invarianten für das Timing-Profil aufgelistet, jeweils mit einer kurzen Beschreibung und der Begründung für ihre Existenz. Diese Regeln sorgen für eine konsistente und eindeutige Modellierung von Dosierungszeitpunkten im FHIR-Kontext.

### TimingFrequencyCount

**Beschreibung:**  
Die Häufigkeit (`frequency`) muss mit der Anzahl der angegebenen Zeitpunkte (`timeOfDay` oder `when`) übereinstimmen, abhängig davon, welche Felder gesetzt sind.

**Warum?**  
Diese Regel stellt sicher, dass die Anzahl der Dosierungen pro Periode korrekt mit den angegebenen Zeitpunkten übereinstimmt. So wird verhindert, dass widersprüchliche oder unklare Dosierungsangaben entstehen.

{% include dosage-constraint-TimingFrequencyCount-examples.md%}

### TimingPeriodUnit

**Beschreibung:**  
Wenn Wochentage (`dayOfWeek`) angegeben sind, muss die Zeiteinheit (`periodUnit`) "Woche" (`wk`) sein, andernfalls "Tag" (`d`).

**Warum?**  
Dadurch wird sichergestellt, dass die Zeiteinheit zur Angabe der Dosierungsperiode konsistent zu den verwendeten Feldern passt und keine Missverständnisse bei der Interpretation entstehen.


{% include dosage-constraint-TimingPeriodUnit-examples.md%}

### TimingOnlyOneType

**Beschreibung:**  
Es darf pro Dosierung nur eine Art der Zeitangabe verwendet werden (z.B. ausschließlich `4-Schema`, `TimeOfDay`, `DayOfWeek`, `Interval`, Kombinationen wie `DayOfWeek+TimeOfDay` oder `Interval+TimeOfDay`).

**Warum?**  
Diese Einschränkung verhindert Mehrdeutigkeiten und sorgt dafür, dass die Dosierungszeitpunkte eindeutig interpretierbar bleiben.

{% include dosage-constraint-TimingOnlyOneType-examples.md%}

### TimingOnlyOneWhen

**Beschreibung:**  
Es darf nicht derselbe Zeitraum des Tages (`when`) in mehreren Dosierungsinstanzen vorkommen.

**Warum?**  
Dadurch wird verhindert, dass Dosierungen mehrfach für denselben Zeitraum angegeben werden, was zu Überdosierung oder Verwirrung führen könnte.

{% include dosage-constraint-TimingOnlyOneWhen-examples.md%}

### TimingOnlyWhenOrTimeOfDay

**Beschreibung:**  
Es darf nicht die Tageszeit `timeOfDay` und der Zeitraum des Tages `when` in mehreren Dosierungsinstanzen gleichzeitig vorkommen.

**Warum?**  
Dadurch wird verhindert, dass Dosierungen gemischte Schemata anzeigen.

{% include dosage-constraint-TimingOnlyWhenOrTimeOfDay-examples.md%}

### TimingOnlyOneTimeOfDay

**Beschreibung:**  
Es darf nicht dieselbe Tageszeit (`timeOfDay`) in mehreren Dosierungsinstanzen vorkommen.

**Warum?**  
Auch hier wird sichergestellt, dass Dosierungen nicht mehrfach für dieselbe Uhrzeit definiert werden, um Redundanzen und Fehler zu vermeiden.

{% include dosage-constraint-TimingOnlyOneTimeOfDay-examples.md%}

### TimingOnlyOneDayOfWeek

**Beschreibung:**  
Es darf nicht derselbe Wochentag (`dayOfWeek`) in mehreren Dosierungsinstanzen vorkommen.

**Warum?**  
Dies verhindert doppelte Einträge für denselben Wochentag und stellt eine eindeutige Zuordnung sicher.

{% include dosage-constraint-TimingOnlyOneDayOfWeek-examples.md%}

### TimingOnlyOneBounds

**Beschreibung:**  
Für die Dauer (`bounds` vom Typ `Duration`) dürfen pro Ressource nur ein Wert und ein Code vorkommen.

**Warum?**  
So wird ausgeschlossen, dass mehrere unterschiedliche Zeiträume für eine Dosierung angegeben werden, was die Interpretation erschweren würde.

{% include dosage-constraint-TimingOnlyOneBounds-examples.md%}

### TimingIntervalOnlyOneFrequency

**Beschreibung:**  
Bei Intervallangaben darf es nur eine Dosierungsinstanz geben.

**Warum?**  
Dadurch wird verhindert, dass ein Intervall mehrfach beschrieben wird, was zu widersprüchlichen Angaben führen könnte.

{% include dosage-constraint-TimingIntervalOnlyOneFrequency-examples.md%}

### TimingOnlyOnePeriodForDayOfWeek

**Beschreibung:**  
Wenn für einen Wochentag mehrere Einträge existieren, müssen sich deren Zeitangaben (`when`/`timeOfDay`) unterscheiden.

**Warum?**  
Dies stellt sicher, dass für jeden Wochentag die Dosierungszeitpunkte eindeutig sind und keine Dopplungen auftreten.

{% include dosage-constraint-TimingOnlyOnePeriodForDayOfWeek-examples.md%}

### TimingOnlyOneTimeForInterval

**Beschreibung:**  
Bei Intervallangaben mit Zeitpunkten (`when` oder `timeOfDay`) dürfen die Zeitangaben nicht mehrfach vorkommen und die Periodenangaben müssen eindeutig sein.

**Warum?**  
Damit wird verhindert, dass für ein Intervall mehrere widersprüchliche Zeitpunkte oder Perioden definiert werden.

{% include dosage-constraint-TimingOnlyOneTimeForInterval-examples.md%}