#!/bin/bash

LmmSubcommandInstancesList() {
	printf "%-*s | %-*s | %-*s | %-*s\n" 20 "Instance name" 8 "Running" 7 "Port" 7 "Version"
	printf -v line "%*s-+-%*s-+-%*s-+-%*s-%*s\n" 20 " " 8 " " 7 " " 7 " "
	echo ${line// /-}
	for I in $(getInstanceList); do
		if [ $(isRunning $I) -eq 1 ]; then
			run="yes"
		else
			run="no"
		fi
		port=$(getConfigValue $I Port ConnectionSettings)
		version=$(getInstanceVersion $I)

		printf "%-*s | %-*s | %-*s | %-*s\n" 20 "$I" 8 "$run" 7 "$port" 7 "$version"
	done
	echo
}

LmmSubcommandInstancesCreate() {
	while : ; do
		readInstanceName
		[ $(isValidInstance "$INSTANCE") -eq 0 ] && break
		echo "Instance name already in use."
		INSTANCE=
	done
	echo

	# Create instance
	# TODO - check if $LMM_BASE/LMPServer exist
	local IPATH=$(getInstancePath "$INSTANCE")
	mkdir -p "$IPATH" 2>/dev/null
	cp -R $LMM_BASE/LMPServer/* "$IPATH/"

	# Edit instance
	loadCurrentConfigValues $INSTANCE
	configEditGeneralSettings configQueryValue
	configEditConnectionSettings configQueryValue
	configEditMasterServerSettings configQueryValue

	# Save new settings
	echo "Saving"
	local arr=(GeneralSettings DedicatedServerSettings ConnectionSettings MasterServerSettings GameplaySettings WarpSettings IntervalSettings ScreenshotSettings CraftSettings WebsiteSettings LogSettings DebugSettings)
	for CV in ${arr[*]}
	do
		if [ ! -f $IPATH/Config/$CV.xml ]; then
			echo "<${CV}Definition/>" > $IPATH/Config/$CV.xml
		fi
	done
	saveCurrentConfigValues $INSTANCE
	chown -R $LMM_USER.$LMM_GROUP $IPATH
	echo "Done"
	echo
}

LmmSubcommandInstancesEdit() {
	if [ $(isValidInstance "$1") -eq 0 ]; then
		echo "No instance given or not a valid instance!"
		return
	fi

	if [ $(isRunning "$1") -eq 0 ]; then
		loadCurrentConfigValues "$1"

		while : ; do
			echo "What section of the config do you want to edit?"
			local i=0
			local sects=()
			for S in $(listConfigEditFuncs); do
				(( i++ ))
				sects[$i]=$S
				printf "  %2d: %s\n" $i "$S"
			done
			echo
			echo "   W: Save and exit"
			echo "   Q: Exit WITHOUT saving"

			local SEC
			while : ; do
				read -p "Section number: " SEC
				SEC=$(lowercase $SEC)
				if [ $(isANumber $SEC) -eq 1 ]; then
					if [ $SEC -ge 1 -a $SEC -le $i ]; then
						break
					fi
				else
					if [ "$SEC" = "q" -o "$SEC" = "w" ]; then
						break
					fi
				fi
				echo "Not a valid section number!"
			done
			echo

			case "$SEC" in
				q)
					echo "Not saving"
					break
					;;
				w)
					echo "Saving"
					saveCurrentConfigValues "$1"
					echo "Done"
					break
					;;
				*)
					configEdit${sects[$SEC]} configQueryValue
					echo
			esac
		done

	else
		echo "Instance $1 is currently running. Please stop it first."
	fi
	echo
}

LmmSubcommandInstancesDelete() {
	if [ $(isValidInstance "$1") -eq 0 ]; then
		echo "No instance given or not a valid instance!"
		return
	fi

	if [ $(isRunning "$1") -eq 0 ]; then
		local SECCODE=$(dd if=/dev/urandom bs=1 count=100 2>/dev/null \
			| tr -cd '[:alnum:]' | head -c5)
		local SECCODEIN
		echo
		echo "WARNING: Do you really want to delete the following instance?"
		echo "    $1"
		echo "This will delete all of its configuration and save data."
		echo "If you REALLY want to continue enter the following security code:"
		echo "    $SECCODE"
		echo
		read -p "Security code: " -e SECCODEIN
		if [ "$SECCODE" = "$SECCODEIN" ]; then
			rm -R "$(getInstancePath "$1")"
			echo "Done"
		else
			echo "Security code did not match, aborting."
		fi
	else
		echo "Instance $1 is currently running. Please stop it first."
	fi
	echo
}

LmmSubcommandInstancesPrintConfig() {
	if [ $(isValidInstance "$1") -eq 0 ]; then
		echo "No instance given or not a valid instance!"
		return
	fi
	loadCurrentConfigValues $1
	configEditAll printConfigValue
	echo
}

LmmCommandInstances() {
	SUBCMD=$1
	shift
	case $SUBCMD in
		list)
			LmmSubcommandInstancesList "$@"
			;;
		create)
			LmmSubcommandInstancesCreate "$@"
			;;
		edit)
			LmmSubcommandInstancesEdit "$@"
			;;
		delete)
			LmmSubcommandInstancesDelete "$@"
			;;
		print_config)
			LmmSubcommandInstancesPrintConfig "$@"
			;;
		*)
			LmmCommandInstancesHelp
			;;
	esac
}

LmmCommandInstancesHelp() {
	line() {
		printf "  %-*s %s\n" 19 "$1" "$2"
	}

	echo "Usage: $(basename $0) instances <subcommand>"
	echo "Subcommands are:"
	line "list" "List all defined instances and their status."
	line "create" "Create a new instance"
	line "edit <instance>" "Edit an existing instance"
	line "delete <instance>" "Delete an existing instance"
	line "print_config <instance>" "List instance settings"
	echo
}

LmmCommandInstancesDescription() {
	echo "List all defined instances"
	echo
}

LmmCommandInstancesExpects() {
	case $1 in
		2)
			echo "list create edit delete print_config"
			;;
		3)
			case $2 in
				edit|delete|print_config)
					echo "$(getInstanceList)"
					;;
			esac
			;;
	esac
	echo
}
