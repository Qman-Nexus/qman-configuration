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
