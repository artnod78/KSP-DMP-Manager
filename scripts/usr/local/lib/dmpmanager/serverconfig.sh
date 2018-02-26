#!/bin/bash 
serverconfig_port_QueryName() { 
	echo "The port the server listens on"
}
serverconfig_port_Type() { 
	echo "number"
}
serverconfig_port_Default() { 
	echo "6702"
}
serverconfig_port_Range() { 
	echo "1024-65533"
}
serverconfig_port_Validate() { 
	local I=${INSTANCE:-!}
	if [ $(checkGamePortUsed "$1" "$I") -eq 0 ]; then  
		echo "1"
	else
		echo "0"
	fi
}
serverconfig_port_ErrorMessage() { 
	echo "Illegal port number or port already in use by another instance."
}

serverconfig_warpMode_QueryName() { 
	echo "Specify the warp type"
}
serverconfig_warpMode_Type() { 
	echo "enum"
}
serverconfig_warpMode_Default() { 
	echo "4"
}
serverconfig_warpMode_Values() { 
	config_allowed_values=("MCW_FORCE" "MCW_VOTE" "MCW_LOWEST" "SUBSPACE_SIMPLE" "SUBSPACE" "NONE")
}

serverconfig_gameMode_QueryName() { 
	echo "Specify the game type"
}
serverconfig_gameMode_Type() { 
	echo "enum"
}
serverconfig_gameMode_Default() { 
	echo "0"
}
serverconfig_gameMode_Values() { 
	config_allowed_values=("SANDBOX" "SCIENCE" "CAREER")
}

serverconfig_gameDifficulty_QueryName() { 
	echo "Specify the gameplay difficulty of the server"
}
serverconfig_gameDifficulty_Type() { 
	echo "enum"
}
serverconfig_gameDifficulty_Default() { 
	echo "1"
}
serverconfig_gameDifficulty_Values() { 
	config_allowed_values=("EASY" "NORMAL" "MODERATE" "HARD" "CUSTOM")
}

serverconfig_whitelisted_QueryName() { 
	echo "Enable white-listing"
}
serverconfig_whitelisted_Type() { 
	echo "boolean"
}
serverconfig_whitelisted_Default() { 
	echo "false"
}
serverconfig_whitelisted_ErrorMessage() { 
	echo "Not a valid boolean given (true/false or yes/no or y/n)."
}

serverconfig_modControl_QueryName() { 
	echo "Enable mod control"
}
serverconfig_modControl_Type() { 
	echo "enum"
}
serverconfig_modControl_Default() { 
	echo "1"
}
serverconfig_modControl_Values() { 
	config_allowed_values=("DISABLED" "ENABLED_STOP_INVALID_PART_SYNC" "ENABLED_STOP_INVALID_PART_LAUNCH")
}

serverconfig_sendPlayerToLatestSubspace_QueryName() { 
	echo "If true, sends the player to the latest subspace upon connecting"
}
serverconfig_sendPlayerToLatestSubspace_Type() { 
	echo "boolean"
}
serverconfig_sendPlayerToLatestSubspace_Default() { 
	echo "true"
}
serverconfig_sendPlayerToLatestSubspace_ErrorMessage() { 
	echo "Not a valid boolean given (true/false or yes/no or y/n)."
}

serverconfig_useUTCTimeInLog_QueryName() { 
	echo "Use UTC instead of system time in the log"
}
serverconfig_useUTCTimeInLog_Type() { 
	echo "boolean"
}
serverconfig_useUTCTimeInLog_Default() { 
	echo "false"
}
serverconfig_useUTCTimeInLog_ErrorMessage() { 
	echo "Not a valid boolean given (true/false or yes/no or y/n)."
}

serverconfig_logLevel_QueryName() { 
	echo "Minimum log level"
}
serverconfig_logLevel_Type() { 
	echo "enum"
}
serverconfig_logLevel_Default() { 
	echo "0"
}
serverconfig_logLevel_Values() { 
	config_allowed_values=("DEBUG" "INFO" "CHAT" "ERROR" "FATAL")
}

serverconfig_screenshotsPerPlayer_QueryName() { 
	echo "Specify maximum number of screenshots to save per player"
}
serverconfig_screenshotsPerPlayer_Type() { 
	echo "number"
}
serverconfig_screenshotsPerPlayer_Default() { 
	echo "20"
}

serverconfig_screenshotHeight_QueryName() { 
	echo "Specify vertical resolution of screenshots"
}
serverconfig_screenshotHeight_Type() { 
	echo "number"
}
serverconfig_screenshotHeight_Default() { 
	echo "720"
}

serverconfig_cheats_QueryName() { 
	echo "Enable use of cheats in-game"
}
serverconfig_cheats_Type() { 
	echo "boolean"
}
serverconfig_cheats_Default() { 
	echo "true"
}
serverconfig_cheats_ErrorMessage() { 
	echo "Not a valid boolean given (true/false or yes/no or y/n)."
}

