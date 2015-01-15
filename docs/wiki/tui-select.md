### tui-select

Description:
------------

Well, almost like the regular select, but matching TUI.

The drawback is, the output per line is limited to 3, which makes it look weird on wide screen and short entries.
On the good side, the cursor stays on the line where he is untill a valid selection was made.

Also since this is a command and not a builtin, the beloved _select X in $XY_ does not work with this.


Examples:
---------

	string=$(tui-select *)
	
Could present itself like:

	# | 1) base                   2) data                  3) dir with space | #
	# | 4) libs                        5) logs                       6) vars | #
	# | > 



But to preserve a select-like menu, how about this:

	string=""
	list="a b"
	while true ; do
 	 	string=$(tui-select quit $list)
		case "$string" in
		a)	echo one	;;
		b)	echo two	;;
		quit)	break		;;
		esac
	done