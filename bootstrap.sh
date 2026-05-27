#!/usr/bin/env bash
# bootstrap.sh — run once on a fresh macOS install
# Usage: bash bootstrap.sh
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "==> Starting bootstrap..."

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
ln -sf "$DOTFILES_DIR/dotfiles/.gitignore_global" "$HOME/.gitignore_global"

# ── git user name & email ─────────────────────────────────────────────────────
echo "==> Setting git user name and email..."
git config --global user.name "Mark Dowdeswell"
git config --global user.email "123539509+mrdowdeswell@users.noreply.github.com"
git config --global core.excludesfile ~/.gitignore_global
git config --global core.pager "less -FXR"

# ── macOS defaults ────────────────────────────────────────────────────────────
echo "==> Applying macOS defaults..."
bash "$DOTFILES_DIR/macOS_defaults.sh"

echo ""
echo "==> Bootstrap complete."
echo ""
echo "    Manual steps remaining:"
echo "    1. Open iTerm2 → Settings → Profiles → Text → change font to 'Hack Nerd Font Mono'"
echo "    2. Enable QuickLook plugins: System Settings → Privacy & Security → Extensions → Quick Look"
echo '    3. Run `bash ssh.sh` to generate a key to authenticate via SSH with GitHub (involves one time auth).'
echo '       After this is done, `git remote set-url origin git@github.com:mrdowdeswell/.dotfiles.git` to set the `.dotfiles` repo to SSH authentication.'
echo "    4. If this is a UTM VM, install Spice Guest Tools to enable clipboard sharing between host and guest"
echo ""
echo "    Optional role scripts available in roles/:"
echo "      bash roles/r.sh"
echo "      bash roles/vscode.sh"
echo "      bash roles/docker.sh"
echo "      bash roles/claudecode.sh"
