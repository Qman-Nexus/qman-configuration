#!/usr/bin/env bash

set -euo pipefail
umask 077

cd "$(dirname "$0")/.."

echo "=== Qman Configuration CI ==="

echo "=== Prohibited file detection ==="
python tests/check-tracked-files.py

echo "=== YAML validation ==="
yamllint --strict \
    playbooks \
    roles \
    inventories/lab \
    tests/syntax_inventory.yml \
    .github/workflows

echo "=== Ansible lint ==="
ansible-lint --offline playbooks/ roles/

echo "=== Playbook syntax validation ==="

for playbook in playbooks/*.yml; do
    echo "Checking $playbook"

    ansible-playbook \
        -i inventories/lab/hosts.yml \
        -i tests/syntax_inventory.yml \
        "$playbook" \
        --syntax-check
done

echo "=== Local integration test ==="
ansible-playbook \
    -i inventories/lab/hosts.yml \
    playbooks/verify.yml \
    --limit localhost

echo "=== Vault integration test ==="
bash tests/test-vault.sh

echo "=== Restic recovery test ==="

TEST_HOME="$(mktemp -d)"
trap 'rm -rf -- "$TEST_HOME"' EXIT

HOME="$TEST_HOME" bash tests/test-restic-recovery.sh

echo "=== Python dependency security audit ==="
pip-audit

echo "PASS: All Qman CI checks completed."
