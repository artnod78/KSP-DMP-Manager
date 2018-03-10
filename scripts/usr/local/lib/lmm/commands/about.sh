#!/bin/bash

lmmCommandAbout() {
	echo "Luna Multiplayer - Linux Server Management Scripts"
	echo "Website: https://github.com/artnod78/KSP-DMP-Manager"
	cat /usr/local/lib/lmm/VERSION
	echo
}

lmmCommandAboutHelp() {
	lmmCommandAbout
}

lmmCommandAboutDescription() {
	echo "Version and short info about these scripts"
	echo
}
