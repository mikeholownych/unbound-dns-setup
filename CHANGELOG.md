# Changelog

## [1.1.0] - 2025-06-16

### 🚀 Added
- Role: `dns_threat_intel_sync` with systemd timer and threat feed automation
- Role: `metrics_uptime_check` with logging and Prometheus readiness
- Role: `dot_doh` secure resolver overlay via Stubby
- Role: `dnssec` trust anchor installation and validation

### 🛠 Improved
- Full Ansible-lint compliance across all roles
- Standardized use of FQCN in all tasks
- Modular template structures for `unbound`, `pihole`, and `prometheus`

### 🐛 Fixed
- Removed all free-form `debug` module violations
- Set proper `changed_when: false` on shell/command tasks to improve idempotency
- Corrected handler state values (`restarted` → `started + notify reload` pattern)

---

For previous changes, see older tagged releases in the repo history.

## [v1.0.1] – 2025-06-16

### Added
- Full Unbound resolver configuration with hardened ACLs and root hints
- Threat feed ingestion and auto-reload with cron sync
- Pi-hole container integration for ad-blocking and privacy
- Prometheus metrics scraping (Unbound, Pi-hole, Grafana, node_exporter)
- Grafana dashboards and Prometheus alerts via Alertmanager
- Docker-based deployment for all roles using `community.docker`
- Active Directory (Windows Server 2019) DNS forward support with realm `adroot.holownych.com`
- Complete firewall with iptables and UFW ACLs
- Integrated CI/CD GitHub workflows: lint, PR labeling, tagging, release
- Verification role for DNS, AD auth, and service health
- Ansible Vault integration for secure secret handling

### Fixed
- All Ansible-lint errors: FQCN, changed_when, no-free-form
- Restart/reload handlers using correct `state: started` and `restart: true`

---

✅ Fully linted, secure, and ready for deployment in any home lab or SMB environment.

