# Makefile for unbound-dns-setup

# ====== 🦠 CONFIG ======
VENV_DIR := .venv
PYTHON := $(VENV_DIR)/bin/python
PIP := $(VENV_DIR)/bin/pip
PRE_COMMIT := $(VENV_DIR)/bin/pre-commit
BLACK := $(VENV_DIR)/bin/black

ANSIBLE_PLAYBOOK := $(VENV_DIR)/bin/ansible-playbook
ANSIBLE_LINT := $(VENV_DIR)/bin/ansible-lint
GALAXY := $(VENV_DIR)/bin/ansible-galaxy

REQUIREMENTS_FILE := collections/requirements.yml
PLAYBOOK_FILE := playbook.yml
INVENTORY_FILE := inventory.ini
VAULT_PASS_FILE := .vault_pass.txt

YAML_FILES := $(shell find . -type f \( -name "*.yml" -o -name "*.yaml" \) ! -path "./.git/*" ! -path "./$(VENV_DIR)/*" ! -path "./collections/*")

# ====== ⚙️ TARGETS ======

.PHONY: all init-venv lint lint-fix lint-fix-all install-collections fix-yaml-header fix-yaml-indent format-python pre-commit-install test run clean yaml-fix

## 🔧 Set up the local Python virtual environment
init-venv:
	@echo "🐍 Setting up Python virtual environment..."
	@test -d $(VENV_DIR) || python3 -m venv $(VENV_DIR)
	@$(PIP) install --upgrade pip setuptools wheel
	@$(PIP) install -r requirements-dev.txt

## 🔍 Run all checks
all: init-venv install-collections lint test

## 📆 Install Ansible Galaxy collections
install-collections:
	@echo "📦 Installing Ansible collections..."
	@$(GALAXY) collection install -r $(REQUIREMENTS_FILE)

## ✅ Run ansible-lint
lint: init-venv
	@echo "🧚 Running ansible-lint..."
	@$(ANSIBLE_LINT) --exclude group_vars/all/vault.yml \
	                 --exclude collections/ansible_collections \
	                 --exclude .ansible/collections \
	                 $(PLAYBOOK_FILE)

## ⚡️ Run auto-fix for ansible-lint
lint-fix: init-venv
	@$(PRE_COMMIT) run fix-ansible-lint --files $(PLAYBOOK_FILE)

## ⚡️ Run all fix tools (yaml headers, indentation, black, lint)
lint-fix-all: init-venv install-collections yaml-fix format-python
	@echo "🔧 Running full lint auto-fix..."
	@$(PRE_COMMIT) run --all-files

## ⚡️ Add missing YAML document headers
fix-yaml-header:
	@echo "🔧 Fixing YAML document headers..."
	@for file in $(YAML_FILES); do \
		if ! grep -q '^---' $$file; then \
			echo "Adding --- to $$file"; \
			sed -i '1s/^/---\n/' $$file; \
		fi; \
	done

## 🧄 Fix YAML indentation using ruamel.yaml
fix-yaml-indent: init-venv
	@echo "🧼 Fixing YAML indentation..."
	@bash utils/fix_yaml_indent.sh

## 🧹 Combined YAML fix: header + indentation
yaml-fix: fix-yaml-header fix-yaml-indent

## 🎨 Format Python files using Black
format-python: init-venv
	@echo "🎨 Formatting Python files with Black..."
	@$(BLACK) utils/

## ⚙️ Install pre-commit hooks
pre-commit-install: init-venv
	@echo "🔗 Installing pre-commit hooks..."
	@$(PRE_COMMIT) install

## ✅ Run Ansible syntax check
test: init-venv
	@echo "🔍 Running Ansible syntax check..."
	@$(ANSIBLE_PLAYBOOK) -i $(INVENTORY_FILE) --syntax-check $(PLAYBOOK_FILE)

## 🚀 Run the full playbook
run: init-venv
	@echo "🚀 Running the playbook..."
	@$(ANSIBLE_PLAYBOOK) -i $(INVENTORY_FILE) $(PLAYBOOK_FILE)

## 🧹 Clean generated and cache files
clean:
	@echo "🧹 Cleaning up..."
	@rm -rf .retry *.retry .cache __pycache__ .mypy_cache .pytest_cache .tox .ansible-lint .coverage $(VENV_DIR)
