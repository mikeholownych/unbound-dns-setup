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
