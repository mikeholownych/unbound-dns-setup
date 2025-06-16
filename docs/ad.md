---
title: Active Directory Integration
layout: default
---

# 🏢 Active Directory (AD) Integration

The Unbound DNS stack integrates with Windows Server 2019 Active Directory (AD) to support:

- Internal domain resolution (`adroot.holownych.com`)
- Kerberos authentication
- AD-based user/group policies
- DNS forwarding for internal zones

---

## 🌐 Domain Configuration

| Setting            | Value                    |
|-------------------|--------------------------|
| AD Realm           | `adroot.holownych.com`   |
| AD DNS IP          | `192.168.1.10` (example) |
| Unbound Zone Stub  | `adroot.holownych.com`   |
| Kerberos Realm     | `ADROOT.HOLOWNYCH.COM`   |

---

## 🧩 Unbound Stub Zone

To delegate AD zone resolution to the domain controller:

```conf
stub-zone:
  name: "adroot.holownych.com"
  stub-addr: 192.168.1.10
```

Defined in: `roles/unbound/templates/unbound.conf.j2`

---

## 🔐 Authentication

This stack joins each DNS node to the domain using:

- `realmd` for domain joining
- `sssd` for account caching and NSS integration
- Kerberos for secure login

### Required Packages

- `realmd`, `sssd`, `krb5-user`, `adcli`, `samba-common`

---

## 📝 Ansible Vault Secrets

Credentials used for domain join are stored securely:

```yaml
ad_join_user: "administrator@adroot.holownych.com"
ad_join_password: !vault |
  $ANSIBLE_VAULT;1.1;AES256...
```

Defined in: `group_vars/all/vault.yml`

---

## 🧪 Verification

To verify domain join:

```bash
realm list
id administrator@adroot.holownych.com
getent passwd
```

To verify DNS resolution:

```bash
dig @127.0.0.1 adroot.holownych.com
```

---

## 📂 Related Files

| File | Purpose |
|------|---------|
| `ad_integration/tasks/main.yml` | Join AD and configure realm |
| `unbound.conf.j2`               | Delegate DNS zones to AD     |
| `vault.yml`                     | Secure credentials            |

---

## ✅ Best Practices

- Ensure accurate system time (NTP is critical)
- Use dedicated AD join account with minimal privileges
- Do not expose Kerberos/LDAP ports externally
- Regularly audit domain join and sssd cache

---

## 📎 References

- [realmd Docs](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/windows_integration_guide/domain-membership)
- [SSSD Docs](https://sssd.io/)
- [Microsoft AD DNS Docs](https://learn.microsoft.com/en-us/windows-server/networking/dns/)
