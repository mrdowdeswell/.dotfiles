#!/usr/bin/env bash
# ssh.sh — generate SSH key and register with GitHub
set -euo pipefail
 
echo "==> Setting up SSH key..."
 
KEY="$HOME/.ssh/id_ed25519"
TITLE="UTM VM $(date +%Y-%m-%d)"
 
# ── Generate key if not already present ──────────────────────────────────────
if [ ! -f "$KEY" ]; then
  mkdir -p "$HOME/.ssh"
  chmod 700 "$HOME/.ssh"
  ssh-keygen -t ed25519 -C "$TITLE" -f "$KEY" -N ""
  echo "  → Key generated: $KEY"
else
  echo "  → Key already exists at $KEY, skipping generation."
fi
 
# ── Install gh CLI if not present ────────────────────────────────────────────
if ! command -v gh &>/dev/null; then
  echo "==> Installing gh CLI..."
  brew install gh
fi
 
# ── Authenticate and register public key with GitHub ─────────────────────────
echo "==> Authenticating with GitHub (browser will open)..."
gh auth login --web --git-protocol ssh
 
echo "==> Registering public key with GitHub..."
gh ssh-key add "${KEY}.pub" --title "$TITLE"
 
# ── Add GitHub to known_hosts to avoid prompt on first git operation ──────────
if ! ssh-keygen -F github.com &>/dev/null; then
  echo "==> Adding GitHub to known_hosts..."
  ssh-keyscan -t ed25519 github.com >> "$HOME/.ssh/known_hosts"
fi
 
# ── Verify ────────────────────────────────────────────────────────────────────
echo "==> Verifying SSH connection to GitHub..."
ssh -T git@github.com 2>&1 || true
# ssh -T exits with code 1 even on success ("Hi username!"), hence `|| true`
 
echo ""
echo "==> SSH setup complete."

