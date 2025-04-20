#!/usr/bin/env bash

import 'try-catch'

function return_error() {
	msg "This is a error message" >&2
	return 1
}

set -- \
	-a argAAAAAAAAAA \
	-b 'XaXrXXgXXBX' \
	-c "        argC           " \
	-d argD

while getopts ":a:b:c:" arg; do
	case "$arg" in
		a)
			lower_case_result="$(lower_case ${OPTARG})"
			msg "$arg is $lower_case_result)"
			;;
		b)
			strip_result="$(strip ${OPTARG} X)"
			msg "$arg is $strip_result"
			;;
		c)
			trim_string_all_result="$(trim_string_all ${OPTARG})"
			msg "$arg is $trim_string_all_result"

			try {
				return_error
			} catch {
				msg "\e[1;31m[ERROR]\e[m  $e"
				msg "\e[1;33m[STATUS]\e[m $s"
			}
			;;
		*)
			msg "* is ${OPTARG}"
			;;
	esac
done


declare -p BP_IMPORTS
