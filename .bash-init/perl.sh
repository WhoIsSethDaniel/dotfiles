unset_var PERL5LIB
set_export_var PERL_CPANM_OPT "--notest"

# check for plenv, do the needful if it exists
unset plenv PLENV_SHELL
if [ -d "$HOME/.plenv/bin" ] ; then
  set_pre_path_var PATH $HOME/.plenv/bin

  # what follows is (mostly) the output of "plenv init -"
  set_pre_path_var PATH $HOME/.plenv/shims
  set_export_var PLENV_SHELL bash
  source $HOME/.plenv/completions/plenv.bash

  function plenv () {
    local command

    command="$1"
    if [ "$#" -gt 0 ]; then
      shift
    fi

    case "$command" in
    rehash|shell)
      eval "`plenv "sh-$command" "$@"`";;
    *)
      command plenv "$command" "$@";;
    esac
  }
fi
