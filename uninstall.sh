#!/bin/sh
# 2014.01.28 by sea
#
#	Variables
#
	app=tui
	[[ ! -f install.sh ]] && cd $(dirname $0)
	[[ -d /usr/bin ]] && \
		DIR_BIN=/usr/bin || \
		DIR_BIN=/bin
	DIR_APP=/usr/share/$app
	DIR_CFG=/etc/$app
	DIR_DOC=/usr/share/doc/$app
	DIR_MAN1=/usr/share/man/man1
#
#	Initall to Environment
#
	tui-echo "Press enter to uninstall $app OR press 'CTRL+c' to abort"
	tui-press
	if tui-bol-yesno "Remove custom configurations of all local users?"
	then 	for usr in /home
		do 	tui-print "Removing configuration of $usr"
			rm -fr "/home/${usr}/.config/$app"
			tui-status $? "Removed configuration of $usr"
		done
	fi
	rm -fr $DIR_APP
	rm -fr $DIR_CFG
	rm -fr $DIR_DOC
	rm $DIR_BIN/${app}*
	rm $DIR_MAN1/${app}*
	
