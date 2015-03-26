Description:
------------

This little coding helper helps to generate filenames which have an increasing number, and become a possible new file extension.

Examples:
---------
Create a simple temp file:

	tui-str-genfilename /tmp/app.tmp

Will return, according to situation:

	# If it does not exist yet
	/tmp/app.tmp
	
	# If passed string already exists
	/tmp/app.0.tmp
	
You can even simple rename the tempfile

	tui-str-genfilename /tmp/app.tmp swp~
	
And it will return:

	# If it does not exist yet
	/tmp/app.swp~
	
	# Or if already some instances were called
	/tmp/app.719.swp~
