#!/usr/bin/env bash
# roles/claudecode.sh — install Claude Code
set -euo pipefail

echo "==> Installing Claude Code role..."

curl -fsSL https://claude.ai/install.sh | sh

echo "==> Claude Code role complete."
echo "    Run: claude setup-token"