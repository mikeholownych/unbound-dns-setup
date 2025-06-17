#!/usr/bin/env python3
# utils/ruamel_indent.py

import sys
from pathlib import Path
from ruamel.yaml import YAML
from ruamel.yaml.error import YAMLError

yaml = YAML()
yaml.indent(mapping=2, sequence=4, offset=2)
yaml.preserve_quotes = True
yaml.width = 4096  # Allow long lines to avoid unnecessary wrapping


def fix_yaml_indentation(filepath: Path):
    try:
        with filepath.open("r", encoding="utf-8") as f:
            documents = list(yaml.load_all(f))
    except YAMLError as e:
        print(f"❌ Failed to parse {filepath}: {e}")
        return
    except Exception as e:
        print(f"❌ Unexpected error in {filepath}: {e}")
        return

    try:
        with filepath.open("w", encoding="utf-8") as f:
            yaml.dump_all(documents, f)
        print(f"✅ Fixed: {filepath}")
    except Exception as e:
        print(f"❌ Failed to write {filepath}: {e}")


def main():
    if len(sys.argv) < 2:
        print("Usage: ruamel_indent.py <file1.yml> [file2.yaml] ...")
        sys.exit(1)

    for filename in sys.argv[1:]:
        path = Path(filename)
        if not path.is_file():
            print(f"⚠️ Skipping non-file: {path}")
            continue
        fix_yaml_indentation(path)


if __name__ == "__main__":
    main()
