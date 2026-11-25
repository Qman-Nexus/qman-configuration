# Patch Management Role

## Control

CFG-007 — Patch Management

## Purpose

Provide a consistent operating system patch
management baseline for the Qman Enterprise Platform.

## Supported Platforms

- Ubuntu Linux
- APT package management
- systemd

## Patch Policy

- Automatically install approved security updates.
- Refresh package metadata daily.
- Validate regular updates in non-production.
- Schedule operating system release upgrades.
- Disable automatic operating system reboots.
- Disable automatic dependency and kernel cleanup.

## Configuration

/etc/apt/apt.conf.d/99-qman-patch-management

Existing vendor configuration files remain unchanged.

## Security Requirements

- Use approved and authenticated package repositories.
- Monitor failed security updates.
- Monitor pending reboot requirements.
- Review package repository coverage.
- Maintain tested backup and recovery procedures.

Third-party repositories require a separate
patch management strategy.

## Availability

Security updates may restart services.

Required operating system reboots must be
scheduled and followed by service validation.

## Reporting

- Unattended-upgrades package status
- Effective APT configuration
- APT timer status
- Available package upgrades
- Reboot requirement

## Implementation Status

Development and preview only.

Package installation, timer activation, candidate
configuration validation, live patch verification,
monitoring integration, and idempotency testing
remain pending until controlled deployment.

## OPS-002A — Controlled Deployment

- Controlled apply playbook implemented.
- Non-production deployment validated.
- Automatic APT maintenance timers enabled.
- Idempotency verified: 16 successful tasks, zero changes.
- Automatic operating system reboots remain disabled.
- Regular and third-party package upgrades remain pending.
