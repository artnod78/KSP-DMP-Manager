#!/bin/bash

# Provides functions to query and validate values for Settings.txt

#################################
## Definition of options

serverconfig_Port_QueryName() {
	echo "Base UDP port"
}
serverconfig_Port_Type() {
	echo "number"
}
serverconfig_Port_Default() {
	echo "8800"
}
serverconfig_Port_Range() {
	echo "1024-65533"
}
serverconfig_ServerPort_Validate() {
	local I=${INSTANCE:-!}
	if [ $(checkGamePortUsed "$I" "$1") -eq 0 ]; then
		echo "1"
	else
		echo "0"
	fi
}
serverconfig_ServerPort_ErrorMessage() {
	echo "Illegal port number or port already in use by another instance."
}

serverconfig_ServerName_QueryName() {
	echo "Server name"
}
serverconfig_ServerName_Type() {
	echo "string"
}
serverconfig_ServerName_Validate() {
	if [ ! -z "$1" ]; then
		echo "1"
	else
		echo "0"
	fi
}
serverconfig_ServerName_ErrorMessage() {
	echo "Server name cannot be empty."
}

serverconfig_Description_QueryName() {
	echo "Server description"
}
serverconfig_Description_Type() {
	echo "string"
}

serverconfig_ServerMotd_QueryName() {
	echo "Server description"
}
serverconfig_ServerMotd_Type() {
	echo "string"
}
serverconfig_ServerMotd_Default() {
	echo "Welcome, %Name%!"
}

serverconfig_MaxPlayers_QueryName() {
 	echo "Max players"
}
serverconfig_MaxPlayers_Type() {
 	echo "number"
}
serverconfig_MaxPlayers_Default() {
	echo "4"
}
serverconfig_MaxPlayers_Range() {
	echo "1-64"
}

serverconfig_MaxUsernameLength_QueryName() {
 	echo "Max username length"
}
serverconfig_MaxUsernameLength_Type() {
 	echo "number"
}
serverconfig_MaxUsernameLength_Default() {
	echo "15"
}
serverconfig_MaxUsernameLength_Range() {
	echo "1-64"
}

serverconfig_RegisterWithMasterServer_QueryName() {
	echo "Appear on the server list"
}
serverconfig_RegisterWithMasterServer_Type() {
	echo "boolean"
}
serverconfig_RegisterWithMasterServer_Default() {
	echo "true"
}
serverconfig_RegisterWithMasterServer_ErrorMessage() {
	echo "Not a valid boolean given (true/false or yes/no or y/n)."
}

serverconfig_MasterServerRegistrationMsInterval_QueryName() {
	echo "MasterServer registration refresh interval in ms"
}
serverconfig_MasterServerRegistrationMsInterval_Type() {
	echo "number"
}
serverconfig_MasterServerRegistrationMsInterval_Default() {
	echo "5000"
}

serverconfig_AutoDekessler_QueryName() {
	echo "Dekessler automatically runs in min"
}
serverconfig_AutoDekessler_Type() {
	echo "number"
}
serverconfig_AutoDekessler_Default() {
	echo "1"
}

serverconfig_AutoNuke_QueryName() {
	echo "Nukeksc automatically runs in min"
}
serverconfig_AutoNuke_Type() {
	echo "number"
}
serverconfig_AutoNuke_Default() {
	echo "0"
}

serverconfig_ShowVesselsInThePast_QueryName() {
	echo "Show vessels in the past"
}
serverconfig_ShowVesselsInThePast_Type() {
	echo "boolean"
}
serverconfig_ShowVesselsInThePast_Default() {
	echo "true"
}
serverconfig_ShowVesselsInThePast_ErrorMessage() {
	echo "Not a valid boolean given (true/false or yes/no or y/n)."
}

serverconfig_Cheats_QueryName() {
	echo "Cheats"
}
serverconfig_Cheats_Type() {
	echo "boolean"
}
serverconfig_Cheats_Default() {
	echo "true"
}
serverconfig_Cheats_ErrorMessage() {
	echo "Not a valid boolean given (true/false or yes/no or y/n)."
}

serverconfig_AllowSackKerbals_QueryName() {
	echo "Allow sack Kerbals"
}
serverconfig_AllowSackKerbals_Type() {
	echo "boolean"
}
serverconfig_AllowSackKerbals_Default() {
	echo "false"
}
serverconfig_AllowSackKerbals_ErrorMessage() {
	echo "Not a valid boolean given (true/false or yes/no or y/n)."
}

