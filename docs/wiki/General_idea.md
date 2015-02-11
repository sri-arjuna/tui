TUI - The general idea
======================

TUI is ment as a framework to easier share scripts with each other. _(for all the commands, see [Commands: Methodology](https://github.com/sri-arjuna/tui/wiki/Commands:-Methodology-order))_

Something similar to rather than everyone is using their own functions to display/report and simplify interactions, one shares a common library.

Given its name, it attempts to create the feeling of an interface, without trying to simulate pseudo 3d, so it is some kind of a markup language.

Idealy, as in getting the most of it, you'd be using this in a multi OS environment, where every user has a diffrent webbrowser, text editor and filemanager installed, 
and you're supposed/wanting to write a highly customizeable script wich does background jobs and status reports, or wraps other commands in custom function-scripts.

No longer get distracted by writing basic functions, focus on the script you want!

As in:

	function my_title()
	{
		printf '\n\t\t%s\n\n' "${1}"
	}
	function my_echo()
	{
		echo -n "\033[040;m${1}\033"
	}
	function edit_file()
	{
		emacs "$1"
	}
	function my_status()
	{
		
	}
	my_title "Example script"
	my_echo "Opening now a file.."
	edit_file "/path/to/file"

One could use instead:

	tui-title "Example Script"
	tui-echo "Opening file:" \
		"/path/to/file"
	tui-edit "/path/to/file"

So one could say, when using the TUI framework commands, one could think of them as functions shared among scripts.

In this example, you have to be aware that the user executing your script doesnt have emacs installed.

With your script he has to search for the function opening a file, and changing the only proper part of the code.

Using TUI takes care of this, as it is looking for which editor the user has installed - also it checks wether it is in GUI (graphical) or CLI (emergency/multiuser) mode and uses the according editor.

This said, TUI also wants to ease and simplify several reoccouring tasks, such as asking for yesno and use this as a boolean:

Rather than a redhat user writing:

	read -n 1 -p "Are you sure to delete this file: 'XY'? (y/n)" yesno
	case "$yesno" in
	y|Y)	echo Yes
		bool=true	;;
	*)	echo No
		bool=false	;;
	esac
	$bool && rm -f test_file

and then getting told by a Solaris users that the script dont work properly, one could use:

	tui-yesno "Are you sure to delete this file: 'XY'?" && \
		rm -f test_file

And it will work from BSD, over GNU to Solaris.

To get this right, to theoreticly keep it the most simply way to edit and improve further for the community, it is written in - and therefore depending on - Bourne Shell (BASH).

However, you can write your scripts with whatever language you want, from csh, fish, ksh* to zsh.
Bash just needs to be installed, so the _tui-*_ commands can be executed.

