# Firewall Management Role

## Control

CFG-006C — Firewall Management

## Purpose

Provide a standardized host firewall baseline
for the Qman Enterprise Platform.

## Policy

- Default deny incoming traffic.
- Default allow outgoing traffic.
- Default deny routed traffic.
- Allow public HTTP and HTTPS.
- Permit SSH management through tailscale0.
- Maintain IPv4 and IPv6 protection.

## Tailscale Integration

Preserve automatic Tailscale netfilter management.

Tailnet authorization remains governed by
Tailscale access and SSH policies.

## Security Requirements

- Preserve provider firewall protection.
- Verify emergency recovery access.
- Prepare rollback procedures.
- Validate public and private connectivity.
- Validate IPv4 and IPv6 independently.

## Implementation Status

Development and preview completed.

Live activation, combined policy validation,
recovery testing and idempotency remain deferred
until the controlled infrastructure rebuild.

## Firewall Drift Detection

The firewall role compares configured UFW user rules against the desired state derived from Ansible variables.

The compliance check detects:

- Unexpected firewall rules.
- Missing firewall rules.

If configuration drift is detected, the playbook fails without modifying the firewall.

### Validation Results

**Date:** 2026-11-26  
**Environment:** Non-production  
**Target:** QMAN-02

| Test | Expected result | Status |
|---|---|---|
| Positive compliance test | Compliance accepted | Passed |
| Unexpected rule detection | Rule detected | Passed |
| Missing rule detection | Rule detected | Passed |
| Negative compliance test | Playbook fails | Passed |
| Final validation | Compliance accepted | Passed |

Final Ansible execution:

```text
ok=14 changed=0 unreachable=0 failed=0
```

### Security Considerations

- Management access is restricted by the configured UFW policy to the Tailscale interface.
- Firewall drift is reported, not automatically remediated.
- Negative testing uses temporary variable overrides.
- No firewall configuration changes were performed during validation.

### Known Limitations

- Rule ordering is not validated.
- Logging and default policies are not yet enforced by compliance assertions.
- External network reachability has not been independently verified.
- Firewall apply functionality is not implemented.
