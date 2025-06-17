#!/bin/bash

set -e

VENV_DIR=".venv"
PYTHON="$VENV_DIR/bin/python3"
SCRIPT="utils/ruamel_indent.py"

echo "🧼 Fixing YAML indentation using ruamel.yaml..."

if [ ! -f "$PYTHON" ]; then
  echo "❌ Python virtual environment not found at $PYTHON"
  exit 1
fi

if [ ! -f "$SCRIPT" ]; then
  echo "❌ Formatter script not found: $SCRIPT"
  exit 1
fi

# Find all YAML files to format
YAML_FILES=$(find . -type f \( -name "*.yml" -o -name "*.yaml" \) ! -path "./.venv/*")

# Run the script on each file
for file in $YAML_FILES; do
  "$PYTHON" "$SCRIPT" "$file"
done
