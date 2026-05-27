# .zshrc

# ── oh-my-zsh ─────────────────────────────────────────────────────────────────
export ZSH="$HOME/.oh-my-zsh"

COMPLETION_WAITING_DOTS="true"

plugins=(
  git
  macos
  zsh-autosuggestions
  zsh-syntax-highlighting
)

export ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST
source $ZSH/oh-my-zsh.sh

# ── Locale ────────────────────────────────────────────────────────────────────
export LANG=en_GB.UTF-8
export LC_MONETARY=af_ZA

# ── Aliases ───────────────────────────────────────────────────────────────────
alias localip="ipconfig getifaddr en0"
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias path='echo $PATH | tr ":" "\n"'
alias resetusb='sudo launchctl stop com.apple.usbd; sudo launchctl start com.apple.usbd'

# ── Docker (only if installed) ────────────────────────────────────────────────
if command -v docker &>/dev/null; then
  if [ -d "$HOME/.docker/completions" ]; then
    fpath=($HOME/.docker/completions $fpath)
    autoload -Uz compinit
    compinit
  fi
  alias dcu="docker compose up -d"
  alias dcd="docker compose down"
fi

# ── R (only if installed) ─────────────────────────────────────────────────────
if command -v R &>/dev/null; then
  alias R="R --no-save"
fi

# ── Claude Code (only if installed) ──────────────────────────────────────────
if [ -d "$HOME/.local/bin" ]; then
  export PATH="$HOME/.local/bin:$PATH"
fi

# ── Greeting ──────────────────────────────────────────────────────────────────
echo -e "\nYou are on a "$(getconf LONG_BIT)"-bit architecture."

# ── Starship prompt ───────────────────────────────────────────────────────────
eval "$(starship init zsh)"
