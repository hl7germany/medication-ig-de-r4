#!/usr/bin/env python3
"""Prüft Dosiereinheiten gegen das KBV-CodeSystem KBV_CS_SFHIR_BMP_DOSIEREINHEIT.

Die dgMP-Profile binden die Dosis `required` an das KBV-ValueSet. Der IG hängt
aber nicht vom KBV-Paket ab, deshalb kennt der IG Publisher das ValueSet nicht
und prüft die Codes der Beispiele nicht ("ValueSet ... not found"). Diese
Prüfung lädt das CodeSystem aus dem in kbv-dosiereinheit.lock gepinnten Paket,
nur für den Test, und prüft:

1. Die Invarianten DosageDoseUnitMatchesCode und DosageDoseUnitMatchesCodeWarning
   führen genau die Codes des CodeSystems mit ihrem Anzeigetext.
2. Jede Dosis mit dem KBV-System in den Beispielen hat einen Code des
   CodeSystems (MedicationRequest, MedicationDispense, MedicationStatement).
   Ob die Einheit zum Code passt, prüfen die Invarianten selbst;
   Negativbeispiele dafür sind also erlaubt.

Aufruf: python3 check-kbv-dosiereinheit.py <Verzeichnis mit Ressourcen>
"""

import glob
import hashlib
import io
import json
import os
import re
import sys
import tarfile
import urllib.error
import urllib.request

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
LOCK_PATH = os.path.join(BASE_DIR, "kbv-dosiereinheit.lock")
VENDOR_DIR = os.path.join(BASE_DIR, "vendor")
FSH_DIR = os.path.normpath(os.path.join(BASE_DIR, "../input/fsh"))
EXAMPLES_DIR = os.path.normpath(os.path.join(BASE_DIR, "../input/examples"))
REGISTRY_URL = "https://packages.fhir.org/{package}/{version}"
SYSTEM = "https://fhir.kbv.de/CodeSystem/KBV_CS_SFHIR_BMP_DOSIEREINHEIT"
INVARIANTS = ("DosageDoseUnitMatchesCode", "DosageDoseUnitMatchesCodeWarning")
RESOURCE_TYPES = ("MedicationRequest", "MedicationDispense", "MedicationStatement")
PAIR = re.compile(r"\(code = '([^']*)' and unit = '([^']*)'\)")

YELLOW, RED, GREEN, RESET = "\033[33m", "\033[31m", "\033[32m", "\033[0m"


def fail(message, details=()):
    print(f"{RED}FEHLER: {message}{RESET}", file=sys.stderr)
    for line in details:
        print(f"{YELLOW}  {line}{RESET}", file=sys.stderr)
    sys.exit(1)


def load_codesystem():
    with open(LOCK_PATH, encoding="utf-8") as handle:
        lock = json.load(handle)
    cache = os.path.join(VENDOR_DIR, f"{lock['package']}-{lock['version']}.tgz")
    if not os.path.exists(cache):
        url = REGISTRY_URL.format(**lock)
        try:
            with urllib.request.urlopen(url, timeout=60) as response:
                data = response.read()
        except (urllib.error.HTTPError, urllib.error.URLError) as error:
            fail(f"Download von {url} fehlgeschlagen: {error}")
        os.makedirs(VENDOR_DIR, exist_ok=True)
        with open(cache, "wb") as handle:
            handle.write(data)
    with tarfile.open(cache, "r:gz") as archive:
        try:
            raw = archive.extractfile(lock["file"]).read()
        except KeyError:
            fail(f"{lock['file']} fehlt in {lock['package']}#{lock['version']}.")
    actual = hashlib.sha256(raw).hexdigest()
    if actual != lock["sha256"]:
        fail(f"Prüfsumme von {lock['file']} aus {lock['package']}#{lock['version']} weicht ab.",
             [f"erwartet: {lock['sha256']}", f"geladen:  {actual}"])
    codesystem = json.loads(raw)
    return lock, {concept["code"]: concept["display"] for concept in codesystem["concept"]}


def invariant_pairs(name):
    """Code-Einheit-Paare aus dem Ausdruck der Invariante in den FSH-Dateien."""
    for path in glob.glob(os.path.join(FSH_DIR, "**", "*.fsh"), recursive=True):
        text = open(path, encoding="utf-8").read()
        match = re.search(rf"^Invariant: {name}\n(.*?)(?=^Invariant: |^Profile: |\Z)", text, re.S | re.M)
        if match:
            return PAIR.findall(match.group(1))
    return None


def kbv_codes(node):
    if isinstance(node, dict):
        if node.get("system") == SYSTEM and "code" in node:
            yield node["code"]
        for value in node.values():
            yield from kbv_codes(value)
    elif isinstance(node, list):
        for value in node:
            yield from kbv_codes(value)


def main():
    if len(sys.argv) != 2:
        sys.exit("Aufruf: python3 check-kbv-dosiereinheit.py <Verzeichnis mit Ressourcen>")
    lock, codes = load_codesystem()
    problems = []

    for name in INVARIANTS:
        pairs = invariant_pairs(name)
        if pairs is None:
            problems.append(f"Invariante {name} nicht gefunden.")
            continue
        listed = dict(pairs)
        if len(listed) != len(pairs):
            problems.append(f"{name}: ein Code steht mehrfach im Ausdruck.")
        for code, display in sorted(codes.items()):
            if code not in listed:
                problems.append(f"{name}: Code {code!r} ({display}) fehlt im Ausdruck.")
            elif listed[code] != display:
                problems.append(f"{name}: Code {code!r} mit {listed[code]!r}, das CodeSystem nennt {display!r}.")
        for code in sorted(set(listed) - set(codes)):
            problems.append(f"{name}: Code {code!r} gibt es im CodeSystem nicht.")

    checked = 0
    paths = sorted(glob.glob(os.path.join(sys.argv[1], "*.json")) + glob.glob(os.path.join(EXAMPLES_DIR, "*.json")))
    for path in paths:
        resource = json.load(open(path, encoding="utf-8"))
        if resource.get("resourceType") not in RESOURCE_TYPES:
            continue
        for code in kbv_codes(resource):
            checked += 1
            if code not in codes:
                problems.append(f"{os.path.basename(path)}: Code {code!r} gibt es im CodeSystem nicht.")

    if problems:
        fail(f"Dosiereinheiten passen nicht zu KBV_CS_SFHIR_BMP_DOSIEREINHEIT "
             f"({lock['package']}#{lock['version']}):", problems)
    print(f"{GREEN}Dosiereinheiten geprüft: {len(codes)} Codes in beiden Invarianten, "
          f"{checked} Dosisangaben in den Beispielen ({lock['package']}#{lock['version']}).{RESET}")


if __name__ == "__main__":
    main()
