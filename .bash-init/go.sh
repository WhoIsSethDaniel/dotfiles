#!/bin/bash

GO_BASE_DIR="${HOME}/.local/go"
GO_ROOT_DIR="${GO_BASE_DIR}/current"

# use modules!
# https://tip.golang.org/cmd/go/#hdr-Modules__module_versions__and_more
GO_LIB_DIR="${HOME}/.local/lib/go"
if [[ ${GOPATH} == "${GO_LIB_DIR}" ]] || [[ -z ${GOPATH} ]]; then
    [[ -z ${GOPATH} ]] && set_export_pre_path_var GOPATH "${GO_LIB_DIR}"
    set_export_var GO111MODULE on
else
    GO_LIB_DIR="${GOPATH}"
    set_export_var GO111MODULE auto
fi
[[ ! -d ${GO_LIB_DIR} ]] && mkdir -p "${GO_LIB_DIR}"

[[ -d ${GOPATH} ]] && [[ ! -d "${GOPATH}/bin" ]] && mkdir "${GOPATH}/bin"
set_pre_path_var PATH ${GOPATH}/bin
set_pre_path_var PATH ${GO_ROOT_DIR}/bin

unset update_go GO_LIB_DIR GO_BASE_DIR GO_ROOT_DIR
unalias upgo 2>/dev/null
