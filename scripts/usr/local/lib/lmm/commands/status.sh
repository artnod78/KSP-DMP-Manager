#!/bin/bash

# Print status of given instance.

lmmCommandStatus() {
	if [ $(isValidInstance $1) -eq 0 ]; then
		echo "No instance given or not a valid instance!"
		return
	fi

	line() {
		printf "    %-*s %s\n" 15 "$1" "$2"
	}
	
	echo "Instance: $1"
	echo

	if [ $(isRunning $1) -eq 1 ]; then
		echo "Status: Running"
		echo "Open ports:"
		netstat -nlp | grep $(getInstancePID $1) | sed -r 's/^([^ ]*)\s+.*[^ :]*:([^ ]*).*[^ :]*:[^ ]*.*/    \2 (\1)/g' | sort
	else
		echo "Status: NOT running"
	fi
	
	echo
	echo "Game info:"
	line "Server name:" "$(getConfigValue $1 ServerName)"
	line "Max players:" "$(getConfigValue $1 MaxPlayers)"
	line "Game Mode:" "$(getConfigValue $1 GameMode)"
	
	echo
	echo "Network info:"
	line "Port:" "$(getConfigValue $1 Port)"
	line "Public:" "$(getConfigValue $1 RegisterWithMasterServer)"
	
	echo
}

lmmCommandStatusHelp() {
	echo "Usage: $(basename $0) status <instance>"
	echo
	echo "Print status information for the given instance."
	echo
}

lmmCommandStatusDescription() {
	echo "Print status for the given instance"
	echo
}

lmmCommandStatusExpects() {
	case $1 in
		2)
			getInstanceList
			;;
	esac
	echo
}
