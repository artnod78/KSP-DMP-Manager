#!/bin/bash
# Provides functions to query and validate values for GeneralSettings.xml

currentInstance=""

#################################
## GeneralSettings.xml
## Definition of options

genconfig_ServerName_QueryName() {
	echo "ServerName"
}
genconfig_ServerName_Type() {
	echo "string"
}
genconfig_ServerName_Default() {
	echo "Luna Server"
}
genconfig_ServerName_Validate() {
	if [ ! -z "$1" ]; then
		echo "1"
	else
		echo "0"
	fi
}
genconfig_ServerName_ErrorMessage() {
	echo "Server name cannot be empty."
}

genconfig_Description_QueryName() {
	echo "Description"
}
genconfig_Description_Type() {
	echo "string"
}
genconfig_Description_Default() {
	echo "Luna Server Description"
}

genconfig_CountryCode_QueryName() {
	echo "CountryCode"
}
genconfig_CountryCode_Type() {
	echo "string"
}
genconfig_CountryCode_Default() {
	echo "fr"
}

genconfig_WebsiteText_QueryName() {
	echo "WebsiteText"
}
genconfig_WebsiteText_Type() {
	echo "string"
}
genconfig_WebsiteText_Default() {
	echo "LMP"
}

genconfig_Website_QueryName() {
	echo "Website"
}
genconfig_Website_Type() {
	echo "string"
}
genconfig_Website_Default() {
	echo "lunamultiplayer.com"
}

genconfig_Password_QueryName() {
	echo "Password"
}
genconfig_Password_Type() {
	echo "string"
}

genconfig_AdminPassword_QueryName() {
	echo "AdminPassword"
}
genconfig_AdminPassword_Type() {
	echo "string"
}

genconfig_ServerMotd_QueryName() {
	echo "ServerMotd"
}
genconfig_ServerMotd_Type() {
	echo "string"
}
genconfig_ServerMotd_Default() {
	echo "Welcome, %Name%!"
}

genconfig_PrintMotdInChat_QueryName() {
	echo "PrintMotdInChat"
}
genconfig_PrintMotdInChat_Type() {
	echo "boolean"
}
genconfig_PrintMotdInChat_Default() {
	echo "false"
}
genconfig_PrintMotdInChat_ErrorMessage() {
	echo "Not a valid boolean given (true/false or yes/no or y/n)."
}

genconfig_MaxPlayers_QueryName() {
 	echo "MaxPlayers"
}
genconfig_MaxPlayers_Type() {
 	echo "number"
}
genconfig_MaxPlayers_Default() {
	echo "20"
}
genconfig_MaxPlayers_Range() {
	echo "1-64"
}

genconfig_MaxUsernameLength_QueryName() {
 	echo "MaxUsernameLength"
}
genconfig_MaxUsernameLength_Type() {
 	echo "number"
}
genconfig_MaxUsernameLength_Default() {
	echo "15"
}
genconfig_MaxUsernameLength_Range() {
	echo "1-64"
}

genconfig_AutoDekessler_QueryName() {
	echo "AutoDekessler"
}
genconfig_AutoDekessler_Type() {
	echo "number"
}
genconfig_AutoDekessler_Default() {
	echo "1"
}

genconfig_AutoNuke_QueryName() {
	echo "AutoNuke"
}
genconfig_AutoNuke_Type() {
	echo "number"
}
genconfig_AutoNuke_Default() {
	echo "0"
}

genconfig_Cheats_QueryName() {
	echo "Cheats"
}
genconfig_Cheats_Type() {
	echo "boolean"
}
genconfig_Cheats_Default() {
	echo "true"
}
genconfig_Cheats_ErrorMessage() {
	echo "Not a valid boolean given (true/false or yes/no or y/n)."
}

genconfig_AllowSackKerbals_QueryName() {
	echo "AllowSackKerbals"
}
genconfig_AllowSackKerbals_Type() {
	echo "boolean"
}
genconfig_AllowSackKerbals_Default() {
	echo "false"
}
genconfig_AllowSackKerbals_ErrorMessage() {
	echo "Not a valid boolean given (true/false or yes/no or y/n)."
}

genconfig_ConsoleIdentifier_QueryName() {
	echo "ConsoleIdentifier"
}
genconfig_ConsoleIdentifier_Type() {
	echo "string"
}
genconfig_ConsoleIdentifier_Default() {
	echo "Server"
}
genconfig_ConsoleIdentifier_Validate() {
	if [ ! -z "$1" ]; then
		echo "1"
	else
		echo "0"
	fi
}
genconfig_ConsoleIdentifier_ErrorMessage() {
	echo "Server console identifier cannot be empty."
}

genconfig_GameDifficulty_QueryName() {
	echo "GameDdifficulty"
}
genconfig_GameDifficulty_Type() {
	echo "enum"
}
genconfig_GameDifficulty_Default() {
	echo "1"
}
genconfig_GameDifficulty_Values() {
	config_allowed_values=("Easy" "Normal" "Moderate" "Hard" "Custom")
}

genconfig_GameMode_QueryName() {
	echo "GameMode"
}
genconfig_GameMode_Type() {
	echo "enum"
}
genconfig_GameMode_Default() {
	echo "1"
}
genconfig_GameMode_Values() {
	config_allowed_values=("Sandbox" "Career" "Science")
}

genconfig_ModControl_QueryName() {
	echo "ModControl"
}
genconfig_ModControl_Type() {
	echo "boolean"
}
genconfig_ModControl_Default() {
	echo "true"
}
genconfig_ModControl_ErrorMessage() {
	echo "Not a valid boolean given (true/false or yes/no or y/n)."
}

genconfig_NumberOfAsteroids_QueryName() {
 	echo "NumberOfAsteroids"
}
genconfig_NumberOfAsteroids_Type() {
 	echo "number"
}
genconfig_NumberOfAsteroids_Default() {
	echo "10"
}
genconfig_NumberOfAsteroids_Range() {
	echo "0-64"
}

genconfig_TerrainQuality_QueryName() {
	echo "TerrainQuality"
}
genconfig_TerrainQuality_Type() {
	echo "enum"
}
genconfig_TerrainQuality_Default() {
	echo "1"
}
genconfig_TerrainQuality_Values() {
	config_allowed_values=("Low" "Default" "High")
}

