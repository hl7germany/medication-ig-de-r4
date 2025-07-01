import json
import sys

def fsh_block(element):
    eid = element.get("id", "")
    short = element.get("short", "")
    definition = element.get("definition", "")
    comment = element.get("comment", "")
    return f"""* {eid.replace('Dosage.', '')}
  ^short = "{short}"
  ^definition = "{definition}"
  ^comment = "{comment}"
"""

def main(path):
    with open(path, encoding="utf-8") as f:
        sd = json.load(f)
    elements = sd.get("snapshot", {}).get("element", [])
    for el in elements:
        print(fsh_block(el))

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python script.py <StructureDefinition.json>")
        sys.exit(1)
    main(sys.argv[1])
