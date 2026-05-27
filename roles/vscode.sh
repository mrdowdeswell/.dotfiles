#!/usr/bin/env bash
# roles/vscode.sh — install VS Code and extensions
set -euo pipefail

echo "==> Installing VS Code role..."

DOTFILES_DIR="$(cd "$(dirname "$0")/.." && pwd)"

brew install --cask visual-studio-code

# Install extensions via the `code` CLI
# Add or remove extensions to taste
extensions=(
  "REditorSupport.r"
  "anthropic.claude-code"
  #"tomoki1207.pdf"
  #"wolframresearch.wolfram"
)

for ext in "${extensions[@]}"; do
  code --install-extension "$ext"
done

# Symlink settings.json
VSCODE_SETTINGS="$HOME/Library/Application Support/Code/User/settings.json"
mkdir -p "$(dirname "$VSCODE_SETTINGS")"
ln -sf "$DOTFILES_DIR/dotfiles/vscode-settings.json" "$VSCODE_SETTINGS"

echo "==> VS Code role complete."