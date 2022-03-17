#!/bin/bash

# shellcheck source=./.bash-functions.sh
source "$HOME/.bash-functions.sh"

# source local overrides
# shellcheck source=./.bash-first.sh
LOCAL_SH="$HOME/.bash-first.sh"
if [ -e "$LOCAL_SH" ]; then
    source "$LOCAL_SH"
fi

# shellcheck source=./.bash-init/start.sh
source "$HOME/.bash-init/start.sh"
for SH in $(find $HOME/.bash-init/*.sh | sort -n); do
    base=$(basename "$SH")
    if [ "$base" == "start.sh" ] || [ "$base" == "end.sh" ]; then
        continue
    fi
    source "$SH"
done
# shellcheck source=./.bash-init/end.sh
source "$HOME/.bash-init/end.sh"

# shellcheck source=./.bash-last.sh
LAST_SH="$HOME/.bash-last.sh"
if [ -e "$LAST_SH" ]; then
    source "$LAST_SH"
fi