genconfig_SafetyBubbleDistance_QueryName() {
	echo "SafetyBubbleDistance"
}
genconfig_SafetyBubbleDistance_Type() {
	echo "number"
}
genconfig_SafetyBubbleDistance_Default() {
	echo "100"
}


#################################
## ConnectionSettings.xml
## Definition of options

connconfig_Port_QueryName() {
 	echo "Port"
}
connconfig_Port_Type() {
 	echo "number"
}
connconfig_Port_Default() {
	echo "8800"
}
connconfig_Port_Range() {
	echo "1024-65535"
}

connconfig_HearbeatMsInterval_QueryName() {
	echo "HearbeatMsInterval"
}
connconfig_HearbeatMsInterval_Type() {
	echo "number"
}
connconfig_HearbeatMsInterval_Default() {
	echo "1000"
}

connconfig_ConnectionMsTimeout_QueryName() {
	echo "ConnectionMsTimeout"
}
connconfig_ConnectionMsTimeout_Type() {
	echo "number"
}
connconfig_ConnectionMsTimeout_Default() {
	echo "30000"
}

connconfig_Upnp_QueryName() {
	echo "Upnp"
}
connconfig_Upnp_Type() {
	echo "boolean"
}
connconfig_Upnp_Default() {
	echo "true"
}
connconfig_Upnp_ErrorMessage() {
	echo "Not a valid boolean given (true/false or yes/no or y/n)."
}

connconfig_UpnpMsTimeout_QueryName() {
	echo "UpnpMsTimeout"
}
connconfig_UpnpMsTimeout_Type() {
	echo "number"
}
connconfig_UpnpMsTimeout_Default() {
	echo "5000"
}

connconfig_MaximumTransmissionUnit_QueryName() {
 	echo "MaximumTransmissionUnit"
}
connconfig_MaximumTransmissionUnit_Type() {
 	echo "number"
}
connconfig_MaximumTransmissionUnit_Default() {
	echo "1408"
}
connconfig_MaximumTransmissionUnit_Range() {
	echo "1408-8192"
}

connconfig_AutoExpandMtu_QueryName() {
	echo "AutoExpandMtu"
}
connconfig_AutoExpandMtu_Type() {
	echo "boolean"
}
connconfig_AutoExpandMtu_Default() {
	echo "false"
}
connconfig_AutoExpandMtu_ErrorMessage() {
	echo "Not a valid boolean given (true/false or yes/no or y/n)."
}


#################################
## MasterServerSettings.xml
## Definition of options

mastconfig_RegisterWithMasterServer_QueryName() {
	echo "RegisterWithMasterServer"
}
mastconfig_RegisterWithMasterServer_Type() {
	echo "boolean"
}
mastconfig_RegisterWithMasterServer_Default() {
	echo "false"
}
mastconfig_RegisterWithMasterServer_ErrorMessage() {
	echo "Not a valid boolean given (true/false or yes/no or y/n)."
}

mastconfig_MasterServerRegistrationMsInterval_QueryName() {
	echo "MasterServerRegistrationMsInterval"
}
mastconfig_MasterServerRegistrationMsInterval_Type() {
	echo "number"
}
mastconfig_MasterServerRegistrationMsInterval_Default() {
	echo "5000"
}


#################################
## DedicatedServerSettings.xml
## Definition of options

dediconfig_UseRainbowEffect_QueryName() {
	echo "UseRainbowEffect"
}
dediconfig_UseRainbowEffect_Type() {
	echo "boolean"
}
dediconfig_UseRainbowEffect_Default() {
	echo "true"
}
dediconfig_UseRainbowEffect_ErrorMessage() {
	echo "Not a valid boolean given (true/false or yes/no or y/n)."
}

dediconfig_Red_QueryName() {
 	echo "Red"
}
dediconfig_Red_Type() {
 	echo "number"
}
dediconfig_Red_Default() {
	echo "255"
}
dediconfig_Red_Range() {
	echo "0-255"
}

dediconfig_Green_QueryName() {
 	echo "Green"
}
dediconfig_Green_Type() {
 	echo "number"
}
dediconfig_Green_Default() {
	echo "0"
}
dediconfig_Green_Range() {
	echo "0-255"
}

dediconfig_Blue_QueryName() {
 	echo "Blue"
}
dediconfig_Blue_Type() {
 	echo "number"
}
dediconfig_Blue_Default() {
	echo "0"
}
dediconfig_Blue_Range() {
	echo "0-255"
}


#################################
## GameplaySettings.xml
## Definition of options

gameconfig_CanRevert_QueryName() {
	echo "CanRevert"
}
gameconfig_CanRevert_Type() {
	echo "boolean"
}
gameconfig_CanRevert_Default() {
	echo "true"
}
gameconfig_CanRevert_ErrorMessage() {
	echo "Not a valid boolean given (true/false or yes/no or y/n)."
}

gameconfig_MissingCrewsRespawn_QueryName() {
	echo "MissingCrewsRespawn"
}
gameconfig_MissingCrewsRespawn_Type() {
	echo "boolean"
}
gameconfig_MissingCrewsRespawn_Default() {
	echo "true"
}
gameconfig_MissingCrewsRespawn_ErrorMessage() {
	echo "Not a valid boolean given (true/false or yes/no or y/n)."
}

gameconfig_RespawnTime_QueryName() {
 	echo "RespawnTime"
}
gameconfig_RespawnTime_Type() {
 	echo "string"
}
gameconfig_RespawnTime_Default() {
	echo "2"
}

gameconfig_AutoHireCrews_QueryName() {
	echo "AutoHireCrews"
}
gameconfig_AutoHireCrews_Type() {
	echo "boolean"
}
gameconfig_AutoHireCrews_Default() {
	echo "true"
}
gameconfig_AutoHireCrews_ErrorMessage() {
	echo "Not a valid boolean given (true/false or yes/no or y/n)."
}

gameconfig_BypassEntryPurchaseAfterResearch_QueryName() {
	echo "BypassEntryPurchaseAfterResearch"
}
gameconfig_BypassEntryPurchaseAfterResearch_Type() {
	echo "boolean"
}
gameconfig_BypassEntryPurchaseAfterResearch_Default() {
	echo "true"
}
gameconfig_BypassEntryPurchaseAfterResearch_ErrorMessage() {
	echo "Not a valid boolean given (true/false or yes/no or y/n)."
}

