#!/bin/bash
VERSION=1

if [ `id -u` -ne 0 ]; then
	echo "This script has to be run as root!"
	exit 1
fi

ADDCRONJOBS=0
RUNINSTALL=0
INSTALLOPTIONALDEPS=0

DEPENDENCIES="unzip screen mono-complete"


if [ -n "$(command -v apt-get)" ]; then
	ISDEBIAN=1
else
	ISDEBIAN=0
fi

if [ $(uname -m) == 'x86_64' ]; then
	IS64BIT=1
else
	IS64BIT=0
fi

showHelp() {
	echo "Ksp Dmp bootstrapper version $VERSION"
	echo
	echo "Usage: ./bootstrap.sh [-h] -i"
	echo "Parameters:"
	echo "  -h   Print this help screen and exit"
#	echo "  -o   Install optional dependencies ($OPTDEPENDENCIES)"
	echo "  -i   Required to actually start the installation"
}

intro() {
	echo
	echo "Ksp Dmp Linux server bootstrapper"
	echo
	echo "This will install a Ksp Dmp server according to the information"
	echo "given on:"
	echo "   https://github.com/artnod78/KSP-DMP-Manager"
	echo
	read -p "Press enter to continue"
	echo -e "\n=============================================================\n\n"
}

nonDebianWarning() {
	if [ $ISDEBIAN -eq 0 ]; then
		echo "NOTE: It seems like this system is not based on Debian."
		echo "Although installation of the scripts"
		echo "will work the installed management scripts will probably"
		echo "fail because of missing dependencies. Make sure you check"
		echo "the website regarding the prerequisites"
		echo "(https://github.com/artnod78/KSP-DMP-Manager)."
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
		echo -e "\n=============================================================\n\n"
	fi
}

installAptDeps() {
	echo -e "Installing dependencies\n"
	if [ $IS64BIT -eq 1 ]; then
		dpkg --add-architecture i386
	fi
	apt-get update -y
	apt-get install -y $DEPENDENCIES
	echo -e "\n=============================================================\n\n"
}

installOptionalDeps() {
	echo -e "Installing optional dependencies\n"
	apt-get install $OPTDEPENDENCIES
	echo -e "\n=============================================================\n\n"
}

checkSetupDeps() {
	for DEP in git unzip screen mono-complete; do
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
	echo -e "\n=============================================================\n\n"
}

installDMPServer() {
	echo -e "Downloading and installing DMPServer\n"
	wget -nv https://d-mp.org/downloads/release/latest/DMPServer.zip -O /tmp/DmpManager.zip
	unzip /tmp/DmpManager.zip -d /home/ksp
	rm /tmp/DmpManager.zip
	chown ksp.ksp /home/ksp -R
	screen -dmS dmpFirstRun mono /home/ksp/DMPServer/DMPServer.exe
	sleep 5
	screen -S dmpFirstRun -X stuff "/shutdown^M"
	echo -e "\n=============================================================\n\n"
}



finish() {
	if [ $ISDEBIAN -eq 0 ]; then
		echo
		echo "You are not running a Debian based distribution."
		echo "The following things should manually be checked:"
		echo " - Existence of prerequsities"
		echo " - Running the init-script on boot"
	else
		echo -e "\n ALL DONE"
	fi

	echo
	echo -e "For feedback, suggestions, problems please visit the github:"
	echo -e "  https://github.com/artnod78/KSP-DMP-Manager"
	echo
}

main() {
	intro
	nonDebianWarning

	if [ $ISDEBIAN -eq 1 ]; then
		installAptDeps
		if [ $INSTALLOPTIONALDEPS -eq 1 ]; then
#			installOptionalDeps
			echo
		fi
	else
		checkSetupDeps
	fi
	setupUser
	installDMPServer
	if [ $ADDCRONJOBS -eq 1 ]; then
		addCronJobs
	fi
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
