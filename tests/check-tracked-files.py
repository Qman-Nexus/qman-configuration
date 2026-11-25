#!/usr/bin/env python3

"""Reject prohibited files in the public repository."""

import subprocess
from pathlib import PurePosixPath

files = subprocess.check_output(
    ["git", "ls-files", "-z"]
).decode().split("\0")

violations = []

for filename in filter(None, files):
    path = PurePosixPath(filename)
    name = path.name.lower()
    parts = tuple(part.lower() for part in path.parts)

    prohibited = (
        any(
            part in parts
            for part in (
                "credentials",
                "secrets",
                "private",
                ".venv",
                ".ansible",
            )
        )
        or (
            len(parts) >= 2
            and parts[0] == "inventories"
            and parts[1] in ("production", "nonproduction", "private")
        )
        or name.startswith(".env")
        or name.startswith(".vault_pass")
        or name.startswith("vault-password")
        or name.endswith((
            ".pem",
            ".key",
            ".password",
            ".retry",
            ".log",
        ))
        or name in (
            "vault.yml",
            "vault.yaml",
            "ansible.local.cfg",
            "id_rsa",
            "id_ed25519",
        )
    )

    if prohibited:
        violations.append(filename)

if violations:
    for filename in violations:
        print(f"Prohibited tracked file: {filename}")

    raise SystemExit("FAIL: Prohibited files detected.")

print("PASS: No prohibited tracked files.")
