Description:
------------

This command simply prints the content of a file within TUI borders.

There is also a typerwriter mode, which prints a passed string or file, line by line, char by char with a certain delay.

Examples:
---------
Regular use of tui-cat, understand that the regular use of tui-cat only accepts files as arguments!

	tui-cat [/path/to/]file

Typerwriter mode, this mode also accepts a string as an argument:

	tui-cat -td 0.5 "Message string" "[/path/to/]file.txt" "Second string" [...]