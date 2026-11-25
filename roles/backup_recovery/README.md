# Backup and Recovery Role

## Control

CFG-009 — Backup and Recovery

## Purpose

Establish a consistent backup and recovery
foundation for the Qman Enterprise Platform.

## Technology

- Restic
- Backblaze B2
- Ansible Vault
- systemd timers (planned)

## Policy

- Daily encrypted backups.
- Separate repositories per environment.
- Separate credentials per environment.
- Weekly repository integrity checks.
- Monthly restore exercises.
- Documented retention and recovery policies.

## Security

- Never commit backup credentials.
- Never expose repository passwords.
- Restrict repository permissions.
- Keep recovery credentials independently accessible.
- Validate deletion and retention operations.

## Recovery Objectives

Initial RPO target: 24 hours.
Initial RTO target: 4 hours.

These objectives require operational validation.

## Implementation Status

Development and preview only.

Remote backup automation, retention enforcement,
monitoring, systemd timer activation and live
recovery validation remain pending.
