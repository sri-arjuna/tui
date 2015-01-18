Description:
------------

This command is is ment to be started from a 'startup' script. If you have problems creating such, 
please use [tui-new-browser](https://github.com/sri-arjuna/tui/wiki/tui-new-browser).

It is thought as reusable and customizable project handler for script based proejcts which are structured by directories.

The most important option is the **-p <PATH>**, that PATH will be used as BASE, and all subfolders and scripts can be passed as arguments to tui-browser.

Another neat feature is upon each folder entry, also for the 'BASE', it will first execute **default.cmd**, and then display **default.info**.
In textmode if you type **help** (HELP,h,?) and if there is no file or folder named so, it will show the contents of **default.help**.
None of these **default.{cmd,info,help}** will be shown in the menu, neither in numeric, nor in text mode.

However, by passing **-d STRING** you can change it from **default.{cmd,info,help}** to **STRING.{cmd,info,help}**

Another powerfull function of tui-browser is if you ever want to:

* have several scripts as a 'function library' to other scripts,
* and using a configuration file, 
* and have multiple files (all scripts 'inside' any subfolder of the BASE ) to have access to these functions,

without the need to source these files in each and every script called.

So with both the **-c /path/to/configfile** and the **-s /path/to/dir_to_source** one has the option to make functions and variables from those passed arguments available to all scripts which will be called by tui-browser.

So if you have like 4 scripts using all the same function, you can export this to a single file, and make it available by adding **-s /path/to/file_with_function** to the command.


Examples:
---------
To use thee current directory you are in as 'Virtual Root' ($BASE internal) simply call it:

	cd /path/to/myScripts/bin
	tui-browser
	
Now lets make a 'personal' example, this could be either an alias or a script:

	tui-browser 	\
			-T "Post Installation Scripts" \
			-p "$HOME/bin/post.bin/" \
			-s "$HOME/bin/post.functions/" \
			-c "$HOME/bin/post-1.conf" \
			-c "$HOME/bin/post-2.conf"

