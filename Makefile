.PHONY: lint vault encrypt decrypt

# Lint all Ansible files
lint:
	ansible-lint playbook.yml --vault-password-file .vault_pass.txt

# Encrypt vault file
encrypt:
	ansible-vault encrypt group_vars/all/vault.yml

# Decrypt vault file
decrypt:
	ansible-vault decrypt group_vars/all/vault.yml
