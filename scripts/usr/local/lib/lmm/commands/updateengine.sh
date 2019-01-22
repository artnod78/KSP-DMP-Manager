#!/bin/bash

# Downloads/Updates LMPServer

LmmCommandUpdateengine() {
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
		echo "No mod installed" 
		echo "  - Download new version: $REMOTE"
		wget -nv -q --show-progress $lmDlUrl -O /tmp/LunaMultiPlayer-Release.zip

		echo "  - Extract new version"
		local TMPPATH=`mktemp -d`
		unzip -q /tmp/LunaMultiPlayer-Release.zip -d $TMPPATH
		cp -R -f $TMPPATH/LMPServer $LMM_BASE
		echo $REMOTE > $LMM_BASE/LMPServer/version.txt
		chown $LMM_USER.$LMM_GROUP -R $LMM_BASE
		rm -f /tmp/LunaMultiPlayer-Release.zip
		rm -rf $TMPPATH

		echo "  - Exec First Run"
		screen -dmS lmFirstRun mono $LMM_BASE/LMPServer/Server.exe
		sleep 5

		echo "  - Kill First Run"
		screen -S lmFirstRun -X stuff $'\003'
		echo
	fi

	local LOCAL=$(getLocalLMPServerVersion)

	if [ "$CHECKONLY" = "yes" ]; then
		echo "Installed release:"
		echo "  - Version: $LOCAL"
		echo "Available release:"
		echo "  - Version: $REMOTE"
		if [ "$REMOTE" != "$LOCAL" ]; then
			echo "Newer LMPServer version available $REMOTE."
		else
			echo "LMPServer on the latest version."
		fi
		echo
		return
	fi

	if [ "$FORCED" = "yes" -o "$REMOTE" != "$LOCAL" ]; then
		echo "A newer version is available."
		echo "  - Local version: $LOCAL"
		echo "  - Available version: $REMOTE"

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

		echo "  - Download new version: $REMOTE"
		wget -nv -q --show-progress $lmDlUrl -O /tmp/LunaMultiPlayer-Release.zip

		echo "  - Extract new version"
		local TMPPATH=`mktemp -d`
		unzip -q /tmp/LunaMultiPlayer-Release.zip -d $TMPPATH
		cp -R -f $TMPPATH/LMPServer $LMM_BASE
		echo $REMOTE > $LMM_BASE/LMPServer/version.txt
		chown $LMM_USER.$LMM_GROUP -R $LMM_BASE
		rm -f /tmp/LunaMultiPlayer-Release.zip
		rm -rf $TMPPATH

		echo "  - Exec First Run"
		screen -dmS lmFirstRun mono $LMM_BASE/LMPServer/Server.exe
		sleep 5

		echo "  - Kill First Run"
		screen -S lmFirstRun -X stuff $'\003'
		echo
		echo "LMPServer is at the latest version (local: $LOCAL, remote: $REMOTE)."
		echo "Run with the --force parameter to update/validate the LMPServer files anyway."
		

		
	else
		echo "LMPServer is at the latest version (local: $LOCAL, remote: $REMOTE)."
		echo "Run with the --force parameter to update/validate the LMPServer files anyway."
	fi
	echo
}

LmmCommandUpdateengineHelp() {
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
	echo
}

LmmCommandUpdateengineDescription() {
	echo "Update the LMPServer files"
	echo
}

LmmCommandUpdateengineExpects() {
	case $1 in
		2)
			echo "--check --force"
			;;
	esac
	echo
}
