# Network Security Change and Recovery Runbook

## Control

CFG-006 — SSH and Firewall Hardening

## Scope

Qman Enterprise Platform Linux servers.

Initial implementation is restricted to
non-production infrastructure.

## Preconditions

- Explicit change authorization.
- Working Tailscale administrative access.
- Working Ansible connectivity.
- Verified provider firewall configuration.
- Verified provider recovery capabilities.
- Protected configuration backups.
- Documented rollback procedure.
- Independent administrative session.

## Configuration Backup

Before applying changes, preserve:

- /etc/ssh/sshd_config
- /etc/ssh/sshd_config.d/
- /etc/ufw/
- /etc/default/ufw
- Relevant systemd overrides
- Existing provider firewall configuration

Configuration backups must remain private.

## Implementation Sequence

1. Verify recovery access.
2. Capture the current configuration.
3. Prepare a timed rollback mechanism.
4. Validate the candidate OpenSSH configuration.
5. Apply OpenSSH hardening.
6. Validate effective SSH settings.
7. Test a new independent administrative session.
8. Configure the host firewall.
9. Verify management access before firewall activation.
10. Activate the host firewall.
11. Repeat all connectivity tests.
12. Verify provider console compatibility.
13. Verify reboot persistence.
14. Verify Ansible idempotency.
15. Cancel rollback only after successful validation.

## Rollback Triggers

- Loss of Tailscale connectivity.
- Failed administrative authentication.
- Invalid OpenSSH configuration.
- Unexpected public SSH exposure.
- Incorrect IPv4 or IPv6 filtering.
- Failed Ansible connectivity.
- Unavailable recovery access.

## Recovery Procedure

If validation fails:

1. Stop further configuration changes.
2. Use the existing administrative session.
3. Restore the previous SSH and UFW configuration.
4. Restore the previous firewall activation state.
5. Validate SSH configuration before reload.
6. Revalidate private administrative access.
7. Confirm public SSH remains blocked.

If normal administrative access is unavailable,
use the provider recovery facilities.

Provider web consoles may depend on SSH and
must not be treated as guaranteed out-of-band access.

Emergency mode is a last-resort recovery mechanism.

## Security Constraints

- Do not disable the provider firewall as a
  routine troubleshooting step.
- Do not disable SSH host key verification.
- Do not modify Tailscale access policies.
- Do not expose SSH to the public internet.
- Do not publish infrastructure-specific backups.

## Implementation Status

Development and preview completed.

Live deployment roles, timed rollback automation,
effective configuration validation, reboot testing,
and recovery execution remain deferred until
the controlled infrastructure rebuild.