serverconfig_httpPort_QueryName() { 
	echo "The port the server listens on"
}
serverconfig_httpPort_Type() { 
	echo "number"
}
serverconfig_httpPort_Default() { 
	echo "0"
}
serverconfig_httpPort_Range() { 
	echo "1024-65533"
}
serverconfig_httpPort_Validate() { 
	local I=${INSTANCE:-!}
	if [ $(checkGamePortUsed "$1" "$I") -eq 0 ]; then  
		echo "1"
	else
		echo "0"
	fi
}
serverconfig_httpPort_ErrorMessage() { 
	echo "Illegal port number or port already in use by another instance."
}

serverconfig_serverName_QueryName() { 
	echo "Name of the server"
}
serverconfig_serverName_Type() { 
	echo "string"
}
serverconfig_serverName_Validate() { 
	if [ ! -z "$1" ]; then  
		echo "1"
	else
		echo "0"
	fi
}
serverconfig_serverName_ErrorMessage() { 
	echo "Server name cannot be empty."
}

serverconfig_maxPlayers_QueryName() { 
 	echo "Maximum amount of players that can join the server"
}
serverconfig_maxPlayers_Type() { 
 	echo "number"
}
serverconfig_maxPlayers_Default() { 
	echo "20"
}
serverconfig_maxPlayers_Range() { 
	echo "1-100"
}

serverconfig_autoNuke_QueryName() { 
 	echo "Specify in minutes how often /nukeksc automatically runs"
}
serverconfig_autoNuke_Type() { 
 	echo "number"
}
serverconfig_autoNuke_Default() { 
	echo "0"
}

serverconfig_autoDekessler_QueryName() { 
 	echo "Specify in minutes how often /dekessler automatically runs"
}
serverconfig_autoDekessler_Type() { 
 	echo "number"
}
serverconfig_autoDekessler_Default() { 
	echo "30"
}

serverconfig_numberOfAsteroids_QueryName() { 
 	echo "How many untracked asteroids to spawn into the universe"
}
serverconfig_numberOfAsteroids_Type() { 
 	echo "number"
}
serverconfig_numberOfAsteroids_Default() { 
	echo "30"
}

serverconfig_consoleIdentifier_QueryName() { 
	echo "Specify the name that will appear when you send a message using the server's console"
}
serverconfig_consoleIdentifier_Type() { 
	echo "string"
}
serverconfig_consoleIdentifier_Validate() { 
	if [ ! -z "$1" ]; then  
		echo "1"
	else
		echo "0"
	fi
}
serverconfig_consoleIdentifier_ErrorMessage() { 
	echo "consoleIdentifier cannot be empty."
}

serverconfig_expireScreenshots_QueryName() { 
 	echo "Specify the amount of days a screenshot should be considered as expired and deleted"
}
serverconfig_expireScreenshots_Type() { 
 	echo "number"
}
serverconfig_expireScreenshots_Default() { 
	echo "0"
}

serverconfig_compressionEnabled_QueryName() { 
	echo "Enable use of cheats in-game"
}
serverconfig_compressionEnabled_Type() { 
	echo "boolean"
}
serverconfig_compressionEnabled_Default() { 
	echo "true"
}
serverconfig_compressionEnabled_ErrorMessage() { 
	echo "Not a valid boolean given (true/false or yes/no or y/n)."
}

serverconfig_expireLogs_QueryName() { 
 	echo "Specify the amount of days a log file should be considered as expired and deleted"
}
serverconfig_expireLogs_Type() { 
 	echo "number"
}
serverconfig_expireLogs_Default() { 
	echo "0"
}

serverconfig_safetyBubbleDistance_QueryName() { 
 	echo "Specify the minimum distance in which vessels can interact with eachother at the launch pad and runway"
}
serverconfig_safetyBubbleDistance_Type() { 
 	echo "number"
}
serverconfig_safetyBubbleDistance_Default() { 
	echo "100"
}


#################################
## Edit option functions

configEditServer() { 
	local CV
	
	echo "Server"
	echo "--------------------------------"
	for CV in serverName port httpPort whitelisted consoleIdentifier compressionEnabled logLevel useUTCTimeInLog expireLogs	; do 
		$1 $CV
	done
	echo
}

configEditGameType() { 
	local CV
	
	echo "Game type"
	echo "--------------------------------"
	for CV in warpMode gameMode modControl numberOfAsteroids maxPlayers sendPlayerToLatestSubspace safetyBubbleDistance ; do 
		$1 $CV
	done
	echo
}

configEditDifficulty() { 
	local CV
	
	echo "Difficulty"
	echo "--------------------------------"
	for CV in gameDifficulty cheats autoNuke autoDekessler ; do 
		$1 $CV
	done
	echo
}

