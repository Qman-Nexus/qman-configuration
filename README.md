# Qman Configuration

## Overview

Configuration management implementation for the
Qman Enterprise Platform.

This repository contains reusable Ansible roles,
playbooks, configuration standards and automated
verification procedures.

## Objectives

- Reproducible operating system configuration
- Security by design
- Configuration consistency
- Environment separation
- Idempotent configuration management
- Configuration drift remediation
- Automated validation
- Provider independence

## Architecture

Terraform manages infrastructure provisioning
where supported by the infrastructure provider.

Ansible manages operating system configuration,
security hardening and service configuration.

The platform supports both manually provisioned
and Terraform-managed infrastructure.

Private administrative connectivity is provided
through Tailscale.

## Repository Structure

| Directory | Purpose |
|-----------|---------|
| inventories | Public reference and lab inventories |
| playbooks | Configuration orchestration |
| roles | Reusable configuration components |
| collections | External Ansible dependencies |
| tests | Automated verification |
| docs | Engineering documentation |
| .github/workflows | CI/CD validation |

## Engineering Standards

- Use fully qualified Ansible module names.
- Prefer declarative and idempotent tasks.
- Use the qman_ prefix for platform-wide variables.
- Use role-specific prefixes for role variables.
- Define explicit file permissions.
- Keep SSH host key verification enabled.
- Apply privilege escalation only where required.
- Pin automation dependencies.
- Validate configurations before deployment.
- Verify configuration changes in non-production first.

## Security

This repository is intended for public distribution.

The following information must never be committed:

- Provider credentials
- SSH private keys
- Passwords
- Unencrypted secrets
- Vault passwords
- Confidential infrastructure inventories
- Customer information
- Sensitive execution logs

Actual infrastructure inventories and credentials
are maintained outside this public repository.

Production configuration changes require explicit
authorization.

## Local Verification

Install the pinned Ansible Core version in an
isolated Python environment using requirements.txt.

Run the following commands from the repository root:

    ansible-inventory --graph
    ansible-playbook playbooks/verify.yml --syntax-check
    ansible-playbook playbooks/verify.yml

The default inventory targets localhost only.

## Related Projects

- qman-platform
- qman-infrastructure
- qman-compliance-engine
- qman-integration-tests

## Project Status

Active development — Configuration Management Foundation.

Remote server configuration, Linux hardening,
credential management and deployment automation
are pending implementation.

---

Qman Enterprise Platform

Secure by design. Automated by default.
