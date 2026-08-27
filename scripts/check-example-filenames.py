#!/usr/bin/env python3
"""Prüft die Dateinamen der generierten Beispiele, bevor der IG Publisher läuft.

Zwei Bedingungen stehen in Spannung zueinander, und beide brechen erst spät im
Build ab — der Publisher läuft über eine Minute, bevor er es merkt, und seine
Meldungen zeigen nicht auf die Ursache:

1. Der Publisher packt jede Ressource als `package/example/<Datei>.json` in ein
   tar. Dessen Namensfeld fasst 100 Byte; darüber bricht er mit einer
   IllegalArgumentException ab.

2. Die Include-Dateien der Constraint-Tabellen werden nicht nach der Invariante
   benannt, sondern über deren Namen im Dateinamen des Beispiels gefunden
   (`-C-<Name>` für Fehler, `-W-<Name>` für Warnungen, siehe
   dosage-generate-constraint-matrix.py). Wird der Name im Beispiel gekürzt,
   entsteht die Include-Datei nicht und Jekyll bricht ab.

Ein Beispielname muss also kurz genug fürs tar sein und zugleich den
vollständigen Namen seiner Invariante tragen. Diese Prüfung meldet beides in
Sekunden statt nach einem Fehlschlag im Publisher.
"""

import json
import os
import re
import sys

TAR_NAME_LIMIT = 100
PACKAGE_PREFIX = "package/example/"
RESOURCE_TYPES = ("MedicationRequest-", "MedicationDispense-", "MedicationStatement-")
MARKER = re.compile(r"-[CW]-(.+?)(?=-|\.json$)")

YELLOW, RED, GREEN, RESET = "\033[33m", "\033[31m", "\033[32m", "\033[0m"


def invariant_keys(folder):
    """Alle in den Profilen definierten Constraint-Schlüssel."""
    keys = set()
    for name in os.listdir(folder):
        if not name.startswith("StructureDefinition-") or not name.endswith(".json"):
            continue
        with open(os.path.join(folder, name), "r", encoding="utf-8") as handle:
            sd = json.load(handle)
        for section in ("snapshot", "differential"):
            for element in sd.get(section, {}).get("element", []) or []:
                for constraint in element.get("constraint", []) or []:
                    if constraint.get("key"):
                        keys.add(constraint["key"])
    return keys


def marker_key(filename, keys):
    """Der Invariantenname aus -C-/-W-, längster Treffer gewinnt.

    Der nicht-gierige Ausdruck allein genügt nicht: Namen wie `dos-1` oder
    `ExtRequiresDosage-MR` enthalten selbst einen Bindestrich.
    """
    match = re.search(r"-[CW]-", filename)
    if not match:
        return None
    rest = filename[match.end():].removesuffix(".json")
    candidates = [k for k in keys if rest == k or rest.startswith(k + "-")]
    return max(candidates, key=len) if candidates else rest.split("-")[0]


def main():
    folder = sys.argv[1] if len(sys.argv) > 1 else os.path.normpath(
        os.path.join(os.path.dirname(os.path.abspath(__file__)), "../fsh-generated/resources")
    )
    if not os.path.isdir(folder):
        sys.exit(f"Ressourcenverzeichnis nicht gefunden: {folder}")

    keys = invariant_keys(folder)
    too_long, unknown_marker = [], []

    for name in sorted(os.listdir(folder)):
        if not name.endswith(".json") or not name.startswith(RESOURCE_TYPES):
            continue

        length = len((PACKAGE_PREFIX + name).encode("utf-8"))
        if length >= TAR_NAME_LIMIT:
            too_long.append((length, name))

        if re.search(r"-[CW]-", name):
            key = marker_key(name, keys)
            if key and key not in keys:
                unknown_marker.append((key, name))

    if too_long:
        print(f"{RED}FEHLER: Beispielnamen sprengen das tar-Limit des Publishers "
              f"({TAR_NAME_LIMIT} Byte inkl. '{PACKAGE_PREFIX}'):{RESET}", file=sys.stderr)
        for length, name in sorted(too_long, reverse=True):
            print(f"{YELLOW}  {length} Byte  {name}{RESET}", file=sys.stderr)
        print("  Kürze den Typ-Marker (Request -> MR, Dispense -> MD, Statement -> MS),\n"
              "  nicht den Namen der Invariante — der wird zum Auffinden gebraucht.",
              file=sys.stderr)

    if unknown_marker:
        print(f"{RED}FEHLER: -C-/-W-Marker ohne zugehörige Invariante — "
              f"die Constraint-Tabelle entstünde nicht:{RESET}", file=sys.stderr)
        for key, name in unknown_marker:
            print(f"{YELLOW}  '{key}' in {name}{RESET}", file=sys.stderr)

    if too_long or unknown_marker:
        sys.exit(1)

    print(f"{GREEN}Beispielnamen geprüft: alle unter {TAR_NAME_LIMIT} Byte, "
          f"alle Marker gehören zu einer Invariante.{RESET}")


if __name__ == "__main__":
    main()
