import os
import subprocess
import sys

def process_files(input_folder, script_path):
    # Nur Dateien mit Prefix und keine Verzeichnisse
    files = [
        f for f in os.listdir(input_folder)
        if f.startswith('MedicationRequest-')
        and os.path.isfile(os.path.join(input_folder, f))
        and 'Invalid' not in f
        and 'Valid' not in f
    ]

    rows = []
    for filename in files:
        file_path = os.path.join(input_folder, filename)
        try:
            # Relativen Pfad verwenden, damit alles von der Konsole aus funktioniert
            rel_file_path = os.path.relpath(file_path)
            # Skript aufrufen und Ausgabe holen
            result = subprocess.check_output(['python3', script_path, rel_file_path], text=True).strip()
            # Zeilenumbrüche für Markdown ersetzen
            result = result.replace('\n', '<br>')
        except Exception as e:
            result = f"Fehler beim Verarbeiten der Datei: {e}"
        filename_no_ext = os.path.splitext(filename)[0]
        md_link = f"[{filename_no_ext}](./{filename})"
        rows.append(f"|{md_link} | {result} |")
    header = "| Beispiel | Ergebnis |\n| :---: | :---:|"
    table = header + "\n" + "\n".join(rows)
    return table

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python3 this_script.py <input_folder> <script_path>")
        sys.exit(1)
    input_folder = sys.argv[1]
    script_path = sys.argv[2]
    table = process_files(input_folder, script_path)
    print(table)
