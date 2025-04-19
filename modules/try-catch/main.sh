#!/usr/bin/env bash

function __TryCatch.try() {
	[[ "$-" == *e* ]]; declare -gi SET_OPT_E="$?"
	set +e

	declare -g __trycatch__tmpfile="${TMPDIR:-/tmp}/tmp-bp.trycatch.$EPOCHREALTIME"
	exec 3<> "$__trycatch__tmpfile"
}

function __TryCatch.catch() {
	declare -gi s="$?"
	declare -g e="$(<"$__trycatch__tmpfile")"

	exec 3>&-
	rm -f "$__trycatch__tmpfile"

	(( SET_OPT_E )) && set +e || set -e

	(( s )) && return 1

	return 0
}

shopt -s expand_aliases
alias try='__TryCatch.try; ( set -e; :;'
alias catch=') 2>&3; __TryCatch.catch ||'
