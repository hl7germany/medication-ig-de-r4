: '
Abfolge der Erstellung von Ressourcen und Dokumenten

1. Sushi baut alle Artefakte von FSH zu FHIR Ressourcen
2. Dosage generate erzeugt für die Dosierung einen Text nach medication-dosage-to-text.py
'

# Generate Sushi
# SUSHI 3.18.1 wie für 1.0.6/1.0.7: neuere Versionen ersetzen hl7.fhir.extensions.r5
# durch die Abhängigkeit hl7.fhir.uv.xver-r5.r4
npx -y fsh-sushi@3.18.1 .

# Build Dosage Files
python3 scripts/dosage-main.py

# Copy current scripts into the IG
rm input/content/medication-dosage-to-text.py
cp scripts/medication-dosage-to-text.py input/content

# Generate IG Publisher Content
./_genonce.sh -no-sushi

# Run Error checks
python3 scripts/ig-expected-error-check.py