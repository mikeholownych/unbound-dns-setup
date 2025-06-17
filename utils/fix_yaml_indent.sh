#!/usr/bin/env bash
set -euo pipefail

echo "🧼 Fixing YAML indentation..."

# Ensure formatter script exists
SCRIPT="utils/fix_yaml_indent.py"
PYTHON_VENV=".venv/bin/python3"

if [[ ! -x "$PYTHON_VENV" ]]; then
  echo "❌ Python virtual environment not found at $PYTHON_VENV"
  exit 1
fi

if [[ ! -f "$SCRIPT" ]]; then
  echo "❌ Formatter script not found: $SCRIPT"
  exit 1
fi

echo "🧼 Fixing YAML indentation using ruamel.yaml..."

# Find YAML files excluding common folders
mapfile -t files < <(find . -type f \( -name "*.yml" -o -name "*.yaml" \) \
  ! -path "./.git/*" \
  ! -path "./.venv/*" \
  ! -path "./collections/*" \
  ! -path "./.ansible/*")

if [[ ${#files[@]} -eq 0 ]]; then
  echo "⚠️ No YAML files found to format."
  exit 0
fi

# Run the formatter
"$PYTHON_VENV" "$SCRIPT" "${files[@]}"
