#!/usr/bin/env python3

import sys
from ruamel.yaml import YAML
from ruamel.yaml.error import YAMLError
from pathlib import Path


def fix_yaml_indentation(filepath: str) -> None:
    yaml = YAML()
    yaml.indent(mapping=2, sequence=2, offset=0)
    yaml.preserve_quotes = True
    yaml.width = 4096  # Prevent line wrapping

    path = Path(filepath)
    if not path.is_file():
        print(f"❌ Skipped (not a file): {filepath}")
        return

    try:
        with path.open("r", encoding="utf-8") as f:
            data = yaml.load(f)

        if data is None:
            print(f"⚠️ Empty or null YAML: {filepath}")
            return

        with path.open("w", encoding="utf-8") as f:
            yaml.dump(data, f)

        print(f"✅ Fixed: {filepath}")

    except YAMLError as e:
        print(f"⚠️ YAML error in {filepath}:\n    {e}")
    except Exception as e:
        print(f"❌ Unexpected error in {filepath}:\n    {e}")


def main():
    if len(sys.argv) < 2:
        print("Usage: ruamel_indent.py <file1.yaml> [file2.yml ...]")
        sys.exit(1)

    for file in sys.argv[1:]:
        fix_yaml_indentation(file)


if __name__ == "__main__":
    main()
