# Credential Management Standard

## Control

CFG-004 — Secure Credential Management

## Principles

- Prefer short-lived workload identities.
- Apply least privilege access.
- Separate production and non-production credentials.
- Never commit credentials to public repositories.
- Encrypt sensitive configuration variables.
- Prevent secret disclosure in automation logs.
- Document credential rotation and recovery.

## Ansible Vault

Ansible Vault is used to encrypt sensitive
configuration variables at rest.

Separate vault identities and unique passwords
must be used for:

- lab
- nonproduction
- production

Vault identity labels are not security boundaries
by themselves. Each environment must use a
different password.

## Storage

Encrypted vault files and actual infrastructure
inventories are maintained outside the public
configuration repository.

Private directories must use permissions of 0700.

Credential files must use permissions of 0600
where applicable.

Vault passwords must be stored separately in
an approved password manager.

## Automation

Interactive execution uses vault password prompts.

Automated execution requires a separately approved
credential retrieval mechanism.

Production secrets must not be available to
non-production workflows.

## Logging

Tasks handling sensitive values must use
no_log: true where appropriate.

Diff output must be disabled for tasks managing
sensitive file content.

Sensitive variables must not be exposed through
debug tasks or execution logs.

## Recovery

Encrypted vault files must be included in the
approved backup and recovery strategy.

Vault password recovery must be maintained
separately from encrypted configuration backups.

Recovery must be tested before production use.

## Prohibited Practices

- Hardcoded credentials
- Shared passwords across environments
- Unencrypted credential files in Git
- Vault passwords stored alongside vault files
- Secrets exposed in automation logs
- Production credentials used in lab environments

## Implementation Status

Local Vault integration is the initial implementation.

Production and non-production vault provisioning,
automated credential retrieval and recovery testing
remain pending.
