#!/bin/bash

WORK_MISE=~/.config/dotfiles/main/.config/mise/mise.work.toml
if [[ -e $WORK_MISE ]]; then
    ln -sf "$WORK_MISE" ~/.config/mise/mise.work.toml
    set_export_var MISE_ENV work
    eval "$(mise --env work activate bash)"
else
    eval "$(mise activate bash)"
fi
