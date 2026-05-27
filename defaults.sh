#!/usr/bin/env bash
# defaults.sh — macOS UI preferences
# Safe to re-run. Most changes take effect after killing the relevant process
# or logging out/in; a few require a reboot.
set -euo pipefail

echo "  → Applying macOS defaults..."

# ── Appearance ────────────────────────────────────────────────────────────────
# Dark mode
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"

# ── Keyboard ──────────────────────────────────────────────────────────────────
# Fast key repeat (lower = faster; default is 6)
defaults write NSGlobalDomain KeyRepeat -int 2
# Short delay before repeat starts (default is 68)
defaults write NSGlobalDomain InitialKeyRepeat -int 25

# ── Trackpad / Mouse ──────────────────────────────────────────────────────────
# Tap to click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# ── Finder ────────────────────────────────────────────────────────────────────
# Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
# Show hidden files
defaults write com.apple.finder AppleShowAllFiles -bool true
# Show path bar at bottom of Finder window
defaults write com.apple.finder ShowPathbar -bool true
# Default to list view
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# ── Dock ──────────────────────────────────────────────────────────────────────
# Auto-hide the Dock
defaults write com.apple.dock autohide -bool true
# Remove auto-hide delay
defaults write com.apple.dock autohide-delay -float 0
# Faster auto-hide animation
defaults write com.apple.dock autohide-time-modifier -float 0.5
# Don't show recent apps in Dock
defaults write com.apple.dock show-recents -bool false

# ── Screenshots ───────────────────────────────────────────────────────────────
# Save screenshots to ~/Desktop/Screenshots rather than cluttering the desktop
mkdir -p "$HOME/Desktop/Screenshots"
defaults write com.apple.screencapture location -string "$HOME/Desktop/Screenshots"
# Save as PNG
defaults write com.apple.screencapture type -string "png"

# ── Reload affected services ──────────────────────────────────────────────────
killall Dock    2>/dev/null || true
killall Finder  2>/dev/null || true

echo "  → macOS defaults applied."
echo "    Note: dark mode and some other changes take full effect after log out/in."
