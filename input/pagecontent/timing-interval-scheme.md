# Schema für Wiederkehrendes Zeitinterval

Dieses Schema basiert auf definierten Zeitabständen zwischen den einzelnen Anwendungen, die sich periodisch wiederholen. Diese Zeitabstände können in verschiedenen Zeiteinheiten angegeben werden, also z.B. in Stunden, Tagen oder Wochen.  Im einfachsten Zustand wiederholt sich das Schema ohne Variation über einen unbefristeten Zeitraum und trifft bspw. keine Aussage darüber, zu welchen Tages- oder Uhrzeiten das Arzneimittel an den betreffenden Tagen anzuwenden ist.

Es wird ermöglicht, die Anzahl in „Stück“ des Arzneimittels, die in einer definierten Zeiteinheit anzuwenden sind, festzulegen. [X] Stück pro [X] [Zeiteinheit]

Alle Anwendungsfälle gehen davon aus, dass die Anzahl pro Zeiteinheit nicht variiert.

Es wird ermöglicht, die geplante Dauer der Anwendung zu begrenzen.   

Folgende Beispiele sind in diesem IG dargestellt:

| Beispiel    | Beipspiel Datei |
| -------- | ------- |
| 1 Tablette alle 8 Stunden  | [Example-MR-Dosage-interval-8h](./MedicationRequest-Example-MR-Dosage-interval-8h.html)    |  |
| 1 Tablette alle 2 Wochen  | [Example-MR-Dosage-interval-2wk](./MedicationRequest-Example-MR-Dosage-interval-2wk.html)    |
| 4 x 1 Tablette pro Tag  | [Example-MR-Dosage-interval-4times-d](./MedicationRequest-Example-MR-Dosage-interval-4times-d.html)    |
| Alle 3 Tage 1 Tablette  | [Example-MR-Dosage-interval-3d](./MedicationRequest-Example-MR-Dosage-interval-3d.html)    |
| Alle 2 Tage 2 Tabletten für 6 Wochen  | [Example-MR-Dosage-interval-2t-bound](./MedicationRequest-Example-MR-Dosage-interval-2t-bound.html)    |

## Angabe und Erkennung der Dosierart

Diese Dosierungsart wird daran erkannt, dass folgende Felder unter ´Dosage.timing.repeat´ angegeben sind:
- frequency
- period
- periodUnit

An diesen Feldern wird kodiert der Zeitinterval angegeben an der eine konkrete Dosierung einzunehmen ist.

Lesende Systeme werten entsprechend auch ´Dosage.timing.repeat´ aus. Wenn ausschließlich die oben genannten Felder angegeben sind, ist dem Nutzer anzuzeigen, dass die Dosierung nach einem Interval definiert ist.
