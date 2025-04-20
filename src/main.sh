#!/usr/bin/env bash

import 'try-catch'

set -- \
	-a argAAAAAAAAAA \
	-b 'XaXrXXgXXBX' \
	-c "        argC           " \
	-d argD

while getopts ":a:b:c:" arg; do
	case "$arg" in
		a)
			try {
				msg "$arg is $(lower_case ${OPTARG})"
				exit 1
			} catch {
				msg "[\e[1;31mERROR\e[m] Error message."
			}
			;;
		b)
			msg "$arg is $(strip_all ${OPTARG} X)"
			;;
		c)
			msg "$arg is $(trim_string_all ${OPTARG})"
			;;
		*)
			msg "* is ${OPTARG}"
			;;
	esac
done

read_file /etc/os-release asds