serverconfig_ConsoleIdentifier_QueryName() {
	echo "Server console identifier"
}
serverconfig_ConsoleIdentifier_Type() {
	echo "string"
}
serverconfig_ConsoleIdentifier_Validate() {
	if [ ! -z "$1" ]; then
		echo "1"
	else
		echo "0"
	fi
}
serverconfig_ConsoleIdentifier_ErrorMessage() {
	echo "Server console identifier cannot be empty."
}

serverconfig_GameDifficulty_QueryName() {
	echo "Game difficulty"
}
serverconfig_GameDifficulty_Type() {
	echo "enum"
}
serverconfig_GameDifficulty_Default() {
	echo "1"
}
serverconfig_GameDifficulty_Values() {
	config_allowed_values=("Easy" "Normal" "Moderate" "Hard" "Custom")
}

serverconfig_GameMode_QueryName() {
	echo "GameMode"
}
serverconfig_GameMode_Type() {
	echo "enum"
}
serverconfig_GameMode_Default() {
	echo "1"
}
serverconfig_GameMode_Values() {
	config_allowed_values=("Sandbox" "Career" "Science")
}

serverconfig_ModControl_QueryName() {
	echo "ModControl"
}
serverconfig_ModControl_Type() {
	echo "enum"
}
serverconfig_ModControl_Default() {
	echo "1"
}
serverconfig_ModControl_Values() {
	config_allowed_values=("EnabledStopInvalidPartSync" "EnabledStopInvalidPartLaunch")
}

serverconfig_NumberOfAsteroids_QueryName() {
 	echo "Number of asteroids"
}
serverconfig_NumberOfAsteroids_Type() {
 	echo "number"
}
serverconfig_NumberOfAsteroids_Default() {
	echo "10"
}
serverconfig_NumberOfAsteroids_Range() {
	echo "0-64"
}

serverconfig_TerrainQuality_QueryName() {
	echo "Terrain quality"
}
serverconfig_TerrainQuality_Type() {
	echo "enum"
}
serverconfig_TerrainQuality_Default() {
	echo "1"
}
serverconfig_TerrainQuality_Values() {
	config_allowed_values=("Low" "Default" "High")
}

serverconfig_SafetyBubbleDistance_QueryName() {
	echo "Safety bubble distance"
}
serverconfig_SafetyBubbleDistance_Type() {
	echo "number"
}
serverconfig_SafetyBubbleDistance_Default() {
	echo "100"
}

serverconfig_WarpMode_QueryName() {
	echo "Warp mode"
}
serverconfig_WarpMode_Type() {
	echo "enum"
}
serverconfig_WarpMode_Default() {
	echo "1"
}
serverconfig_WarpMode_Values() {
	config_allowed_values=("None" "Subspace" "Master")
}

serverconfig_Whitelisted_QueryName() {
	echo "Whitelisted"
}
serverconfig_Whitelisted_Type() {
	echo "boolean"
}
serverconfig_Whitelisted_Default() {
	echo "false"
}
serverconfig_Whitelisted_ErrorMessage() {
	echo "Not a valid boolean given (true/false or yes/no or y/n)."
}

serverconfig_HearbeatMsInterval_QueryName() {
	echo "HearbeatMsInterval"
}
serverconfig_HearbeatMsInterval_Type() {
	echo "number"
}
serverconfig_HearbeatMsInterval_Default() {
	echo "1000"
}

serverconfig_ConnectionMsTimeout_QueryName() {
	echo "ConnectionMsTimeout"
}
serverconfig_ConnectionMsTimeout_Type() {
	echo "number"
}
serverconfig_ConnectionMsTimeout_Default() {
	echo "30000"
}

serverconfig_DropControlOnVesselSwitching_QueryName() {
	echo "DropControlOnVesselSwitching"
}
serverconfig_DropControlOnVesselSwitching_Type() {
	echo "boolean"
}
serverconfig_DropControlOnVesselSwitching_Default() {
	echo "true"
}
serverconfig_DropControlOnVesselSwitching_ErrorMessage() {
	echo "Not a valid boolean given (true/false or yes/no or y/n)."
}

serverconfig_DropControlOnExitFlight_QueryName() {
	echo "DropControlOnExitFlight"
}
serverconfig_DropControlOnExitFlight_Type() {
	echo "boolean"
}
serverconfig_DropControlOnExitFlight_Default() {
	echo "true"
}
serverconfig_DropControlOnExitFlight_ErrorMessage() {
	echo "Not a valid boolean given (true/false or yes/no or y/n)."
}

