# dotfiles

Personal development configuration managed with Git.

## What's included

- **opencode**: AI coding agent configuration and `oh-my-opencode-slim` routing.
- **Ghostty**: terminal font, theme, opacity, scrolling, and macOS key behavior.
- **Neovim**: Lua-based editor setup, plugins, LSP, Telescope, Treesitter, Git signs, tests, and terminal integration.
- **tmux**: prefix/keybindings, panes, mouse support, Catppuccin theme, and TPM plugins.

Tracked paths:

- `.config/opencode`
- `.config/ghostty`
- `.config/nvim`
- `.tmux.conf`

## Quick start

Clone the repo:

```bash
git clone git@github.com:mrcfps/dotfiles.git ~/Projects/dotfiles
cd ~/Projects/dotfiles
```

Install symlinks into `$HOME`:

```bash
./install.sh
```

Existing targets are moved to `~/.dotfiles-backup/<timestamp>/` before links are created.

## Tools

### opencode

Config location:

```text
~/.config/opencode
```

Main files:

- `opencode.json`: base opencode config.
- `oh-my-opencode-slim.json`: orchestrator/sub-agent model routing.
- `tui.json`: terminal UI settings.

The config expects API keys from environment variables, for example:

```bash
export OPENROUTER_API_KEY="..."
```

Local package files, lockfiles, runtime state, backups, and machine-local skill links are ignored.

### Ghostty

Config location:

```text
~/.config/ghostty/config
```

Highlights:

- JetBrains Mono Nerd Font + PingFang SC fallback.
- Catppuccin Mocha theme.
- Semi-transparent background.
- Option-as-Alt behavior for macOS.
- tmux/Neovim-friendly terminal settings.

### Neovim

Config location:

```text
~/.config/nvim
```

Entry point:

```text
~/.config/nvim/init.lua
```

Common features:

- Plugin management via `lazy.nvim`.
- LSP and Mason setup.
- Telescope search helpers.
- Treesitter syntax support.
- Git signs and trouble diagnostics.
- ToggleTerm integration.
- Which-key leader mappings.

Start Neovim:

```bash
nvim
```

### tmux

Config location:

```text
~/.tmux.conf
```

Highlights:

- Prefix: `Ctrl-Space` / `C-@`.
- Split panes:
  - `prefix |`: horizontal split.
  - `prefix -`: vertical split.
- Vim-style pane navigation: `prefix h/j/k/l`.
- Reload config: `prefix r`.
- Catppuccin theme and TPM plugins.

Install tmux plugins after first launch:

```text
prefix + I
```

## Update workflow

After changing any live config under `~/.config/...` or `~/.tmux.conf`, the changes are already inside this repo because those paths are symlinks.

Commit and push changes:

```bash
cd ~/Projects/dotfiles
git status
git add .
git commit -m "Update dotfiles"
git push
```

## Uninstall

Uninstall symlinks and restore the latest backup when available:

```bash
./uninstall.sh
```

## Notes

- Backups are stored under `~/.dotfiles-backup/<timestamp>/`.
- `install.sh` is idempotent for already-correct symlinks.
- Secrets should stay in environment variables, not committed files.
