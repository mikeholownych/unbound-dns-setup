[![CI](https://github.com/mikeholownych/unbound-dns-setup/actions/workflows/lint.yml/badge.svg)](https://github.com/mikeholownych/unbound-dns-setup/actions/workflows/lint.yml)
[![Release](https://github.com/mikeholownych/unbound-dns-setup/actions/workflows/release.yml/badge.svg)](https://github.com/mikeholownych/unbound-dns-setup/actions/workflows/release.yml)
[![Version](https://img.shields.io/github/v/tag/mikeholownych/unbound-dns-setup?label=version)](https://github.com/mikeholownych/unbound-dns-setup/releases)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Ansible](https://img.shields.io/badge/ansible-tested-blue.svg)](https://www.ansible.com)
[![Build](https://img.shields.io/github/languages/top/mikeholownych/unbound-dns-setup)](https://github.com/mikeholownych/unbound-dns-setup)

# 🧠 Unbound DNS + Monitoring + Security – Production-Grade IaC Playbook

This repository provisions a full-stack DNS resolver and monitoring solution using Unbound, Pi-hole, Prometheus, Grafana, Loki, and Active Directory authentication. It includes hardened security with Fail2Ban, firewall rules, and alerting via Alertmanager.

## 🔧 Features

- 🔐 Unbound + Pi-hole DNS resolution (internal + external)
- 📊 Grafana dashboards for DNS, system, and log observability
- 📈 Prometheus metrics (Unbound, Pi-hole, system)
- 🔔 Alertmanager with email + Slack integration
- 🛡️ Integrated firewall ACLs and Fail2Ban for hardening
- 🪵 Centralized logging with Loki + Promtail
- 👤 Active Directory authentication (Windows Server 2019)
- 🧪 CI/CD automation with GitHub Actions
- 🔄 Vault-safe secrets and full infrastructure-as-code setup

## 📦 Setup

```bash
ansible-playbook -i inventory.ini playbook.yml --ask-vault-pass
```

## 🗂️ Structure

- `playbook.yml` – Orchestration entry point
- `group_vars/all/vault.yml` – Encrypted credentials + tokens
- `roles/*` – Modular Ansible roles
- `.github/workflows/` – CI pipelines for lint, label enforcement, release
- `scripts/release.sh` – Version bumping + changelog update

## ✅ Inventory Example

```ini
[dns_nodes]
192.168.1.10
192.168.1.11
```

## 🔒 Vault Variables Example

```yaml
smtp_user: "monitor@example.com"
smtp_password: "vault-encrypted-password"
alert_email_to: "admin@example.com"
loki_host: "192.168.1.100"
```

## 🧪 Run Lint + CI

Push with `release` label or tag manually:

```bash
git tag v1.0.0 && git push origin v1.0.0
```

## 📄 License

MIT
