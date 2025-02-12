#!/usr/bin/env bash

function main() {
    set -- -a argAAAAAAAAAA -b 'XaXrXXgXXBX' -c "        argC           " -d argD

    (( $# == 0 ))

    while getopts ":a:b:c:" arg; do
        case "$arg" in
            a)
                msg "$arg is $(lower_case ${OPTARG})"
            ;;
            b)
                msg "$arg is $(strip_all ${OPTARG} X)"
            ;;
            c)
                msg "$arg is $(trim_string_all ${OPTARG})"
            ;;
            *)
                msg "* is ${OPTARG}"
            ;;
        esac
    done
}