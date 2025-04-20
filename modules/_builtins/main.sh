#!/usr/bin/env bash
###########################################################
#
# bashpackager builtin functions
#
# VERSION: 1.0
# LICENSE: 0-BSD
#
###########################################################

###########################################################
# builtins
###########################################################

function import() {
    local path="$1"

    if [[ -e "${BP_ENV[modules]}/$path/main.sh" ]]; then
		__ImportModule "$path"
    elif [[ -e "${BP_ENV[project-src]}/$path" ]]; then
		source "${BP_ENV[project-src]}/$path"
    else
		__FatalError "module '$path' not found."
    fi
}

function msg() {
	# usage  : msg "example"
	# returns: example
	local message="$*"

	printf '%b\n' "$message"
}

function basename() {
	# usage  : basename "/p/a/t/h"
	# returns: h
	local path="${1%/}"

	printf '%s\n' "${path##*/}"
}

function trim_string() {
	# usage  : trim_string "   example   string    "
	# returns: example   string
	: "${1#"${1%%[![:space:]]*}"}"
	: "${_%"${_##*[![:space:]]}"}"

	printf '%s\n' "$_"
}

function trim_quotes() {
    # usage: trim_quotes "string"
    local trim="${1//\'}"
    printf '%s\n' "${trim//\"}"
}

function trim_string_all() {
	# usage  : trim_string_all "   example   string    "
	# returns: example string
	local -i SET_OPT_F

	[[ $- == *f* ]]; SET_OPT_F=$?
	set -f

	set -- $*
	printf '%s\n' "$*"

	(( SET_OPT_F == 0 )) && set +f
}

function rstrip() {
	# usage: rstrip "string" "pattern"
	local string="$1"
	local pattern="$2"

	printf '%s\n' "${string%%$pattern}"
}

function lstrip() {
	# usage: lstrip "string" "pattern"
	local string="$1"
	local pattern="$2"

	printf '%s\n' "${string##$pattern}"
}

function strip() {
	# usage: strip_all "string" "pattern"
	local string="$1"
	local pattern="$2"

	printf '%s\n' "${string//$pattern}"
}

function regex() {
	# usage: regex "string" "regex"
	local text="$1"
	local compile="$2"

	[[ $text =~ $compile ]] && printf '%s\n' "${BASH_REMATCH[1]}"
}

function split() {
	# usage: split "string" "delimiter"
	local string="$1"
	local delimiter="$2"
	local -a arr

	IFS=$'\n' read -d "" -ra arr <<< "${string//$delimiter/$'\n'}"

	printf '%s\n' "${arr[@]}"
}

function lower_case() {
	# usage  : lower "STRING"
	# returns: string
	local string="$*"

	printf '%s\n' "${string,,}"
}

function upper_case() {
	# usage  : upper "string"
	# returns: STRING
	local string="$*"

	printf '%s\n' "${string^^}"
}

function reverse_case() {
	# usage  : reverse_case "String"
	# returns: sTRING
	local string="$*"

	printf '%s\n' "${string~~}"
}

function pass() {
	# usage  : pass
	# returns: status 0
	return 0
}

function read_file() {
	# usage: read_file "file1.txt" "file2.txt"
	local files="$@"
	local -i SET_OPT_F
	local -i _error=1
	local line

	[[ $- == *f* ]]; SET_OPT_F=$?
	set -f

	for file in ${files[@]}; {
		if [[ -f "$file" ]]; then
			while IFS= read -r line; do
				printf '%s\n' "$line"
			done < "$file"
		elif [[ -d "$file" ]]; then
			_error=0
			printf '%s\n' "read_file: $file: Is a directory"
		else
			_error=0
			printf '%s\n' "read_file: $file: No such file or directory"
		fi
	}

	(( SET_OPT_F == 0 )) && set +f

	(( _error )) && return 0
	return 1
}
