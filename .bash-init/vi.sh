#!/bin/bash

set_pre_path_var PATH "$HOME/.local/nvim/current/bin"
set_pre_path_var PATH "$HOME/.local/share/nvim/mason/bin"

set_export_var VIM_VERSIONS "[stable]=0.11.0 [nightly]=0.12.0"

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

vim_install_dir=$HOME/.local/nvim
function vim-cd() {
    [[ -z $1 ]] && echo "usage: vim-cd <plugin> | config | conf | cf | in | install | lsp | local | loc | state | cache | plugins" && return
    local pldir=$XDG_CONFIG_HOME/nvim/pack/git-plugins/opt
    local locdir=$XDG_DATA_HOME/nvim
    local statedir=$HOME/.local/state/nvim
    local indir=${vim_install_dir}
    local cachedir=$HOME/.cache/nvim
    if [[ $1 == "local" || $1 == "loc" ]]; then
        cd "$locdir" || return
    elif [[ $1 == "in" || $1 == "install" ]]; then
        cd "$indir" || return
    elif [[ $1 == "plugins" ]]; then
        cd "$pldir" || return
    elif [[ $1 == "state" ]]; then
        cd "$statedir" || return
    elif [[ $1 == "cache" ]]; then
        cd "$cachedir" || return
    elif [[ -d "$pldir/$1" ]]; then
        cd "$pldir/$1" || return
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
    pushd "$pldir/$plugin" >/dev/null || return
    git log "${args[@]}"
    popd >/dev/null || return
}

_complete_vim_plugins() {
    read -r -a COMPREPLY <<<"$(vim-ls | grep -iF "${2}" | tr "\n" " " 2>/dev/null)"
}

_complete_vim_installed_versions() {
    pushd "$vim_install_dir" >/dev/null || return
    for d in ./*; do
        v=$(basename "$d")
        [[ $v == 'current' ]] && continue
        COMPREPLY+=("$v")
    done
    popd >/dev/null || return
}

# completion for (some) vim-* commands
declare -A versions
eval versions=\("$VIM_VERSIONS"\)
complete -W "${!versions[*]}" vim-install
complete -F _complete_vim_installed_versions vim-switch
complete -F _complete_vim_plugins vim-cd vim-check vim-enable vim-disable vim-rename vim-remove vim-log vim-config vim-freeze vim-thaw

unset_var versions
