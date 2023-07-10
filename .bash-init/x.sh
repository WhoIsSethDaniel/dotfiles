#!/bin/bash

if [ "$WEZTERM_EXECUTABLE" == "" ] && [ "$ALACRITTY_SOCKET" == "" ]; then
    # need the 'vte' for any VTE terminal. Terminator sets it to xterm-256color.
    set_export_var TERM vte-256color
fi
