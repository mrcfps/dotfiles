#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_ROOT="${DOTFILES_BACKUP_ROOT:-$HOME/.dotfiles-backup}"

LINKS=(
  ".config/opencode"
  ".config/ghostty"
  ".config/nvim"
  ".tmux.conf"
)

latest_backup_for() {
  local rel="$1"
  local candidate

  candidate="$(for dir in "$BACKUP_ROOT"/*; do
    [[ -e "$dir/$rel" || -L "$dir/$rel" ]] && printf '%s\n' "$dir/$rel"
  done 2>/dev/null | sort | tail -n 1)"

  printf '%s' "$candidate"
}

restore_link() {
  local rel="$1"
  local source="$DOTFILES_DIR/$rel"
  local target="$HOME/$rel"
  local backup

  if [[ -L "$target" ]]; then
    local current
    current="$(readlink "$target")"
    if [[ "$current" == "$source" ]]; then
      rm "$target"
      printf 'Removed link: %s\n' "$target"
    else
      printf 'Skipping non-dotfiles symlink: %s -> %s\n' "$target" "$current"
      return
    fi
  elif [[ -e "$target" ]]; then
    printf 'Skipping existing non-symlink target: %s\n' "$target"
    return
  fi

  backup="$(latest_backup_for "$rel")"
  if [[ -n "$backup" ]]; then
    mkdir -p "$(dirname "$target")"
    mv "$backup" "$target"
    printf 'Restored %s -> %s\n' "$backup" "$target"
  else
    printf 'No backup found for %s\n' "$target"
  fi
}

main() {
  for rel in "${LINKS[@]}"; do
    restore_link "$rel"
  done
}

main "$@"
