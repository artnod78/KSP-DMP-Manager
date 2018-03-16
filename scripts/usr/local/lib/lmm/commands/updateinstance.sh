#!/bin/bash

# Tries to update instance.

lmmCommandUpdateinstance() {
	if [ "$1" = "!" ]; then
		echo "Update all instances:"
		echo
		for I in $(getInstanceList); do
			lmmCommandUpdateinstance $I
		done
		echo "All done"
		echo
		return
	fi

	echo "Instance $1 :"

	if [ $(isValidInstance $1) -eq 0 ]; then
		echo "No instance given or not a valid instance!"
		echo
		return
	fi

	local instanceVersion=$(getInstanceVersion $1)
	local modVersion=$(getLocalLMPServerVersion)


	if [ "$instanceVersion" != "$modVersion" ]; then
		echo "A newer version of the mod is available."
		echo "Instance version:     $instanceVersion"
		echo "Mod version: $modVersion"

		while : ; do
			local CONTINUE
			read -p "Continue? (yn) " CONTINUE
			case $CONTINUE in
				y)
					echo "Updating..."
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
		cp -f $LMM_BASE/LMPServer/LiteDB.xml $IPATH
		cp -f $LMM_BASE/LMPServer/version.txt $IPATH
		chown -R $LMM_USER.$LMM_GROUP $IPATH
		
	else
		echo "Instance is already at the newest version (instance: $instanceVersion, mod: $modVersion)."
		
	fi
	echo
}

lmmCommandUpdateinstanceHelp() {
	echo "Usage: $(basename $0) updateinstance <instance>"
	echo
	echo "Updates the given instance."
	echo "If <instance> is \"!\" all defined instances are updated."
	echo
}

lmmCommandUpdateinstanceDescription() {
	echo "Updates the given instance"
	echo
}

lmmCommandUpdateinstanceExpects() {
	case $1 in
		2)
			echo "! $(getInstanceList)"
			;;
	esac
}