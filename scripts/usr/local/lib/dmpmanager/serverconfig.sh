#!/bin/bash 
# Get conf file path 
# Params:
#   1: Instance name
# Returns:
#   Conf file path
getConfFile() { 
	echo "$DMP_BASE/$1/Config/Settings.txt"
}

# Get all raw Settings line
# Params:
#   1: Instance name
# Returns:
#   Raw Settings line
getRawSettings() { 
	cat $(getConfFile $1) | grep -v "^#" | grep -v "^$"
}

# Get raw setting line for a specific setting name
# Params:
#   1: Instance name
#   2: Setting name
# Returns:
#   Raw Setting line
getRawSetting() { 
	getRawSettings $1 | grep -e "$2"
}

getRawSettingDesc() { 
	cat $(getConfFile $1) | grep -e "^# $2" 
}

getRawSettingFullDesc() { 
	startLine=$(cat -n $(getConfFile $1) | grep -e "$(getRawSettingDesc $1 $2)" | awk '{print $1}')
	stopLine=$(($(cat -n $(getConfFile $1) | grep -e "$(getRawSetting $1 $2)" | awk '{print $1}') - 1))
	sed -n "$startLine,$stopLine p" $(getConfFile $1)
}
# Get all settings name
# Params:
#   1: Instance name
# Returns:
#   Settings name
getAllSettingsName() { 
	getRawSettings $1 | cut -d "=" -f1
}

# Get Setting value for a specific setting name
# Params:
#   1: Instance name
#   2: Setting name
# Returns:
#   Setting value
getSettingValue() { 
	getRawSetting $1 $2 | cut -d "=" -f2
}

# Set Setting for a specific setting name
# Params:
#   1: Instance name
#   2: Setting name
#   3: Setting value
# Returns:
#   1. success
#   0. fail
setSettingValue() { 
	instanceName=$1
	settingName=$2
	shift
	shift
	settingValue=$@
	if [ "$settingValue" != "$(getSettingValue $instanceName $settingName)" ]
	then
	sed -i "s/$(getRawSetting $instanceName $settingName)/$settingName=$settingValue/" $(getConfFile $instanceName)
		echo 1
	else
		echo 0
	fi
}

# Check if a valid setting Name
# Params:
#   1: Instance name
#   2: Setting name
# Returns:
#   1: Valid name
#   0: Unknown name
isValidSettingName() { 
	$(getAllSettingsName $1) | grep -e "$2" > /dev/null
	if [ "$?" -eq "0" ]
	then
		echo 1
	else
		echo 0
	fi
}


editSettings() { 
	for setting in $(getAllSettingsName $1)
	do 
		echo "################"
		echo "$(getRawSettingFullDesc $1 $setting)"
		echo
		read -p "$setting [$(getSettingValue $1 $setting)]: " curVal
		if [ "$curVal" == "" ]
		then
			curVal=$(getSettingValue $1 $setting)
		fi
		if [ $(setSettingValue $1 $setting $curVal) = 1 ]
		then
			echo "Setting changed"
		else
			echo "Setting Not changed"
		fi
		echo "################"
		echo
	done
}