gameconfig_IndestructibleFacilities_QueryName() {
	echo "IndestructibleFacilities"
}
gameconfig_IndestructibleFacilities_Type() {
	echo "boolean"
}
gameconfig_IndestructibleFacilities_Default() {
	echo "false"
}
gameconfig_IndestructibleFacilities_ErrorMessage() {
	echo "Not a valid boolean given (true/false or yes/no or y/n)."
}

gameconfig_AllowStockVessels_QueryName() {
	echo "AllowStockVessels"
}
gameconfig_AllowStockVessels_Type() {
	echo "boolean"
}
gameconfig_AllowStockVessels_Default() {
	echo "false"
}
gameconfig_AllowStockVessels_ErrorMessage() {
	echo "Not a valid boolean given (true/false or yes/no or y/n)."
}

gameconfig_AllowOtherLaunchSites_QueryName() {
	echo "AllowOtherLaunchSites"
}
gameconfig_AllowOtherLaunchSites_Type() {
	echo "boolean"
}
gameconfig_AllowOtherLaunchSites_Default() {
	echo "false"
}
gameconfig_AllowOtherLaunchSites_ErrorMessage() {
	echo "Not a valid boolean given (true/false or yes/no or y/n)."
}

gameconfig_ReentryHeatScale_QueryName() {
 	echo "ReentryHeatScale"
}
gameconfig_ReentryHeatScale_Type() {
 	echo "string"
}
gameconfig_ReentryHeatScale_Default() {
	echo "1"
}

gameconfig_ResourceAbundance_QueryName() {
 	echo "ResourceAbundance"
}
gameconfig_ResourceAbundance_Type() {
 	echo "string"
}
gameconfig_ResourceAbundance_Default() {
	echo "1"
}

gameconfig_CommNetwork_QueryName() {
	echo "CommNetwork"
}
gameconfig_CommNetwork_Type() {
	echo "boolean"
}
gameconfig_CommNetwork_Default() {
	echo "true"
}
gameconfig_CommNetwork_ErrorMessage() {
	echo "Not a valid boolean given (true/false or yes/no or y/n)."
}

gameconfig_StartingFunds_QueryName() {
 	echo "StartingFunds"
}
gameconfig_StartingFunds_Type() {
 	echo "string"
}
gameconfig_StartingFunds_Default() {
	echo "25000"
}

gameconfig_StartingScience_QueryName() {
 	echo "StartingScience"
}
gameconfig_StartingScience_Type() {
 	echo "string"
}
gameconfig_StartingScience_Default() {
	echo "0"
}

gameconfig_StartingReputation_QueryName() {
 	echo "StartingReputation"
}
gameconfig_StartingReputation_Type() {
 	echo "string"
}
gameconfig_StartingReputation_Default() {
	echo "0"
}

gameconfig_ScienceGainMultiplier_QueryName() {
 	echo "ScienceGainMultiplier"
}
gameconfig_ScienceGainMultiplier_Type() {
 	echo "string"
}
gameconfig_ScienceGainMultiplier_Default() {
	echo "1"
}

gameconfig_FundsGainMultiplier_QueryName() {
 	echo "FundsGainMultiplier"
}
gameconfig_FundsGainMultiplier_Type() {
 	echo "string"
}
gameconfig_FundsGainMultiplier_Default() {
	echo "1"
}

gameconfig_RepGainMultiplier_QueryName() {
 	echo "RepGainMultiplier"
}
gameconfig_RepGainMultiplier_Type() {
 	echo "string"
}
gameconfig_RepGainMultiplier_Default() {
	echo "1"
}

gameconfig_FundsLossMultiplier_QueryName() {
 	echo "FundsLossMultiplier"
}
gameconfig_FundsLossMultiplier_Type() {
 	echo "string"
}
gameconfig_FundsLossMultiplier_Default() {
	echo "1"
}

gameconfig_RepLossMultiplier_QueryName() {
 	echo "RepLossMultiplier"
}
gameconfig_RepLossMultiplier_Type() {
 	echo "string"
}
gameconfig_RepLossMultiplier_Default() {
	echo "1"
}

gameconfig_RepLossDeclined_QueryName() {
 	echo "RepLossDeclined"
}
gameconfig_RepLossDeclined_Type() {
 	echo "string"
}
gameconfig_RepLossDeclined_Default() {
	echo "1"
}

gameconfig_KerbalExp_QueryName() {
	echo "KerbalExp"
}
gameconfig_KerbalExp_Type() {
	echo "boolean"
}
gameconfig_KerbalExp_Default() {
	echo "true"
}
gameconfig_KerbalExp_ErrorMessage() {
	echo "Not a valid boolean given (true/false or yes/no or y/n)."
}

gameconfig_ImmediateLevelUp_QueryName() {
	echo "ImmediateLevelUp"
}
gameconfig_ImmediateLevelUp_Type() {
	echo "boolean"
}
gameconfig_ImmediateLevelUp_Default() {
	echo "false"
}
gameconfig_ImmediateLevelUp_ErrorMessage() {
	echo "Not a valid boolean given (true/false or yes/no or y/n)."
}

gameconfig_AllowNegativeCurrency_QueryName() {
	echo "AllowNegativeCurrency"
}
gameconfig_AllowNegativeCurrency_Type() {
	echo "boolean"
}
gameconfig_AllowNegativeCurrency_Default() {
	echo "false"
}
gameconfig_AllowNegativeCurrency_ErrorMessage() {
	echo "Not a valid boolean given (true/false or yes/no or y/n)."
}

gameconfig_PressurePartLimits_QueryName() {
	echo "PressurePartLimits"
}
gameconfig_PressurePartLimits_Type() {
	echo "boolean"
}
gameconfig_PressurePartLimits_Default() {
	echo "false"
}
gameconfig_PressurePartLimits_ErrorMessage() {
	echo "Not a valid boolean given (true/false or yes/no or y/n)."
}

gameconfig_GPartLimits_QueryName() {
	echo "GPartLimits"
}
gameconfig_GPartLimits_Type() {
	echo "boolean"
}
gameconfig_GPartLimits_Default() {
	echo "false"
}
gameconfig_GPartLimits_ErrorMessage() {
	echo "Not a valid boolean given (true/false or yes/no or y/n)."
}

