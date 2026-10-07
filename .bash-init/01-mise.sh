#!/bin/bash

unset_var MISE_ENV
mise_envs=(neovim)
WORK_MISE=~/.config/dotfiles/main/config/mise/mise.work.toml
HOME_MISE=~/.config/dotfiles/main/config/mise/mise.home.toml
if [[ -e $WORK_MISE ]]; then
    mise_envs+=(work)
    ln -sf "$WORK_MISE" ~/.config/mise/mise.work.toml
    eval "$(mise --env work activate bash)"
elif [[ -e $HOME_MISE ]]; then
    mise_envs+=(home)
    ln -sf "$HOME_MISE" ~/.config/mise/mise.home.toml
    eval "$(mise --env work activate bash)"
else
    eval "$(mise activate bash)"
fi
touch ~/.config/mise/mise.lock

set_alias mise-upgrade "mise --env "$(IFS=,; echo "${mise_envs[*]}")" upgrade"
