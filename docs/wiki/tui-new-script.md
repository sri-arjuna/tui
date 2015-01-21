Description:
------------

This command is a simple helper to create a new script.

It actualy supports 3 modes / templates:

1. Default with no arguments: medium
2. **-m**, gives a minimal template, contains a line with the license and your name
3. **-r**, gives a regular template, same as default (no option), but less pre-sets
4. **-t**, gives you a template optimized to act like a tool
5. **-a**, gives an 'application' template, from all the options, its the most complex template


Examples:
---------

To create a new minimal script in the current directory:

	tui-new-secript -m ./myscript.sh
	
When you call:

	tui-new-script myscript.sh
	
It will look for the existence of either **$HOME/bin** or **$HOME/.local/bin**, if neither is found, it will **create $HOME/bin** and place the script there.