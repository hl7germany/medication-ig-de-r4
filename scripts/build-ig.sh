: '
Abfolge der Erstellung von Ressourcen und Dokumenten

1. Sushi baut alle Artefakte von FSH zu FHIR Ressourcen
2. Dosage generate erzeugt für jede Dosierung eine Dosage Beschreibung nach dosage-to-text.py
'

# Generate Sushi
sushi .

# Build Dosage Files
python3 scripts/run-dosage-generate.py

# Generate IG Publisher Content
./_genonce.sh -no-sushi