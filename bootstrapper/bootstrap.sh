#!/bin/bash
VERSION=2

if [ `id -u` -ne 0 ]; then
	echo "This script has to be run as root!"
	exit 1
fi

ADDCRONJOBS=0
RUNINSTALL=0
INSTALLOPTIONALDEPS=0

DEPENDENCIES="curl xmlstarlet rsync net-tools unzip screen mono-complete"
OPTDEPENDENCIES=""


if [ -n "$(command -v apt-get)" ]; then
	ISDEBIAN=1
else
	ISDEBIAN=0
fi

showHelp() {
	echo "Luna Multi Player Server bootstrapper version $VERSION"
	echo
	echo "Usage: ./bootstrap.sh [-h] -i"
	echo "Parameters:"
	echo "  -h   Print this help screen and exit"
	echo "  -o   Install optional dependencies ($OPTDEPENDENCIES)"
	echo "  -i   Required to actually start the installation"
}

intro() {
	echo
	echo "Luna Multi Player Server bootstrapper"
	echo
	echo "This will install a Luna Multi Player server according to the information"
	echo "given on:"
	echo "   https://github.com/artnod78/KSP-DMP-Manager"
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
		echo -e "\n=============================================================\n"
	fi
}

installAptDeps() {
	echo -e "Installing dependencies\n"
	apt-get update -y
	apt-get install -y $DEPENDENCIES
	echo -e "\n=============================================================\n"
}

installOptionalDeps() {
	echo -e "Installing optional dependencies\n"
	apt-get install -y $OPTDEPENDENCIES
	echo -e "\n=============================================================\n"
}

checkSetupDeps() {
	for DEP in netstat curl xmlstarlet rsync unzip screen mono-complete; do
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

installManagementScripts() {
	echo -e "Downloading and installing management scripts"
	echo "  - Download scripts"
	wget -nv -q --show-progress https://github.com/artnod78/KSP-DMP-Manager/archive/master.zip -O /tmp/LmpManager.zip

	echo "  - Extract scripts"
	TMPPATH=`mktemp -d`
	unzip -q /tmp/LmpManager.zip -d $TMPPATH
	cp -R $TMPPATH/KSP-DMP-Manager-master/scripts/* /

	chown root.root /etc/lmm.conf
	chmod 0600 /etc/lmm.conf
	chown root.root /etc/bash_completion.d/lmm
	chmod 0755 /etc/bash_completion.d/lmm
	chown root.root /etc/cron.d/lmm
	chmod 0755 /etc/cron.d/lmm
	chown root.root /etc/systemd/system/lmm.service
	chmod 0777 /etc/systemd/system/lmm.service
	chown root.root /usr/local/bin/lmm.sh
	chmod 0755 /usr/local/bin/lmm.sh
	chown root.root /usr/local/lib/lmm -R
	chmod 0755 /usr/local/lib/lmm -R

	rm -R $TMPPATH
	rm /tmp/LmpManager.zip

	echo "  - Enable deamon"
	systemctl enable lmm.service
	echo -e "\n=============================================================\n"
}

installLunaServer() {
	echo -e "Installing Luna Multi Player Server\n"
	lmm.sh updateengine
	echo -e "=============================================================\n"
}

addCronJobs() {
	echo -e "Enabling backup cron job\n"

	echo -e "By default a backup of the save folder will be created once"
	echo -e "  per hour. This can be changed in /etc/cron.d/lmm."
	
	cat /etc/cron.d/lmm | tr -d '#' > /tmp/lmm
	cp /tmp/lmm /etc/cron.d

	echo -e "\n=============================================================\n"
}

finish() {
	if [ $ISDEBIAN -eq 0 ]; then
		echo
		echo "You are not running a Debian based distribution."
		echo "The following things should manually be checked:"
		echo " - Existence of prerequsities"
		echo " - Running the init-script on boot"
	else
		echo -e "ALL DONE"
	fi

	echo
	echo -e "For further configuration options check:"
	echo -e "  /etc/lmm.conf"
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
	installManagementScripts
	installLunaServer
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
		c)
			ADDCRONJOBS=1
			;;
		o)
			INSTALLOPTIONALDEPS=1
			;;
		i)
			RUNINSTALL=1
			;;
	esac
done
if [ $RUNINSTALL -eq 1 ]; then
	main
else
	if [ $ADDCRONJOBS -eq 1 ]; then
		if [ -f /etc/cron.d/lmm ]; then
			addCronJobs
		fi
	fi
fi
