#!/usr/bin/env bash
set -euo pipefail

: '
Abfolge der Erstellung von Ressourcen und Dokumenten

1. Sushi baut alle Artefakte von FSH zu FHIR Ressourcen
2. Dosage generate erzeugt für die Dosierung einen Text nach dem in
   scripts/dosage-algorithm.lock gepinnten Textgenerierungs-Algorithmus
3. Der IG Publisher erzeugt die Seiten
4. Die erwarteten Fehler werden gegen qa.xml geprüft

Verwendung:
  scripts/build-ig.sh                 gepinnte Version aus dosage-algorithm.lock
  scripts/build-ig.sh --algo main     Stand eines Branches, Tags oder Commits
  scripts/build-ig.sh --algo local    die Arbeitskopie in scripts/

--algo umgeht das Pinning und ist für die Weiterentwicklung des Algorithmus
gedacht. Der Build ist dann nicht reproduzierbar, und die erzeugte
algorithmVersion bezeichnet eine so nicht veröffentlichte Version. Solche
Stände gehören nicht in eine Veröffentlichung.
'

usage() {
    sed -n '/^Verwendung:/,/^--algo/p' "$0" | sed 's/^/  /'
    exit "${1:-0}"
}

while [[ $# -gt 0 ]]; do
    case "$1" in
        --algo)
            [[ $# -ge 2 ]] || { echo "--algo braucht einen Wert (z. B. main, local, 2.0.0)" >&2; exit 2; }
            export DOSAGE_ALGORITHM_REF="$2"
            shift 2
            ;;
        --algo=*)
            export DOSAGE_ALGORITHM_REF="${1#*=}"
            shift
            ;;
        -h|--help)
            usage 0
            ;;
        *)
            echo "Unbekannte Option: $1" >&2
            usage 2
            ;;
    esac
done

# Generate Sushi
sushi .

# Build Dosage Files
python3 scripts/dosage-main.py

# Generate IG Publisher Content
./_genonce.sh -no-sushi

# Run Error checks
python3 scripts/ig-expected-error-check.py
