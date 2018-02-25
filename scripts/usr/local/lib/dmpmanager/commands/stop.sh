#!/bin/bash

# Tries to stop the DMPServer instance given as first parameter.
# Returns:
#  0 : Done
#  1 : Was not running
#  2 : No instance name given
#  3 : No such instance

dmpCommandKill() {
	if [ "$1" = "!" ]; then
		echo "Stopping all instances:"
		for I in $(getInstanceList); do
			printf "%s:\n" "$I"
			dmpCommandKill $I
			echo
		done
		echo "All done"
		return
	fi

	if [ $(isValidInstance $1) -eq 0 ]; then
		echo "No instance given or not a valid instance!"
		return
	fi

	res=$(isRunning $1)
	if [ $res -eq 1 ]; then

		echo "Trying to gracefully shutdown..."
		tmp=$(sendCommand $1 "/shutdown")
		echo "Waiting for server to shut down..."
	
		waittime=0
		maxwait=${STOP_WAIT:-5}
		until [ $(isRunning $1) -eq 0 ] || [ $waittime -eq $maxwait ]; do
			(( waittime++ ))
			sleep 1
			echo $waittime/$maxwait
		done
	
		if [ $(isRunning $1) -eq 1 ]; then
			echo "Failed, force closing server..."
			kill -9 $(getInstancePID $1)
		fi
		rm $(getInstancePath $1)/monitor.pid

		echo "Done"	
	else
		echo "Instance $1 is NOT running"
	fi
}

dmpCommandKillHelp() {
	echo "Usage: $(basename $0) kill <instance>"
	echo
	echo "Stops the given instance."
	echo "If <instance> is \"!\" all defined instances are stopped."
}

dmpCommandKillDescription() {
	echo "Stop the given instance"
}

dmpCommandKillExpects() {
	case $1 in
		2)
			echo "! $(getInstanceList)"
			;;
	esac
}

