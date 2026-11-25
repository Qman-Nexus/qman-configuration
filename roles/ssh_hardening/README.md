# SSH Hardening Role

## Control

CFG-006B — OpenSSH Hardening

## Purpose

Establish a secure OpenSSH authentication baseline
for the Qman Enterprise Platform.

## Security Controls

- Disable direct root login.
- Disable password authentication.
- Disable keyboard-interactive authentication.
- Enable public key authentication.
- Prohibit empty passwords.
- Disable X11 forwarding.
- Limit authentication attempts.
- Enable verbose SSH logging.

## Configuration

The role uses a dedicated configuration drop-in:

/etc/ssh/sshd_config.d/00-qman-hardening.conf

Existing cloud-init configuration files remain unchanged.

## Compatibility

- Ubuntu Linux
- OpenSSH
- systemd socket activation
- Tailscale SSH

## Safety Requirements

- Verify emergency console access.
- Preserve an independent administrative session.
- Validate effective OpenSSH configuration.
- Verify recovery access before disabling passwords.
- Prepare a rollback procedure.
- Test private and public network access.

## Implementation Status

Preview only.

Live deployment, service reload, effective configuration
verification and recovery testing remain pending.

Provider firewall and host firewall management are
implemented separately.

## BLD-006B — Controlled SSH Deployment

Live execution is restricted to QMAN-02.

### Preconditions

- Verified independent administrative access.
- Provider recovery capabilities available.
- Protected configuration backup.
- Active timed rollback mechanism.
- Explicit deployment authorization.

### Validation

- Validate existing OpenSSH configuration.
- Deploy the managed configuration.
- Validate the complete OpenSSH configuration.
- Verify effective security settings.
- Reload only when configuration changes.
- Test independent administrative access.
- Verify idempotency.

Tailscale SSH and provider firewall policies
remain outside the scope of this role.

Cancel the rollback timer only after successful
deployment and connectivity validation.
