#!/bin/bash
VERSION=3

if [ `id -u` -ne 0 ]; then
	echo "This script has to be run as root!"
	exit 1
fi

ADDCRONJOBS=0
RUNINSTALL=0

DEPENDENCIES="curl unzip screen mono-complete"


if [ -n "$(command -v apt-get)" ]; then
	ISDEBIAN=1
else
	ISDEBIAN=0
fi

showHelp() {
	echo "Luna Multi Player Server simple bootstrapper version $VERSION"
	echo
	echo "Usage: ./bootstrap.sh [-h] -i"
	echo "Parameters:"
	echo "  -h   Print this help screen and exit"
	echo "  -i   Required to actually start the installation"
}

intro() {
	echo
	echo "Luna Multi Player Server bootstrapper"
	echo
	echo "This will install a Luna Multi Player server according to the information"
	echo "given on:"
	echo "   https://github.com/artnod78/KSP-LMP-Manager"
	echo
	read -p "Press enter to continue"
	echo -e "\n=============================================================\n"
}

nonDebianWarning() {
	if [ $ISDEBIAN -eq 0 ]; then
		echo "NOTE: It seems like this system is not based on Debian."
		echo "Although installation of the scripts"
		echo "will work the installed management scripts will probably"
		echo "fail because of missing dependencies. Make sure you check"
		echo "the website regarding the prerequisites"
		echo "(https://github.com/artnod78/KSP-LMP-Manager)."
		echo
		echo "Do you want to continue anyway?"
		select yn in "Yes" "No"; do
			case $yn in
				Yes)
					echo "Continuing..."
					break;;
				No)
					echo "Aborting."
					exit 0
					;;
			esac
		done
		echo -e "\n=============================================================\n"
	fi
}

installAptDeps() {
	echo -e "Installing dependencies\n"
	apt-get update -y
	apt-get install -y $DEPENDENCIES
	echo -e "\n=============================================================\n"
}

checkSetupDeps() {
	for DEP in curl unzip screen mono-complete; do
		which $DEP > /dev/null 2>&1
		if [ $? -ne 0 ]; then
			echo "\"$DEP\" not installed. Please install it and run this script again."
			exit 1
		fi
	done

}

setupUser() {
	echo -e "Setting up user and group \"ksp\"\n"
	useradd -d /home/ksp -m -r -s /bin/bash -U ksp
	echo -e "\n=============================================================\n"
}

installLunaServer() {
	local REMOTE=$(curl -s https://api.github.com/repos/LunaMultiplayer/LunaMultiplayer/releases/latest | grep -e "tag_name" | cut -d "\"" -f4)
	echo "Downloading and installing Luna Multi Player $REMOTE"
	if [ -e /home/ksp/LMPServer ]; then
		local LOCAL=$(cat /home/ksp/LMPServer/version.txt)
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
		rm -fr /home/ksp/LMPServer
	fi
	echo "  - Download latest release: $REMOTE"
	lmDlUrl="https://github.com/LunaMultiplayer/LunaMultiplayer/releases/download/$REMOTE/LunaMultiPlayer-Release.zip"
	wget -nv -q --show-progress $lmDlUrl -O /tmp/LunaMultiPlayer-Release.zip

	echo "  - Extract new version"
	local TMPPATH=`mktemp -d`
	unzip -q /tmp/LunaMultiPlayer-Release.zip -d $TMPPATH
	cp -R -f $TMPPATH/LMPServer /home/ksp
	echo $REMOTE > /home/ksp/LMPServer/version.txt
	chown root.ksp -R /home/ksp
	rm -f /tmp/LunaMultiPlayer-Release.zip
	rm -rf $TMPPATH
	echo "  - Executing first run"
	screen -dmS lmFirstRun mono /home/ksp/LMPServer/Server.exe
	sleep 5
	echo "  - Kill first run"
	screen -S lmFirstRun -X stuff $'\003'
	echo -e "\n=============================================================\n"
}



finish() {
	if [ $ISDEBIAN -eq 0 ]; then
		echo
		echo "You are not running a Debian based distribution."
	else
		echo "ALL DONE"
	fi

	echo
	echo "For feedback, suggestions, problems please visit the github:"
	echo "  https://github.com/artnod78/KSP-LMP-Manager"
	echo
}

main() {
	intro
	nonDebianWarning

	if [ $ISDEBIAN -eq 1 ]; then
		installAptDeps
	else
		checkSetupDeps
	fi
	setupUser
	installLunaServer
	finish
}

if [ -z $1 ]; then
	showHelp
	exit 0
fi

while getopts "hcoi" opt; do
	case "$opt" in
		h)
			showHelp
			exit 0
			;;
		i)
			RUNINSTALL=1
			;;
	esac
done
if [ $RUNINSTALL -eq 1 ]; then
	main
fi
