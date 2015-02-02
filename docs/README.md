README - 0.6.0
==============


TUI - a (line based) Text User Interface framework
---------------------------------


Description:
------------
TUI is an abrevihation for "Text User Interface".
It provies you with commands named similar to their GNU originals, but enables you to wrap your output into a TUI.

Eventhough ther are only 4 core commands for display use, there are 29 additional assistant commands for many tasks a scripter comes by daily (tui-{list,read,select,yesno)).
Furthermore, it provides diffrent 'interactions' according to the mode the user is in, wether a VT or any GUI, 
some of the commands will use diffrent applications (tui-{edit,filemgr,terminal,web}), or display its output in a slight other way (tui-status).

It is designed to be working during all stages, from init 1 to init 5.

Also, a big **thank you** goes to the forummembers of unix.com.


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
