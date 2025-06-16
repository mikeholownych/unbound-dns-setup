# 🧠 Unbound DNS Resolver – Secure, Observable, Production-Ready Stack

![CI](https://github.com/mikeholownych/unbound-dns-setup/actions/workflows/lint.yml/badge.svg)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Ansible](https://img.shields.io/badge/ansible-tested-blue.svg)](https://www.ansible.com)
[![Build](https://img.shields.io/github/languages/top/mikeholownych/unbound-dns-setup)](https://github.com/mikeholownych/unbound-dns-setup)

---

This project sets up a **redundant DNS resolver stack** using Unbound, Pi-hole, and Prometheus, built with Ansible and deployed in Proxmox.  
It’s hardened, monitored, and integrates Active Directory, custom ACLs, zone transfers, and full observability via Grafana.

> ✅ Built for homelab, SMB, and ethical AI/IT compliance labs.

---

## 🔧 Features

- ✅ **Unbound DNS resolvers** (primary + secondary)
- ✅ **Pi-hole** for ad-blocking and override zones
- ✅ **Windows AD integration** (`adroot.holownych.com`)
- ✅ **DNS metrics** via Prometheus + Grafana
- ✅ **Threat feeds** auto-sync and integrated with Unbound
- ✅ **Ansible Vault** secured secrets
- ✅ **Full CI/CD** via GitHub Actions (lint, PR gating, tagging, release)
- ✅ **Zone transfer** support between resolvers
- ✅ **Firewall & Fail2Ban** hardened defaults
- ✅ **Self-documenting infrastructure**

---

## 🗂️ Repo Structure

```bash
📁 roles/
  ├── unbound/           # Core resolver config
  ├── pihole/            # Docker Pi-hole + static entries
  ├── ad_integration/    # Auth + Realm join
  ├── threatfeeds/       # Blocklists synced regularly
  ├── alertmanager/      # Notifications + Grafana alerts
  ├── prometheus/        # Exporters, dnsmasq + unbound
  ├── grafana/           # Dashboards as code
  ├── nginx_proxy/       # TLS reverse proxy
  ├── firewall/          # UFW + iptables
  ├── backups/           # DNS & container backup hooks
  ├── verify/            # Post-deploy checks
📄 playbook.yml          # Master playbook
📄 inventory.ini         # Your target inventory
📁 .github/workflows/    # Lint, release, tagging, PR checks
📄 CHANGELOG.md
📄 Makefile              # Easy dev/test/CI triggers
📁 docs/                 # GitHub Pages documentation
