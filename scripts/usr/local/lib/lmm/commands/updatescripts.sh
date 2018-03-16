#!/bin/bash

# Checks for newer scripts version and downloads them

lmmCommandUpdatescripts() {
	local LOCAL=$(tr -d "\r" <<< $(cat /usr/local/lib/lmm/VERSION | grep "Version" | awk '{print $2}'))
	local REMOTE=$(tr -d "\r" <<< $(wget -qO- https://raw.githubusercontent.com/artnod78/KSP-DMP-Manager/master/scripts/usr/local/lib/lmm/VERSION | grep "Version" | awk '{print $2}'))

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

	if [ "$CHECKONLY" = "yes" ]; then
		echo "Installed scripts release:"
		echo "  - Version: $LOCAL"
		echo "Available scripts release:"
		echo "  - Version: $REMOTE"
		if [ $REMOTE -gt $LOCAL ]; then
			echo "Newer version available $REMOTE."
		else
			echo "Scripts on the latest version."
		fi
		echo
		return
	fi

	if [ "$FORCED" = "yes" ] || [ $REMOTE -gt $LOCAL ]; then
		echo "A newer version of the scripts is available."
		echo "  - Local version: $LOCAL"
		echo "  - Available version: $REMOTE"
		echo
		echo "Please check the release notes before continuing:"
		echo "  https://github.com/artnod78/KSP-DMP-Manager"
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

		rm -f /usr/local/lib/lmm/VERSION /usr/local/lib/lmm/*.sh /usr/local/lib/lmm/commands/* /usr/local/bin/lmm.sh

		echo "  - Download scripts v.$REMOTE"
		wget -nv  -q --show-progress https://github.com/artnod78/KSP-DMP-Manager/archive/master.zip -O /tmp/LmpManager.zip

		echo "  - Extract scripts"
		local TMPPATH=`mktemp -d`
		unzip -q /tmp/LmpManager.zip -d $TMPPATH
		cp -R $TMPPATH/KSP-DMP-Manager-master/scripts/usr/* /usr/
		chown root.root /usr/local/bin/lmm.sh
		chown root.root /usr/local/lib/lmm -R
		chmod 0755 /usr/local/bin/lmm.sh
		chmod 0755 /usr/local/lib/lmm -R
		# TODO - edit /etc/lmm.conf if needed
		rm -fr $TMPPATH
		rm -f /tmp/LmpManager.zip

		echo "Update done."
		echo
		echo "Note: This updated only script files. If the global config file"
		echo "/etc/lmm.conf contains changes for the newer version or there"
		echo "were new files added to the user folder /home/ksp those changes"
		echo "have not been applied!"
	else
		echo "Scripts are already at the newest version (v.$LOCAL)."
	fi
	echo
}

lmmCommandUpdatescriptsHelp() {
	echo "Usage: $(basename $0) updatescripts [--check] [--force]"
	echo
	echo "Check for a newer version of the management scripts. If there is a newer"
	echo "version they can be updated by this command."
	echo
	echo "If --force is specified you are asked if you want to redownload the scripts"
	echo "even if there is no new version available."
	echo
	echo "If --check is specified it will only output the current local and remote version"
	echo "and if an update is available."
	echo
}

lmmCommandUpdatescriptsDescription() {
	echo "Update these scripts"
	echo
}

lmmCommandUpdatescriptsExpects() {
	case $1 in
		2)
			echo "--check --force"
			;;
	esac
	echo
}
