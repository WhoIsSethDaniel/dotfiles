#!/bin/bash

GIT_HOME=$HOME/.config/dotfiles/home

mkdir -p "$GIT_HOME"

function check () {
  git --git-dir="$GIT_HOME" --work-tree="$HOME" "$@"
}

function gh-cd () {
  cd "$HOME/.config/dotfiles"
}

check config status.showUntrackedFiles no
check config core.excludesfile ~/.config/dotfiles/global/git/ignore

for DIR in "$HOME/.config/dotfiles/"*/bin; do
  set_post_path_var PATH "$DIR"
done
