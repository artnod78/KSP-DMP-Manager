#!/bin/bash

# Tries to start the DMPServer instance.

lmmCommandStart() {
	if [ "$1" = "!" ]; then
		echo "Starting all instances:"
		for I in $(getInstanceList); do
			printf "%-*s: " 10 "$I"
			lmmCommandStart $I
		done
		echo "All done"
		return
	fi

	if [ $(isValidInstance $1) -eq 0 ]; then
		echo "No instance given or not a valid instance!"
		return
	fi

	if [ $(isRunning $1) -eq 0 ]; then
		echo "mono $(getInstancePath $1)/Server.exe"
		screen -dmS $1 "mono $(getInstancePath $1)/Server.exe"
		sleep 1

		if [ $(isRunning $1) -eq 1 ]; then
			echo "Done!"
		else
			echo "Failed!"
		fi
	else
		echo "Instance $1 is already running"
	fi
}

lmmCommandStartHelp() {
	echo "Usage: $(basename $0) start <instance>"
	echo
	echo "Starts the given instance."
	echo "If <instance> is \"!\" all defined instances are started."
}

lmmCommandStartDescription() {
	echo "Start the given instance"
}

lmmCommandStartExpects() {
	case $1 in
		2)
			echo "! $(getInstanceList)"
			;;
	esac
}