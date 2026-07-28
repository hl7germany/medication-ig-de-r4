: '
Abfolge der Erstellung von Ressourcen und Dokumenten

1. Sushi baut alle Artefakte von FSH zu FHIR Ressourcen
2. Dosage generate erzeugt für die Dosierung einen Text nach medication-dosage-to-text.py
'

# Generate Sushi
sushi .

# Build Dosage Files
python3 scripts/dosage-main.py

# Generate IG Publisher Content
./_genonce.sh -no-sushi

# Run Error checks
python3 scripts/ig-expected-error-check.py
