#!/bin/bash

if [[ -n $TEMPDIR ]]; then
    set_export_path_var TMPDIR "$TEMPDIR"
    [ ! -e "$HOME"/tmp ] && ln -sf "$TEMPDIR" "$HOME"/tmp
else
    [ ! -e "$HOME/tmp" ] && mkdir "$HOME"/tmp
    set_export_path_var TMPDIR "$HOME"/tmp
fi
