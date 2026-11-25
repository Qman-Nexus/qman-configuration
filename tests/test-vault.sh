#!/usr/bin/env bash

set -euo pipefail
umask 077

LAB_DIR="$(mktemp -d)"

trap 'rm -rf -- "$LAB_DIR"' EXIT

openssl rand -hex 32 > "$LAB_DIR/vault.password"
openssl rand -hex 32 > "$LAB_DIR/wrong.password"

cat > "$LAB_DIR/vault.yml" <<'VARS'
---
vault_demo_token: "ci-test-token"
vault_demo_password: "ci-test-password"
VARS

echo "Encrypting synthetic test variables"

ansible-vault encrypt \
    --vault-id "lab@$LAB_DIR/vault.password" \
    "$LAB_DIR/vault.yml"

echo "Verifying encrypted file header"

grep -q '^\$ANSIBLE_VAULT;' "$LAB_DIR/vault.yml"

echo "Testing successful decryption"

ansible-playbook \
    -i inventories/lab/hosts.yml \
    playbooks/verify_vault.yml \
    --vault-id "lab@$LAB_DIR/vault.password" \
    -e "@$LAB_DIR/vault.yml"

echo "Testing rejection of incorrect password"

if ansible-vault view \
    --vault-id "lab@$LAB_DIR/wrong.password" \
    "$LAB_DIR/vault.yml" >/dev/null 2>&1; then

    echo "FAIL: Incorrect password was accepted."
    exit 1
fi

echo "PASS: Vault encryption and decryption verified."
