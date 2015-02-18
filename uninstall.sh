#!/bin/sh
# 2015.02.18 by sea
#
#	Variables
#
	app=tui
	source /etc/tui/tui.conf ## To get the PREFIX used when installed
	[ ! -f uninstall.sh ] && cd $(dirname $0)
	
	# OLD
	# DIR_APP=$PREFIX/share/$app
	
	# NEW
	DIR_APP=$PWD				# Since unstall.sh is located here
	DIR_BIN=$(dirname $(which $app))	# As the commands needs to be available, they will report their location
	DIR_CFG=/etc/$app
	DIR_DOC=$PREFIX/share/doc/$app
	DIR_MAN1=$PREFIX/share/man/man1
	COMPL=$(locate tui_compl.bash|$GREP etc)
#
#	Uninstall from Environment
#
	tui-echo "Press enter to uninstall $app OR press 'CTRL+c' to abort"
	tui-press
	if tui-yesno "Remove custom configurations of all local users?"
	then 	for usr in $(ls /home --hide=lost+found)
		do 	tui-printf "Removing TUI configuration of $usr"
			[ -d "/home/${usr}/.config/$app" ] && rm -fr "/home/${usr}/.config/$app"
			tui-status $? "Removed TUI configuration of $usr"
		done
	fi
	rm -fr $DIR_APP
	rm -fr $DIR_CFG
	rm -fr $DIR_DOC
	rm $COMPL
	rm -f /etc/profile.d/tui.sh
	rm $DIR_BIN/${app}*
	rm $DIR_MAN1/${app}*
	
