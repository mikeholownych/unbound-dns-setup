---
title: Unbound DNS Configuration
layout: default
---

# 📘 Unbound DNS – Configuration Guide

The Unbound DNS resolver provides a high-performance, validating, recursive, and caching DNS service.

This setup is hardened for production and integrates with Pi-hole, Prometheus, and Active Directory for observability and access control.

---

## 📂 Configuration File

The Unbound configuration is templated in Ansible using `roles/unbound/templates/unbound.conf.j2`.

Key settings:

```conf
server:
  verbosity: 1
  interface: 0.0.0.0
  port: 53
  do-ip4: yes
  do-ip6: no
  access-control: 10.0.0.0/8 allow
  access-control: 172.16.0.0/12 allow
  access-control: 192.168.0.0/16 allow
  harden-glue: yes
  hide-identity: yes
  hide-version: yes
  identity: ""
  version: ""

forward-zone:
  name: "."
  forward-addr: 1.1.1.1
  forward-addr: 9.9.9.9
```

> 🔐 Access control includes RFC1918 ranges for internal access.

---

## 🧩 Integration with Active Directory

Unbound is configured to **forward specific internal zones** to the Active Directory DNS (typically Windows Server 2019).

Example:

```conf
stub-zone:
  name: "adroot.holownych.com"
  stub-addr: 192.168.1.10
```

---

## 📈 Monitoring

Metrics are collected using Prometheus’ `dnsmasq_exporter` or `unbound_exporter`, depending on the deployment.

Unbound exposes statistics via:

```bash
unbound-control stats
```

These are parsed into Grafana dashboards via Prometheus.

---

## 🔁 Zone Transfers

To support secondary Unbound resolvers, the configuration includes:

```conf
allow-notify: 192.168.1.2
allow-notify: 192.168.1.3
```

Zone transfers are **read-only** and controlled by ACLs.

---

## 🔐 Security Hardening

- DNSSEC validation is enabled by default
- Logging is minimized but stored locally
- Only internal ranges are allowed to query
- Rate-limiting and cache busting are configurable

---

## 🔄 Restart Unbound

After making configuration changes:

```bash
sudo systemctl restart unbound
```

---

## 📁 Files

| File | Purpose |
|------|---------|
| `unbound.conf.j2` | Main config |
| `local-zones.conf` | Internal zone overrides |
| `root.hints` | Updated root server list |

---

## 📎 References

- [Unbound Docs](https://nlnetlabs.nl/documentation/unbound/)
- [DNSSEC Validation](https://dnssec-analyzer.verisignlabs.com/)