gameconfig_GKerbalLimits_QueryName() {
	echo "GKerbalLimits"
}
gameconfig_GKerbalLimits_Type() {
	echo "boolean"
}
gameconfig_GKerbalLimits_Default() {
	echo "false"
}
gameconfig_GKerbalLimits_ErrorMessage() {
	echo "Not a valid boolean given (true/false or yes/no or y/n)."
}

gameconfig_KerbalGToleranceMult_QueryName() {
 	echo "KerbalGToleranceMult"
}
gameconfig_KerbalGToleranceMult_Type() {
 	echo "string"
}
gameconfig_KerbalGToleranceMult_Default() {
	echo "1"
}

gameconfig_ObeyCrossfeedRules_QueryName() {
	echo "ObeyCrossfeedRules"
}
gameconfig_ObeyCrossfeedRules_Type() {
	echo "boolean"
}
gameconfig_ObeyCrossfeedRules_Default() {
	echo "false"
}
gameconfig_ObeyCrossfeedRules_ErrorMessage() {
	echo "Not a valid boolean given (true/false or yes/no or y/n)."
}

gameconfig_ActionGroupsAlways_QueryName() {
	echo "ActionGroupsAlways"
}
gameconfig_ActionGroupsAlways_Type() {
	echo "boolean"
}
gameconfig_ActionGroupsAlways_Default() {
	echo "false"
}
gameconfig_ActionGroupsAlways_ErrorMessage() {
	echo "Not a valid boolean given (true/false or yes/no or y/n)."
}

gameconfig_BuildingDamageMultiplier_QueryName() {
	echo "BuildingDamageMultiplier"
}
gameconfig_BuildingDamageMultiplier_Type() {
	echo "string"
}
gameconfig_BuildingDamageMultiplier_Default() {
	echo "0.05"
}

gameconfig_PartUpgrades_QueryName() {
	echo "PartUpgrades"
}
gameconfig_PartUpgrades_Type() {
	echo "boolean"
}
gameconfig_PartUpgrades_Default() {
	echo "true"
}
gameconfig_PartUpgrades_ErrorMessage() {
	echo "Not a valid boolean given (true/false or yes/no or y/n)."
}

gameconfig_RequireSignalForControl_QueryName() {
	echo "RequireSignalForControl"
}
gameconfig_RequireSignalForControl_Type() {
	echo "boolean"
}
gameconfig_RequireSignalForControl_Default() {
	echo "false"
}
gameconfig_RequireSignalForControl_ErrorMessage() {
	echo "Not a valid boolean given (true/false or yes/no or y/n)."
}

gameconfig_ReentryBlackout_QueryName() {
	echo "ReentryBlackout"
}
gameconfig_ReentryBlackout_Type() {
	echo "boolean"
}
gameconfig_ReentryBlackout_Default() {
	echo "true"
}
gameconfig_ReentryBlackout_ErrorMessage() {
	echo "Not a valid boolean given (true/false or yes/no or y/n)."
}

gameconfig_RangeModifier_QueryName() {
 	echo "RangeModifier"
}
gameconfig_RangeModifier_Type() {
 	echo "string"
}
gameconfig_RangeModifier_Default() {
	echo "1"
}

gameconfig_DsnModifier_QueryName() {
 	echo "DsnModifier"
}
gameconfig_DsnModifier_Type() {
 	echo "string"
}
gameconfig_DsnModifier_Default() {
	echo "1"
}

gameconfig_OcclusionModifierVac_QueryName() {
	echo "OcclusionModifierVac"
}
gameconfig_OcclusionModifierVac_Type() {
	echo "string"
}
gameconfig_OcclusionModifierVac_Default() {
	echo "0.9"
}

gameconfig_OcclusionModifierAtm_QueryName() {
	echo "OcclusionModifierAtm"
}
gameconfig_OcclusionModifierAtm_Type() {
	echo "string"
}
gameconfig_OcclusionModifierAtm_Default() {
	echo "0.75"
}

gameconfig_ExtraGroundstations_QueryName() {
	echo "ExtraGroundstations"
}
gameconfig_ExtraGroundstations_Type() {
	echo "boolean"
}
gameconfig_ExtraGroundstations_Default() {
	echo "true"
}
gameconfig_ExtraGroundstations_ErrorMessage() {
	echo "Not a valid boolean given (true/false or yes/no or y/n)."
}


#################################
## WarpSettings.xml
## Definition of options
warpconfig_WarpMode_QueryName() {
	echo "WarpMode"
}
warpconfig_WarpMode_Type() {
	echo "string"
}
warpconfig_WarpMode_Default() {
	echo "Subspace"
}
warpconfig_WarpMode_Values() {
	config_allowed_values=("None" "Subspace")
}


#################################
## IntervalSettings.xml
## Definition of options

inteconfig_VesselUpdatesMsInterval_QueryName() {
 	echo "VesselUpdatesMsInterval"
}
inteconfig_VesselUpdatesMsInterval_Type() {
 	echo "number"
}
inteconfig_VesselUpdatesMsInterval_Default() {
	echo "50"
}

inteconfig_SecondaryVesselUpdatesMsInterval_QueryName() {
 	echo "SecondaryVesselUpdatesMsInterval"
}
inteconfig_SecondaryVesselUpdatesMsInterval_Type() {
 	echo "number"
}
inteconfig_SecondaryVesselUpdatesMsInterval_Default() {
	echo "150"
}

inteconfig_SendReceiveThreadTickMs_QueryName() {
 	echo "SendReceiveThreadTickMs"
}
inteconfig_SendReceiveThreadTickMs_Type() {
 	echo "number"
}
inteconfig_SendReceiveThreadTickMs_Default() {
	echo "5"
}

inteconfig_MainTimeTick_QueryName() {
 	echo "MainTimeTick"
}
inteconfig_MainTimeTick_Type() {
 	echo "number"
}
inteconfig_MainTimeTick_Default() {
	echo "5"
}

inteconfig_BackupIntervalMs_QueryName() {
 	echo "BackupIntervalMs"
}
inteconfig_BackupIntervalMs_Type() {
 	echo "number"
}
inteconfig_BackupIntervalMs_Default() {
	echo "30000"
}


