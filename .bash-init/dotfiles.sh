#!/bin/bash

set_export_path_var DOTFILES_HOME "$HOME"/.config/dotfiles/home

mkdir -p "$DOTFILES_HOME"

function check() {
    git --git-dir="$DOTFILES_HOME" --work-tree="$HOME" "$@"
}

function gh-cd() {
    cd "$HOME/.config/dotfiles" || return
}

# check config status.showUntrackedFiles no
check config core.excludesfile ~/.config/dotfiles/global/git/ignore

for DIR in "$HOME/.config/dotfiles/"*/bin; do
    set_post_path_var PATH "$DIR"
done
