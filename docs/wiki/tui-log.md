### tui-log

Description:
------------

This coding helper is ment to make loging easier.

Also it simplifies the task of loging and showing the message to the user, as this log tool has a verbose mode.

If the verbose flag is not passed, there will be no visual output unless there is no write access.

Examples:
---------

	tui-log -tv /path/to/logfile "Server: Started"
	
'As is' this obviously fails, when run as normal user:

	# | Failed to create /path/to/logfile as sea                    [  ✘   ] | #

However, when passing a path one has write access to, this will be displayed:

	# | Server: Started                                                      | #

and the according log message will look like:

	#### 2015-01-15 ####
	16:54:16 	 Server: Started
