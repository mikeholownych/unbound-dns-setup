# 🤝 Contributing to Unbound DNS Stack

Thanks for your interest in contributing to the **Unbound DNS Stack**! Whether you're fixing bugs, improving documentation, or suggesting new features, your input is highly valued.

---

## 📋 How to Contribute

1. **Fork the repository**
2. **Clone your fork locally**
3. **Create a new branch** for your changes:
   ```bash
   git checkout -b feature/my-awesome-change
   ```
4. **Make your changes**
5. **Ensure your code passes linting**:
   ```bash
   make lint
   ```
6. **Commit your changes**:
   ```bash
   git commit -m "feat: add my awesome feature"
   ```
7. **Push to your fork** and create a Pull Request (PR)

---

## 🧪 Code Style & Testing

- All YAML and Ansible code must follow `ansible-lint` rules
- Use FQCN (fully qualified collection names) for all modules
- Avoid hardcoded passwords/secrets — use Ansible Vault
- All roles should include basic idempotency checks
- Playbooks must be tested using `make test` before PRs are merged

---

## 🏷 Pull Request Requirements

- ✅ One feature or fix per PR
- ✅ Linked to an Issue (if applicable)
- ✅ Title uses [Conventional Commits](https://www.conventionalcommits.org)
- ✅ PR has the `release` label to trigger a new tag (if needed)

---

## 📢 Communication

- Questions? Open an issue.
- Found a bug? Use the bug report template.
- Feature idea? We'd love to hear it — open a discussion or issue.

---

## 🙌 Code of Conduct

Please follow the [Contributor Covenant](https://www.contributor-covenant.org/version/2/0/code_of_conduct/) in all project spaces.

---

Thanks again!  
— Mike Holownych 🧠
