# dotfiles

Personal development configuration managed with Git.

Included:

- `.config/opencode`
- `.config/ghostty`
- `.config/nvim`
- `.tmux.conf`

## Usage

Install symlinks into `$HOME`:

```bash
./install.sh
```

Existing targets are moved to `~/.dotfiles-backup/<timestamp>/` before links are created.

Uninstall symlinks and restore the latest backup when available:

```bash
./uninstall.sh
```
