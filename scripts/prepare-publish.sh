#!/usr/bin/env bash
echo "Starte Prepare-Publish-Skript: $(date '+%Y-%m-%d %H:%M:%S')"

# Zielordner immer neu anlegen
rm -rf medication-no-sushi
mkdir -p medication-no-sushi

# 2) output, custom-template und input rekursiv kopieren
cp -r output medication-no-sushi/
cp -r custom-template medication-no-sushi/
cp -r input medication-no-sushi/

# 3) Danach den Ordner fsh im kopierten input leeren
rm -rf medication-no-sushi/input/fsh/*

# 4) Ressourcen und Includes aus FSH-Generierung übernehmen
mkdir -p medication-no-sushi/input/resources
mkdir -p medication-no-sushi/input/examples

# Kopiere alle Ressourcen mit Namen beginnend mit "Medication" in examples
find fsh-generated/resources -maxdepth 1 -type f -name 'Medication*' -exec cp {} medication-no-sushi/input/examples/ \;
# Kopiere alle anderen Ressourcen in resources
find fsh-generated/resources -maxdepth 1 -type f ! -name 'Medication*' -exec cp {} medication-no-sushi/input/resources/ \;

# Entfernen der automatisch generierten ImplementationGuide-Dateien
rm medication-no-sushi/input/resources/ImplementationGuide*.json

mkdir -p medication-no-sushi/input/includes

# 5) Konfigurationsdateien übernehmen
cp sushi-config.yaml medication-no-sushi/
cp ig.ini medication-no-sushi/
cp publication-request.json medication-no-sushi/
echo "Fertig mit Prepare-Publish-Skript: $(date '+%Y-%m-%d %H:%M:%S')"