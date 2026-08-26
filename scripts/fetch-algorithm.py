#!/usr/bin/env python3
"""Stellt die gepinnte Version des Textgenerierungs-Algorithmus bereit.

Der Algorithmus wird nicht mehr in diesem Repository gepflegt, sondern in
hl7germany/dgMP-DosageTextgenerierung-Skript. Welche Version der Build
verwendet, legt `dosage-algorithm.lock` fest.

Der Tag allein genügt nicht: Tags lassen sich verschieben. Deshalb wird die
geladene Datei zusätzlich gegen die im Lock hinterlegte SHA-256 geprüft. Weicht
sie ab, bricht der Build ab, statt Dosierungstexte aus einer unbekannten Version
zu erzeugen — die Version wird als `algorithmVersion` in jede Ressource
geschrieben und wäre dann eine falsche Angabe.

Solange der im Lock genannte Tag im externen Repository noch nicht existiert,
greift der Übergangsweg: eine lokal vorhandene `medication-dosage-to-text.py`
wird verwendet, sofern ihre Prüfsumme dem Lock entspricht. Damit ist auch vor
dem Release sichergestellt, dass lokal genau das läuft, was der Tag tragen wird.

Für die Weiterentwicklung lässt sich das Pinning bewusst umgehen:

    DOSAGE_ALGORITHM_REF=main   beliebiger Branch, Tag oder Commit
    DOSAGE_ALGORITHM_REF=local  die Arbeitskopie in scripts/

In beiden Fällen entfällt die Prüfsummenkontrolle und der Build ist nicht mehr
reproduzierbar. Die erzeugten Texte tragen dann trotzdem das `__version__` der
verwendeten Datei als `algorithmVersion` — sie behaupten also eine Version, die
so nicht veröffentlicht ist. Deshalb wird deutlich gewarnt, und solche Stände
gehören nicht in einen Release-Build.
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
RAW_URL = "https://raw.githubusercontent.com/{repository}/{tag}/{file}"


def read_lock():
    with open(LOCK_PATH, "r", encoding="utf-8") as handle:
        lock = json.load(handle)
    for key in ("repository", "file", "tag", "sha256"):
        if not lock.get(key):
            sys.exit(f"dosage-algorithm.lock: '{key}' fehlt oder ist leer.")
    return lock


def digest(data):
    return hashlib.sha256(data).hexdigest()


def download(lock):
    """Lädt die Datei vom gepinnten Tag. None, wenn der Tag nicht existiert."""
    url = RAW_URL.format(**lock)
    try:
        with urllib.request.urlopen(url, timeout=30) as response:
            return response.read()
    except urllib.error.HTTPError as error:
        if error.code == 404:
            return None
        sys.exit(f"Download von {url} fehlgeschlagen: HTTP {error.code}")
    except urllib.error.URLError as error:
        sys.exit(f"Download von {url} fehlgeschlagen: {error.reason}")


def local_fallback(lock):
    """Vorhandene lokale Kopie, sofern sie zur gepinnten Prüfsumme passt."""
    path = os.path.join(BASE_DIR, lock["file"])
    if not os.path.isfile(path):
        return None
    with open(path, "rb") as handle:
        data = handle.read()
    return data if digest(data) == lock["sha256"] else None


def override_ref():
    return (os.environ.get("DOSAGE_ALGORITHM_REF") or "").strip()


def warn_unpinned(source):
    line = "!" * 78
    print(
        f"\n{line}\n"
        f"  ACHTUNG: ungepinnter Algorithmus aus {source}.\n"
        "  Keine Pruefsummenkontrolle, Build nicht reproduzierbar. Die erzeugte\n"
        "  algorithmVersion bezeichnet eine so nicht veroeffentlichte Version.\n"
        "  Nur fuer Entwicklung und Test - nicht veroeffentlichen.\n"
        f"{line}\n",
        file=sys.stderr,
    )


def main():
    lock = read_lock()
    target = os.path.join(VENDOR_DIR, lock["file"])

    ref = override_ref()
    if ref:
        if ref == "local":
            path = os.path.join(BASE_DIR, lock["file"])
            if not os.path.isfile(path):
                sys.exit(f"DOSAGE_ALGORITHM_REF=local, aber {path} fehlt.")
            warn_unpinned(f"Arbeitskopie {path}")
            return path
        unpinned = dict(lock, tag=ref)
        data = download(unpinned)
        if data is None:
            sys.exit(
                f"Ref '{ref}' existiert in {lock['repository']} nicht."
            )
        os.makedirs(VENDOR_DIR, exist_ok=True)
        with open(target, "wb") as handle:
            handle.write(data)
        warn_unpinned(f"{lock['repository']}@{ref}")
        return target

    data = download(lock)
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
        source = f"{lock['repository']}@{lock['tag']}"
    else:
        data = local_fallback(lock)
        if data is None:
            sys.exit(
                f"Tag {lock['tag']} existiert in {lock['repository']} noch nicht, "
                "und es gibt keine lokale Kopie mit passender Pruefsumme.\n"
                "Entweder den Tag im externen Repository anlegen oder im Lock auf "
                "eine bereits veroeffentlichte Version zeigen."
            )
        source = f"lokale Kopie (Tag {lock['tag']} noch nicht veroeffentlicht)"

    os.makedirs(VENDOR_DIR, exist_ok=True)
    with open(target, "wb") as handle:
        handle.write(data)
    print(f"Algorithmus {lock['tag']} bereitgestellt aus {source}.")
    return target


if __name__ == "__main__":
    main()
