#!/usr/bin/env python3
"""Prüft FSH-Quellen auf Dezimalzahlen mit nachfolgender Null, bevor SUSHI läuft.

FHIR legt fest, dass die Genauigkeit eines decimal einschließlich nachfolgender
Nullen Bedeutung trägt (0.010 ist nicht 0.01) und auch für die Darstellung zu
erhalten ist. SUSHI (geprüft mit 3.20.1) verwirft sie beim Export nach JSON:
aus `2.50 'mg'` wird `"value": 2.5`, aus `period = 1.0` wird `1`. Es gibt keine
Option dagegen.

Die Folge wäre eine stille Abweichung zwischen Quelle und Ausgabe: Wer im FSH
`1.0` schreibt, bekommt im IG den Dosierungstext `je 1 Stück`, nicht
`je 1,0 Stück`. Diese Prüfung meldet solche Werte, damit FSH und erzeugtes
JSON übereinstimmen. Ein Beispiel, das eine nachfolgende Null tatsächlich
zeigen soll, muss als JSON unter input/resources gepflegt werden.
"""

import os
import re
import sys

# Dezimalliteral mit nachfolgender Null rechts eines Zuweisungs-"=":
# "= 2.50", "= 1.0 'mg'", "= -0.10". Ganze Zahlen (10, 100) sind nicht betroffen.
TRAILING_ZERO = re.compile(r"=\s*(-?\d+\.\d*0)(?![\d.])")
QUOTED = re.compile(r'"(?:[^"\\]|\\.)*"')

YELLOW, RED, GREEN, RESET = "\033[33m", "\033[31m", "\033[32m", "\033[0m"


def find_trailing_zeros(path):
    """Alle (Zeilennummer, Literal, Zeile) mit nachfolgender Null in einer FSH-Datei."""
    hits = []
    with open(path, encoding="utf-8") as handle:
        for number, line in enumerate(handle, start=1):
            code = line.split("//", 1)[0]
            # Strings (Versionen wie "1.0.0", Beschreibungen) nicht prüfen
            code = QUOTED.sub('""', code)
            for match in TRAILING_ZERO.finditer(code):
                hits.append((number, match.group(1), line.rstrip()))
    return hits


def main():
    folder = sys.argv[1] if len(sys.argv) > 1 else os.path.normpath(
        os.path.join(os.path.dirname(os.path.abspath(__file__)), "../input/fsh")
    )
    if not os.path.isdir(folder):
        sys.exit(f"FSH-Verzeichnis nicht gefunden: {folder}")

    findings = []
    for root, _, files in os.walk(folder):
        for name in sorted(files):
            if not name.endswith(".fsh"):
                continue
            path = os.path.join(root, name)
            for number, literal, line in find_trailing_zeros(path):
                findings.append((os.path.relpath(path, folder), number, literal, line))

    if findings:
        print(f"{RED}FEHLER: Dezimalzahlen mit nachfolgender Null im FSH — SUSHI verwirft "
              f"sie beim Export, Quelle und erzeugtes JSON wichen ab:{RESET}", file=sys.stderr)
        for path, number, literal, line in findings:
            print(f"{YELLOW}  {path}:{number}  {literal}{RESET}", file=sys.stderr)
            print(f"    {line.strip()}", file=sys.stderr)
        print("  Schreibe den Wert ohne nachfolgende Null (1.0 -> 1, 2.50 -> 2.5). Soll die\n"
              "  Null im Beispiel sichtbar sein, pflege es als JSON unter input/resources.",
              file=sys.stderr)
        sys.exit(1)

    print(f"{GREEN}FSH-Dezimalzahlen geprüft: keine nachfolgende Null, die SUSHI verwerfen würde.{RESET}")


if __name__ == "__main__":
    main()