#################################
## ScreenshotSettings.xml
## Definition of options

screconfig_MinScreenshotIntervalMs_QueryName() {
 	echo "MinScreenshotIntervalMs"
}
screconfig_MinScreenshotIntervalMs_Type() {
 	echo "number"
}
screconfig_MinScreenshotIntervalMs_Default() {
	echo "30000"
}

screconfig_MaxScreenshotWidth_QueryName() {
 	echo "MaxScreenshotWidth"
}
screconfig_MaxScreenshotWidth_Type() {
 	echo "number"
}
screconfig_MaxScreenshotWidth_Default() {
	echo "1920"
}

screconfig_MaxScreenshotHeight_QueryName() {
 	echo "MaxScreenshotHeight"
}
screconfig_MaxScreenshotHeight_Type() {
 	echo "number"
}
screconfig_MaxScreenshotHeight_Default() {
	echo "1080"
}

screconfig_MaxScreenshotsPerUser_QueryName() {
 	echo "MaxScreenshotsPerUser"
}
screconfig_MaxScreenshotsPerUser_Type() {
 	echo "number"
}
screconfig_MaxScreenshotsPerUser_Default() {
	echo "30"
}

screconfig_MaxScreenshotsFolders_QueryName() {
 	echo "MaxScreenshotsFolders"
}
screconfig_MaxScreenshotsFolders_Type() {
 	echo "number"
}
screconfig_MaxScreenshotsFolders_Default() {
	echo "50"
}


#################################
## CraftSettings.xml
## Definition of options

crafconfig_MinCraftLibraryRequestIntervalMs_QueryName() {
 	echo "MinCraftLibraryRequestIntervalMs"
}
crafconfig_MinCraftLibraryRequestIntervalMs_Type() {
 	echo "number"
}
crafconfig_MinCraftLibraryRequestIntervalMs_Default() {
	echo "5000"
}

crafconfig_MaxCraftsPerUser_QueryName() {
 	echo "MaxCraftsPerUser"
}
crafconfig_MaxCraftsPerUser_Type() {
 	echo "number"
}
crafconfig_MaxCraftsPerUser_Default() {
	echo "10"
}

crafconfig_MaxCraftFolders_QueryName() {
 	echo "MaxCraftFolders"
}
crafconfig_MaxCraftFolders_Type() {
 	echo "number"
}
crafconfig_MaxCraftFolders_Default() {
	echo "50"
}


#################################
## WebsiteSettings.xml
## Definition of options

websconfig_EnableWebsite_QueryName() {
	echo "EnableWebsite"
}
websconfig_EnableWebsite_Type() {
	echo "boolean"
}
websconfig_EnableWebsite_Default() {
	echo "true"
}
websconfig_EnableWebsite_ErrorMessage() {
	echo "Not a valid boolean given (true/false or yes/no or y/n)."
}

websconfig_Port_QueryName() {
 	echo "Port"
}
websconfig_Port_Type() {
 	echo "number"
}
websconfig_Port_Default() {
	echo "8900"
}

websconfig_RefreshIntervalMs_QueryName() {
 	echo "RefreshIntervalMs"
}
websconfig_RefreshIntervalMs_Type() {
 	echo "number"
}
websconfig_RefreshIntervalMs_Default() {
	echo "5000"
}


#################################
## LogSettings.xml
## Definition of options

logconfig_LogLevel_QueryName() {
	echo "LogLevel"
}
logconfig_LogLevel_Type() {
	echo "string"
}
logconfig_LogLevel_Default() {
	echo "Debug"
}
logconfig_LogLevel_Values() {
	config_allowed_values=("Normal" "Debug" "NetworkDebug" "VerboseNetworkDebug")
}

logconfig_ExpireLogs_QueryName() {
 	echo "ExpireLogs"
}
logconfig_ExpireLogs_Type() {
 	echo "number"
}
logconfig_ExpireLogs_Default() {
	echo "14"
}

logconfig_UseUtcTimeInLog_QueryName() {
	echo "UseUtcTimeInLog"
}
logconfig_UseUtcTimeInLog_Type() {
	echo "boolean"
}
logconfig_UseUtcTimeInLog_Default() {
	echo "false"
}
logconfig_UseUtcTimeInLog_ErrorMessage() {
	echo "Not a valid boolean given (true/false or yes/no or y/n)."
}


#################################
## DebugSettings.xml
## Definition of options

debugconfig_SimulatedLossChance_QueryName() {
	echo "SimulatedLossChance"
}
debugconfig_SimulatedLossChance_Type() {
	echo "string"
}
debugconfig_SimulatedLossChance_Default() {
	echo "0"
}

debugconfig_SimulatedDuplicatesChance_QueryName() {
	echo "SimulatedDuplicatesChance"
}
debugconfig_SimulatedDuplicatesChance_Type() {
	echo "string"
}
debugconfig_SimulatedDuplicatesChance_Default() {
	echo "0"
}

debugconfig_MaxSimulatedRandomLatencyMs_QueryName() {
 	echo "MaxSimulatedRandomLatencyMs"
}
debugconfig_MaxSimulatedRandomLatencyMs_Type() {
 	echo "number"
}
debugconfig_MaxSimulatedRandomLatencyMs_Default() {
	echo "0"
}

debugconfig_MinSimulatedLatencyMs_QueryName() {
 	echo "MinSimulatedLatencyMs"
}
debugconfig_MinSimulatedLatencyMs_Type() {
 	echo "number"
}
debugconfig_MinSimulatedLatencyMs_Default() {
	echo "0"
}


