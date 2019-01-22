#!/bin/bash

# Backups game data files.

LmmCommandBackup() {
	local DT=`date "+%Y-%m-%d_%H-%M"`
	local NewBackup=$LMM_BACKUP_ROOT/$DT
	
	if [ ! -d "$LMM_BASE/instances" ]; then
		return
	fi

	# Check for backup folder existence
	if [ -e $LMM_BACKUP_ROOT ]; then
		# Exists, copy(link) latest backup
		unset -v LatestBackup
		local fileI
		for fileI in $(find "$LMM_BACKUP_ROOT" -mindepth 1 -maxdepth 1 -type d); do
			if [ "$fileI" -nt "$LatestBackup" ]; then
				LatestBackup=$fileI
			fi
		done
		if [ -d "$LatestBackup" ]; then
			cp -al "$LatestBackup" "$NewBackup"
		fi
	fi

	if [ ! -d $LMM_BACKUP_ROOT ]; then
		# Create new backup dir
		mkdir $LMM_BACKUP_ROOT
	fi

	$RSYNC -a --delete --numeric-ids --delete-excluded $LMM_BASE/instances/./ $NewBackup
	touch $NewBackup
	
	## Compress if enabled
	case ${LMM_BACKUP_COMPRESS:-none} in
		all)
			local dfname=$(basename $NewBackup)
			cd $LMM_BACKUP_ROOT
			tar -czf $dfname.tar.gz $dfname
			touch -r $dfname $dfname.tar.gz
			rm -Rf $dfname
			;;
		old)
			if [ -d $LatestBackup ]; then
				local dfname=$(basename $LatestBackup)
				cd $LMM_BACKUP_ROOT
				tar -czf $dfname.tar.gz $dfname
				touch -r $dfname $dfname.tar.gz
				rm -Rf $dfname
			fi
			;;
		none)
			;;
	esac
	
	cd $LMM_BACKUP_ROOT
	
	## Purge old/too many backups
	local keepMin=${LMM_BACKUP_MIN_BACKUPS_KEEP:-0}
	if [ $(isANumber $LMM_BACKUP_MAX_BACKUPS) -eq 1 ]; then
		local removeBut=$LMM_BACKUP_MAX_BACKUPS
		if [ $LMM_BACKUP_MAX_BACKUPS -lt $keepMin ]; then
			removeBut=$keepMin
		fi
		local num=0
		local F
		for F in $(ls -t1 $LMM_BACKUP_ROOT); do
			(( num++ ))
			if [ $num -gt $removeBut ]; then
				rm -Rf $F
			fi
		done
	fi
	if [ $(isANumber $LMM_BACKUP_MAX_AGE) -eq 1 ]; then
		local FINDBASE="find $LMM_BACKUP_ROOT -mindepth 1 -maxdepth 1"
		# Only continue if there are more than MIN_BACKUPS_KEEP backups at all
		if [ $($FINDBASE | wc -l) -gt $keepMin ]; then
			local minutes=$(( $LMM_BACKUP_MAX_AGE*60 ))
			while [ $($FINDBASE -mmin -$minutes | wc -l) -lt $keepMin ]; do
				minutes=$(( minutes+60 ))
			done
			$FINDBASE -mmin +$minutes -exec rm -Rf {} \;
		fi
	fi
	if [ $(isANumber $LMM_BACKUP_MAX_STORAGE) -eq 1 ]; then
		local maxKBytes=$(( $LMM_BACKUP_MAX_STORAGE*1024 ))
		local curNumFiles=$(ls -t1 $LMM_BACKUP_ROOT | wc -l)
		while [ $(du -sk $LMM_BACKUP_ROOT | tr '[:blank:]' ' ' | cut -d\  -f1) -gt $maxKBytes -a $curNumFiles -gt $keepMin ]; do
			local toDel=$(ls -tr1 | head -n 1)
			rm -Rf $toDel
			(( curNumFiles-- ))
		done
	fi
}

LmmCommandBackupHelp() {
	echo "Usage: $(basename $0) backup"
	echo
	echo "Backups all data files."
	echo
}

LmmCommandBackupDescription() {
	echo "Backup game data files"
	echo
}