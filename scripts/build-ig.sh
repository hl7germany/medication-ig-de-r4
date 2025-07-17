: '
Abfolge der Erstellung von Ressourcen und Dokumenten

1. Sushi baut alle Artefakte von FSH zu FHIR Ressourcen
2. Dosage generate erzeugt für jede Dosierung eine Dosage Beschreibung nach dosage-to-text.py
'

# Generate Sushi
sushi .

# Build Dosage Files
python3 scripts/dosage-main.py

# Copy current script into the IG
rm input/content/dosage-to-text.py
cp scripts/dosage-to-text.py input/content

# Generate IG Publisher Content
./_genonce.sh -no-sushi

# Run Error checks
python3 scripts/ig-expected-error-check.py