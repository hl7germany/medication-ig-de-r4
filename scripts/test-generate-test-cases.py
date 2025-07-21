import os
import json
import re
import sys

def is_conformance_resource(filename):
    return filename.startswith(("StructureDefinition-", "ValueSet-", "CodeSystem-", "ImplementationGuide-"))

def get_profile_from_file(filepath):
    try:
        with open(filepath, "r", encoding="utf-8") as f:
            data = json.load(f)
        profiles = data.get("meta", {}).get("profile", [])
        if profiles:
            return profiles[0]  # Assuming one profile per file
    except Exception:
        pass
    return None

def build_outcome_block(key):
    return {
        "resourceType": "OperationOutcome",
        "issue": [
            {
                "severity": "error",
                "code": "invariant",
                "extension": [
                    {
                        "url": "http://hl7.org/fhir/StructureDefinition/operationoutcome-message-id",
                        "valueCode": f"http://ig.fhir.de/igs/medication/StructureDefinition/TimingDgMP#{key}"
                    }
                ]
            }
        ]
    }

def main(input_path, output_path):
    profiles = {}
    for filename in os.listdir(input_path):
      if not filename.endswith(".json"):
          continue
      if is_conformance_resource(filename):
          continue

      filepath = os.path.join(input_path, filename)
      profile_url = get_profile_from_file(filepath)
      if not profile_url:
          continue

      test_entry = {
          "source": f"/fsh-generated/resources/{filename}",
          "description": os.path.splitext(filename)[0].replace("-", " "),
          "valid": not (("Invalid" in filename) or ("Unsupported" in filename))
      }

      c_key_match = re.search(r"-C-([A-Za-z0-9]+)", filename)
      if c_key_match:
          key = c_key_match.group(1)
          test_entry["outcome"] = build_outcome_block(key)

      if profile_url not in profiles:
          profiles[profile_url] = []
      profiles[profile_url].append(test_entry)


    result = {
        "profiles": [
            {
                "url": profile_url,
                "tests": tests
            }
            for profile_url, tests in profiles.items()
        ]
    }

    # Always write test.json inside the output directory
    output_file = os.path.join(output_path, "test.json")
    with open(output_file, "w", encoding="utf-8") as out_f:
        json.dump(result, out_f, indent=2, ensure_ascii=False)


if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python generate_tests.py <input_path> <output_path>")
        sys.exit(1)
    main(sys.argv[1], sys.argv[2])
