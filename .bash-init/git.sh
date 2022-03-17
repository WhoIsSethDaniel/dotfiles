#!/bin/bash

# set_export_var GIT_CONFIG_GLOBAL "$HOME/.config/dotfiles/main/git/config"

unset_var GIT_PAGER
if [[ $PAGER =~ less$ ]]; then
    set_export_var GIT_PAGER "$PAGER $LESS -F"
fi
