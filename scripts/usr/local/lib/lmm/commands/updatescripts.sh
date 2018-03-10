#!/bin/bash

# Checks for newer scripts version and downloads them

lmmCommandUpdatescripts() {
	local LOCAL=$(cat /usr/local/lib/lmm/VERSION | grep "Version" | cut -d\  -f2)
	local REMOTE=$(wget -qO- https://raw.githubusercontent.com/artnod78/KSP-DMP-Manager/master/scripts/usr/local/lib/lmm/VERSION | grep "Version" | cut -d\  -f2)
	
	local FORCED
	if [ "$1" = "--force" ]; then
		FORCED=yes
	else
		FORCED=no
	fi
	if [ "$FORCED" = "yes" -o $REMOTE -gt $LOCAL ]; then
		echo "A newer version of the scripts is available."
		echo "Local:     v.$LOCAL"
		echo "Available: v.$REMOTE"
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
		
		wget -q https://github.com/artnod78/KSP-DMP-Manager/archive/master.zip -O /tmp/DmpManager.zip
		rm -f /usr/local/lib/lmm/VERSION /usr/local/lib/lmm/*.sh /usr/local/lib/lmm/commands/* /usr/local/bin/lmm.sh
		TMPPATH=`mktemp -d`
		unzip /tmp/DmpManager.zip -d $TMPPATH
		cd $TMPPATH/KSP-DMP-Manager-master/scripts
		for SRCFILE in `find * -type f`; do
			DESTFOLDER=/`dirname $SRCFILE`
			mkdir -p $DESTFOLDER
			cp -a $SRCFILE $DESTFOLDER/
		done
		cd ~
		rm -R $TMPPATH
		rm /tmp/DmpManager.zip

#		chown root.root /etc/init.d/lmm.sh
		chown root.root /etc/bash_completion.d/lmm
		chown root.root /usr/local/bin/lmm.sh
		chown root.root /usr/local/lib/lmm -R
#		chmod 0755 /etc/init.d/lmm.sh
		chmod 0755 /etc/bash_completion.d/lmm
		chmod 0755 /usr/local/bin/lmm.sh
		chmod 0755 /usr/local/lib/lmm -R
		
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

sdtdCommandUpdatescriptsHelp() {
	echo "Usage: $(basename $0) updatescripts [--force]"
	echo
	echo "Check for a newer version of the management scripts. If there is a newer"
	echo "version they can be updated by this command."
	echo
	echo "If --force is specified you are asked if you want to redownload the scripts"
	echo "even if there is no new version available."
	echo
}

sdtdCommandUpdatescriptsDescription() {
	echo "Update these scripts"
	echo
}

sdtdCommandUpdatescriptsExpects() {
	case $1 in
		2)
			echo "--force"
			;;
	esac
	echo
}
