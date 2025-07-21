import os
import sys
import yaml  # pip install pyyaml
import json

def is_conformance_resource(filename):
    return filename.startswith(("StructureDefinition-", "ValueSet-", "CodeSystem-", "ImplementationGuide-"))

def get_resource_type_and_id(filepath):
    try:
        with open(filepath, "r", encoding="utf-8") as f:
            data = json.load(f)
        resource_type = data.get("resourceType")
        resource_id = data.get("id")
        if resource_type and resource_id:
            return f"{resource_type}/{resource_id}"
    except Exception:
        pass
    return None

def main(input_path):
    # Find sushi-config.yaml one directory up
    script_dir = os.path.dirname(os.path.abspath(__file__))
    yaml_path = os.path.join(script_dir, "..", "sushi-config.yaml")
    yaml_path = os.path.abspath(yaml_path)

    # Load YAML
    with open(yaml_path, "r", encoding="utf-8") as f:
        config = yaml.safe_load(f)

    # Remove parameters.no-validate if it exists
    if "parameters" in config and "no-validate" in config["parameters"]:
        del config["parameters"]["no-validate"]

    # Gather invalid/unsupported files
    no_validate = []
    for filename in os.listdir(input_path):
        if not filename.endswith(".json"):
            continue
        if is_conformance_resource(filename):
            continue
        if "Invalid" in filename or "Unsupported" in filename:
            filepath = os.path.join(input_path, filename)
            entry = get_resource_type_and_id(filepath)
            if entry:
                no_validate.append(entry)

    # Sort for consistency
    no_validate.sort()

    # Add new no-validate list
    if "parameters" not in config:
        config["parameters"] = {}
    config["parameters"]["no-validate"] = no_validate

    # Write YAML back with correct indentation
    class IndentDumper(yaml.SafeDumper):
        def increase_indent(self, flow=False, indentless=False):
            return super(IndentDumper, self).increase_indent(flow, False)
    with open(yaml_path, "w", encoding="utf-8") as f:
        yaml.dump(config, f, Dumper=IndentDumper, sort_keys=False, allow_unicode=True, default_flow_style=False)

    print(f"Updated {yaml_path} with {len(no_validate)} no-validate entries.")

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python update_no_validate.py <input_path>")
        sys.exit(1)
    main(sys.argv[1])
