#!/bin/bash

LmmCommandAbout() {
	echo "Luna Multiplayer - Linux Server Management Scripts"
	echo "Website: https://github.com/artnod78/KSP-LMP-Manager"
	cat /usr/local/lib/lmm/VERSION
	echo
}

LmmCommandAboutHelp() {
	LmmCommandAbout
}

LmmCommandAboutDescription() {
	echo "Version and short info about these scripts"
	echo
}
