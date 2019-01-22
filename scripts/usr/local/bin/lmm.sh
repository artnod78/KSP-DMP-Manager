#!/bin/bash

. /usr/local/lib/lmm/common.sh
checkRootLoadConf

if [ -z $1 ]; then
	genericHelp
else
	CMD=$(camelcasePrep "$1")
	shift

	if [ "$CMD" = "Help" ]; then
		if [ -z $1 ]; then
			genericHelp
		else
			HELPCMD=$(camelcasePrep "$1")
			if [ "$(type -t LmmCommand${HELPCMD}Help)" = "function" ]; then
				LmmCommand${HELPCMD}Help
			else
				echo "Command \"$1\" does not exist!"
				exit 1
			fi
		fi
	else
		if [ "$(type -t LmmCommand${CMD})" = "function" ]; then
			LmmCommand${CMD} "$@"
		else
			echo "Command \"$CMD\" does not exist!"
			exit 1
		fi
	fi
fi

exit 0
