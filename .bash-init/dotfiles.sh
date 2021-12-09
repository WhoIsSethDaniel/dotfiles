#!/bin/bash

function check () {
  git --git-dir="$HOME/.dotfiles" --work-tree="$HOME" "$@"
}
