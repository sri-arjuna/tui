### tui-read

Description:
------------

This user interaction : script  is ment to 'look nice' when expecting user input and to simplify the task of printing the question and expecting the input with a single command.

Otherwise, it is a command and not a shell built-in, thus one can read just one string, which you still could split up, if your skill allows.

You can also pass **-p** to hide the user input from the screen, helpfull to get a password into a variable without displaying it.


Examples:
---------
So this is how the invocation should look like:

	myAnswer=$(tui-read "A Question about haircolor:")

Will look like this, after i entered 'brown':

	# | A Question about haircolor: brown                                    | #

At all times you can fallback to the real read, and make it look almost the same:
Note, sourcing tui is required so you get the variable *$BORDER_LEFT*

	source tui
	msg="A question about age:"
	tui-printf "$msg"
	printf "\r$BORDER_LEFT $msg "
	read myAnswer
	tui-echo "$msg" "$myAnswer"