### tui-list

Description:
------------
This is a simple tool to list values within TUI.
By default its indexing the values numeric, but this can be disabled, or changed to roman letters.


Examples:
---------
Lets see how a default call handles an array containing 3 strings

	array=("Some value" "Another one" "Watch out")
	tui-list "${array[@]}"

Looks like:

	# | 1) Some value               2) Another one              3) Watch out | #

Lets keep the array, and just use the roman toggle (**-r**):

	array=("Some value" "Another one" "Watch out" "Some value" "Another one" "Watch out")
	tui-list -r "${array[@]}"

Looks like:

	# | I. Some value             II. Another one             III. Watch out | #
	# | IV. Some value              V. Another one             VI. Watch out | #
