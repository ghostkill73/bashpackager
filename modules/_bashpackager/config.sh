#!/usr/bin/env bash
#################################################################
# Bashpackager Setup
#################################################################
# shellcheck disable=SC1090

# shellcheck disable=SC2034
function __SetConfigs() {
    declare -ig TRUE=0 # exit status for success.
    declare -ig FALSE=1 # exit status for recognized error."
    declare -ig ERROR=2 # exit status for not recognized error."

    declare -Ag BP_ENV[root-path]="$PWD"
    declare -Ag BP_ENV[setup-filename]="setup.sh"
    declare -Ag BP_ENV[setup-file]="${BP_ENV[root-path]}/${BP_ENV[setup-filename]}"
    declare -Ag BP_ENV[modules]="${BP_ENV[root-path]}/modules"
    declare -g  BP_ENV[project-src]="${BP_ENV[root-path]}/src"

    declare -ag BP_IMPORTS=()
}

# shellcheck disable=SC2154
function __GetConfigValuesFromSetupFile() {
    source "${BP_ENV[setup-file]}"
    declare -Ag BP_ENV[project-name]="$project_name"
    declare -Ag BP_ENV[project-version]="$version"
    declare -Ag BP_ENV[project-desc]="$description"
    unset name version description

    [[ -z "${BP_ENV[project-name]}" ]] &&
        __FatalError "An error occurred while reading the value of 'project_name' in ${BP_ENV[setup-file]}."

    [[ -z "${BP_ENV[project-version]}" ]] &&
        __FatalError "An error occurred while reading the value of 'version' in ${BP_ENV[setup-file]}."

    [[ -z "${BP_ENV[project-desc]}" ]] &&
        __FatalError "An error occurred while reading the value of 'description' in ${BP_ENV[setup-file]}."
}

function __ImportModule() {
    local moduleName="$1"
    local package

    # testing if alredy imported
    for package in "${BP_IMPORTS[@]}"; {
        [[ "$path" == "$package" ]] && return 0
    }

    # importing
    source "${BP_ENV[modules]}/$moduleName/main.sh" # || error <----------------
    BP_IMPORTS+=("$moduleName")
}

function __ImportBuiltinModules() {
    local package

    BP_IMPORTS+=(
        '_builtins'
    )
    for package in "${BP_IMPORTS[@]}"; {
        __ImportModule "$package"
    }
}

function __LoadSetupConfigs() {
    __SetConfigs
    __GetConfigValuesFromSetupFile
    __ImportBuiltinModules
}
