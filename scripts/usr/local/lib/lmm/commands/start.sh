#!/bin/bash

# Tries to start the DMPServer instance.

dmpCommandStart() {
	if [ "$1" = "!" ]; then
		echo "Starting all instances:"
		for I in $(getInstanceList); do
			printf "%-*s: " 10 "$I"
			dmpCommandStart $I
		done
		echo "All done"
		return
	fi

	if [ $(isValidInstance $1) -eq 0 ]; then
		echo "No instance given or not a valid instance!"
		return
	fi

	if [ $(isRunning $1) -eq 0 ]; then
		# Kill monitor if it is still running
		
		if [ -f "$(getInstancePath $1)/monitor.pid" ]; then
			sendCommand $1 "/shutdown"
			rm $(getInstancePath $1)/monitor.pid
		fi
		
		if [ ! -d "$(getInstancePath $1)/logs" ]; then
			mkdir "$(getInstancePath $1)/logs"
		fi
		chown $SDTD_USER.$SDTD_GROUP "$(getInstancePath $1)/logs"
		
		screen -dmS $1 "$(getInstancePath $1)/DMPServer.exe"
		screenPID=$(screen -ls | grep -e "$(getInstancePath $1)" | awk '{print $1}' | cut -d '.' -f1)
		echo $screenPID > $(getInstancePath $1)/monitor.pid
		sleep 1

		if [ $(isRunning $1) -eq 1 ]; then
			echo "Done!"
		else
			echo "Failed!"
			rm -f $(getInstancePath $1)/monitor.pid
		fi
	else
		echo "Instance $1 is already running"
	fi
}

dmpCommandStartHelp() {
	echo "Usage: $(basename $0) start <instance>"
	echo
	echo "Starts the given instance."
	echo "If <instance> is \"!\" all defined instances are started."
}

dmpCommandStartDescription() {
	echo "Start the given instance"
}

dmpCommandStartExpects() {
	case $1 in
		2)
			echo "! $(getInstanceList)"
			;;
	esac
}