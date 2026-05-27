# .dotfiles

macOS bootstrap for a fresh install (UTM VM or physical machine).

## Structure

```
.dotfiles/
├── bootstrap.sh          # run once on a fresh machine
├── Brewfile              # all Homebrew packages and casks
├── defaults.sh           # macOS UI preferences via `defaults write`
├── dotfiles/
│   ├── .zshrc            # symlinked to ~/.zshrc
│   └── starship.toml     # symlinked to ~/.config/starship.toml
└── roles/                # optional, run selectively after bootstrap
    ├── r.sh
    ├── vscode.sh
    ├── docker.sh
    └── claudecode.sh
```

## Fresh machine setup

```bash
git clone https://github.com/mrdowdeswell/.dotfiles ~/.dotfiles
cd ~/.dotfiles
bash bootstrap.sh
```

If Xcode Command Line Tools weren't already installed, the script will prompt
for that and exit. Re-run `bash bootstrap.sh` once the CLT installation finishes.

## After bootstrap — manual steps

1. **iTerm2 font**: Settings → Profiles → Text → change font to `Hack Nerd Font Mono`
2. **QuickLook plugins**: System Settings → Privacy & Security → Extensions → Quick Look
   → enable QLMarkdown and Syntax Highlight
3. Start a new shell session

## Optional roles

Run any of these after bootstrap as needed:

```bash
bash roles/r.sh           # R + RStudio
bash roles/vscode.sh      # VS Code
bash roles/docker.sh      # Docker Desktop
bash roles/claudecode.sh  # Claude Code
```

## Iteration workflow (UTM VM)

1. Restore the clean snapshot
2. Clone this repo and run `bootstrap.sh`
3. Note anything missing or broken
4. Update the relevant file in the repo
5. Repeat
