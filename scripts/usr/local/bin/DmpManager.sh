#!/bin/bash
# KSP DMP Manager Script Utilities

### VAR ###
dmpPath="/root/DMPServer"
screenName="dmp_ksp"
command="mono DMPServer.exe"

### UTILITIES ###
screenIsRunning()
{
	screen=$1
	screen -ls | grep -e "$screen" > /dev/null
	if [[ $? == 0 ]]; then
		return 1
	fi
	return 0
}
serverIsRunning()
{
	server=$@
	ps -lat | grep -e "$server" | grep -v grep > /dev/null
	if [[ $? == 0 ]]; then
		return 1
	fi
	return 0
}
isRunning()
{
	screenName=$1
	shift;
	command=$@
	screenIsRunning $screenName
	if [[ $? == 1 ]]; then
		serverIsRunning $command
		if [[ $? == 1 ]]; then
			return 1
		fi
	fi
	return 0
}
sendCommand()
{
	screen=$1
	shift;
	message=$@
	screen -S $screen -X stuff "$message ^M"
}

### MAIN FUNC ###
startServer()
{
	isRunning $screenName $command
	if [[ $? == 1 ]]; then
		echo "START - Server Allready Running"
	else
		echo "START - Server Not Running"
		echo "START - Starting Server"
		cd $dmpPath
		screen -dmS $screenName $command
		echo "START - Server Started!"
	fi
}
stopServer()
{
	# kill process
	serverIsRunning $command
	if [[ $? == 1 ]]; then
		echo "STOP - Stopping Process"
		sendCommand "/shutdown"
		echo "STOP - Process Stoped!"
	else
		echo "STOP - Process Allready Stoped!"
	fi
	
	#clear dead screen
	screen -S $screenName -X quit > /dev/null
	screen -wipe > /dev/null
}
restartServer()
{
	stopServer
	sleep 3
	startServer
}
status()
{
	screenIsRunning $screenName
	if [[ $? == 1 ]]; then
		echo "STATUS - Screen running ($screenName)"
		serverIsRunning $command
		if [[ $? == 1 ]]; then
			echo "STATUS - Process running ($command)"
			echo "STATUS - Server Running!"
		else
			echo "STATUS - Process not running ($command)"
			echo "STATUS - Server Not Running!"
		fi
	else
		echo "STATUS - Screen not running ($screenName)"
		echo "STATUS - Process not running ($command)"
		echo "STATUS - Server Not Running!"
	fi
}
command()
{
	message=$@
	sendCommand $screenName $message
}

### MAIN ###
toto=$1
shift;
tata=$@
if [ "$toto" == "start" ]; then
	startServer
fi
if [ "$toto" == "stop" ]; then
	stopServer
fi
if [ "$toto" == "restart" ]; then
	restartServer
fi
if [ "$toto" == "status" ]; then
	status
fi
if [ "$toto" == "command" ]; then
	command $tata
fi
if [ "$toto" == "" ]; then
	echo "Commands: start, stop, restart, status, command \"dmp-command\""
fi
