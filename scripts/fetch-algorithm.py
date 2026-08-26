#!/usr/bin/env python3
"""Stellt die gepinnte Version des Textgenerierungs-Algorithmus bereit.

Der Algorithmus wird nicht in diesem Repository gepflegt, sondern in
hl7germany/dgMP-DosageTextgenerierung-Skript. Welche Version der Build
verwendet, legt `dosage-algorithm.lock` fest.

Der Tag allein genügt nicht: Tags lassen sich verschieben. Deshalb wird die
geladene Datei zusätzlich gegen die im Lock hinterlegte SHA-256 geprüft. Weicht
sie ab, bricht der Build ab, statt Dosierungstexte aus einer unbekannten Version
zu erzeugen — die Version wird als `algorithmVersion` in jede Ressource
geschrieben und wäre dann eine falsche Angabe.

Existiert der im Lock genannte Tag noch nicht, greift der Fallback auf `main`.
Das hält den Build während der Entwicklung lauffähig, hebt aber die
Reproduzierbarkeit auf: `main` bewegt sich, und die erzeugte `algorithmVersion`
bezeichnet dann eine Version, die so nicht veröffentlicht ist. Der Fallback
hinterlegt deshalb eine Marke in `vendor/`, die `build-ig.sh` am Ende des Builds
ausliest und prominent meldet — eine Warnung zu Beginn eines IG-Builds wäre
längst weggescrollt, bevor jemand das Ergebnis ansieht.
"""

import hashlib
import json
import os
import sys
import urllib.error
import urllib.request

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
LOCK_PATH = os.path.join(BASE_DIR, "dosage-algorithm.lock")
VENDOR_DIR = os.path.join(BASE_DIR, "vendor")
MARKER_PATH = os.path.join(VENDOR_DIR, "UNPINNED")
FALLBACK_REF = "main"
RAW_URL = "https://raw.githubusercontent.com/{repository}/{ref}/{file}"


def read_lock():
    with open(LOCK_PATH, "r", encoding="utf-8") as handle:
        lock = json.load(handle)
    for key in ("repository", "file", "tag", "sha256"):
        if not lock.get(key):
            sys.exit(f"dosage-algorithm.lock: '{key}' fehlt oder ist leer.")
    return lock


def digest(data):
    return hashlib.sha256(data).hexdigest()


def download(lock, ref):
    """Lädt die Datei bei der angegebenen Ref. None, wenn die Ref nicht existiert."""
    url = RAW_URL.format(ref=ref, **{k: lock[k] for k in ("repository", "file")})
    try:
        with urllib.request.urlopen(url, timeout=30) as response:
            return response.read()
    except urllib.error.HTTPError as error:
        if error.code == 404:
            return None
        sys.exit(f"Download von {url} fehlgeschlagen: HTTP {error.code}")
    except urllib.error.URLError as error:
        sys.exit(f"Download von {url} fehlgeschlagen: {error.reason}")


def store(data, marker_text=None):
    os.makedirs(VENDOR_DIR, exist_ok=True)
    target = os.path.join(VENDOR_DIR, "medication-dosage-to-text.py")
    with open(target, "wb") as handle:
        handle.write(data)
    if marker_text is None:
        if os.path.exists(MARKER_PATH):
            os.remove(MARKER_PATH)
    else:
        with open(MARKER_PATH, "w", encoding="utf-8") as handle:
            handle.write(marker_text + "\n")
    return target


def main():
    lock = read_lock()

    data = download(lock, lock["tag"])
    if data is not None:
        actual = digest(data)
        if actual != lock["sha256"]:
            sys.exit(
                f"Pruefsumme von {lock['file']}@{lock['tag']} weicht ab.\n"
                f"  erwartet: {lock['sha256']}\n"
                f"  geladen:  {actual}\n"
                "Wurde der Tag verschoben? Der Build wird abgebrochen, weil sonst "
                "Texte einer unbekannten Version als algorithmVersion "
                f"{lock['tag']} veroeffentlicht wuerden."
            )
        print(f"Algorithmus {lock['tag']} bereitgestellt (gepinnt, Pruefsumme geprueft).")
        return store(data)

    data = download(lock, FALLBACK_REF)
    if data is None:
        sys.exit(
            f"Weder Tag '{lock['tag']}' noch '{FALLBACK_REF}' sind in "
            f"{lock['repository']} erreichbar."
        )
    source = f"{lock['repository']}@{FALLBACK_REF}"
    print(
        f"Tag {lock['tag']} existiert noch nicht - Fallback auf {source}.",
        file=sys.stderr,
    )
    return store(
        data,
        f"Tag {lock['tag']} existiert noch nicht. Verwendet wurde {source} "
        f"(SHA-256 {digest(data)}), ungeprueft und beweglich.",
    )


if __name__ == "__main__":
    main()
