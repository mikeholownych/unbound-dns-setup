import os
import yaml
import re

from pathlib import Path

# Paths to process
TARGET_DIRS = ['roles', '.']
YAML_EXTS = ('.yml', '.yaml')

def load_yaml(filepath):
    with open(filepath, 'r') as f:
        return list(yaml.safe_load_all(f)), f.read()

def dump_yaml(data, filepath):
    with open(filepath, 'w') as f:
        yaml.safe_dump_all(data, f, sort_keys=False)

def fix_truthy_strings(content):
    return re.sub(r':\s*(yes|no)\b', lambda m: ': true' if m.group(1) == 'yes' else ': false', content)

def fix_import_role_lines(content):
    return content.replace('import_role:', 'ansible.builtin.import_role:')

def fix_builtin_mail(content):
    return content.replace('ansible.builtin.mail', 'community.general.mail')

def fix_pipefail(lines):
    if any('|' in line for line in lines):
        if not any('pipefail' in line for line in lines):
            for i, line in enumerate(lines):
                if 'shell:' in line:
                    lines.insert(i + 1, '    set -o pipefail')
                    break
    return lines

def ensure_changed_when_false(lines):
    if not any('changed_when:' in l for l in lines):
        lines.append('  changed_when: false')
    return lines

def process_file(path):
    if not path.suffix in YAML_EXTS:
        return

    original = path.read_text()
    modified = fix_truthy_strings(original)
    modified = fix_import_role_lines(modified)
    modified = fix_builtin_mail(modified)

    if modified != original:
        path.write_text(modified)
        print(f"✅ Fixed truthy/FQCN/mail: {path}")

    # Line-based processing
    lines = modified.splitlines()
    changed = False

    for i, line in enumerate(lines):
        if line.strip().startswith('shell:'):
            block = lines[i:i + 10]
            if '|' in ''.join(block):
                lines = fix_pipefail(lines)
                changed = True
            lines = ensure_changed_when_false(lines)
            changed = True

    if changed:
        path.write_text('\n'.join(lines) + '\n')
        print(f"✅ Fixed pipefail/changed_when: {path}")

def main():
    for base in TARGET_DIRS:
        for path in Path(base).rglob('*'):
            if path.is_file() and path.suffix in YAML_EXTS:
                process_file(path)

if __name__ == "__main__":
    main()
