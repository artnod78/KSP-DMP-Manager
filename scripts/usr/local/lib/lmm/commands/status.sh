#!/bin/bash

# Print status of given instance.

LmmCommandStatus() {
	if [ $(isValidInstance $1) -eq 0 ]; then
		echo "No instance given or not a valid instance!"
		echo
		return
	fi

	loadCurrentConfigValues $1

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
	line "Server name:" "$(getConfigValue $1 ServerName GeneralSettings)"
	line "Max players:" "$(getConfigValue $1 MaxPlayers GeneralSettings)"
	line "Game Mode:" "$(getConfigValue $1 GameMode GeneralSettings)"

	echo
	echo "Network info:"
	line "Port:" "$(getConfigValue $1 Port ConnectionSettings)"
	line "Public:" "$(getConfigValue $1 RegisterWithMasterServer MasterServerSettings)"

	echo
}

LmmCommandStatusHelp() {
	echo "Usage: $(basename $0) status <instance>"
	echo
	echo "Print status information for the given instance."
	echo
}

LmmCommandStatusDescription() {
	echo "Print status for the given instance"
	echo
}

LmmCommandStatusExpects() {
	case $1 in
		2)
			getInstanceList
			;;
	esac
	echo
}