#################################
## Edit option functions
#################################
configEditGeneralSettings() {
	local CV

	echo "GeneralSettings"
	echo "--------------------------------"
	for CV in \
		ServerName Password AdminPassword ConsoleIdentifier Description \
		ServerMotd PrintMotdInChat CountryCode WebsiteText Website \
		GameDifficulty GameMode ModControl MaxPlayers MaxUsernameLength \
		SafetyBubbleDistance Cheats AllowSackKerbals \
		AutoDekessler AutoNuke NumberOfAsteroids TerrainQuality \
		; do
		$1 $CV genconfig
	done
	echo
}
configEditConnectionSettings() {
	local CV

	echo "ConnectionSettings"
	echo "--------------------------------"
	for CV in \
		Port HearbeatMsInterval ConnectionMsTimeout Upnp UpnpMsTimeout \
		MaximumTransmissionUnit AutoExpandMtu \
		; do
		$1 $CV connconfig
	done
	echo
}
configEditMasterServerSettings() {
	local CV

	echo "MasterServerSettings"
	echo "--------------------------------"
	for CV in \
		RegisterWithMasterServer MasterServerRegistrationMsInterval \
		; do
		$1 $CV mastconfig
	done
	echo
}
configEditGameplaySettings() {
	local CV

	echo "GameplaySettings"
	echo "--------------------------------"
	for CV in \
		CanRevert MissingCrewsRespawn RespawnTime AutoHireCrews BypassEntryPurchaseAfterResearch \
		IndestructibleFacilities AllowStockVessels AllowOtherLaunchSites ReentryHeatScale \
		ResourceAbundance CommNetwork StartingFunds StartingScience StartingReputation \
		ScienceGainMultiplier FundsGainMultiplier RepGainMultiplier FundsLossMultiplier \
		RepLossMultiplier RepLossDeclined KerbalExp ImmediateLevelUp AllowNegativeCurrency \
		PressurePartLimits GPartLimits GKerbalLimits KerbalGToleranceMult ObeyCrossfeedRules \
		ActionGroupsAlways BuildingDamageMultiplier PartUpgrades RequireSignalForControl \
		ReentryBlackout RangeModifier DsnModifier OcclusionModifierVac OcclusionModifierAtm \
		ExtraGroundstations \
		; do
		$1 $CV gameconfig
	done
	echo
}
configEditDedicatedServerSettings() {
	local CV

	echo "DedicatedServerSettings"
	echo "--------------------------------"
	for CV in \
		UseRainbowEffect Red Green Blue \
		; do
		$1 $CV dediconfig
	done
	echo
}
configEditWarpSettings() {
	local CV

	echo "WarpSettings"
	echo "--------------------------------"
	for CV in \
		WarpMode \
		; do
		$1 $CV warpconfig
	done
	echo
}
configEditIntervalSettings() {
	local CV

	echo "IntervalSettings"
	echo "--------------------------------"
	for CV in \
		VesselUpdatesMsInterval SecondaryVesselUpdatesMsInterval SendReceiveThreadTickMs \
		MainTimeTick BackupIntervalMs \
		; do
		$1 $CV inteconfig
	done
	echo
}
configEditScreenshotSettings() {
	local CV

	echo "ScreenshotSettings"
	echo "--------------------------------"
	for CV in \
		MinScreenshotIntervalMs MaxScreenshotWidth MaxScreenshotHeight \
		MaxScreenshotsPerUser MaxScreenshotsFolders \
		; do
		$1 $CV screconfig
	done
	echo
}
configEditCraftSettings() {
	local CV

	echo "CraftSettings"
	echo "--------------------------------"
	for CV in \
		MinCraftLibraryRequestIntervalMs MaxCraftsPerUser MaxCraftFolders \
		; do
		$1 $CV crafconfig
	done
	echo
}
configEditWebsiteSettings() {
	local CV

	echo "WebsiteSettings"
	echo "--------------------------------"
	for CV in \
		EnableWebsite Port RefreshIntervalMs \
		; do
		$1 $CV websconfig
	done
	echo
}
configEditLogSettings() {
	local CV

	echo "LogSettings"
	echo "--------------------------------"
	for CV in \
		LogLevel ExpireLogs UseUtcTimeInLog \
		; do
		$1 $CV logconfig
	done
	echo
}
configEditDebugSettings() {
	local CV

	echo "DebugSettings"
	echo "--------------------------------"
	for CV in \
		SimulatedLossChance SimulatedDuplicatesChance \
		MaxSimulatedRandomLatencyMs MinSimulatedLatencyMs \
		; do
		$1 $CV debugconfig
	done
	echo
}

configEditAll() {
	configEditGeneralSettings $1
	configEditConnectionSettings $1
	configEditMasterServerSettings $1
	configEditGameplaySettings $1
	configEditDedicatedServerSettings $1
	configEditWarpSettings $1
	configEditIntervalSettings $1
	configEditScreenshotSettings $1
	configEditCraftSettings $1
	configEditWebsiteSettings $1
	configEditLogSettings $1
	configEditDebugSettings $1
}


#################################
## Generic worker functions for General Settings
#################################

