---
title: DNS Monitoring Stack
layout: default
---

# 📈 DNS Monitoring & Observability

The Unbound DNS stack includes **Prometheus**, **Grafana**, and **Alertmanager** to provide end-to-end visibility into DNS performance, availability, and security.

---

## 📦 Components

| Component      | Role                             |
|---------------|----------------------------------|
| Prometheus     | Metrics collection and scraping  |
| Grafana        | Dashboarding and visualizations  |
| Alertmanager   | Notifications via Slack/email    |
| Exporters      | Metrics exporters (Unbound, Pi-hole) |

---

## 🎯 Metrics Overview

### Unbound Exporter

- `unbound_up`
- `unbound_total_queries`
- `unbound_cache_hits`
- `unbound_requestlist_avg`

### Pi-hole Exporter

- `pihole_domains_blocked`
- `pihole_dns_queries_today`
- `pihole_ads_blocked_today`

---

## 📊 Grafana Dashboards

Default dashboards included:

- **DNS Health**
- **Unbound Cache Ratio**
- **Pi-hole Block Stats**
- **Query Distribution by Client**
- **Forwarding Rates & Latency**

Dashboard templates are located in:
```
roles/grafana/templates/
```

To import manually:

1. Go to Grafana → Dashboards
2. Click "Import"
3. Upload `default_dashboard.json` template

---

## 🔔 Alerts

Alertmanager is pre-configured to notify based on:

- Unbound not responding
- Excessive failed lookups
- Pi-hole unavailable
- Query latency > threshold

Edit rules in:

```yaml
roles/alertmanager/templates/alert.rules.yml.j2
```

---

## ⚙️ Prometheus Config

Prometheus pulls from:

- Unbound Exporter
- Pi-hole Exporter
- Node Exporter (optional)

Scrape configs defined in:

```
roles/prometheus/templates/prometheus.yml.j2
```

---

## 📁 File Structure

| File | Description |
|------|-------------|
| `prometheus.yml.j2` | Prometheus scrape config |
| `alert.rules.yml.j2` | Prometheus alert rules |
| `default_dashboard.json.j2` | Grafana dashboard |

---

## 🔐 Securing Access

- Grafana admin password is vault-encrypted
- Use HTTPS via nginx_proxy for external access
- Lock down ports to internal networks only

---

## 🔄 Restart Services

Use Ansible to restart monitoring stack:

```bash
ansible-playbook -i inventory.ini playbook.yml --tags monitoring
```

---

## 📎 References

- [Prometheus Docs](https://prometheus.io/docs/)
- [Grafana Docs](https://grafana.com/docs/)
- [Alertmanager Docs](https://prometheus.io/docs/alerting/latest/alertmanager/)
