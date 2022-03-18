#!/bin/bash

set_prog_var FIND fdfind fd
if [ -n "$FIND" ]; then
    set_alias fdfind "$FIND --color=always"
fi
