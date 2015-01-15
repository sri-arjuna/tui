### tui-yesno

Description:
------------

This little user interaction helper is one of my favorites.

It simplyfies the task of working with a 'yes or no' expected answer.


Examples:
---------
Recomended usage:

	if tui-yesno "Wipe my disk?"
	then	tui-echo "Wiping disk now"
	else	tui-echo "AHA, not this time!"
	fi
	
Will output as either one of the 2 lines:

	# | Wipe my disk? (y/n)                                                y | #
	# | Wiping disk now                                                      | #
 	 
	# | Wipe my disk? (y/n)                                                n | #
	# | AHA, not this time!                                                  | #
	
Of course you can use the shortcut, which outputs identical as the above:

	tui-yesno "Wipe my disk?" && \
		tui-echo "Wiping disk now" || \
		tui-echo "AHA, not this time!"
