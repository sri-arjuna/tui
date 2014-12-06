#!/bin/bash
#--This file was created using: tui-new-script -m ./demo0.sh
# demo0.sh by Simon Arjuna Erat (sea) (erat.simon@gmail.com) on 2014-12-03

# Lets see: changing variables
FILE=$HOME/demo.tmp.conf
tui-header "${0##*/} - Working with configuration files"

# Write the file
	tui-title "Writing $FILE"
	touch $FILE
	tui-conf-set $FILE pid 		$$
	tui-conf-set $FILE user 	$USER
	tui-conf-set $FILE host 	$(hostname)
	tui-conf-set $FILE kernel 	$(uname -r)
	
# Read the file
	tui-title "Reading $FILE"
	for VAR in pid user host kernel
	do
		tui-echo "$VAR::" $(tui-conf-get $FILE $VAR)
	done
# Change a variable
	# Set new value
	tui-conf-set $FILE kernel nonsense
	# Read new value
	tui-echo \
		"New kernel is:" \
		"$(tui-conf-get $FILE kernel)"
# Removing temp file
	tui-printf "Deleting tempfile..."
	rm $FILE
	tui-status $? "Deleted: $FILE"