#!/bin/sh
#	Author: 	Simon A. Erat (sea)
#	Contact:	erat.simon@gmail.com
#
#	Variable defaults
#
	script_version=0.3
	ME="$(basename $0)"
	help_text="\r$ME ($script_version)
		\rUsage: $ME
		\rShows some commands in use.
		\rYou could also use edit any $(which tui-*)-command
		\r"
	TITLE="sea's Sample script"
#
#	Load own/users TUI configuration?
#
	#source tui #	This enables:
#			  * Variables: $DEFAULT_USER, $DEFAULT_EMAIL
#			  * Functions: DATE TIME
#
#	Variable handling
#
	#[[ -z $1 ]] && echo -e "$help_text" && exit $RET_HELP
	case "$1" in
	"-h")	source tui;echo -e "$help_text" ; exit $RET_HELP 	;;
	esac
#
#	Display
#
	clear
	tui-header "Could be used as Status or Informationbar"
	tui-title "$TITLE ($script_version)"
	if tui-yesno "Load additional configuration?"
	then	source tui
	fi
	tui-echo "Welcome:" \
		"$USER_NAME"
	tui-echo "It is now:" \
		"$(DATE)" \
		"$(TIME)"
	
	tui-title "Asking" "for" "strings"
	VARIABLE=$(tui-read "Enter something:")
	tui-echo "You entred:" "$VARIABLE"
	
	tui-title "Asking for yes or no"
	tui-yesno "Do you wear a blue hat?"
	if tui-status $? "$DEFAULT_USER wears a blue hat"
	then	tui-echo "You're a fedora user!"
	else	tui-echo "You're not using fedora..."
	fi
	if tui-yesno "Does that matter"
	then	tui-echo yup
	else	tui-echo nope
	fi
	
	tui-title "Introducing tui-printf and tui-indi"
	THAT_LIST=($HOME/*)
	for ENTRY in ${THAT_LIST[@]}
	do	tui-printf "Parsing (just showing):" "$ENTRY" "[  $(tui-indi)   ]"
		sleep 1
	done
	tui-status $? "Worked through list"