# List all defined config options
# Params:
#   1: Settings type
# Returns:
#   List of defined config options
listConfigValues() {
	local CV
	for CV in $(declare -F | cut -d\  -f3 | grep "^$1_.*_Type$"); do
		CV=${CV#$1_}
		CV=${CV%_Type}
		printf "%s " "$CV"
	done
}

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

# Load all config values from xml file of the given instance
# Params:
#   1: Instance name
loadCurrentConfigValues() {
	currentInstance=$1
	local CV
	# load general settings
	changeUTF $1 8 GeneralSettings
	for CV in $(listConfigValues genconfig); do
		local currentValName=configCurrent_$CV
		local CONF=$(getInstancePath "$1")/Config/GeneralSettings.xml
		local VAL=$($XMLSTARLET sel -t -m "/GeneralSettingsDefinition" -v "$CV" -n $CONF)
		if [ ! -z "$VAL" ]; then
			export $currentValName="$VAL"
		fi
	done
	# load dedicated server settings
	changeUTF $1 8 DedicatedServerSettings
	for CV in $(listConfigValues dediconfig); do
		local currentValName=configCurrent_$CV
		local CONF=$(getInstancePath "$1")/Config/DedicatedServerSettings.xml
		local VAL=$($XMLSTARLET sel -t -m "/DedicatedServerSettingsDefinition" -v "$CV" -n $CONF)
		if [ ! -z "$VAL" ]; then
			export $currentValName="$VAL"
		fi
	done
	# load connection settings
	changeUTF $1 8 ConnectionSettings
	for CV in $(listConfigValues connconfig); do
		local currentValName=configCurrent_$CV
		local CONF=$(getInstancePath "$1")/Config/ConnectionSettings.xml
		local VAL=$($XMLSTARLET sel -t -m "/ConnectionSettingsDefinition" -v "$CV" -n $CONF)
		if [ ! -z "$VAL" ]; then
			export $currentValName="$VAL"
		fi
	done
	# load master server settings
	changeUTF $1 8 MasterServerSettings
	for CV in $(listConfigValues mastconfig); do
		local currentValName=configCurrent_$CV
		local CONF=$(getInstancePath "$1")/Config/MasterServerSettings.xml
		local VAL=$($XMLSTARLET sel -t -m "/MasterServerSettingsDefinition" -v "$CV" -n $CONF)
		if [ ! -z "$VAL" ]; then
			export $currentValName="$VAL"
		fi
	done
	# load gameplay settings
	changeUTF $1 8 GameplaySettings
	for CV in $(listConfigValues gameconfig); do
		local currentValName=configCurrent_$CV
		local CONF=$(getInstancePath "$1")/Config/GameplaySettings.xml
		local VAL=$($XMLSTARLET sel -t -m "/GameplaySettingsDefinition" -v "$CV" -n $CONF)
		if [ ! -z "$VAL" ]; then
			export $currentValName="$VAL"
		fi
	done
	# Warp settings
	changeUTF $1 8 WarpSettings
	for CV in $(listConfigValues warpconfig); do
		local currentValName=configCurrent_$CV
		local CONF=$(getInstancePath "$1")/Config/WarpSettings.xml
		local VAL=$($XMLSTARLET sel -t -m "/WarpSettingsDefinition" -v "$CV" -n $CONF)
		if [ ! -z "$VAL" ]; then
			export $currentValName="$VAL"
		fi
	done
	# Interval settings
	changeUTF $1 8 IntervalSettings
	for CV in $(listConfigValues inteconfig); do
		local currentValName=configCurrent_$CV
		local CONF=$(getInstancePath "$1")/Config/IntervalSettings.xml
		local VAL=$($XMLSTARLET sel -t -m "/IntervalSettingsDefinition" -v "$CV" -n $CONF)
		if [ ! -z "$VAL" ]; then
			export $currentValName="$VAL"
		fi
	done
	# Screenshot settings
	changeUTF $1 8 ScreenshotSettings
	for CV in $(listConfigValues screconfig); do
		local currentValName=configCurrent_$CV
		local CONF=$(getInstancePath "$1")/Config/ScreenshotSettings.xml
		local VAL=$($XMLSTARLET sel -t -m "/ScreenshotSettingsDefinition" -v "$CV" -n $CONF)
		if [ ! -z "$VAL" ]; then
			export $currentValName="$VAL"
		fi
	done
	# Craft settings
	changeUTF $1 8 CraftSettings
	for CV in $(listConfigValues crafconfig); do
		local currentValName=configCurrent_$CV
		local CONF=$(getInstancePath "$1")/Config/CraftSettings.xml
		local VAL=$($XMLSTARLET sel -t -m "/CraftSettingsDefinition" -v "$CV" -n $CONF)
		if [ ! -z "$VAL" ]; then
			export $currentValName="$VAL"
		fi
	done
	# Website settings
	changeUTF $1 8 WebsiteSettings
	for CV in $(listConfigValues websconfig); do
		local currentValName=configCurrent_$CV
		local CONF=$(getInstancePath "$1")/Config/WebsiteSettings.xml
		local VAL=$($XMLSTARLET sel -t -m "/WebsiteSettingsDefinition" -v "$CV" -n $CONF)
		if [ ! -z "$VAL" ]; then
			export $currentValName="$VAL"
		fi
	done
	# Log settings
	changeUTF $1 8 LogSettings
	for CV in $(listConfigValues logconfig); do
		local currentValName=configCurrent_$CV
		local CONF=$(getInstancePath "$1")/Config/LogSettings.xml
		local VAL=$($XMLSTARLET sel -t -m "/LogSettingsDefinition" -v "$CV" -n $CONF)
		if [ ! -z "$VAL" ]; then
			export $currentValName="$VAL"
		fi
	done
	# Debug settings
	changeUTF $1 8 DebugSettings
	for CV in $(listConfigValues debugconfig); do
		local currentValName=configCurrent_$CV
		local CONF=$(getInstancePath "$1")/Config/DebugSettings.xml
		local VAL=$($XMLSTARLET sel -t -m "/DebugSettingsDefinition" -v "$CV" -n $CONF)
		if [ ! -z "$VAL" ]; then
			export $currentValName="$VAL"
		fi
	done
}

# Get a single value from a serverconfig
# Params:
#   1: Instance name
#   2: Property name
#   3: Settings type
# Returns:
#   Property value
getConfigValue() {
	local CONF=$(getInstancePath $1)/Config/$3.xml
	$XMLSTARLET sel -t -m "/${3}Definition" -v "$2" -n $CONF
}

# Change utf-16 to utf-8
# Params:
#   1: Instance name
#   2: format
#   3: File name
changeUTF() {
if [ $2 -eq 16 ] || [ $2 -eq 8 ]; then
	local CONF=$(getInstancePath $1)/Config/$3.xml
	local TMPPATH=`mktemp -d`
	if [ $2 -eq 8 ]; then
		sed 's/<?xml version="1.0" encoding="utf-16"?>/<?xml version="1.0" encoding="utf-8"?>/' $CONF > $TMPPATH/$3.xml
	else
		sed 's/<?xml version="1.0" encoding="utf-8"?>/<?xml version="1.0" encoding="utf-16"?>/' $CONF > $TMPPATH/$3.xml
	fi
	mv $TMPPATH/$3.xml $CONF -f
	rm -fr $TMPPATH
fi
}

# Print defined config value
# Params:
#   1: Config option
#   2: type option
printConfigValue() {
	local currentValName=configCurrent_$1
	printf "%-25s = %s\n" "$($2_$1_QueryName)" "${!currentValName}"
}


################
##### EDIT #####
################

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


# Validate the given value for the given option
# Params:
#   1: Option name
#   2: Value
#   3: Option type
# Returns:
#   0/1: invalid/valid
isValidOptionValue() {
	local TYPE=$($3_$1_Type)
	local RANGE=""

	if [ "$TYPE" = "enum" ]; then
		TYPE="number"
		$3_$1_Values
		RANGE=1-${#config_allowed_values[@]}
	else
		if [ "$(type -t ${3}_$1_Range)" = "function" ]; then
			RANGE=$($3_$1_Range)
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

	if [ "$(type -t $3_$1_Validate)" = "function" ]; then
		if [ $($3_$1_Validate "$2") -eq 0 ]; then
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
#   2: Settings type
configQueryValue() {
	local TYPE=$($2_$1_Type)
	local NAME=""
	local RANGE=""
	local DEFAULT=""
	local currentValName=configCurrent_$1

	if [ "$(type -t $2_$1_Values)" = "function" ]; then
		echo "$($2_$1_QueryName), options:"
		$2_$1_Values
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
		NAME=$($2_$1_QueryName)
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
		if [ "$(type -t $2_$1_Range)" = "function" ]; then
			RANGE=$($2_$1_Range)
		fi
	fi

	if [ -z "$DEFAULT" ]; then
		if [ ! -z "${!currentValName}" ]; then
			DEFAULT=${!currentValName}
		else
			if [ "$(type -t $2_$1_Default)" = "function" ]; then
				DEFAULT=$($2_$1_Default)
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

		if [ $1 == "Password" ] || [ $1 == "WarpMaster" ];then
			if [ "$DEFAULT" != "${!currentValName}" ] && [ "${!currentValName}" == "" ]; then
				while : ; do
					local CONTINUE
					read -p "Remove $1 ? (yn) " CONTINUE
					case $CONTINUE in
						y)
							printf "$1 removed\n"
							export $currentValName="${!currentValName}"
							break
							;;
						n)
							printf "$1 not changed\n"
							export $currentValName="$DEFAULT}"
							break
							;;
						*)
							printf "Wrong input\n"
					esac
				done
			else
				export $currentValName="${!currentValName:-$DEFAULT}"
			fi
		else
			export $currentValName="${!currentValName:-$DEFAULT}"
		fi

		if [ $(isValidOptionValue "$1" "${!currentValName}" "$2") -eq 0 ]; then
			if [ "$(type -t $2_$1_ErrorMessage)" = "function" ]; then
				$2_$1_ErrorMessage "${!currentValName}"
			fi
		fi

		[ $(isValidOptionValue "$1" "${!currentValName}" "$2") -eq 1 ] && break
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


################
##### SAVE #####
################

# Update a single value in a serverconfig
# Params:
#   1: Instance name
#   2: Property name
#   3: New value
#   4: Settings type
setConfigValue() {
	local CONF=$(getInstancePath $1)/Config/$4.xml
	$XMLSTARLET ed -L -u "/${4}Definition/$2" -v "$3" $CONF
}


# Save all config values to the config.xml of the given instance
# Params:
#   1: Instance name
saveCurrentConfigValues() {
	local CV
	# general settings
	for CV in $(listConfigValues genconfig); do
		local currentValName=configCurrent_$CV
		local val="${!currentValName}"
		local CONF=$(getInstancePath "$1")/Config/GeneralSettings.xml
		setConfigValue $1 $CV "$val" GeneralSettings
	done
	# dedicated server settings
	for CV in $(listConfigValues dediconfig); do
		local currentValName=configCurrent_$CV
		local val="${!currentValName}"
		local CONF=$(getInstancePath "$1")/Config/DedicatedServerSettings.xml
		setConfigValue $1 $CV "$val" DedicatedServerSettings
	done
	# connection settings
	for CV in $(listConfigValues connconfig); do
		local currentValName=configCurrent_$CV
		local val="${!currentValName}"
		local CONF=$(getInstancePath "$1")/Config/ConnectionSettings.xml
		setConfigValue $1 $CV "$val" ConnectionSettings
	done
	# master server settings
	for CV in $(listConfigValues mastconfig); do
		local currentValName=configCurrent_$CV
		local val="${!currentValName}"
		local CONF=$(getInstancePath "$1")/Config/MasterServerSettings.xml
		setConfigValue $1 $CV "$val" MasterServerSettings
	done
	# gameplay settings
	for CV in $(listConfigValues gameconfig); do
		local currentValName=configCurrent_$CV
		local val="${!currentValName}"
		local CONF=$(getInstancePath "$1")/Config/GameplaySettings.xml
		setConfigValue $1 $CV "$val" GameplaySettings
	done
	# WarpSettings
	for CV in $(listConfigValues warpconfig); do
		local currentValName=configCurrent_$CV
		local val="${!currentValName}"
		local CONF=$(getInstancePath "$1")/Config/WarpSettings.xml
		setConfigValue $1 $CV "$val" WarpSettings
	done
	# IntervalSettings
	for CV in $(listConfigValues inteconfig); do
		local currentValName=configCurrent_$CV
		local val="${!currentValName}"
		local CONF=$(getInstancePath "$1")/Config/IntervalSettings.xml
		setConfigValue $1 $CV "$val" IntervalSettings
	done
	# ScreenshotSettings
	for CV in $(listConfigValues screconfig); do
		local currentValName=configCurrent_$CV
		local val="${!currentValName}"
		local CONF=$(getInstancePath "$1")/Config/ScreenshotSettings.xml
		setConfigValue $1 $CV "$val" ScreenshotSettings
	done
	# CraftSettings
	for CV in $(listConfigValues crafconfig); do
		local currentValName=configCurrent_$CV
		local val="${!currentValName}"
		local CONF=$(getInstancePath "$1")/Config/CraftSettings.xml
		setConfigValue $1 $CV "$val" CraftSettings
	done
	# WebsiteSettings
	for CV in $(listConfigValues websconfig); do
		local currentValName=configCurrent_$CV
		local val="${!currentValName}"
		local CONF=$(getInstancePath "$1")/Config/WebsiteSettings.xml
		setConfigValue $1 $CV "$val" WebsiteSettings
	done
	# LogSettings
	for CV in $(listConfigValues logconfig); do
		local currentValName=configCurrent_$CV
		local val="${!currentValName}"
		local CONF=$(getInstancePath "$1")/Config/LogSettings.xml
		setConfigValue $1 $CV "$val" LogSettings
	done
	# 
	for CV in $(listConfigValues debugconfig); do
		local currentValName=configCurrent_$CV
		local val="${!currentValName}"
		local CONF=$(getInstancePath "$1")/Config/DebugSettings.xml
		setConfigValue $1 $CV "$val" DebugSettings
	done
}

