#!/bin/bash

# Tries to update instance.

LmmCommandUpdateinstance() {
	if [ "$1" = "!" ]; then
		echo "Update all instances:"
		echo
		for I in $(getInstanceList); do
			LmmCommandUpdateinstance $I
		done
		echo "All done"
		echo
		return
	fi

	if [ $(isValidInstance $1) -eq 0 ]; then
		echo "No instance given or not a valid instance!"
		echo
		return
	fi

	echo "Instance $1 :"
	local instanceVersion=$(getInstanceVersion $1)
	local modVersion=$(getLocalLMPServerVersion)


	if [ $instanceVersion != $modVersion ]; then
		echo "A newer version of the mod is available."
		echo "  - Instance version: $instanceVersion"
		echo "  - LMPServer version: $modVersion"

		while : ; do
			local CONTINUE
			read -p "Continue? (yn) " CONTINUE
			case $CONTINUE in
				y)
					echo "Updating instance $1"
					break
					;;
				n)
					echo "Canceled"
					return
					;;
				*)
					echo "Wrong input"
			esac
		done

		if [ $(isRunning $1) -eq 1 ]; then
			echo "This instance is still running (\"$I\")."
			echo "Before updating please stop instance"
			echo
			return
		fi

		local IPATH=$(getInstancePath $1)
		cp -f $LMM_BASE/LMPServer/*.dll $IPATH
		cp -f $LMM_BASE/LMPServer/Server.exe $IPATH
		cp -f $LMM_BASE/LMPServer/version.txt $IPATH
		chown -R $LMM_USER.$LMM_GROUP $IPATH

	else
		echo "Instance is already at the newest version (instance: $instanceVersion, mod: $modVersion)."
	fi
	echo
}

LmmCommandUpdateinstanceHelp() {
	echo "Usage: $(basename $0) updateinstance <instance>"
	echo
	echo "Updates the given instance."
	echo "If <instance> is \"!\" all defined instances are updated."
	echo
}

LmmCommandUpdateinstanceDescription() {
	echo "Updates the given instance"
	echo
}

LmmCommandUpdateinstanceExpects() {
	case $1 in
		2)
			echo "! $(getInstanceList)"
			;;
	esac
}