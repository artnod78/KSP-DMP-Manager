#!/bin/bash

lmmCommandAbout() {
	echo "Luna Multiplayer - Linux Server Management Scripts"
	echo "Website: https://github.com/artnod78/KSP-DMP-Manager"
	echo
	cat /usr/local/lib/lmm/VERSION
}

lmmCommandAboutHelp() {
	sdtdCommandAbout
}

lmmCommandAboutDescription() {
	echo "Version and short info about these scripts"
}
