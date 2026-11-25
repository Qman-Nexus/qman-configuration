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
