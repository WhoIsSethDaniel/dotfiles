#!/bin/bash

if [[ -f ~/.config/dotfiles/main/bash/work.sh ]]; then
    . ~/.config/dotfiles/main/bash/work.sh
fi
if [[ -d ~/.config/dotfiles/main/bin ]]; then
    set_post_path_var PATH ~/.config/dotfiles/main/bin
fi
