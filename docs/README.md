Text User Interface - 0.9.x
===========================

This is the general purpose / all in one README.
For detailed information, see the DOCUMENTION heading and/or the files in ./docs


WHAT IS TUI?
------------

TUI is a framework for scripts to give them an interface like feeling,
some 'bling bling' to output the data, and coding helpers for scripters.

It has a new approach to the console, as it allows to print your output 
to be either left, center or right aligned, or even beeing colored.

Furthermore it takes the scripters burdon of figuring out what application
a $USER uses by providing wrappers for tasks like:
  
  * download (curl/wget)
  * edit
  * filemgr
  * ftp (ftp, sftp, lftp)
  * install (dnf/yum, pacman, pkg, emerge, ... )
  * web(browser)
  * terminal
  
These wrappers will search for installed applications on the $USER computer, 
and save the first found (if default was missing) item to be the 'default'
If none is found, it asks to install one or name it manually.
This applies for GUI and TTY mode! (but not terminal, that is GUI only)

In the same style, it provides wrappers for everyday tasks a scripts comes by:
Such as, but not limited to:
  
  * bol-gui
  * conf-{g,s}et
  * list (alpha, none (default), num, roman) (auto=3, 1 or 2 colums)
  * log
  * progress (dash, numeric, bar)
  * press
  * select (-1 or -2 columns, auto=1-3)
  * status
  * wait
  * yesno
  
But in fact, TUI is tui-browser!
All other commands, are only to make it easier to write scripts that fit in it.


DEPENDENCIES
------------

This is a quite short list:
  
  * BASH
  * GNU Coreutils (awk, grep, sed, ls, which)
  
Requires either one of (per line): (in most cases, one of these is always installed)
  
  * emacs, nano, vim, vi
  * curl, wget
  
For best possible experiene, it is recomended to have one of these installed as well.
  * elinks, lynx, w3m, www
  * ftp, sftp, lftp
  
If your favorite console command is missing in this list, 
please, let me know! :)


WHY BASH?
---------

  Steampunk, make high-tech from low-tech.
  
  TUI was meant to be a minimal approach for maximal convenience,
  while 'letting even' endusers to update its code, in case of internet loss.
  
  This has lead to interpreted languages like python or shells.
  Python in this scenario has had too many dependencies, and from all shells
  available out there in the wild, BASH seemed to be the most spread.
  Both, in pre-installed and install-able aspects...


PRO & CONTRA
------------

  * PRO
    * Small (tarball < 250k)
    * Lightweight (small memory footprint)
    * Portable (Requires a FHS conform system, BASH and GNU Coreutils)
    * 47 Powerfull and convenient commands
  
  * CONTRA
    * Not spread yet, so you cant just share a single script. (Unless you use [YASSI](./configure) to install that script)
    * Scripts are not as secure as binaries


INSTALLATION
------------

Once you changed into the TUI project root, simply run:
  
  	time (./configure --prefix=/usr ; make && sudo make install all)
  

EXAMPLE
-------

  To provide a small example, here is a short one.
  
  	tui-title "Asking a question:"
  	tui-yesno "Are you a scripter?"
  	ret=$?
  	tui-status $ret "You said: $(tui-str-bol-conv $ret)"
  
  Which will output as:
  
  	# |                Asking a question:                  | #
  	# | Are you a scripter? (y/n)                        y | #
	# | You said: yes                              [  ✓   ]| #
  
  
DOCUMENTION
-----------

For more details before installing, see the files in ./docs

For detailed usage documention, please install TUI and call:
  
  	tuirc html
  	tuirc samples
  
For more details, please see:
  * See the [News](docs/NEWS) for news
  * See the [Chagelog](ChangeLog) for the latest changes
  * See the [Install page](docs/INSTALL.md) for help with (de-)installation.
  * See the [COPYING](COPYING) (GNU GPLv3+) for copyright/copyleft related information.
  * See the [COPYING.LESSER](COPYING.LESSER) (GNU LPLv3+) for copyright/copyleft related information.
  * Additional Licenses:
      * GNU Free Documentation License [GFDL.txt](docs/GFDL.txt) for the documention
      * All scripts in ./docs/samples are licensed as GPLv3+ too, 

