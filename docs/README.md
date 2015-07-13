README - TUI - 0.8.8-GNU-RC3
============================

A 'Text User Interface' framework for scripts
-------------------------------------------


Description / What is it?:
--------------------------

It is a command based framework which wraps the task (executed command name represents task or description) into an adaptive Text User Interface (TUI).
It is a framework to be used in the shell or shell scripts, though the usage of scripts is recomended to preserve the interface feeling.
It aims to simplify the task of script writing and mainwhile reward the scripter and the final user with a TUI.

This said, when executed alone, a single tui-\<command\>, it doesnt look that interface'ish.
However, as soon you append a few tui-echo after another or use tui-cat to print a small textfile to the screen, you will feel the difference.

The core display commands are:

* tui-header, has the full background colored
* tui-title, has only the inline background colored
* tui-echo
* tui-printf
* tui-cat
* tui-list

With the basic user interactions like:

* tui-read
* tui-select
* tui-yesno

As it is command based and uses a dash (-) to seperate descriptors, it is possible to group some tasks.
Those are tui-bol-\*, tui-conf-\*, tui-str-\*, which are considered coding helpers.

There are some special cases:

*	tui-install, is ment to install packages distro-independant, so the scripter doesnt have to care wether its apt-get, emerge, dnf, pacman, pkg or zypper
*	tui-printf, does not accecpt string formating as its origin name
*	tui-bgjob-mgr, is the only abrevihation, backgroundjob script manager (displaying which of a list of scripts are already executedd with success/failure, currently running or still todo.
*	tui-terminal beeing some kind of exception here, as it will only work in a GUI enviornment, but this will also start the prefered terminal window of the user, with its last list entry **xterm** ment as last fallback option.



Purpose & usage:
-----------------

In todays world, everything is about presenting. There are many tasks that can be faster accomplished using a script rather than writing an application for it as others require to use it.

This said, it is known many end-users dont like the terminal screen. That is usualy because the commands in terminals have their output not very well structured, usualy just text-by-text-by-newline-by-text.

This is if you need/want/have to provide scripts for users to use, and make it (a little) easier for them to 'read' the terminal, without to have to write 'presentation' handlers.

Thus user.conf in ~/.config/tui provides variables that may be used for any script that sources tui, same goes for apps.conf, which will provide EDITOR, BROWSER, FILEMGR, TERMINAL with your set favorite applications.

Now in the combination with tui-edit, you dont even need to source tuirc to have tui-edit open the given filename with your favorite editor.



Default behaviour:
------------------
Prints left and right border according to selected theme, and colors tui-header and tui-title.
Each of the core display commands prints up to 3 strings to align output.
While tui-title prints a single string centered, the others will print if left.
If passed 2 strings, first one will be left, second will be right.
If passed 3 strings, the 2nd will be centered and the third one be right.
Use tui-list to print more than three string, and use -1 or -2 to force to pass only that many items to print a line.

tui-printf might be irritating at first, as it doesnt accept the string formating as its name-ancestor printf, but it is the absolute core display tool used in TUI, and therefor deserves that name.
Please see its helpscreen or manpage or the examples for more details.

There are several tools that work with their or passed return/exit codes.
tui-yesno beeing one of them as it returns no visible value, just its exit code changes from 0 for yes, to 1 for no.

	if tui-yesno "Some question?"
	then	tui-echo "Do this" "$list"
	else	tui-status 4 "Skipped"
	fi

There are also tools that expect the returned value to be stored as a string variable, such as tui-select.

	A="Some Entries"
	B="With whitespaces"
	while [ ! "$MENU" = Quit ]
	do	MENU=$(tui-select -1 Quit "$A" "$B")
		case "$MENU" in
		"$A")	echo todo	;;
		"$B"	echo todo	;;
		esac
	done

Also be sure to compare the exit codes of:

	tui-status 1 fail
	echo $?
	
	tui-printf -S 4 Skipping
	echo $?

As an application/package it is a dependency, not a standalone application, it also requires bash to be installed, however your script could be _anyhting_ from bash to zsh.

It is not ment that 'endusers' (have to) care about TUI, its ment that a scripter uses tui as his library (-functions).

It provides you with commands named similar to their GNU originals or by its task and warps its output with TUI.

_Either think of TUI as a simpler zenity/curses, or as a **metapher**: If your script is a php-website then tui is html._ (it is not ment to be used for websites!)



Description / Helpers:
----------------------

Also it aims to simplify the functionality among diffrent distros, in the special means of, 
if your requires additional dependencies, as the author of the script, 
you can just use **tui-install $REQUIRED\_PACKAGES** and do not need to care wether to use whatever from apt-get to yum...

And tools like tui-edit, tui-web, tui-filemgr also help with other interactions on 'foreign' systems to the script author.

They simply check a list of (to me) known applications specifily in gui or cli mode, and starts it then accordingly.

The priority of the internaly used lists are that first non-default editors are checked (such as: emacs, eclipse, nano) and the least 'modern' tools (such as: leafpad, ed/vi) as the last fall back.

If you should ever experience that no propper application should be started, please let me know your installed appllication its name and raise a [issue](https://github.com/sri-arjuna/tui/issues)

Eventhough ther are only 4 core commands for display use, there are 29 additional assistant commands for many tasks a scripter comes by daily (tui-{list,read,select,status,yesno)).



Dependcies
-------------

Its dependency list is quite short.
As the goal was to be as minimalistic as possible regarding its dependencies, 
and beeing as 'linux-philosophy-close-as-possible' as i understand it.

Origin:
	Everything is a file.
And my addition:
	Every file is text.

So i decided to write everything as scripts, which enables me the stay almost dependency-less to match a minimalistic apporoach.

*	bash
*	coreutils
*	awk
*	grep
*	sed
*	sudo (optional)

