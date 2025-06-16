---
title: Pi-hole Configuration
layout: default
---

# 🧰 Pi-hole Integration Guide

This system includes **Pi-hole** for DNS filtering, ad-blocking, and custom domain resolution. Pi-hole works in tandem with Unbound to provide privacy and performance.

---

## ⚙️ Architecture

```
Client → Pi-hole → Unbound → Root DNS or AD DNS
```

- Pi-hole handles DNS filtering and domain overrides
- Unbound performs recursive DNS resolution
- AD zones are resolved via conditional forwarding

---

## 📦 Pi-hole Deployment

Pi-hole is deployed via Ansible using Docker Compose:

- Uses a custom image with DNS logging enabled
- Persistent volumes for configs and logs
- Web interface exposed on port `8181`

Ansible role: `roles/pihole/tasks/docker.yml`

---

## 🔧 Configuration Highlights

- **Web Port:** 8181
- **Admin Interface:** http://<ip>:8181/admin
- **DNS Upstream:** Unbound resolver at `127.0.0.1#5335`
- **Adlists:** Community and custom threat feeds
- **Custom DNS Entries:** Managed via `pihole-custom.list`

### pihole-custom.list Example:

```
192.168.1.10 adhost.adroot.holownych.com
192.168.1.11 devhost.adroot.holownych.com
```

---

## 📊 Monitoring

DNS query metrics are exported to Prometheus using the [pihole_exporter](https://github.com/eko/pihole-exporter):

- Total queries
- Blocked domains
- Forward destinations
- Client stats

Grafana dashboards visualize these metrics in real-time.

---

## 🔐 Admin Access

All admin credentials are stored via **Ansible Vault**.

To change the password:

```bash
ansible-vault edit group_vars/all/vault.yml
```

---

## 🔄 Restart Pi-hole

```bash
docker restart pihole
```

Or use Ansible:

```bash
ansible-playbook -i inventory.ini playbook.yml --tags pihole
```

---

## 📁 Files

| File | Description |
|------|-------------|
| `docker-compose.yml.j2` | Docker config for Pi-hole |
| `pihole-custom.list.j2` | Custom DNS records |
| `pihole.env.j2`         | Environment vars (vault-managed) |

---

## ✅ Best Practices

- Set Pi-hole DNS upstream to Unbound
- Never expose admin panel externally
- Use strong, vault-managed credentials
- Sync blocklists regularly (via threatfeeds role)

---

## 📎 References

- [Pi-hole Docs](https://docs.pi-hole.net/)
- [Pi-hole Exporter](https://github.com/eko/pihole-exporter)
- [Security Best Practices](https://pi-hole.net/blog/2021/03/19/securing-your-pi-hole/)
