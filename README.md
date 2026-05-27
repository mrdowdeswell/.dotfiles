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

You will need `git` to clone the `.dotfiles` repo. One way to get this is via the Xcode Command Line Tools, which is also needed to install `homebrew`.

```bash
sudo -v
xcode-select --install
```

Now that `git` is installed you can clone the repo and run the bootstrap shell script.
```bash
git clone https://github.com/mrdowdeswell/.dotfiles ~/.dotfiles
cd ~/.dotfiles
bash bootstrap.sh
```

## After bootstrap — manual steps

1. **iTerm2 font**: Settings → Profiles → Text → change font to `Hack Nerd Font Mono`
2. **QuickLook plugins**: System Settings → Privacy & Security → Extensions → Quick Look
   → enable QLMarkdown and Syntax Highlight
3. **SSH**: Run `bash ssh.sh` to generate a key to authenticate via SSH with GitHub (involves one time auth). After this is done, 

    ```bash
    cd ~/.dotfiles
    git remote set-url origin git@github.com:mrdowdeswell/.dotfiles.git
    ```

    to set the `.dotfiles` repo to SSH authentication.
4. **UTM clipboard sharing**: Install the Spice Guest Tools in the UTM VM to enable host/guest clipboard sharing.

## Optional roles

Run any of these after bootstrap as needed:

```bash
bash roles/r.sh           # R & RStudio
bash roles/vscode.sh      # VS Code
bash roles/docker.sh      # Docker Desktop
bash roles/claudecode.sh  # Claude Code
```

