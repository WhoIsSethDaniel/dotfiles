#!/bin/bash

if [[ -f ~/.config/dotfiles/main/.config/mise/mise.work.toml ]]; then
    ln -sf ~/.config/dotfiles/main/.config/mise/mise.work.toml ~/.config/mise/mise.work.toml
fi

eval "$(mise activate bash)"
