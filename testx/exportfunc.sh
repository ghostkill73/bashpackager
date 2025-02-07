#!/bin/bash

# declare -- __main__="export"

function export.makeTempFile() {
    declare -g __export__storedFunctions

    __export__storedFunctions="$(mktemp -t db.export.$$.XXXXXXXXXX)"
}

function export.clearTempFile() {
    :>"$__export__storedFunctions"
}

function export.removeTempFile() {
    /bin/rm -f "$__export__storedFunctions"
}

function export.appendFnToExport() {
    declare -g __export__arrayFunctions
    local oldIfs="$IFS"

    IFS=' ' read -ra __export__arrayFunctions <<< "$*"
    IFS="$oldIfs"
}

function export.makeExports() {
    local callName="$1"

    export.clearTempFiles

    for fn in "${__export__arrayFunctions[@]}"
    {
        echo "${callName}.$(declare -f ${fn})"
    }
}

function exportMe() {
    echo "${FUNCNAME[0]} method."
}

function add() {
    echo "${FUNCNAME[0]} method."
}

function sub() {
    echo "${FUNCNAME[0]} method."
}

export.appendFnToExport exportMe add sub
export.makeExports export
