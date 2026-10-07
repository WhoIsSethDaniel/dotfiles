#!/bin/bash

WORK_MISE=~/.config/dotfiles/main/config/mise/mise.work.toml
HOME_MISE=~/.config/dotfiles/main/config/mise/mise.home.toml
if [[ -e $WORK_MISE ]]; then
    MISE_ENV=work
    ln -sf "$WORK_MISE" ~/.config/mise/mise.work.toml
    eval "$(mise --env work activate bash)"
elif [[ -e $HOME_MISE ]]; then
    MISE_ENV=home
    ln -sf "$HOME_MISE" ~/.config/mise/mise.home.toml
    eval "$(mise --env work activate bash)"
else
    eval "$(mise activate bash)"
fi
touch ~/.config/mise/mise.lock