serverconfig_DropControlOnExit_QueryName() {
	echo "DropControlOnExit"
}
serverconfig_DropControlOnExit_Type() {
	echo "boolean"
}
serverconfig_DropControlOnExit_Default() {
	echo "true"
}
serverconfig_DropControlOnExit_ErrorMessage() {
	echo "Not a valid boolean given (true/false or yes/no or y/n)."
}

serverconfig_VesselUpdatesSendMsInterval_QueryName() {
	echo "VesselUpdatesSendMsInterval"
}
serverconfig_VesselUpdatesSendMsInterval_Type() {
	echo "number"
}
serverconfig_VesselUpdatesSendMsInterval_Default() {
	echo "30"
}

serverconfig_SecondaryVesselUpdatesSendMsInterval_QueryName() {
	echo "SecondaryVesselUpdatesSendMsInterval"
}
serverconfig_SecondaryVesselUpdatesSendMsInterval_Type() {
	echo "number"
}
serverconfig_SecondaryVesselUpdatesSendMsInterval_Default() {
	echo "500"
}

serverconfig_VesselPartsSyncMsInterval_QueryName() {
	echo "VesselPartsSyncMsInterval"
}
serverconfig_VesselPartsSyncMsInterval_Type() {
	echo "number"
}
serverconfig_VesselPartsSyncMsInterval_Default() {
	echo "500"
}

serverconfig_RelaySystemMode_QueryName() {
	echo "RelaySystemMode"
}
serverconfig_RelaySystemMode_Type() {
	echo "enum"
}
serverconfig_RelaySystemMode_Default() {
	echo "1"
}
serverconfig_RelaySystemMode_Values() {
	config_allowed_values=("Dictionary" "DataBase")
}

serverconfig_FarDistanceUpdateIntervalMs_QueryName() {
	echo "FarDistanceUpdateIntervalMs"
}
serverconfig_FarDistanceUpdateIntervalMs_Type() {
	echo "number"
}
serverconfig_FarDistanceUpdateIntervalMs_Default() {
	echo "500"
}

serverconfig_MediumDistanceUpdateIntervalMs_QueryName() {
	echo "MediumDistanceUpdateIntervalMs"
}
serverconfig_MediumDistanceUpdateIntervalMs_Type() {
	echo "number"
}
serverconfig_MediumDistanceUpdateIntervalMs_Default() {
	echo "250"
}

serverconfig_CloseDistanceUpdateIntervalMs_QueryName() {
	echo "CloseDistanceUpdateIntervalMs"
}
serverconfig_CloseDistanceUpdateIntervalMs_Type() {
	echo "number"
}
serverconfig_CloseDistanceUpdateIntervalMs_Default() {
	echo "33"
}

serverconfig_CloseDistanceInMeters_QueryName() {
	echo "CloseDistanceInMeters"
}
serverconfig_CloseDistanceInMeters_Type() {
	echo "number"
}
serverconfig_CloseDistanceInMeters_Default() {
	echo "25000"
}

serverconfig_SendReceiveThreadTickMs_QueryName() {
	echo "SendReceiveThreadTickMs"
}
serverconfig_SendReceiveThreadTickMs_Type() {
	echo "number"
}
serverconfig_SendReceiveThreadTickMs_Default() {
	echo "5"
}

serverconfig_MainTimeTick_QueryName() {
	echo "MainTimeTick"
}
serverconfig_MainTimeTick_Type() {
	echo "number"
}
serverconfig_MainTimeTick_Default() {
	echo "5"
}

serverconfig_LogLevel_QueryName() {
	echo "LogLevel"
}
serverconfig_LogLevel_Type() {
	echo "enum"
}
serverconfig_LogLevel_Default() {
	echo "1"
}
serverconfig_LogLevel_Values() {
	config_allowed_values=("Debug" "Info" "Chat" "Error" "Fatal")
}

serverconfig_ExpireLogs_QueryName() {
	echo "ExpireLogs"
}
serverconfig_ExpireLogs_Type() {
	echo "number"
}
serverconfig_ExpireLogs_Default() {
	echo "0"
}

serverconfig_UseUtcTimeInLog_QueryName() {
	echo "UseUtcTimeInLog"
}
serverconfig_UseUtcTimeInLog_Type() {
	echo "boolean"
}
serverconfig_UseUtcTimeInLog_Default() {
	echo "false"
}
serverconfig_UseUtcTimeInLog_ErrorMessage() {
	echo "Not a valid boolean given (true/false or yes/no or y/n)."
}

serverconfig_VesselsBackupIntervalMs_QueryName() {
	echo "VesselsBackupIntervalMs"
}
serverconfig_VesselsBackupIntervalMs_Type() {
	echo "number"
}
serverconfig_VesselsBackupIntervalMs_Default() {
	echo "30000"
}

