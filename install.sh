#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_ROOT="${DOTFILES_BACKUP_ROOT:-$HOME/.dotfiles-backup}"
BACKUP_DIR="$BACKUP_ROOT/$(date +%Y%m%d-%H%M%S)"

LINKS=(
  ".config/opencode"
  ".config/ghostty"
  ".config/nvim"
  ".tmux.conf"
)

backup_target() {
  local target="$1"
  local rel="$2"
  local backup="$BACKUP_DIR/$rel"

  mkdir -p "$(dirname "$backup")"
  mv "$target" "$backup"
  printf 'Backed up %s -> %s\n' "$target" "$backup"
}

install_link() {
  local rel="$1"
  local source="$DOTFILES_DIR/$rel"
  local target="$HOME/$rel"

  if [[ ! -e "$source" && ! -L "$source" ]]; then
    printf 'Missing source: %s\n' "$source" >&2
    exit 1
  fi

  mkdir -p "$(dirname "$target")"

  if [[ -L "$target" ]]; then
    local current
    current="$(readlink "$target")"
    if [[ "$current" == "$source" ]]; then
      printf 'Already linked: %s -> %s\n' "$target" "$source"
      return
    fi
    backup_target "$target" "$rel"
  elif [[ -e "$target" ]]; then
    backup_target "$target" "$rel"
  fi

  ln -s "$source" "$target"
  printf 'Linked %s -> %s\n' "$target" "$source"
}

main() {
  for rel in "${LINKS[@]}"; do
    install_link "$rel"
  done

  if [[ -d "$BACKUP_DIR" ]]; then
    printf '\nBackups saved in: %s\n' "$BACKUP_DIR"
  fi
}

main "$@"
