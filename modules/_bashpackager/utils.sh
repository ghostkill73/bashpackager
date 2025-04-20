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
	exit 1
}

# __ImportModule
# Imports standard modules of bashpackager.
declare -gA BP_IMPORTS
function __ImportModule() {
    local moduleName="$1" # get module name

	# Check if 'moduleName' is already imported
	local -i isPackageImported="${BP_IMPORTS["$moduleName"]:-0}"
	(( isPackageImported )) && return 0

    # Importing
	local importModule="${BP_ENV[modules]}/$moduleName/main.sh"
	if [[ -f "$importModule" ]]; then
    	source "$importModule" ||
			__FatalError "Failed to import $importModule."
	    BP_IMPORTS["$moduleName"]=1
	else
		__FatalError "The $importModule module does not exists."
	fi
}