#################################
## Edit option functions

configEditServer() {
	local CV
	
	echo "Server"
	echo "--------------------------------"
	for CV in \
		ServerName Port Description ServerMotd ConsoleIdentifier \
		RegisterWithMasterServer MasterServerRegistrationMsInterval \
		HearbeatMsInterval ConnectionMsTimeout SendReceiveThreadTickMs MainTimeTick \
		LogLevel ExpireLogs UseUtcTimeInLog \
		; do
		$1 $CV
	done
	echo
}

configEditSlots() {
	local CV
	
	echo "Slots"
	echo "--------------------------------"
	for CV in \
			MaxPlayers MaxUsernameLength Whitelisted \
			; do
		$1 $CV
	done
	echo
}

configEditGameType() {
	local CV
	
	echo "Game type"
	echo "--------------------------------"
	for CV in \
			GameMode GameDifficulty Cheats AllowSackKerbals TerrainQuality NumberOfAsteroids\
			WarpMode AutoDekessler AutoNuke ShowVesselsInThePast AllowSackKerbals \
			; do
		$1 $CV
	done
	echo
}

configEditVessels() {
	local CV
	
	echo "Vessels options"
	echo "--------------------------------"
	for CV in \
			ModControl SafetyBubbleDistance \
			DropControlOnVesselSwitching DropControlOnExitFlight DropControlOnExit \
			VesselUpdatesSendMsInterval SecondaryVesselUpdatesSendMsInterval VesselPartsSyncMsInterval VesselsBackupIntervalMs \
			; do
		$1 $CV
	done
	echo
}

configEditRelay() {
	local CV
	
	echo "Relay position option"
	echo "--------------------------------"
	for CV in \
			RelaySystemMode FarDistanceUpdateIntervalMs MediumDistanceUpdateIntervalMs CloseDistanceUpdateIntervalMs \
			; do
		$1 $CV
	done
	echo
}

configEditAll() {
	configEditServer "$1"
	configEditSlots "$1"
	configEditGameType "$1"
	configEditVessels "$1"
	configEditRelay "$1"
}

#################################
## Generic worker functions


# List all defined config editing parts
# Returns:
#   List of config funcs
listConfigEditFuncs() {
	local CV
	for CV in $(declare -F | cut -d\  -f3 | grep "^configEdit.*$"); do
		CV=${CV#configEdit}
		printf "%s " "$CV"
	done
}


# List all defined config options
# Returns:
#   List of defined config options
listConfigValues() {
	local CV
	for CV in $(declare -F | cut -d\  -f3 | grep "^serverconfig_.*_Type$"); do
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

	case "$TYPE" in
		number)
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
			;;
		boolean)
			if [ $(isABool "$2") -eq 0 ]; then
				echo "0"
				return
			fi
			;;
		string)
			;;
	esac
	

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

# Print defined config value
# Params:
#   1: Config option
printConfigValue() {
	local currentValName=configCurrent_$1
	printf "%-25s = %s\n" "$(serverconfig_$1_QueryName)" "${!currentValName}"
}

# Query for an instance name (will be saved in $INSTANCE)
readInstanceName() {
	until [ $(isValidInstanceName "$INSTANCE") -eq 1 ]; do
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
	for CV in $(listConfigValues); do
		local currentValName=configCurrent_$CV
		export $currentValName=
	done
}

# Load all config values from the config.xml of the given instance
# Params:
#   1: Instance name
loadCurrentConfigValues() {
	local CV
	for CV in $(listConfigValues); do
		local currentValName=configCurrent_$CV
		local CONF=$(getInstancePath "$1")/Config/Settings.txt
		local VAL=$($XMLSTARLET sel -t -m "/SettingsDefinition" -v "$CV" -n $CONF)
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
	for CV in $(listConfigValues); do
		local currentValName=configCurrent_$CV
		local val="${!currentValName}"
		local CONF=$(getInstancePath "$1")/Config/Settings.txt
		setConfigValue $1 $CV "$val"
	done
}

# Get a single value from a serverconfig
# Params:
#   1: Instance name
#   2: Property name
# Returns:
#   Property value
getConfigValue() {
	local CONF=$(getInstancePath $1)/Config/Settings.txt
	$XMLSTARLET sel -t -m "/SettingsDefinition" -v "$2" -n $CONF
}

# Update a single value in a serverconfig
# Params:
#   1: Instance name
#   2: Property name
#   3: New value
setConfigValue() {
	local CONF=$(getInstancePath $1)/Config/Settings.txt
	$XMLSTARLET ed -L -u "/SettingsDefinition/$2" -v "$3" $CONF
}