#!/bin/bash

genericHelp() {
	line() {
		printf "  %-*s %s\n" 15 "$1" "$2"
	}
	
	echo
	if [ ! -z $1 ]; then
		echo "Unknown command: $1"
	fi
	echo "Usage: $(basename $0) <command> [parameters]"
	echo
	echo "Commands are:"
	
	for C in $(listCommands); do
		if [ "$(type -t dmpCommand$(camelcasePrep $C)Description)" = "function" ]; then
			line "${C}" "$(dmpCommand$(camelcasePrep $C)Description)"
		else
			line "${C}" "TODO: Description"
		fi
	done
	
	echo
	echo "Use \"$(basename $0) help <command>\" to get further details on a specific command."
}


