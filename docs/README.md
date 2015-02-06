README - 0.7.0
==============


TUI - a (line based) Text User Interface framework
---------------------------------


Description / What is it?:
--------------------------

As an application/package it is a dependency, not a standalone application, it also requires bash to be installed, however your script could be _anyhting_ from bash to zsh.

It is not ment that 'endusers' (have to) care about TUI, its ment that a scripter uses tui as his library (-functions).

It provides you with commands named similar to their GNU originals or by its task and warps its output with TUI.

_Either think of TUI as a simpler zenity/curses, or as a metapher: If your script is a php-website then tui is html._


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



-----------


Core Functions / Purpose:
------------------------
* tui-echo (actualy uses printf with a trailing '\n' for compability reason)
* tui-printf (Keeps writing on current line, replacing previous tui-printf outputs)
* tui-header (Prints the whole line blue background, with white font :: default)
* tui-title (Prints borders 'normal', between white background and blue font :: default)

Each of these commands can display up to 3 strings.
For all, but without tui-title, the alignemt goes:
	1 String  = 1) left
	2 Strings = 1) left 2) right
	3 Strings = 1) left 2) center 3) right

See [this preview]()

For tui-title it is:
1 String = 1) center
More Strings like the others...

Thus, the commands have alignmends to the: left, center and the right.
So each command that is supposed to just display strings,
may be passed up to 3 strings at a time, or empty.



Configuration Files:
--------------------

**/etc/tui/**
	apps.conf
	colors.conf
	commands.conf
	status.conf
	tui.conf
	
**HOME/.config/tui/**
	apps.conf
	user.conf

apps.conf stores the variables for your default applications used by their specific tui-APP command (tui-edit).

commands.conf stores which awk, grep or sed is used tui - internaly and systemwide only.



Purpose & usage:
------------
In todays world, everything is about presenting.
There are many tasks that can be faster accomplished
using a script rather than writing an application for
it as others require to use it.

This said, it is known many end-users dont like the terminal screen.
That is usualy because the commands in terminals have their
output not very well structured, usualy just text-by-text-by-newline-by-text.

This is if you need/want/have to provide scripts for users to use,
and make it (a little) easier for them to 'read' the terminal,
without to have to write 'presentation' handlers.


Also inspired by the use of credentials files for the use of mounting a Network Attached Storage (NAS),
i wanted to reuse my name and email easily without
having to rename each and every script if i decide to use another email adress or homepage.
Or if my new scripts shall be another LICENSE_TEXT.
Each of the command aims to be a 1 line output.
Surrounded with a customable border layout.

Thus user.conf in ~/.config/tui provides variables that may be used for any script that sources tui,
same goes for apps.conf, which will provide EDITOR, BROWSER, FILEMGR, TERMINAL with your set favorite applications.

Now in the combination with tui-edit, you dont even need to source tui
to have tui-edit open the given filename with your favorite editor.


