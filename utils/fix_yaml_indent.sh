#!/usr/bin/env bash
set -euo pipefail

echo "🧼 Fixing YAML indentation using ruamel.yaml..."
YAML_FORMATTER="$(dirname "$0")/../$(VENV_DIR)/bin/python3 utils/ruamel_indent.py"

if [[ ! -x "$YAML_FORMATTER" ]]; then
  echo "❌ Formatter script not found: $YAML_FORMATTER"
  exit 1
fi

mapfile -t files < <(find . -type f \( -name "*.yml" -o -name "*.yaml" \) \
  ! -path "./.git/*" \
  ! -path "./$(VENV_DIR)/*" \
  ! -path "./collections/*" \
  ! -path "./.ansible/*")

[[ ${#files[@]} -eq 0 ]] && { echo "⚠️ No YAML files found."; exit 0; }

"$YAML_FORMATTER" "${files[@]}"
