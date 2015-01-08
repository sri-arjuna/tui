#!/bin/bash -x
# sample-status by Simon Arjuna Erat (sea) (erat.simon@gmail.com) on 2014-05-18

tui-header "$(basename $0)"
. /etc/profile.d/tui.sh

demo_menu() { # PATH
#
#
	[ -d "$1" ] && cd "$1"
	
	tui-title "tui-status sample"
	tui-echo "Aside of 'Quit' each entry is the name of a variable, which can be used"
	tui-echo "Hower, tui-status expects a number as first argument,"
	tui-echo "therefor you can use \$RET_[DONE,FAIL....] to get the desired output"
	select F in Quit \
		DONE FAIL WORK TODO SKIP NEXT BACK CANC ENAB DIAB HELP INFO ; do
	case "$F" in
	Quit)	break			;;
	*)	str=$(eval echo \$RET_${F})
		tui-status $str "Selected: $F"	;;
	esac
	done
	
	
}

demo_menu $HOME
tui-status $? "You exited with: $?"
