#!/usr/bin/env python3
"""Prüft, ob die auf der Seite genannte Algorithmusversion noch stimmt.

`dosierung-textgenerierung.md` nennt die Version, mit der die Beispieltexte
erzeugt wurden. Die Angabe dient der Nachvollziehbarkeit — sie ist wertlos,
sobald sie von der tatsächlich verwendeten Version abweicht, und das fällt
sonst niemandem auf: Der Build läuft durch, die Seite behauptet nur etwas
Falsches.

Verglichen werden drei Stellen, die übereinstimmen müssen:

* `__version__` des Skripts, das der Build tatsächlich verwendet — dieser Wert
  landet als `algorithmVersion` in jeder Ressource
* der Tag in `dosage-algorithm.lock`
* die Version im Text und im Release-Link der Seite

Aufruf: check-documented-version.py <pfad-zum-algorithmus-skript>
"""

import ast
import json
import os
import re
import sys

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
LOCK_PATH = os.path.join(BASE_DIR, "dosage-algorithm.lock")
PAGE_PATH = os.path.normpath(
    os.path.join(BASE_DIR, "..", "input", "pagecontent", "dosierung-textgenerierung.md")
)
YELLOW, RED, GREEN, RESET = "\033[33m", "\033[31m", "\033[32m", "\033[0m"


def script_version(path):
    tree = ast.parse(open(path, "r", encoding="utf-8").read())
    for node in tree.body:
        if isinstance(node, ast.Assign):
            for target in node.targets:
                if isinstance(target, ast.Name) and target.id == "__version__":
                    return node.value.value
    sys.exit(f"__version__ nicht gefunden in {path}")


def page_versions(text):
    """Alle Versionsangaben der Seite: Fließtext und Release-Link."""
    found = set()
    # **[<version>](…/releases/tag/<version>)**
    for m in re.finditer(r'\*\*\[([^\]]+)\]\(([^)]*/releases/tag/([^)/]+))\)\*\*', text):
        found.add(("Text", m.group(1)))
        found.add(("Release-Link", m.group(3)))
    return found


def main():
    if len(sys.argv) < 2:
        sys.exit("Aufruf: check-documented-version.py <pfad-zum-algorithmus-skript>")
    used = script_version(sys.argv[1])

    with open(LOCK_PATH, "r", encoding="utf-8") as handle:
        lock_tag = json.load(handle)["tag"]

    with open(PAGE_PATH, "r", encoding="utf-8") as handle:
        page = handle.read()
    stellen = page_versions(page)

    if not stellen:
        sys.exit(
            f"{RED}FEHLER: {os.path.basename(PAGE_PATH)} nennt keine Algorithmusversion.{RESET}\n"
            "  Erwartet wird die Form **[<version>](…/releases/tag/<version>)**."
        )

    abweichung = sorted({(wo, v) for wo, v in stellen if v != used})
    if abweichung or lock_tag != used:
        print(f"{RED}FEHLER: Die dokumentierte Algorithmusversion weicht ab.{RESET}", file=sys.stderr)
        print(f"{YELLOW}  tatsaechlich verwendet (__version__): {used}{RESET}", file=sys.stderr)
        if lock_tag != used:
            print(f"{YELLOW}  dosage-algorithm.lock (tag):         {lock_tag}{RESET}", file=sys.stderr)
        for wo, v in abweichung:
            print(f"{YELLOW}  {os.path.basename(PAGE_PATH)} ({wo}): {v}{RESET}", file=sys.stderr)
        print("  Die Angabe dient der Nachvollziehbarkeit und ist wertlos, wenn sie\n"
              "  nicht mit der Version uebereinstimmt, die in den Ressourcen steht.",
              file=sys.stderr)
        sys.exit(1)

    print(f"{GREEN}Dokumentierte Algorithmusversion geprueft: {used} "
          f"in Skript, Lock und Seite.{RESET}")


if __name__ == "__main__":
    main()
