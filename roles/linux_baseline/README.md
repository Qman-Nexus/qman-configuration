# Linux Baseline Role

## Control

CFG-005 — Linux Security Baseline

## Purpose

Establish a consistent Linux configuration
foundation for the Qman Enterprise Platform.

## Supported Platforms

- Ubuntu Linux
- systemd-based systems

## Responsibilities

- Operating system validation
- Baseline package management
- Standardized platform metadata
- Explicit file ownership and permissions
- Time synchronization verification

## Default Variables

| Variable | Purpose |
|----------|---------|
| linux_baseline_version | Baseline version |
| linux_baseline_packages | Required packages |
| linux_baseline_platform_name | Platform name |
| linux_baseline_metadata_path | Metadata file path |

## Required Inventory Variables

- qman_environment

## Security

- Privilege escalation is limited to tasks
  requiring administrative permissions.
- Package removal is prohibited by default.
- Secrets must not be stored in platform metadata.
- Production changes require explicit authorization.
- Preview execution is restricted to non-production.

## Validation

The initial implementation is validated using
Ansible check mode and package installation simulation.

Full execution and idempotency testing must be
completed on an approved Linux test environment.

## Out of Scope

- SSH hardening
- Firewall configuration
- User management
- Automatic security updates
- Application installation
- Backup configuration

These capabilities are implemented separately.

## Status

Initial baseline implementation.
Live application and idempotency verification pending.

## BLD-005 — Controlled Deployment

Live deployment is restricted to the approved
non-production server.

### Safety Requirements

- Inventory alias: qman-02
- Environment: nonproduction
- Operating system: Ubuntu 26.04 LTS
- Hostname: qman-nonprod-01
- Explicit deployment authorization required.
- Time synchronization verified before changes.

### Deployment Lifecycle

1. Pass repository CI checks.
2. Merge the approved pull request.
3. Verify the target inventory.
4. Execute the baseline preview.
5. Authorize live deployment.
6. Verify the resulting configuration.
7. Repeat deployment to verify idempotency.

### Exclusions

Production deployment remains prohibited.

SSH, firewall, patch management, monitoring
and backup configuration are managed separately.
