#!/bin/bash
VERSION=1

if [ `id -u` -ne 0 ]; then
	echo "This script has to be run as root!"
	exit 1
fi

ADDCRONJOBS=0
RUNINSTALL=0
INSTALLOPTIONALDEPS=0

DEPENDENCIES="git unzip screen mono-complete"


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

installManagementScripts() {
	echo -e "Downloading and installing management scripts\n"
	wget -nv https://github.com/artnod78/KSP-DMP-Manager/archive/master.zip -O /tmp/DmpManager.zip
	TMPPATH=`mktemp -d`
	unzip /tmp/DmpManager.zip -d $TMPPATH
	cd $TMPPATH/KSP-DMP-Manager-master
	for SRCFILE in `find * -type f`; do
		DESTFOLDER=/`dirname $SRCFILE`
		mkdir -p $DESTFOLDER
		cp -a $SRCFILE $DESTFOLDER/
	done
	rm -R $TMPPATH

	chown root.root /etc/7dtd.conf
	chmod 0600 /etc/7dtd.conf

	chown sdtd.sdtd /home/sdtd -R

	chown root.root /etc/init.d/7dtd.sh
	chown root.root /etc/bash_completion.d/7dtd
	chown root.root /etc/cron.d/7dtd-backup
	chown root.root /usr/local/bin/7dtd.sh
	chown root.root /usr/local/lib/7dtd -R
	chmod 0755 /etc/init.d/7dtd.sh
	chmod 0755 /etc/bash_completion.d/7dtd
	chmod 0755 /etc/cron.d/7dtd-backup
	chmod 0755 /usr/local/bin/7dtd.sh
	chmod 0755 /usr/local/lib/7dtd -R

	if [ $ISDEBIAN -eq 1 ]; then
		update-rc.d 7dtd.sh defaults
	fi
	
	echo
	echo "Compiling start-stop-daemon"
	cd /usr/local/lib/7dtd/start-stop-daemon

	gcc -Wall -Wextra -Wno-return-type -o start-stop-daemon start-stop-daemon.c
	chown root.root start-stop-daemon
	chmod 0755 start-stop-daemon

	echo -e "\n=============================================================\n\n"
}