configEditScreenshoot() { 
	local CV
	
	echo "Screenshoot options"
	echo "--------------------------------"
	for CV in screenshotsPerPlayer screenshotHeight expireScreenshots ; do 
		$1 $CV
	done
	echo
}

configEditAll() { 
	configEditServer "$1"
	configEditGameType "$1"
	configEditDifficulty "$1"
	configEditScreenshoot "$1"
}





#################################
## Generic worker functions


# List all defined config editing parts
# Returns:
#   List of config funcs
listConfigEditFuncs() { 
	local CV
	for CV in $(declare -F | cut -d\  -f3 | grep "configEdit.*$ "); do  
		CV=${CV#configEdit}
		printf "%s " "$CV"
	done
}


# List all defined config options
# Returns:
#   List of defined config options
listConfigValues() { 
	local CV
	for CV in $(declare -F | cut -d\  -f3 | grep "^serverconfig_.*_Type$ "); do 
		CV=${CV#serverconfig_}
		CV=${CV%_Type}
		printf "%s " "$CV"
	done
}


# Validate the given value for the given option
# Params:
#   1: Option name
#   2: Value
# Returns:
#   0/1: invalid/valid
isValidOptionValue() { 
	local TYPE=$(serverconfig_$1_Type)
	local RANGE=""
	
	if [ "$TYPE" = "enum" ]; then 
		TYPE="number"
		serverconfig_$1_Values
		RANGE=1-${#config_allowed_values[@]} 
	else 
		if [ "$(type -t serverconfig_$1_Range)" = "function" ]; then 
			RANGE=$(serverconfig_$1_Range) 
		fi
	fi
	
	if [ "$TYPE" = "number" ]; then 
		if [ $(isANumber "$2") -eq 0 ]; then 
			echo "0"
			return
		fi
		
		if [ ! -z "$RANGE" ]; then 
                	local MIN=$(cut -d- -f1 <<< "$RANGE")
                	local MAX=$(cut -d- -f2 <<< "$RANGE")
			
                	if [ $2 -lt $MIN -o $2 -gt $MAX ]; then 
                    		echo "0"
                    		return
			fi
		fi
	fi
	if [ "$TYPE" = "boolean" ]; then 
		if [ $(isABool "$2") -eq 0 ]; then 
			echo "0"
			return
		fi
	fi
	
	if [ "$(type -t serverconfig_$1_Validate)" = "function" ]; then 
		if [ $(serverconfig_$1_Validate "$2") -eq 0 ]; then 
			echo "0"
			return
        	fi
        fi
        echo "1"
}

# Query for the value of a single config option
# Will be stored in $configCurrent_$1
# Params:
#   1: Option name
configQueryValue() { 
	local TYPE=$(serverconfig_$1_Type)
	local NAME=""
	local RANGE=""
	local DEFAULT=""
	local currentValName=configCurrent_$1

	if [ "$(type -t serverconfig_$1_Values)" = "function" ]; then 
		echo "$(serverconfig_$1_QueryName), options:"
		serverconfig_$1_Values
		NAME="Select option"
		if [ "$TYPE" = "enum" ]; then 
			local OPTOFFSET=1
		else
			local OPTOFFSET=0
		fi
		for (( i=$OPTOFFSET; i < ${#config_allowed_values[@]}+$OPTOFFSET; i++ )); do 
			printf "  %2d: %s\n" $i "${config_allowed_values[$i-$OPTOFFSET]}"
		done
	else
		NAME=$(serverconfig_$1_QueryName)
	fi

	if [ "$TYPE" = "enum" ]; then 
		RANGE=1-${#config_allowed_values[@]}
		if [ ! -z "${!currentValName}" ]; then 
			for (( i=1; i < ${#config_allowed_values[@]}+1; i++ )); do 
				if [ "${!currentValName}" = "${config_allowed_values[$i-1]}" ]; then 
					DEFAULT=$i
				fi
			done
			export $currentValName=
		fi
	else
		if [ "$(type -t serverconfig_$1_Range)" = "function" ]; then 
			RANGE=$(serverconfig_$1_Range)
		fi
	fi

	if [ -z "$DEFAULT" ]; then 
		if [ ! -z "${!currentValName}" ]; then 
			DEFAULT=${!currentValName}
		else
			if [ "$(type -t serverconfig_$1_Default)" = "function" ]; then 
				DEFAULT=$(serverconfig_$1_Default)
			fi
		fi
	fi

	local prompt=$(printf "%s" "$NAME")
	if [ ! -z "$RANGE" ]; then 
		prompt=$(printf "%s (%s)" "$prompt" "$RANGE")
	fi
	if [ ! -z "$DEFAULT" ]; then 
		prompt=$(printf "%s [%s]" "$prompt" "$DEFAULT")
	fi
	prompt=$(printf "%s:" "$prompt")
	prompt=$(printf "%-*s " 40 "$prompt")

	while : ; do 
		read -p "$prompt" $currentValName
		export $currentValName="${!currentValName:-$DEFAULT}"
		if [ $(isValidOptionValue "$1" "${!currentValName}") -eq 0 ]; then 
			if [ "$(type -t serverconfig_$1_ErrorMessage)" = "function" ]; then 
				serverconfig_$1_ErrorMessage "${!currentValName}"
			fi
		fi
		[ $(isValidOptionValue "$1" "${!currentValName}") -eq 1 ] && break
	done
	
	if [ "$TYPE" = "boolean" ]; then 
		if [ $(getBool ${!currentValName}) -eq 1 ]; then 
			export $currentValName="true"
		else
			export $currentValName="false"
		fi
	fi
	if [ "$TYPE" = "enum" ]; then 
		export $currentValName="${config_allowed_values[$currentValName-1]}"
	fi
	echo
}

# Set parameters for current instance that have forced values:
#  - TelnetEnabled must be set so that management scripts can work
#  - AdminFileName is made to point to the local instance admins.xml
#  - SaveGameFolder is made to point to the instance folder
# Params:
#   1: Instance name
configSetAutoParameters() { 
	configCurrent_SaveGameFolder="$(getInstancePath "$1")"
}


# Print defined config value
# Params:
#   1: Config option
printConfigValue() { 
	local currentValName=configCurrent_$1
	printf "%-25s = %s\n" "$(serverconfig_$1_QueryName)" "${!currentValName}"
}

# Query for an instance name (will be saved in $INSTANCE)
readInstanceName() { 
	until [ $(isValidInstanceName "$INSTANCE") -eq 1 ] ; do 
		read -p "Instance name: " INSTANCE
		if [ $(isValidInstanceName "$INSTANCE") -eq 0 ]; then 
			echo "Invalid instance name, may only contain:"
			echo " - letters (A-Z / a-z)"
			echo " - digits (0-9)"
			echo " - underscores (_)"
			echo " - hyphens (-)"
		fi
	done
}

# Undefine the current config values
unsetAllConfigValues() { 
	local CV
	for CV in $(listConfigValues) ; do 
		local currentValName=configCurrent_$CV
		export $currentValName=
	done
}

# Load all config values from the config.xml of the given instance
# Params:
#   1: Instance name
loadCurrentConfigValues() { 
	local CV
	for CV in $(listConfigValues) ; do 
		local currentValName=configCurrent_$CV
		local cfile=$(getInstancePath "$1")/Config/Setting.txt
		local XPATH="/ServerSettings/property[@name='$CV']/@value"
		local VAL=$($XMLSTARLET sel -t -v "$XPATH" $cfile)
		if [ ! -z "$VAL" ]; then 
			export $currentValName="$VAL"
		fi
	done
}

# Save all config values to the config.xml of the given instance
# Params:
#   1: Instance name
saveCurrentConfigValues() { 
	local CV
	for CV in $(listConfigValues) TelnetEnabled AdminFileName SaveGameFolder ; do 
		local currentValName=configCurrent_$CV
		local val="${!currentValName}"
		local cfile=$(getInstancePath "$1")/config.xml

		XPATHBASE="/ServerSettings/property[@name='$CV']"

		if [ -z $($XMLSTARLET sel -t -v "$XPATHBASE/@name" $cfile) ]; then 
			$XMLSTARLET ed -L \
				-s "/ServerSettings" -t elem -n "property" -v "" \
				-i "/ServerSettings/property[not(@name)]" -t attr -n "name" -v "$CV" \
				-i "$XPATHBASE" -t attr -n "value" -v "$val" \
				$cfile
		else
			$XMLSTARLET ed -L \
				-u "$XPATHBASE/@value" -v "$val" \
				$cfile
		fi
	done
}

# Check if the config template exists
# Returns:
#   0/1: no/yes
configTemplateExists() { 
	if [ -f $SDTD_BASE/templates/config.xml ]; then 
		echo 1
	else
		echo 0
	fi
}

# Get a single value from a serverconfig
# Params:
#   1: Instance name
#   2: Property name
# Returns:
#   Property value
getConfigValue() { 
	local CONF=$(getInstancePath $1)/config.xml
	$XMLSTARLET sel -t -v "/ServerSettings/property[@name='$2']/@value" $CONF
}

# Update a single value in a serverconfig
# Params:
#   1: Instance name
#   2: Property name
#   3: New value
setConfigValue() { 
	local CONF=$(getInstancePath $1)/config.xml
	$XMLSTARLET ed -L -u "/ServerSettings/property[@name='$2']/@value" -v "$3" $CONF
}

echo .
