#!/usr/bin/env bash
set -euo pipefail

: '
Abfolge der Erstellung von Ressourcen und Dokumenten

1. Sushi baut alle Artefakte von FSH zu FHIR Ressourcen
2. Dosage generate erzeugt für die Dosierung einen Text nach dem in
   scripts/dosage-algorithm.lock gepinnten Textgenerierungs-Algorithmus
3. Der IG Publisher erzeugt die Seiten
4. Die erwarteten Fehler werden gegen qa.xml geprüft

Existiert der gepinnte Tag noch nicht, weicht Schritt 2 auf main des
Algorithmus-Repositories aus. Der Build läuft dann durch, ist aber nicht
reproduzierbar — darauf weist die Ausgabe am Ende hin.
'

MARKER="scripts/vendor/UNPINNED"
rm -f "$MARKER"

# Generate Sushi
sushi .

# Build Dosage Files
python3 scripts/dosage-main.py

# Generate IG Publisher Content
./_genonce.sh -no-sushi

# Run Error checks
python3 scripts/ig-expected-error-check.py

# Am Ende, damit der Hinweis nicht im Build-Log verschwindet
if [[ -f "$MARKER" ]]; then
    LINE=$(printf '=%.0s' {1..78})
    printf '\n%s\n' "$LINE" >&2
    printf '  ACHTUNG: DIESER BUILD IST NICHT REPRODUZIERBAR\n\n' >&2
    sed 's/^/  /' "$MARKER" >&2
    printf '\n  Die erzeugten Texte tragen eine algorithmVersion, die so nicht\n' >&2
    printf '  veroeffentlicht ist. Nicht als Release publizieren - erst den Tag\n' >&2
    printf '  im Algorithmus-Repository anlegen und die Pruefsumme in\n' >&2
    printf '  scripts/dosage-algorithm.lock nachziehen.\n' >&2
    printf '%s\n\n' "$LINE" >&2
fi
