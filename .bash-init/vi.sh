#!/bin/bash

set_prog_alias vi nvim vim vi
set_prog_alias vim nvim vim vi
set_export_prog_var VISUAL nvim vim vi
set_export_prog_var EDITOR nvim vim vi

set_alias vim-ls vim-list

set_export_var MANPAGER "$EDITOR +Man!"

# sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60 >/dev/null 2>/dev/null
# sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60 >/dev/null 2>/dev/null
# sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60 /dev/null 2>/dev/null

function vim-cd() {
    [[ -z $1 ]] && echo "usage: vim-cd <plugin> | config | conf | cf | local | loc | cache | plugins" && return
    local pldir=$XDG_CONFIG_HOME/nvim/pack/git-plugins/opt
    local cfdir=$XDG_CONFIG_HOME/nvim/lua/plugins
    local locdir=$XDG_DATA_HOME/nvim
    local cachedir=$HOME/.cache/nvim
    if [[ $1 == "config" || $1 == "cf" || $1 == "conf" ]]; then
        cd "$cfdir"
    elif [[ $1 == "local" || $1 == "loc" ]]; then
        cd "$locdir"
    elif [[ $1 == "plugins" ]]; then
        cd "$locdir/plugins"
    elif [[ $1 == "cache" ]]; then
        cd "$cachedir"
    elif [[ -d "$pldir/$1" ]]; then
        cd "$pldir/$1"
    else
        echo "cannot find directory for '$1'"
    fi
}

function vim-log() {
    [[ -z $1 ]] && echo "usage: vim-log <plugin>" && return
    local pldir=$XDG_CONFIG_HOME/nvim/pack/git-plugins/opt
    local plugin=${!#}
    local -a args
    for arg in "$@"; do
        if [[ $arg != "$plugin" ]]; then
            args+=("$arg")
        fi
    done
    pushd "$pldir/$plugin" >/dev/null
    git log ${args[*]}
    popd >/dev/null
}

_complete_vim_plugins() {
    pushd "$HOME/.config/nvim/pack/git-plugins/opt" >/dev/null
    COMPREPLY=($(/bin/ls -1dx *${2}* 2>/dev/null))
    popd >/dev/null
}

# completion for (some) vim-* commands
complete -F _complete_vim_plugins vim-cd vim-check vim-enable vim-disable vim-remove vim-log
