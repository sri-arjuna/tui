#!/bin/sh
# 2015.05.24 by sea
#
#	Variables
#
	app=tui
	source $HOME/.tui_rc
	[ ! -f uninstall.sh ] && cd $(dirname $0)
	
	# NEW
	DIR_APP="$TUI_DIR_SYSTEM"				# Since unstall.sh is located here
	DIR_BIN="$TUI_PREFIX/bin"	# As the commands needs to be available, they will report their location
	DIR_CFG="$TUI_DIR_INSTALL_ROOT/etc/$app"
	DIR_DOC="$TUI_DIR_DOCS"
	DIR_MAN1="$TUI_DIR_MANPAGES"
	COMPL="$TUI_PREFIX/share/bash_completion/completions"
#
#	Uninstall from Environment
#
	tui-echo "Press enter to uninstall $app OR press 'CTRL+c' to abort"
	tui-press
	if tui-bol-root
	then	if tui-yesno "Remove custom configurations of all local users?"
		then 	for usr in $(ls /home --hide=lost+found)
			do 	tui-printf "Removing TUI configuration of $usr"
				[ -d "/home/${usr}/.config/$app" ] && rm -fr "/home/${usr}/.config/$app"
				tui-status $? "Removed TUI configuration of $usr"
			done
		fi
	fi
	# These are variables providing a last folder named 'tui'
	rm -fr "$DIR_APP"
	rm -fr "$DIR_CFG"
	rm -fr "$DIR_DOC"
	# Remove bash_completion
	rm $COMPL/tui_compl.bash
	# Remove binaries starting with 'tui'
	rm $DIR_BIN/${app}*
	# Remove manages starting with 'tui'
	rm $DIR_MAN1/${app}* && \
		echo -e "$TUI_DONE Removed TUI successfully.\n" || \
		echo -e ""$TUI_FAIL Could not remove TUI.\n"
	echo -e "\n\nThanks for having tried $app by sea.\n"