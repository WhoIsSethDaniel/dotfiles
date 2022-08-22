#!/bin/bash

set +P
set -o vi
set bell-style none
shopt -u nullglob
shopt -s cdspell checkwinsize

# aliases
# set_alias ls 'ls -C --color=tty -F -T 0'
OS=$(uname -s 2>/dev/null)
if [ "$OS" == "FreeBSD" ]; then
    set_alias ls 'ls -C -F'
else
    set_alias ls 'ls --color -C -F -T 0'
fi
# set_alias man 'LC_ALL=C man'

# history
# https://unix.stackexchange.com/questions/18212/bash-history-ignoredups-and-erasedups-setting-conflict-with-common-history
shopt -s histappend
set_export_var HISTFILE "$HOME"/.bash_history
set_export_var HISTFILESIZE 10000
set_export_var HISTSIZE 10000
set_export_var HISTCONTROL 'ignoredups:erasedups'
set_export_var HISTIGNORE 'clear'
set_export_var PROMPT_COMMAND 'history -n; history -w; history -c; history -r'

set_export_prog_var PAGER less view more

set_alias grep 'grep --color=never'
# do NOT clear the scrollback buffer (see clear(1) for more)
set_alias clear 'clear -x'

set_export_var LESS "-X -n -R"
if [ "$OS" == "FreeBSD" ]; then
    set_export_var LANG C
    set_export_var LANGUAGE C
    set_export_var LC_ALL C
else
    set_export_var LANG en_US.UTF-8
    set_export_var LANGUAGE en_US.UTF-8
    set_export_var LC_ALL en_US.UTF-8
fi

# search paths
set_post_path_var PATH "$HOME"/bin
set_pre_path_var PATH /snap/bin
set_export_pre_path_var LD_LIBRARY_PATH /usr/lib

# XDG
set_export_var XDG_DATA_HOME "$HOME/.local/share"
set_export_var XDG_CONFIG_HOME "$HOME/.config"

# man pages
check_for_program manpath
if [ "$manpath" != "" -a -z "$MANPATH" ]; then
    POSSIBLE_MANPATH=$("$manpath" 2>/dev/null)
    set_export_var MANPATH "$POSSIBLE_MANPATH"
fi
set_post_path_var MANPATH "$HOME/.local/share/man"

# prompt
set_alias tpp truncated_path_prompt
set_var PS1 '\h:\$(tpp)> '
# set_export_var LS_COLORS 'di=01;32:ex=01;33'

[ ! -d "$HOME/tmp" ] && mkdir "$HOME"/tmp
set_export_path_var TMPDIR "$HOME"/tmp
