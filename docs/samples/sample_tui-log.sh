#!/bin/bash
# Some demonstration for the tui-log use...
#
#	Variables
#
	LOG=temp.log
#
#	Prepare logfile
#
	tui-title "Demonstation of logfile use..."
	[[ -f $LOG ]] && rm $LOG
	touch $LOG
	tui-status $? "Created logfile: $LOG"
#
#	Action
#	
	tui-echo "Now do 3 default log actions"
	tui-log -t $LOG "Some entry"
	tui-log -t $LOG "Another entry"
	tui-log -t $LOG "A third line"
	
	tui-echo "Now 3 '-v' (verbose)  log actions"
	tui-log -vt $LOG "2 Some entry"
	tui-log -vt $LOG "2 Another entry"
	tui-log -vt $LOG "2 A third line"
	
	tui-echo
	tui-title "Now showing the content of: $LOG"
	
	while read line;do
		if [[ ! "" = "$(echo $line)" ]]
		then	len=${#line}
			#len=$(($len-1))
			line="$(echo ${line}|sed s,\\t,\ \ ,g)"
			tui-echo "${line}"
		fi
	done<"$LOG"
