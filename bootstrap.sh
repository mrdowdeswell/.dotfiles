#!/usr/bin/env bash
# bootstrap.sh — run once on a fresh macOS install
# Usage: bash bootstrap.sh
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "==> Starting bootstrap..."

# ── Xcode Command Line Tools ─────────────────────────────────────────────────
if ! xcode-select -p &>/dev/null; then
  echo "==> Installing Xcode Command Line Tools..."
  xcode-select --install
  # Wait for installation to complete before proceeding
  echo "    Re-run this script once Xcode CLT installation is complete."
  exit 0
fi

# ── Homebrew ──────────────────────────────────────────────────────────────────
if ! command -v brew &>/dev/null; then
  echo "==> Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Apple Silicon path (no-op on Intel)
if [[ -f /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# ── Homebrew packages ─────────────────────────────────────────────────────────
echo "==> Installing Homebrew packages..."
brew bundle --file="$DOTFILES_DIR/Brewfile"

# ── oh-my-zsh ─────────────────────────────────────────────────────────────────
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "==> Installing oh-my-zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# ── zsh plugins (external) ────────────────────────────────────────────────────
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  echo "==> Installing zsh-autosuggestions..."
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  echo "==> Installing zsh-syntax-highlighting..."
  git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

# ── Dotfiles (symlinks) ───────────────────────────────────────────────────────
echo "==> Symlinking dotfiles..."
ln -sf "$DOTFILES_DIR/dotfiles/.zshrc" "$HOME/.zshrc"
mkdir -p "$HOME/.config"
ln -sf "$DOTFILES_DIR/dotfiles/starship.toml" "$HOME/.config/starship.toml"

# ── macOS defaults ────────────────────────────────────────────────────────────
echo "==> Applying macOS defaults..."
bash "$DOTFILES_DIR/defaults.sh"

echo ""
echo "==> Bootstrap complete."
echo ""
echo "    Manual steps remaining:"
echo "    1. Open iTerm2 → Settings → Profiles → Text → change font to 'Hack Nerd Font Mono'"
echo "    2. Enable QuickLook plugins: System Settings → Privacy & Security → Extensions → Quick Look"
echo "    3. Start a new zsh session (or: source ~/.zshrc)"
echo ""
echo "    Optional role scripts available in roles/:"
echo "      bash roles/r.sh"
echo "      bash roles/vscode.sh"
echo "      bash roles/docker.sh"
echo "      bash roles/claudecode.sh"
