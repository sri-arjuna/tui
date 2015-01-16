Description:
------------

This command for User interactions : External commands, will search for an applicable web browser according to whether you are in GUI (graphical) or CLI (emergency, multiuser) mode.

It attemps to start a new instance of $BROWSER_{CLI,GUI} (from apps.conf of the user configuration), if $$BROWSER_{CLI,GUI} is not found, it is looking for firefox chrome chromium epiphany midori opera seamonkey safari when in graphical mode,
or w3m, lynx or elinks when in cli mode.


Examples:
---------

	tui-web "http://www.linux.org"
