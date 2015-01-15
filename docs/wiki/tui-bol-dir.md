### tui-bol-dir

Description:
------------

This coding helper assists you to make sure a folder exists.

It reports wether the folder was found, created, or could not be created.

Examples:
---------

	tui-bol-dir data

Could look like either one of:

	# | Found: data                                                 [  √   ] | #
	# | Created: data                                               [  √   ] | #
	# | Created: data                                               [  ✘   ] | #

Obviously, it can be used for an if-block as well:

	if tui-bol-dir data
	then	tui-echo "The folder $PWD/data was required to continue."
	fi
	
Which then could look like this:

	# | Created: data                                               [  √   ] | #
	# | The folder /home/sea/tmp/data was required to continue.              | #
