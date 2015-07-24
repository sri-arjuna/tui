Configuration:
--------------

Since TUI is meant have a minimalists approach, there is not much to configure.
However, you do so by calling:
	
	tui config

There will be these to change:
1.	$TUI\_THEME, to define the colors for tui-{header,title} and the borders printed in $HOME/.tuirc
2.	${EDITOR,BROWSER,FILEMGR}\_{CLI,GUI}, $TERMINAL as the favorite applications for their representing task in **$TUI\_FILE\_USER\_APPS**
3.	$USER\_{EMAIL,NAME,HOMEPAGE}, and $DEFAULT\_LICENSE[\_URL] which will be used in new scripts in **$TUI\_FILE\_USER**
4.	There are settings like, $TAR\_EXT, $DD\_BS, $USER\_SHELL or $useSudo in **$TUI\_FILE\_USER\_SETTINGS**


However, you may access the files directly as well, on a default installation, you will find them at these places:
System wide settings are located in:	/etc/tui
User template configuration file:	/usr/share/tui
User configuration actually is in:	$HOME/.config/tui
The RC file providing the theme and all the dir and file variables, is always in **$HOME/.tuirc**
