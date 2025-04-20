#!/usr/bin/env bash
#################################################################
# Bashpackager Setup
#################################################################

# __SetConfigs
# Define the default variables of bashpackager.
function __SetConfigs() {
    declare -gri TRUE=0  # exit status for success.
    declare -gri FALSE=1 # exit status for recognized error.
    declare -gri ERROR=2 # exit status for not recognized error.

	declare -gA BP_ENV
    BP_ENV[root-path]="$PWD"
    BP_ENV[setup-filename]="setup.sh"
    BP_ENV[setup-file]="${BP_ENV[root-path]}/${BP_ENV[setup-filename]}"
    BP_ENV[modules]="${BP_ENV[root-path]}/modules"
    BP_ENV[project-src]="${BP_ENV[root-path]}/src"

    declare -ga BP_IMPORTS=()
}

# __GetConfigValuesFromSetupFile
# Stores the setup-file configurations.
function __GetConfigValuesFromSetupFile() {
    source "${BP_ENV[setup-file]}"
    BP_ENV[project-name]="$project_name"
    BP_ENV[project-version]="$version"
    BP_ENV[project-desc]="$description"
    unset name version description

    [[ -z "${BP_ENV[project-name]}" ]] &&
        __FatalError "An error occurred while reading the value of 'project_name' in ${BP_ENV[setup-file]}."

    [[ -z "${BP_ENV[project-version]}" ]] &&
        __FatalError "An error occurred while reading the value of 'version' in ${BP_ENV[setup-file]}."

    [[ -z "${BP_ENV[project-desc]}" ]] &&
        __FatalError "An error occurred while reading the value of 'description' in ${BP_ENV[setup-file]}."
}

# __ImportModule
# Imports standard modules of bashpackager.
function __ImportModule() {
    local moduleName="$1" # get module name

	# Defining an array with the packages to be checked
	local pkg
	local -A element
	for pkg in "${BP_IMPORTS[@]}"; {
		element["$pkg"]=1
	}

	# Check if this package is already imported
	local -i is_package_imported="${element["$moduleName"]:-0}"
	(( is_package_imported )) && return 0

    # Importing
	local import_module="${BP_ENV[modules]}/$moduleName/main.sh"
	if [[ -f "$import_module" ]]; then
    	source "$import_module" ||
			__FatalError "Failed to import the $import_module module"
	    BP_IMPORTS+=("$moduleName")
	else
		__FatalError "The $import_module module does not exists."
	fi
}

# __ImportBuiltinModules
# Imports built-in modules.
function __ImportBuiltinModules() {
	local -a builtin_packages=(
		'_builtins'
	)

	for pkg in "${builtin_packages[@]}"; {
		__ImportModule "$pkg"
	}
}

function __LoadSetupConfigs() {
    __SetConfigs
    __GetConfigValuesFromSetupFile
    __ImportBuiltinModules
}
