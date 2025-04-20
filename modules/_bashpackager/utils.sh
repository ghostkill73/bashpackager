#!/usr/bin/env bash
#################################################################
# Bashpackager Utils
#################################################################

function __Message() {
	local content="$*"
	printf '%b\n' "$content" >&2
}

function __FatalError() {
	local errorMessage="$*"
	__Message "\e[1;31mfatal error\e[m: $errorMessage"

	exit $FALSE
}
