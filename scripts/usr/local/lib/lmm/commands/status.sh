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
	
	local IPATH=$(getInstancePath "$1")
	TMPPATH=`mktemp -d`
	sed 's/<?xml version="1.0" encoding="utf-16"?>/<?xml version="1.0" encoding="utf-8"?>/' $IPATH/Config/Settings.txt > $TMPPATH/Settings.txt
	mv $TMPPATH/Settings.txt $IPATH/Config/Settings.txt -f
	rm -fr $TMPPATH
	
	echo
	echo "Network info:"
	line "Port:" "$(getConfigValue $1 Port)"
	line "Public:" "$(getConfigValue $1 RegisterWithMasterServer)"
	
	local IPATH=$(getInstancePath "$1")
	TMPPATH=`mktemp -d`
	sed 's/<?xml version="1.0" encoding="utf-8"?>/<?xml version="1.0" encoding="utf-16"?>/' $IPATH/Config/Settings.txt > $TMPPATH/Settings.txt
	mv $TMPPATH/Settings.txt $IPATH/Config/Settings.txt -f
	rm -fr $TMPPATH
	
	echo
}

lmmCommandStatusHelp() {
	echo "Usage: $(basename $0) status <instance>"
	echo
	echo "Print status information for the given instance."
}

lmmCommandStatusDescription() {
	echo "Print status for the given instance"
}

lmmCommandStatusExpects() {
	case $1 in
		2)
			getInstanceList
			;;
	esac
}
