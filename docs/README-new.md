README - 0.7.2
==============

1. Introduction
---------------

In the modern days, scripts are often not as valued as they should be, and having graphical interfaces certainly increases this trend.

But there are uses where scripts are just more applicable than a full blown compiled application.

TUI helps you to achieve script wich provide alot of comfort and simplicity for both, the scripter and enduser.



1.1. What is TUI?
-----------------

Ever used some commands on the command line and thought, which of those lines contain now the information i need/want?

Ever wanted to display your script its output on the left, center or right aligned?

You might already have tried to write your own text user interface for your script, but either never got it done, or at least not as good as you wanted.

As it aims to be easy useable by/for scripts, it comes as a set of commands, of which each does only 1 thing, eventualy in diffrent ways.


Beeing a modern tool, it also simplifies interaction with the Graphical User Interface (GUI).

Meaning, if your scripts should require to open either one of a text-editor, a web-browser or file-browser, there are already tools available, which not only search for local installed applications, but also selects according to beeing in a VT or GUI.


##So what is it?##

It has 4 diffrent 'main' display commands (tui-header|title|echo|printf), all the other ##33## (and increasing) commands are coding helpers which are already optimized to use those display commands.

And since it shall be easy usable by/with scripts, it is a line based framework by its proper techical description.



1.2. What can we do with TUI
----------------------------

It is a great tool to wrap around a task or another command line application.

You can write single application-like scripts, such as [Video Handler Script (VHS]](https://github.com/sri-arjuna/vhs)
or basic task wrappers like [EFI-Helper](https://github.com/sri-arjuna/efi-helper).

However, even managing a project based on the use of several scripts (from bash (default) via php to zsh, ##tui-browser## is the ultimate tool you have always needed but didnt know!

TUI comes with a wide range of tools, simplifying tasks like (but not limited to):

* Regular output up to 3 columns, left, center and right aligned.
* Init-like status messages
* Typewriter-style output
* Progress-bar
* Log-files writing
* Conf-file handling
* Background jobs
* Colored lines (tui-header/tui-title - could be used to create a 'box')
* Keeping the power of tui-browser still as a surprise for you
* And much more!

So, what can you do with this? ;)

Basicly everything, you can imagine.



1.3. What can we NOT do with TUI?
---------------------------------

* No mouse required (no buttons)
* No 2D / (pseudo) 3D Text-Windows/Boxes

Personaly i have not figured any 'real limits' other than beeing mouseless and text only.




1.4. What Operating systems does it run on?
-------------------------------------------

It is known to run well on:

* CentOS
* Debian
* Fedora
* FreeBSD
* Gentoo
* Mint
* RHEL
* Ubuntu




1.5. How to install / Where to get it
-------------------------------------

If you are on a RedHat (or otherwise RPM) based distro, simply create a file like: [/etc/yum.repos.d/sea-devel.repo](https://sea.fedorapeople.org/sea-devel.repo)

	[FedoraPeople-sea]
	name=sea's devel packages
	baseurl=http://sea.fedorapeople.org/repo
	enabled=1
	gpgcheck=0


Once you've prepared the repo file, simply run:

	su
	yum install tui

Obviously, it will become updated automaticly if available by using:

	su
	yum update


Other systems might prefer to use git:

	git clone https://github.com/sri-arjuna/tui.git ./tui-inst
	cd ./tui-inst
	su
	PREFIX=/usr ./install.sh 

Or download a zipfile:

	wget https://github.com/sri-arjuna/tui/archive/master.zip
	unzip master.zip
	cd tui-master
	su
	PREFIX=/usr ./install.sh


You can use other PREFIX's, but you do need root access as the PREFIX value is saved to /etc/tui/tui.conf,
which cannot be saved without root rights.

All the code can be reviewd at: [http://github.com/sri-arjuna/tui/](https://github.com/sri-arjuna/tui/)

