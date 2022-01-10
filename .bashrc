#!/bin/bash

source "$HOME/.bash-init/start.sh"
for SH in $(ls -1vL $HOME/.bash-init/*.sh | grep -vE 'end.sh$|start.sh$') 
do
  source "$SH"
done
source "$HOME/.bash-init/end.sh"
