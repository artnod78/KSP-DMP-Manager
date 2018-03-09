#!/bin/bash

# Downloads LMPServer

lmmCommandUpdateengine() {
	local FORCED=no
	local CHECKONLY=no
	
	while test $# -gt 0; do
		case "$1" in
			--check)
				CHECKONLY=yes
				;;
			--force)
				FORCED=yes
				;;
		esac
		shift
	done
	
	local REMOTE=$(curl -s https://api.github.com/repos/LunaMultiplayer/LunaMultiplayer/releases/latest | grep -e "tag_name" | cut -d "\"" -f4)
	local lmDlUrl="https://github.com/LunaMultiplayer/LunaMultiplayer/releases/download/$REMOTE/LunaMultiPlayer-Release.zip"
	
	if [ ! -e $LMM_BASE/LMPServer ]; then
		wget -nv $lmDlUrl -O /tmp/LunaMultiPlayer-Release.zip
		unzip /tmp/LunaMultiPlayer-Release.zip -d $LMM_BASE
		echo
		rm /tmp/LunaMultiPlayer-Release.zip
		
		echo $REMOTE > $LMM_BASE/LMPServer/version.txt
		chown $LMM_USER.$LMM_GROUP -R $LMM_BASE
		screen -dmS lmFirstRun mono $LMM_BASE/LMPServer/Server.exe
		sleep 5
		screen -S lmFirstRun -X stuff $'\003'
		
		TMPPATH=`mktemp -d`
		sed 's/<?xml version="1.0" encoding="utf-16"?>/<?xml version="1.0" encoding="utf-8"?>/' $LMM_BASE/LMPServer/Config/Settings.txt > $TMPPATH/Settings.txt
		mv $TMPPATH/Settings.txt $LMM_BASE/LMPServer/Config/Settings.txt -f
		rm -fr $TMPPATH
		
	fi
	
	local LOCAL=$(getLocalLMPServerVersion)
	
	
	if [ "$CHECKONLY" = "yes" ]; then
		echo "Installed:"
		echo "  Version:     $LOCAL"
		echo
		echo "Available release:"
		echo "  Version:     $REMOTE"
		echo
		
		if [ "$REMOTE" != "$LOCAL" ]; then
			echo "Newer LMPServer version available $REMOTE."
		else
			echo "LMPServer on the latest version."
		fi
		return
	fi

	for I in $(getInstanceList); do
		if [ $(isRunning $I) -eq 1 ]; then
			echo "At least one instance is still running (\"$I\")."
			echo "Before updating the mod please stop all instances!"
			return
		fi
	done

	if [ "$FORCED" = "yes" -o "$REMOTE" != "$LOCAL" ]; then
		echo "A newer version of the mod is available."
		echo "Local version:     $LOCAL"
		echo "Available version: $REMOTE"
		echo

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
		
		rm -fr $LMP_BASE/LMPServer	
		rm -fr $LMP_BASE/LMPClient
		rm -f $LMP_BASE/LMP\ Readme.txt
		
		wget -nv $lmDlUrl -O /tmp/LunaMultiPlayer-Release.zip
		unzip /tmp/LunaMultiPlayer-Release.zip -d $LMM_BASE
		echo
		rm /tmp/LunaMultiPlayer-Release.zip
		
		echo $lmVersion > $LMM_BASE/LMPServer/version.txt
		chown $LMM_USER.$LMM_GROUP -R $LMM_BASE
		screen -dmS lmFirstRun mono $LMM_BASE/LMPServer/Server.exe
		sleep 5
		screen -S lmFirstRun -X stuff $'\003'
		
		TMPPATH=`mktemp -d`
		sed 's/<?xml version="1.0" encoding="utf-16"?>/<?xml version="1.0" encoding="utf-8"?>/' $LMM_BASE/LMPServer/Config/Settings.txt > $TMPPATH/Settings.txt
		mv $TMPPATH/Settings.txt $LMM_BASE/LMPServer/Config/Settings.txt -f
		rm -fr $TMPPATH
		
		# TODO copy new version in all instances
		

		
	else
		echo "LMPServer is already at the newest version (local: $LOCAL, remote: $REMOTE)."
		echo "Run with the --force parameter to update/validate the LMPServer files anyway."
	fi
}

lmmCommandUpdateengineHelp() {
	echo "Usage: $(basename $0) updateengine [--check] [--force]"
	echo
	echo "Check for a newer version of files. If there is a newer"
	echo "version they will be updated by this command."
	echo
	echo "If --force is specified you are asked if you want to redownload the engine"
	echo "even if there is no new version detected."
	echo
	echo "If --check is specified it will only output the current local and remote version"
	echo "and if an update is available."
}

lmmCommandUpdateengineDescription() {
	echo "Update the LMPServer files"
}

lmmCommandUpdateengineExpects() {
	case $1 in
		2)
			echo "--check --force"
			;;
	esac
}
