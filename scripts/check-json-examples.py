#!/usr/bin/env python3
"""Prüft die von Hand gepflegten JSON-Beispiele unter input/examples.

Manche Beispiele lassen sich nicht in FSH schreiben: SUSHI verwirft beim Export
nachfolgende Nullen (2.50 -> 2.5, siehe check-fsh-decimals.py), FHIR betrachtet
die Genauigkeit eines decimal aber als Teil des Werts. Solche Beispiele liegen
als JSON unter input/examples. Der Build-Schritt dosage-add-extension.py
verarbeitet nur fsh-generated/resources; deshalb tragen diese Beispiele
Dosierungstext und Algorithmusversion fest in sich.

Diese Prüfung stellt sicher, dass der eingetragene Text dem entspricht, den der
gepinnte Algorithmus (scripts/dosage-algorithm.lock) erzeugt, und dass die
eingetragene algorithmVersion dessen Version ist. Ändert sich der Algorithmus,
schlägt sie fehl, statt ein veraltetes Beispiel stillschweigend zu
veröffentlichen.

Aufruf: python3 check-json-examples.py <medication-dosage-to-text.py>
"""

import ast
import json
import os
import subprocess
import sys

EXAMPLES_DIR = os.path.normpath(os.path.join(os.path.dirname(os.path.abspath(__file__)), "../input/examples"))
RESOURCE_TYPES = ("MedicationRequest", "MedicationDispense", "MedicationStatement")
RENDERED_URL = "http://hl7.org/fhir/5.0/StructureDefinition/extension-{}.renderedDosageInstruction"
META_URL = "http://ig.fhir.de/igs/medication/StructureDefinition/GeneratedDosageInstructionsMeta"

YELLOW, RED, GREEN, RESET = "\033[33m", "\033[31m", "\033[32m", "\033[0m"


def script_version(script_path):
    tree = ast.parse(open(script_path, encoding="utf-8").read())
    for node in tree.body:
        if isinstance(node, ast.Assign) and any(getattr(t, "id", None) == "__version__" for t in node.targets):
            return node.value.value
    return None


def embedded(resource):
    """(Text, algorithmVersion) aus den Extensions der Ressource."""
    text = version = None
    for extension in resource.get("extension", []):
        if extension.get("url") == RENDERED_URL.format(resource["resourceType"]):
            text = extension.get("valueMarkdown")
        if extension.get("url") == META_URL:
            for sub in extension.get("extension", []):
                if sub.get("url") == "algorithmVersion":
                    version = sub.get("valueString")
    return text, version


def main():
    if len(sys.argv) != 2:
        sys.exit("Aufruf: python3 check-json-examples.py <medication-dosage-to-text.py>")
    script = sys.argv[1]
    if not os.path.isdir(EXAMPLES_DIR):
        print(f"{GREEN}Keine JSON-Beispiele unter input/examples.{RESET}")
        return
    pinned_version = script_version(script)

    problems, checked = [], 0
    for name in sorted(os.listdir(EXAMPLES_DIR)):
        if not name.endswith(".json") or not name.startswith(RESOURCE_TYPES):
            continue
        path = os.path.join(EXAMPLES_DIR, name)
        # Text und Version direkt aus der Datei; die CLI des Skripts liest mit
        # parse_float=Decimal und erhält damit die Genauigkeit des Werts.
        resource = json.load(open(path, encoding="utf-8"))
        text, version = embedded(resource)
        result = subprocess.run([sys.executable, script, path], capture_output=True, text=True)
        generated = result.stdout.strip() if result.returncode == 0 else None
        checked += 1
        if result.returncode != 0:
            problems.append((name, f"Textgenerierung bricht ab: {(result.stderr or result.stdout).strip()}"))
        elif text != generated:
            problems.append((name, f"eingetragen: {text!r}\n      erzeugt:     {generated!r}"))
        if version != pinned_version:
            problems.append((name, f"algorithmVersion {version!r}, gepinnt ist {pinned_version!r}"))

    if problems:
        print(f"{RED}FEHLER: JSON-Beispiele unter input/examples passen nicht zum gepinnten "
              f"Algorithmus {pinned_version}:{RESET}", file=sys.stderr)
        for name, message in problems:
            print(f"{YELLOW}  {name}{RESET}\n      {message}", file=sys.stderr)
        print("  Text und algorithmVersion in der Datei an den gepinnten Algorithmus anpassen.", file=sys.stderr)
        sys.exit(1)
    print(f"{GREEN}JSON-Beispiele geprüft: {checked}, Text und Version passen zum gepinnten "
          f"Algorithmus {pinned_version}.{RESET}")


if __name__ == "__main__":
    main()
