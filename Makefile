VAULT_PASS_FILE := .vault_pass.txt
INVENTORY := inventory.ini
PLAYBOOK := playbook.yml
ROLE := myrole

.PHONY: help lint syntax-check run decrypt encrypt molecule test clean

help:
	@echo "Usage:"
	@echo "  make lint            - Run ansible-lint on playbook and roles"
	@echo "  make syntax-check    - Run syntax check on the playbook"
	@echo "  make run             - Run playbook with vault decryption"
	@echo "  make decrypt         - Decrypt all vault-encrypted files"
	@echo "  make encrypt         - Encrypt a file with Ansible Vault"
	@echo "  make molecule        - Run Molecule scenario for $(ROLE)"
	@echo "  make test            - Run lint, syntax-check, and molecule"
	@echo "  make clean           - Remove .retry files and cleanup"

lint:
	ansible-lint $(PLAYBOOK)
	ansible-lint roles/

syntax-check:
	ansible-playbook --syntax-check -i $(INVENTORY) --vault-password-file $(VAULT_PASS_FILE) $(PLAYBOOK)

run:
	ansible-playbook -i $(INVENTORY) --vault-password-file $(VAULT_PASS_FILE) $(PLAYBOOK)

decrypt:
	ansible-vault decrypt --vault-password-file $(VAULT_PASS_FILE) $${FILE}

encrypt:
	@read -p "Enter filename to encrypt: " FILE; \
	ansible-vault encrypt --vault-password-file $(VAULT_PASS_FILE) $$FILE

molecule:
	cd roles/$(ROLE) && MOLECULE_VAULT_PASSWORD_FILE=../../$(VAULT_PASS_FILE) molecule test

test: lint syntax-check molecule

clean:
	find . -name "*.retry" -delete
