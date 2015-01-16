Description:
------------

This command for User interactions : External commands, should help the author of scripts to install requires packages for their scripts.

So the author of a script must neither know nor handle diffrent package managers, he simply passes the package required to tui-install, and it will install it using the package manager of the current system.

Obviously, if a package is installed already, it returns successfull too.

Examples:
---------
Install something required:

	tui-bol-sudo && \
		sudo tui-install PACKAGE PACKAGE2 ... || \
		su -c "tui-install PACKAGE1 PACKAGE2 ..."

Could look like:

	# | Installing vim                        nano                        vi | #
	# | Installed: 'vim nano vi'                                    [  √   ] | #

There is also a verbose mode:

	sudo tui-install -v vim nano vi
	
Will look like:

	# | Installed package: vim                                      [  √   ] | #
	# | Installed package: nano                                     [  √   ] | #
	# | Installed package: vi                                       [  √   ] | #


Get the current Distro:
	
	tui-install -d

Prints out:

	Fedora
	
Get which linux this distro is based on:

	tui-install -b
	
Prints out:
	
	redhat
	
