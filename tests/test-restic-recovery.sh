#!/usr/bin/env bash

set -euo pipefail
umask 077

RESTIC_BIN="$(command -v restic)"

LAB_ROOT="$HOME/qman-greenfield/labs"

mkdir -p "$LAB_ROOT"

LAB_DIR="$(mktemp -d "$LAB_ROOT/restic-cfg009.XXXXXX")"

mkdir -p "$LAB_DIR/source"
mkdir -p "$LAB_DIR/restore"

openssl rand -hex 32 > "$LAB_DIR/lab.password"
chmod 600 "$LAB_DIR/lab.password"

run_restic() {
    env -i PATH="$PATH" HOME="$HOME" \
        "$RESTIC_BIN" \
        --repo "$LAB_DIR/repository" \
        --password-file "$LAB_DIR/lab.password" \
        --no-cache "$@"
}

cd "$LAB_DIR"

printf '%s\n' \
    'Qman Enterprise Platform' \
    'Environment: lab' \
    'Control: CFG-009' \
    > source/platform.conf

echo "Creating original checksum"

ORIGINAL_HASH="$(shasum -a 256 source/platform.conf | awk '{print $1}')"

echo "Initializing isolated test repository"

run_restic init

echo "Creating backup"

run_restic backup source --tag cfg-009-test

echo "Listing snapshots"

run_restic snapshots

echo "Checking repository integrity"

run_restic check --read-data

echo "Restoring backup"

run_restic restore latest --target "$LAB_DIR/restore"

echo "Verifying restored file"

RESTORED_HASH="$(shasum -a 256 restore/source/platform.conf | awk '{print $1}')"

echo "Original checksum: $ORIGINAL_HASH"
echo "Restored checksum: $RESTORED_HASH"

if [ "$ORIGINAL_HASH" != "$RESTORED_HASH" ]; then
    echo "FAIL: Restored data does not match original data."
    exit 1
fi

echo "PASS: Backup and recovery verified."
echo "Lab directory: $LAB_DIR"
