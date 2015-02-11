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

But see more on their according wiki page.