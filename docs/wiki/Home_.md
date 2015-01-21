## TUI - A line based Text User Interface framework for scripts

1. Intro
2. [Commands, Methodology](https://github.com/sri-arjuna/tui/wiki#commands---methodology)

	2.1. [Out of Scale](https://github.com/sri-arjuna/tui/wiki#out-of-scale)
	2.2. [Basic Display](https://github.com/sri-arjuna/tui/wiki#basic-display)
	2.2. [Coding Helpers](https://github.com/sri-arjuna/tui/wiki#coding-helpers)
	2.3. [User interactions : Script](https://github.com/sri-arjuna/tui/wiki#user-interactions-:-script)
	2.4. [User interactions : External commands](https://github.com/sri-arjuna/tui/wiki#user-interactions-:-external-commands)
	2.5. [Advanced](https://github.com/sri-arjuna/tui/wiki#advanced)
3. [Commands, Alphabetic](https://github.com/sri-arjuna/tui/wiki#commands---alphabetic-order)

When writing scripts, arent you tired to write basic checks all the time over and over again?
You know, that basic stuff like, "Do you want to do this? (y/n)" ?
Or simply execute a command and have a cool init-style status message for it?
You have those scripts, structured by folders, but fail to get an usefull menu for this?

Here are the tools, for you to make your new masterpieces of scripts!

In most of the screenshots, you see the ***theme: default-blue***, though there are others.
Simply change it by typing:

	tui theme <tab>


They are best used in full screen terminals, but also work well in terminal windows, as long the minimum width is somewhat around 80-100 columns.

You can use it to verify your REGEX before using **mv**, for example:

	for f in *
	do	tui-echo "$f"	"${f/$STR_REMOVE/$STR_REPLACE}
	done
But one of the most used simplifiers is:

	if tui-yesno "Is it true?"
	then	tui-status $? "Success"
	else	tui-status $? "Failure"
	fi

And this is actualy almost the same:

	tui-yesno "Is it true?"
	
	if tui-status $? "Success"
	then	tui-echo "Do this on success"
	else	tui-echo "Do that on failure"
	fi

tui-yesno will simply print the question, and expecting (& accepting) ysjo as yes/true, everything else is no/false.
tui-status requires a number/exit status as first argument, that number is translated into a visual string and reported init-style'ish.

But see more on the according wiki page:


Commands - Methodology
========================
Out of scale
------------
* [tui-browser](https://github.com/sri-arjuna/tui/wiki/tui-browser)
* [tui-new-browser](https://github.com/sri-arjuna/tui/wiki/tui-new-browser)
* [tui-new-manpage](https://github.com/sri-arjuna/tui/wiki/tui-new-manpage)
* [tui-new-script](https://github.com/sri-arjuna/tui/wiki/tui-new-script)

Basic Display
-------------
These tools are the most used to display information to the user
* [tui-cat](https://github.com/sri-arjuna/tui/wiki/tui-cat)
* [tui-echo](https://github.com/sri-arjuna/tui/wiki/tui-printf)
* [tui-header](https://github.com/sri-arjuna/tui/wiki/tui-printf)
* [tui-printf](https://github.com/sri-arjuna/tui/wiki/tui-printf)
* [tui-progress](https://github.com/sri-arjuna/tui/wiki/tui-progress)
* [tui-list](https://github.com/sri-arjuna/tui/wiki/tui-list)
* [tui-status](https://github.com/sri-arjuna/tui/wiki/tui-status)
* [tui-title](https://github.com/sri-arjuna/tui/wiki/tui-printf)


Coding helpers
--------------
These tools should simplify some often repeated tasks
* [tui-bol-dir](https://github.com/sri-arjuna/tui/wiki/tui-bol-dir)
* [tui-bol-sudo](https://github.com/sri-arjuna/tui/wiki/tui-bol-sudo)
* [tui-indi](https://github.com/sri-arjuna/tui/wiki/tui-indi)
* [tui-log](https://github.com/sri-arjuna/tui/wiki/tui-log)
* [tui-rnd](https://github.com/sri-arjuna/tui/wiki/tui-rnd)


User interactions : Script
--------------------------
These tools should simplify coding, and have their output alread wraped to match the rest of the TUI theme.
* [tui-press](https://github.com/sri-arjuna/tui/wiki/tui-press)
* [tui-read](https://github.com/sri-arjuna/tui/wiki/tui-read)
* [tui-select](https://github.com/sri-arjuna/tui/wiki/tui-select)
* [tui-str-usb](https://github.com/sri-arjuna/tui/wiki/tui-str-usb)
* [tui-wait](https://github.com/sri-arjuna/tui/wiki/tui-wait)
* [tui-yesno](https://github.com/sri-arjuna/tui/wiki/tui-yesno)


User interactions : External commands
-------------------------------------
These commands are wrappers for either the name or function they represent.
tui-install beeing the exception, as it is a wrapper for just about 5 diffrent package managers.
* [tui-dd](https://github.com/sri-arjuna/tui/wiki/tui-dd)
* [tui-download](https://github.com/sri-arjuna/tui/wiki/tui-download)
* [tui-filemgr](https://github.com/sri-arjuna/tui/wiki/tui-filemgr)
* [tui-install](https://github.com/sri-arjuna/tui/wiki/tui-install)
* [tui-tar](https://github.com/sri-arjuna/tui/wiki/tui-tar)
* [tui-terminal](https://github.com/sri-arjuna/tui/wiki/tui-terminal)
* [tui-web](https://github.com/sri-arjuna/tui/wiki/tui-web)


Advanced
--------
* [tui-bgjob](https://github.com/sri-arjuna/tui/wiki/tui-bgjob)
* [tui-conf-editor](https://github.com/sri-arjuna/tui/wiki/tui-conf-editor)
* [tui-conf-get](https://github.com/sri-arjuna/tui/wiki/tui-conf-get)
* [tui-conf-set](https://github.com/sri-arjuna/tui/wiki/tui-conf-set)
* [tui-psm](https://github.com/sri-arjuna/tui/wiki/tui-psm)


Commands - Alphabetic order
===========================
* [tui](https://github.com/sri-arjuna/tui/wiki/TUI)
* [tui-bgjob](https://github.com/sri-arjuna/tui/wiki/tui-bgjob)
* [tui-bol-dir](https://github.com/sri-arjuna/tui/wiki/tui-bol-dir)
* [tui-bol-sudo](https://github.com/sri-arjuna/tui/wiki/tui-bol-sudo)
* [tui-browser](https://github.com/sri-arjuna/tui/wiki/tui-browser)
* [tui-conf-editor](https://github.com/sri-arjuna/tui/wiki/tui-conf-editor)
* [tui-conf-get](https://github.com/sri-arjuna/tui/wiki/tui-conf-get)
* [tui-conf-set](https://github.com/sri-arjuna/tui/wiki/tui-conf-set)
* [tui-dd](https://github.com/sri-arjuna/tui/wiki/tui-dd)
* [tui-download](https://github.com/sri-arjuna/tui/wiki/tui-download)
* [tui-echo](https://github.com/sri-arjuna/tui/wiki/tui-printf)
* [tui-edit](https://github.com/sri-arjuna/tui/wiki/tui-edit)
* [tui-filemgr](https://github.com/sri-arjuna/tui/wiki/tui-filemgr)
* [tui-header](https://github.com/sri-arjuna/tui/wiki/tui-printf)
* [tui-indi](https://github.com/sri-arjuna/tui/wiki/tui-indi)
* [tui-install](https://github.com/sri-arjuna/tui/wiki/tui-install)
* [tui-list](https://github.com/sri-arjuna/tui/wiki/tui-list)
* [tui-log](https://github.com/sri-arjuna/tui/wiki/tui-log)
* [tui-new-browser](https://github.com/sri-arjuna/tui/wiki/tui-new-browser)
* [tui-new-manpage](https://github.com/sri-arjuna/tui/wiki/tui-new-manpage)
* [tui-new-script](https://github.com/sri-arjuna/tui/wiki/tui-new-script)
* [tui-press](https://github.com/sri-arjuna/tui/wiki/tui-press)
* [tui-printf](https://github.com/sri-arjuna/tui/wiki/tui-printf)
* [tui-progress](https://github.com/sri-arjuna/tui/wiki/tui-progress)
* [tui-psm](https://github.com/sri-arjuna/tui/wiki/tui-psm)
* [tui-read](https://github.com/sri-arjuna/tui/wiki/tui-read)
* [tui-rnd](https://github.com/sri-arjuna/tui/wiki/tui-rnd)
* [tui-select](https://github.com/sri-arjuna/tui/wiki/tui-select)
* [tui-status](https://github.com/sri-arjuna/tui/wiki/tui-status)
* [tui-str-usb](https://github.com/sri-arjuna/tui/wiki/tui-str-usb)
* [tui-tar](https://github.com/sri-arjuna/tui/wiki/tui-tar)
* [tui-terminal](https://github.com/sri-arjuna/tui/wiki/tui-terminal)
* [tui-title](https://github.com/sri-arjuna/tui/wiki/tui-printf)
* [tui-wait](https://github.com/sri-arjuna/tui/wiki/tui-wait)
* [tui-web](https://github.com/sri-arjuna/tui/wiki/tui-web)
* [tui-yesno](https://github.com/sri-arjuna/tui/wiki/tui-yesno)