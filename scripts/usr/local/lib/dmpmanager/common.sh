#!/bin/bash

# Provides common functions for dmpmanager-scripts. Not intended to be run directly.

# Check if the script is run as root (exit otherwise) and load global config
checkRootLoadConf() {
	if [ `id -u` -ne 0 ]; then
		echo "This script has to be run as root!"
		exit 10
	fi
	. /etc/dmpmanager.conf
}

# Get the config path for the given instance
# Params:
#   1: Instance name
# Returns:
#   Config path for instance
getInstancePath() {
	echo $DMP_BASE/instances/$1
}

# Check if the given instance name is valid (no blanks, no special chars,
# only letters, digits, underscore, hyphen -> [A-Za-z0-9_\-])
# Params:
#   1: Instance name
# Returns:
#   0/1 instance not valid/valid
isValidInstanceName() {
	if [[ "$1" =~ ^[A-Za-z0-9_\-]+$ ]]; then
		echo 1
	else
		echo 0
	fi
}

# Check if the given instance name is an existing instance
# Params:
#   1: Instance name
# Returns:
#   0/1 instance not valid/valid
isValidInstance() {
	if [ ! -z "$1" ]; then
		if [ $(isValidInstanceName "$1") -eq 1 ]; then
			if [ -d $(getInstancePath "$1") ]; then
				if [ -f $(getInstancePath "$1")/Config/Settings.txt ]; then
					echo 1
					return
				fi
			fi
		fi
	fi
	echo 0
}

# Check if the given instance is currently running
# Params:
#   1: Instance name
# Returns:
#   0 = not running
#   1 = running
isRunning() {
	screen -ls | grep -e "$1" > /dev/null
	if [[ $? == 0 ]]; then
		processPID=$(ps -lat | grep $screenPID | grep -v grep | awk '{print $3}')
		if [[ $processPID ]]; then
			echo 1
		else 
			echo 0
		fi
	else
		echo 0
	fi
}

# Get list of defined instances
# Returns:
#   List of instances
getInstanceList() {
	local IF
	for IF in $DMP_BASE/instances/*; do
		local I=`basename $IF`
		if [ $(isValidInstance $I) -eq 1 ]; then
			echo $I
		fi
	done
}

# Get the PID of the instance if it is running, 0 otherwise
# Params:
#   1: Instance name
# Returns:
#   0 if not running
#   PID otherwise
getInstancePID() {
	if [ $(isRunning $1) -eq 1 ]; then
		screenPID=$(screen -ls | grep dmp_ksp | awk '{print $1}' | cut -d '.' -f1)
		processPID=$(ps -lat | grep $screenPID | grep -v grep | awk '{print $3}')
		echo $processPID
	else
		echo 0
	fi
}


# Get the local engine version number (i.e. build id)
# Returns:
#   0 if no engine installed or no appmanifest found or buildid could not be read
#   Build Id otherwise
getLocalDMPServerVersion() {
	local VERSION=$(cat $DMP_BASE/DMPServer/git-version.txt)
	local LOCAL=0
	if [ -f "$VERSION" ]; then
		LOCAL=VERSION
	fi
	echo $LOCAL
}


# Check if a given TCP port is already in use by any instance
# Params:
#   1: Port
# Returns:
#   0/1 not in use/in use
checkGamePortUsed() {
	local I
	for I in $(getInstanceList); do
		if [ "$2" != "$I" ]; then
			local CURPORT=$(getConfigValue $I "ServerPort")
			if [ $CURPORT -eq $1 ]; then
				echo 1
				return
			fi
			local CURHTTP=$(getConfigValue $I "HttpPort")
			if [ $CURHTTP -eq $1 ]; then
				echo 1
				return
			fi
		fi
	done
	echo 0
}

# Send a single command via screen
# Params:
#   1: Instance name
#   2: Command
sendCommand()
{
	screen=$1
	shift;
	message=$@
	screen -S $screen -X stuff "$message ^M"
}


# Lowercase passed string
# Params:
#   1: String
# Returns:
#   Lowercased string
lowercase() {
	echo "${1}" | tr "[:upper:]" "[:lower:]"
}

# Prepare passed string as part of camelcase, i.e. first char upper case, others
# lowercase
# Params:
#   1: String
# Returns:
#   Transformed string
camelcasePrep() {
	echo $(echo "${1:0:1}" | tr "[:lower:]" "[:upper:]")$(echo "${1:1}" | tr "[:upper:]" "[:lower:]")
}

# Check if given value is a (integer) number
# Params:
#   1: Value
# Returns:
#   0/1 for NaN / is a number
isANumber() {
	if [[ $1 =~ ^[0-9]+$ ]] ; then
		echo "1"
	else
		echo "0"
	fi
}

# Check if given value is a boolean (true/false, yes/no, y/n)
# Params:
#   1: Value
# Returns:
#   0/1
isABool() {
	local LOW=$(lowercase "$1")
	if [ "$LOW" = "false" -o "$LOW" = "true"\
		-o "$LOW" = "yes" -o "$LOW" = "y"\
		-o "$LOW" = "no" -o "$LOW" = "n" ]; then
		echo 1
	else
		echo 0
	fi
}

# Convert the given value to a boolean 0/1
# Params:
#   1: Value
# Returns:
#   0/1 as false/true
getBool() {
	if [ $(isABool "$1") -eq 0 ]; then
		echo 0
	else
		local LOW=$(lowercase "$1")
		if [ "$LOW" = "true" -o "$LOW" = "yes" -o "$LOW" = "y" ]; then
			echo 1
		else
			echo 0
		fi
	fi
}

listCommands() {
	local C
	for C in $(declare -F | cut -d\  -f3 | grep "^dmpCommand"\
			| grep -v "Help$"\
			| grep -v "Description$"\
			| grep -v "Expects$"); do
		local CMD=$(lowercase "${C#dmpCommand}")
		printf "%s " "$CMD"
	done
}

. /usr/local/lib/dmpmanager/help.sh
. /usr/local/lib/dmpmanager/serverconfig.sh
for M in /usr/local/lib/dmpmanager/commands/*.sh; do
	. $M
done

checkRootLoadConf
