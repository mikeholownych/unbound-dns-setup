#!/usr/bin/env python3

import yaml
import os
from pathlib import Path

SAFE_MODULES = {
    "command",
    "shell",
    "raw",
    "script",
    "ansible.builtin.command",
    "ansible.builtin.shell",
}

EXCLUDED_MODULES = {
    "community.docker.docker_container",
    "docker_container",
    "ansible.builtin.docker_container",
}


def patch_task(task):
    if not isinstance(task, dict):
        return
    for key in task:
        if key in SAFE_MODULES:
            task.setdefault("changed_when", "true")
        elif key in EXCLUDED_MODULES and "changed_when" in task:
            del task["changed_when"]


def fix_file(path):
    try:
        with open(path, "r", encoding="utf-8") as f:
            docs = list(yaml.safe_load_all(f))

        modified_docs = []
        for doc in docs:
            if isinstance(doc, list):  # play or task list
                for task in doc:
                    patch_task(task)
            elif isinstance(doc, dict):  # playbook dictionary
                if "tasks" in doc and isinstance(doc["tasks"], list):
                    for task in doc["tasks"]:
                        patch_task(task)
            modified_docs.append(doc)

        with open(path, "w", encoding="utf-8") as f:
            yaml.dump_all(modified_docs, f, default_flow_style=False, indent=2)

        print(f"✅ Fixed: {path}")

    except yaml.YAMLError as e:
        print(f"⚠️ YAML error in {path}: {e}")
    except Exception as e:
        print(f"❌ Unexpected error in {path}: {e}")


if __name__ == "__main__":
    for root, dirs, files in os.walk("roles"):
        for file in files:
            if file.endswith(".yml") or file.endswith(".yaml"):
                if "tasks" in root or "handlers" in root:
                    fix_file(os.path.join(root, file))
