#!/usr/bin/env bash
###########################################################
#
# bashpackager builtin functions
#
###########################################################

###########################################################

function msg
{
	# usage  : msg "example"
	# returns: example
	local message="$@"

	printf '%b\n' "$message" >&2
}

function trim_string
{
	# usage  : trim_string "   example   string    "
	# returns: example   string
	: "${1#"${1%%[![:space:]]*}"}"
	: "${_%"${_##*[![:space:]]}"}"
	printf '%s\n' "$_"
}

# shellcheck disable=SC2086,SC2048
function trim_string_all
{
	# usage  : trim_string_all "   example   string    "
	# returns: example string
	set -f
	set -- $*
	printf '%s\n' "$*"
	set +f
}

function strip_all
{
	# usage: strip_all "string" "pattern"
	local string="$1"
	local pattern="$2"

	printf '%s\n' "${string//$pattern}"
}

function regex
{
	# usage: regex "string" "regex"
	local text="$1"
	local compile="$2"

	[[ $text =~ $compile ]] && printf '%s\n' "${BASH_REMATCH[1]}"
}

function split
{
	# usage: split "string" "delimiter"
	local string="$1"
	local delimiter="$2"
	local old_ifs="$IFS"
	local arr

	declare -a arr

	IFS=$'\n' read -d "" -ra arr <<< "${string//$delimiter/$'\n'}"
	IFS="$old_ifs"

	printf '%s\n' "${arr[@]}"
}

function lower_case
{
	# usage  : lower "STRING"
	# returns: string
	local string="$*"

	printf '%s\n' "${string,,}"
}

function upper_case
{
	# usage  : upper "string"
	# returns: STRING
	local string="$*"

	printf '%s\n' "${string^^}"
}

function reverse_case
{
	# usage  : reverse_case "String"
	# returns: sTRING
	local string="$*"

	printf '%s\n' "${string~~}"
}
