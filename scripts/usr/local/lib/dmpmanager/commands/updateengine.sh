#!/bin/bash

# Downloads DMPServer

dmpCommandUpdateengine() {
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
	
	if [ ! -e $DMP_BASE/DMPServer ]; then
		mkdir $DMP_BASE/DMPServer
		chown $SDTD_USER.$SDTD_GROUP -R $DMP_BASE/DMPServer
		cd /tmp
		wget https://d-mp.org/downloads/release/latest/DMPServer.zip
		unzip -C $DMP_BASE/DMPServer
		cd $DMP_BASE/DMPServer
		# TODO first run + quit
	fi
	

	local LOCAL=$(getLocalDMPServerVersion)
	local REMOTE=$(curl -s https://api.github.com/repos/godarklight/DarkMultiPlayer/releases/latest | grep -e "tag_name" | cut -d "\"" -f4)
	
	if [ "$CHECKONLY" = "yes" ]; then
		echo "Installed:"
		echo "  Version:     $LOCAL"
		echo
		echo "Available release:"
		echo "  Version:     $REMOTE"
		echo
		
		if [ "$REMOTE" != "$LOCAL" ]; then
			echo "Newer DMPServer version available $REMOTE."
		else
			echo "DMPServer on the latest version."
		fi
		return
	fi

	for I in $(getInstanceList); do
		if [ $(isRunning $I) -eq 1 ]; then
			echo "At least one instance is still running (\"$I\")."
			echo "Before updating the engine please stop all instances!"
			return
		fi
	done

	if [ "$FORCED" = "yes" -o "$REMOTE" != "$LOCAL" ]; then
		echo "A newer version of the engine is available."
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
		
		rm -fr $DMP_BASE/DMPServer	
		mkdir $DMP_BASE/DMPServer
		chown $SDTD_USER.$SDTD_GROUP -R $DMP_BASE/DMPServer
		cd /tmp
		wget https://d-mp.org/downloads/release/latest/DMPServer.zip
		unzip -C $DMP_BASE/DMPServer
		cd $DMP_BASE/DMPServer
		# TODO first run + quit
		# TODO copy file in all instannce
		

		
	else
		echo "DMPServer is already at the newest version (local: $LOCAL, remote: $REMOTE)."
		echo "Run with the --force parameter to update/validate the DMPServer files anyway."
	fi
}

sdtdCommandUpdateengineHelp() {
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

sdtdCommandUpdateengineDescription() {
	echo "Update the DMPServer files"
}

sdtdCommandUpdateengineExpects() {
	case $1 in
		2)
			echo "--check --force"
			;;
	esac
}