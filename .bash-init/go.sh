#!/bin/bash

# use modules!
# https://tip.golang.org/cmd/go/#hdr-Modules__module_versions__and_more
GO_LIB_DIR="${HOME}/.local"
if [[ -z ${GOPATH} ]]; then
    set_export_pre_path_var GOPATH "$GO_LIB_DIR"
else
    GO_LIB_DIR="$GOPATH"
fi
[[ ! -d ${GO_LIB_DIR} ]] && mkdir -p "$GO_LIB_DIR"

[[ -d ${GOPATH} ]] && [[ ! -d "${GOPATH}/bin" ]] && mkdir "${GOPATH}/bin"

set_export_var GO111MODULE auto
set_pre_path_var PATH "$GOPATH"/bin
set_export_var GOBIN "$GOPATH/bin"
set_export_var MISE_GO_SET_GOBIN false
