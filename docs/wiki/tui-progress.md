### tui-progress

Description:
------------

Belongs to the display assistants, and is ment to be used as progress indicator.
Its default setting is using [tui-indi](https://github.com/sri-arjuna/tui/wiki/tui-indi) to show a little animation of "\ - / |" on the right hand side of the terminal.

It can be used when 'parsing' a list or an array, to inform the user what currently happens, without producing to many lines of output.

Basicly, it is tui-printf with the third string beeing diffrent kind of progress indicators, as it replaces itself when called after another tui-progress call.


Examples:
---------
The simplest use is with the default progress indication, the animated dash.

	for entry in $list
	do 	tui-progress "Working with:" 	"$entry"
	done

Which will look similar to:

	# | Working with:                     entry                     [  |   ] | #

A little bit more preparation is needed, when you want the list processed to have the current and max number displayed.

	declare -a list
	list=$(ls)
	count=${#list[@]}
	tui-echo "Updating the file its timestamp"
	tui-progress -r
	for file in "${list[@]}"
	do 	tui-progress -m $count "Working on file:" 	"$file"
		touch "$file"
		sleep 0.3
	done

Which will look similar to:

	# | Working on file:                     file                     7 / 20 | #
	

Simliar is for the the bar progress indication, but it has one drawback.
Like the 'max' number indication, it requires a maximum value, and upon each new call, the bar fills up more relativly to its percentage, which is displayed either.

	declare -a list
	list=$(ls)
	count=${#list[@]}
	tui-progress -r	
	msg="Updating the file its timestamp"
	while [[ 0 -eq $? ]]
	do 	# fetch here wether or not the script shall continue
		# TODO
		./tui-progress -bm $count  "$msg"
	done

Which will look similar to:

	# | Updating the file its timestamp                             # [ 5% ] | #