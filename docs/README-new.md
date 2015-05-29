README - 0.8.2
==============

For installation please see [./docs/INSTALL.md](./docs/INSTALL.md)

For configuration please see [./docs/CONFIG.md](./docs/CONFIG.md)


1. What is SWARM?
-----------------
SWARM (Shell Wrapper And Runtime Modificator), is a command based framework
to enable scripts to provide an interface-like feeling, while also eases some
repeative tasks for developers or the author of such scripts.

It provides command-wrappers for either thir identical named counterpart, 
or describe their task in a 'natural developer' language.

Its very basic task is to wrap up to three strings, aligining left, center and right with borders,
and use 2 colors to provide a header (top, outer) and title (sub,inner) visualy colored horizontal dividers
defined by a theme changable per user preference.

While this is accomplished with just 4 commands, the real benefit comes with all the other commands,
which generally do what their name describes and are already using the wrapping  and alignment provided by SWARM.

Beeing a modern console tool, it also takes advantage of beeing within a GUI enviornment.
**swarm-status NUM ["STRING"]** will prodive ANSI chars for a nicer view instead of textual based information otherwise.
Also, when invoking external commands with **swarm-{edit,filemgr,web}** it will use the per-user prefered
application set in $SWARM\_FILE\_USER\_APPS according to wether the script is executed in a terminal window or a tty.
However, there is no mouse interaction, as the focus of its purpose is the console or a headless device, such as a server or Raspery Pi.

2. Dependcies
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
*	(sudo)

Which it requires **bash** to execute its commands, at some certain circumstance you can even tell one of the scripts to fail when executing a bash script, rather than a script of another script langauge.
Saying, as it is command based, it can be used by every scripting language available.


**swarm-terminal** beeing some kind of exception here, as it will only work in a GUI enviornment, 
but this will also start the prefered terminal window of the user, 
with its last list entry **xterm** ment as last fallback option.

As it is command based and uses a dash (-) to seperate descriptors, it is possible to group some tasks.
Those are swarm-bol-\*, swarm-conf-\*, swarm-math-\*, swarm-str-\*, which are considered coding helpers.

There are three special cases:

*	swarm-install, is ment to install packages distro-independant, so the scripter doesnt have to care wether its apt-get, emerge, dnf, pacman, pkg or zypper
*	swarm-printf, does not accecpt string formating as its origin name
*	swarm-psm, is the only abrevihation, background script manager


It also attempts to reduce required user interaction to a minimum, 
by not requiring an [ENTER] after typing 'y' or 'n' to answer tui-yesno,
or by having tui-select count the number of options and 
stops reading at given amount of characters corresponding to the length of the count of options.
These small things, give a much more dynamic feeling to the TUI it generates.

This said



In the modern days, scripts are often not as valued as they should be, and having graphical interfaces certainly increases this trend.

But there are uses where scripts are just more applicable than a full blown compiled application.

TUI helps you to achieve script wich provide alot of comfort and simplicity for both, the scripter and user. 


1. Introduction
---------------

Beeing aware that i probably missed its coolness by like 20 years, 
this is what i always wanted to do, eversince my first contact with a computer.

I always thought there was missing a framework to give the look and feel of an interface.

There are lots of tools to make an interface on the console/terminal, but most of them or dialog based, 
which to my understanding is ridioulous for a console/terminal.

Thus i wanted something that (generaly speaking) works on a 'per-line' and 'command-as-function' basis,
rather than on a 'dialog' basis.

Something that can be used individually and simple be used as a standalone tool, 
but brings the most benefit if used as the collection/framework it is.

I wanted to provide functionality with the most natural speaking and meaningfull appraoch i can achieve.


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

