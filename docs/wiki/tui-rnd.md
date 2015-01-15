### tui-rnd

Description:
------------

This coding helper is ment to make random numbers within a range.

By default it prints a random number between 0 and 100.

Because one often uses a random number to select from a list or array, the minimum value in most uses will be 0, thus the first argument is the MAX value the number may be.

Examples:
---------

	# Prints a random number between 0 and 100
	tui-rnd
	
	# Saves a random number between 0 and 15 as variables RND
	RND=$(tui-rnd 15)
	
	# Print a random number between MAX but is at least $MIN
	MIN=128
	MAX=255
	tui-rnd $MAX $MIN