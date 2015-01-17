Description:
------------

This command is a simple helper to create a new script.

It actualy supports 2 modes / templates:

1. Default with no arguments: minimal
2. **-a**, make an 'advanced' template, quite more text examples to copy paste ;)

There is no need to pass a number, it will automaticly add a **.1** after the string.


Examples:
---------

To create a new minimal manpage in the current directory:

	tui-new-manpage -m ./myscript
	
When you call:

	tui-new-manpage myscript

It will look for the existence of either **$HOME/bin** or **$HOME/.local/bin**, if neither is found, it will **create $HOME/bin** and place the manpage there.