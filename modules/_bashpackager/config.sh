#!/usr/bin/env bash
#################################################################
# Bashpackager Setup
#################################################################
# Requires: ./utils.sh

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
