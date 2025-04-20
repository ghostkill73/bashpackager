#!/usr/bin/env bash

import 'try-catch'

set -- \
	-a argAAAAAAAAAA \
	-b 'XaXrXXgXXBX' \
	-c "        argC           " \
	-d argD

try {
	while getopts ":a:b:c:" arg; do
		case "$arg" in
			a)
				msg "$arg is $(lower_case ${OPTARG})"
				;;
			b)
				msg "$arg is $(strip_all ${OPTARG} X)"
				comando-invalido-test
				;;
			c)
				msg "$arg is $(trim_string_all ${OPTARG})"
				;;
			*)
				msg "* is ${OPTARG}"
				;;
		esac
	done
} catch {
	msg "\e[1;31m[ERROR]\e[m  $e"
	msg "\e[1;33m[STATUS]\e[m $s"
}
