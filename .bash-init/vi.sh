#!/bin/bash

set_pre_path_var PATH "$HOME/.local/nvim/current/bin"
set_pre_path_var PATH "$HOME/.local/share/nvim/mason/bin"

editor_list="nvim vim vi"
if [[ -S $NVIM_LISTEN_ADDRESS ]]; then
    editor_list="nvr "$editor_list
fi

set_prog_alias vi "$editor_list"
set_prog_alias vim "$editor_list"
set_export_prog_var VISUAL "$editor_list"
set_export_prog_var EDITOR "$editor_list"

if [[ -n $EDITOR ]]; then
    unset_var GIT_EDITOR
    if [[ $EDITOR =~ nvr$ ]]; then
        set_export_var GIT_EDITOR "$EDITOR --remote-wait-silent"
    else
        set_export_var GIT_EDITOR "$EDITOR"
    fi
fi

set_alias vim-ls vim-list

set_export_var MANPAGER "$EDITOR +Man!"

pldir=$XDG_DATA_HOME/nvim/site/pack/core/opt
vim_install_dir=$HOME/.local/nvim
declare -A vim_cd
vim_cd=(
    [cache]="$HOME/.cache/nvim"
    [config]="$XDG_CONFIG_HOME/nvim/lua/plugins/"
    [install]="$vim_install_dir"
    [local]="$XDG_DATA_HOME/nvim"
    [plugins]="$pldir"
    [state]="$HOME/.local/state/nvim"
    [log]="$HOME/.local/state/nvim"
)

function vim-cd() {
    local cd_keys=$(echo "${!vim_cd[*]}" | tr " " "|")
    [[ -z $1 ]] && echo "usage: vim-cd <plugin>|$cd_keys" && return
    for K in "${!vim_cd[@]}"; do
        if [[ $1 == "$K" ]]; then
            cd "${vim_cd[$K]}" || return
            return
        fi
    done
    if [[ -d "$pldir/$1" ]]; then
        cd "$pldir/$1" || return
    else
        echo "cannot find directory for '$1'"
    fi
}

function vim-log() {
    [[ -z $1 ]] && echo "usage: vim-log <plugin>" && return
    local plugin=${!#}
    local -a args
    for arg in "$@"; do
        if [[ $arg != "$plugin" ]]; then
            args+=("$arg")
        fi
    done
    pushd "$pldir/$plugin" >/dev/null || return
    git log "${args[@]}"
    popd >/dev/null || return
}

_complete_vim_plugins() {
    read -r -a COMPREPLY <<<"$(vim-ls | grep -iF "${2}" | tr "\n" " " 2>/dev/null)"
}

_complete_vim_cd() {
    local plugin_names=$(vim-ls)
    local cd_keys="${!vim_cd[*]}"
    local possibles="$(echo "$cd_keys" "$plugin_names" | tr " " "\n")"
    read -r -a COMPREPLY <<<"$(echo "$possibles" | grep -iF "${2}" | tr "\n" " " 2>/dev/null)"
}

_complete_vim_installed_versions() {
    pushd "$vim_install_dir" >/dev/null || return
    local possibles
    for d in ./*; do
        v=$(basename "$d")
        [[ $v == 'current' ]] && continue
        possibles+=("$v")
    done
    read -r -a COMPREPLY <<<"$(echo "${possibles[@]}" | tr " " "\n" | grep -iF "${2}" | tr "\n" " " 2>/dev/null)"
    popd >/dev/null || return
}

# completion for (some) vim-* commands
complete -F _complete_vim_installed_versions vim-switch
complete -F _complete_vim_plugins vim-check vim-enable vim-disable vim-rename vim-remove vim-log vim-config vim-freeze vim-thaw
complete -F _complete_vim_cd vim-cd
