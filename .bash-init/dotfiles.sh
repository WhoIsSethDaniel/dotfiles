#!/bin/bash

function check () {
  git --git-dir="$HOME/.dotfiles" --work-tree="$HOME" "$@"
}

for DIR in "$HOME/.config/dotfiles/"*/bin; do
  set_post_path_var PATH "$DIR"
done
