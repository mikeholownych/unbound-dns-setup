#!/usr/bin/env bash
set -euo pipefail

echo "🔧 Running YAML document header fix..."

find . -type f \( -name "*.yml" -o -name "*.yaml" \) \
  ! -path "./.git/*" \
  ! -path "./.ansible/*" \
  ! -path "./venv/*" \
  ! -path "./.venv/*" \
  -print0 | while IFS= read -r -d '' file; do

    # Skip binary or vault files
    if file "$file" | grep -q 'ASCII text'; then
        # Check if the first non-empty, non-comment line is '---'
        first_line=$(grep -vE '^\s*(#|$)' "$file" | head -n1 || true)
        if [[ "$first_line" != "---" ]]; then
            echo "Adding --- to $file"
            sed -i '1s;^;---\n;' "$file"
        fi
    fi
done

echo "✅ YAML headers fixed."
