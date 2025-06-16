---
title: Unbound DNS Stack Documentation
layout: default
---

# 🧠 Unbound DNS Stack – Docs

Welcome to the documentation for the **Unbound DNS Resolver Stack**, a production-grade, secure, and observable DNS infrastructure tailored for homelab, enterprise edge, and ethical AI systems.

> Built by [Mike Holownych](https://linkedin.com/in/mikeholownych), Founder of Ethical AI Insider.

---

## 📌 Overview

This system combines:

- ✅ **Unbound** for DNS resolution
- ✅ **Pi-hole** for ad-blocking and local overrides
- ✅ **Active Directory integration**
- ✅ **Prometheus & Grafana** for observability
- ✅ **Threat feeds** for blocking malware domains
- ✅ **Zone transfers and ACLs**
- ✅ **Firewall hardening**
- ✅ **Ansible Vault + GitHub Actions** for automation

---

## 🚀 Quick Start

### 1. Clone the repo:

```bash
git clone https://github.com/mikeholownych/unbound-dns-setup.git
cd unbound-dns-setup
```

### 2. Create and encrypt your secrets:

```bash
ansible-vault encrypt_string 'MyPassword' --name 'admin_password'
```

### 3. Run the playbook:

```bash
ansible-playbook -i inventory.ini playbook.yml --ask-vault-pass
```

---

## 🗂️ Key Components

| Component       | Description |
|----------------|-------------|
| **Unbound**     | Primary DNS resolver with hardened configuration |
| **Pi-hole**     | DNS ad-blocker with override list support |
| **Active Directory** | Optional AD-based authentication for DNS integration |
| **Grafana**     | Real-time DNS dashboards |
| **Prometheus**  | Metrics collection for DNS, Pi-hole, system |
| **Alertmanager**| Optional email/Slack alerts on anomalies |
| **Firewall**    | UFW + iptables rules to restrict exposure |
| **Verify role** | Ensures services and configurations are healthy post-deploy |

---

## 📊 Dashboards

- **DNS Health**
- **Top Queries**
- **Blocked Domains**
- **AD Lookup Success/Failures**
- **Unbound Cache Stats**

---

## 🔒 Secrets Management

All passwords and tokens are handled securely via [Ansible Vault](https://docs.ansible.com/ansible/latest/user_guide/vault.html).

---

## 🤝 Contributing

Pull requests are welcome! Please follow our [contributing guide](CONTRIBUTING.md) and ensure your code passes linting:

```bash
make lint
```

---

## 📘 Documentation Pages

- [Unbound Configuration](unbound.md)
- [Pi-hole Setup](pihole.md)
- [Monitoring Stack](monitoring.md)
- [Active Directory Integration](ad.md)

---

## 📜 License

MIT – use it, fork it, improve it.

> Made with 🧠 by [Mike Holownych](https://ethical-ai-insider.com)
