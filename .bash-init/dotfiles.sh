#!/bin/bash

function check () {
  git --git-dir="$HOME/.dotfiles" --work-tree="$HOME" "$@"
}

set_alias git-crypt "GIT_DIR=$HOME/.dotfiles GIT_WORK_TREE=$HOME git-crypt"
