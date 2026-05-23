#!/bin/bash

# deal with ssh keys
SSH_KEY_DIR=$HOME/.ssh/login-keys.d
for TYPE in dsa rsa ed25519; do
    if [ -f "$SSH_KEY_DIR/id_$TYPE" ]; then
        PERSONAL_SSH_KEY="$SSH_KEY_DIR/id_$TYPE"
        break
    fi
done

nullglob=$(shopt -p nullglob)
shopt -s nullglob
SSH_KEYS=("$SSH_KEY_DIR"/*_id_{dsa,rsa,ed25519})
eval "$nullglob"

# check permissions on all keys
chmod 400 "$PERSONAL_SSH_KEY" 2>/dev/null
for KEY in "${SSH_KEYS[@]}"; do
    chmod 400 "$KEY" 2>/dev/null
done

# check permissions on all ssh directories and files
SSH_HOME="$HOME/.ssh"
mkdir -p "$SSH_HOME/control"
if [ -d "$SSH_HOME" ]; then
    chmod 700 "$SSH_HOME"
    AUTHKEYS=("$SSH_HOME"/*authorized_keys*)
    for AUTHKEY in "${AUTHKEYS[@]}"; do
        chmod 400 "$AUTHKEY" 2>/dev/null
    done
fi

if [ -f "$HOME/.ssh/agent-$HOSTNAME" ]; then
    source "$HOME/.ssh/agent-$HOSTNAME" >/dev/null 2>&1
fi

# check to see if the ssh personal key has already been loaded by pam-ssh
unset_var EXTRA_SSH_KEYS
if [ -f "$PERSONAL_SSH_KEY" ]; then
    timeout 5s ssh-add -l | grep -q " $PERSONAL_SSH_KEY "
    if [ "$?" -ne 0 ]; then
        EXTRA_SSH_KEYS=$PERSONAL_SSH_KEY
    fi
fi

# use keychain for any other keys
if [ "$EXTRA_SSH_KEYS" != "" ] || [ ${#SSH_KEYS[@]} -ne 0 ]; then
    check_for_program keychain
    if [ "$keychain" != "" ]; then
        "$keychain" --quiet "$EXTRA_SSH_KEYS" "${SSH_KEYS[@]}"
    fi
fi
