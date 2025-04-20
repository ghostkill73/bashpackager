#!/usr/bin/env bash
#################################################################
# Load configs and src/main.sh
#################################################################

function __LoadBashpackager() {
    # loading bashpackager
    __LoadSetupConfigs

    # exec src/main.sh script
    source "${BP_ENV[root-path]}/src/main.sh"

    # exit status from src/main.sh
    exit $?
}
