#!/bin/bash

source $HOME/.bash-functions.sh

# source local overrides
LOCAL_SH="$HOME/.bash-first.sh"
if [ -e "$LOCAL_SH" ] ; then
  source $LOCAL_SH
fi

source "$HOME/.bash-init/start.sh"
for SH in $(ls -1vL $HOME/.bash-init/*.sh | grep -vE 'end.sh$|start.sh$') 
do
  source "$SH"
done
source "$HOME/.bash-init/end.sh"

LAST_SH="$HOME/.bash-last.sh"
if [ -e "$LAST_SH" ] ; then
  source $LAST_SH
fi
