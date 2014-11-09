README - 0.5.0
==============

TUI - Text (based) User Interface
---------------------------------



Description:
------------
TUI is an abrevihation for "Text User Interface".
It enables you to write scripts which when using the tui-'simulation a TUI in any terminal window or tty console.
Due to the 'limitation's of a TTY/Terminal, it is a line-based-interface.

It is ment for scripts that are 'selective' with their output to the user, 
and also want to present themself a little bit more attractive.
By this i mean, if you want to write handlers, tools, 
and therefor want to look a little bit more attractive.

With TUI you can give your scripts a touch of user interface, even at init 1 /emergency mode.
It is 

All the commands try to be as native langue OR self explaining as possible.
!!
   During the currently running ALPHA and BETA stages,
   i'm open to any name change suggestions!
!!

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
	status.conf
	tui.conf
	
**HOME/.config/tui/**
	apps.conf
	user.conf

apps.conf stores the variables for your default applications used by their specific tui-APP command (tui-edit).



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
